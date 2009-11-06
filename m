From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 09/22] i2c-designware: Process i2c_msg messages in the
 interrupt handler
Date: Fri, 06 Nov 2009 21:47:51 +0900
Message-ID: <4AF41AF7.60605@necel.com>
References: <4AF419B6.1000802@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AF419B6.1000802-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Symptom:
--------
When we're going to send/receive the longer size of data than the Tx
FIFO length, the I2C transaction will be divided into several separated
transactions, limited by the Tx FIFO length.

Details:
--------
As a hardware feature, DW I2C core generates a STOP condition whenever
the Tx FIFO becomes empty (strictly speaking, whenever the last byte in
the Tx FIFO is sent out), even if we have more bytes to be written.
Then, once a new transmit data is written to the Tx FIFO, DW I2C core
will initiate a new transaction, which leads to another START condition.

This explains how the transaction in question goes, and implies that
current tasklet-based dw_i2c_pump_msg() strategy couldn't meet the
timing constraint required for avoiding Tx FIFO underrun.

To avoid this scenario, we must keep providing new transmit data within
a given time period.  In case of Fast-mode + 32-byte Tx FIFO, for
instance, it takes about 22.5[us] to process single byte, and 720[us] in
total.

This patch removes the existing tasklet-based "pump" system, and move
its jobs into the interrupt handler.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Acked-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |   39 ++++++++++++----------------------
 1 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index bfb42f0..5fce1a0 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -149,7 +149,6 @@ static char *abort_sources[] = {
  * @dev: driver model device node
  * @base: IO registers pointer
  * @cmd_complete: tx completion indicator
- * @pump_msg: continue in progress transfers
  * @lock: protect this struct and IO registers
  * @clk: input reference clock
  * @cmd_err: run time hadware error code
@@ -175,7 +174,6 @@ struct dw_i2c_dev {
 	struct device		*dev;
 	void __iomem		*base;
 	struct completion	cmd_complete;
-	struct tasklet_struct	pump_msg;
 	struct mutex		lock;
 	struct clk		*clk;
 	int			cmd_err;
@@ -325,7 +323,7 @@ static int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
 /*
  * Initiate low level master read/write transaction.
  * This function is called from i2c_dw_xfer when starting a transfer.
- * This function is also called from dw_i2c_pump_msg to continue a transfer
+ * This function is also called from i2c_dw_isr to continue a transfer
  * that is longer than the size of the TX FIFO.
  */
 static void
@@ -489,10 +487,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	/* no error */
 	if (likely(!dev->cmd_err)) {
-		/* read rx fifo, and disable the adapter */
-		do {
-			i2c_dw_read(dev);
-		} while (dev->status & STATUS_READ_IN_PROGRESS);
+		/* Disable the adapter */
 		writel(0, dev->base + DW_IC_ENABLE);
 		ret = num;
 		goto done;
@@ -520,20 +515,6 @@ static u32 i2c_dw_func(struct i2c_adapter *adap)
 	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR;
 }
 
-static void dw_i2c_pump_msg(unsigned long data)
-{
-	struct dw_i2c_dev *dev = (struct dw_i2c_dev *) data;
-	u32 intr_mask;
-
-	i2c_dw_read(dev);
-	i2c_dw_xfer_msg(dev);
-
-	intr_mask = DW_IC_INTR_STOP_DET | DW_IC_INTR_TX_ABRT;
-	if (dev->status & STATUS_WRITE_IN_PROGRESS)
-		intr_mask |= DW_IC_INTR_TX_EMPTY;
-	writel(intr_mask, dev->base + DW_IC_INTR_MASK);
-}
-
 static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
 {
 	u32 stat;
@@ -604,10 +585,19 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 	if (stat & DW_IC_INTR_TX_ABRT) {
 		dev->cmd_err |= DW_IC_ERR_TX_ABRT;
 		dev->status = STATUS_IDLE;
-	} else if (stat & DW_IC_INTR_TX_EMPTY)
-		tasklet_schedule(&dev->pump_msg);
+	}
+
+	if (stat & DW_IC_INTR_TX_EMPTY) {
+		i2c_dw_read(dev);
+		i2c_dw_xfer_msg(dev);
+	}
+
+	/*
+	 * No need to modify or disable the interrupt mask here.
+	 * i2c_dw_xfer_msg() will take care of it according to
+	 * the current transmit status.
+	 */
 
-	writel(0, dev->base + DW_IC_INTR_MASK);	/* disable interrupts */
 	if (stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET))
 		complete(&dev->cmd_complete);
 
@@ -653,7 +643,6 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	}
 
 	init_completion(&dev->cmd_complete);
-	tasklet_init(&dev->pump_msg, dw_i2c_pump_msg, (unsigned long) dev);
 	mutex_init(&dev->lock);
 	dev->dev = get_device(&pdev->dev);
 	dev->irq = irq;
-- 
1.6.5.2
