From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 17/22] i2c-designware: Process all i2c_msg messages in
 the interrupt handler
Date: Fri, 06 Nov 2009 21:50:40 +0900
Message-ID: <4AF41BA0.1050003@necel.com>
References: <4AF419B6.1000802@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AF419B6.1000802-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Currently we process the first i2c_dw_xfer_msg() in i2c_dw_xfer(),
but in this case there is a possibility to be interrupted by certain
interrupts.  As described before in this patchset, we need to keep
providing new transmit data within a given time period, otherwise Tx
FIFO underrun takes place and STOP condition will be generated on the
bus, even if we have more bytes to be written.

In order to exclude all such possibilities, change TX_EMPTY interrupt
usage as below:

* DW_IC_INTR_DEFAULT_MASK: Define a default interrupt mask set, and
  put TX_EMPTY there.

* i2c_dw_xfer_init: Enable DW_IC_INTR_DEFAULT_MASK prior to initiating
  a new I2C transaction.  The first TX_EMPTY will be triggered shortly.
  With the help of it, we can make the first call to i2c_dw_xfer_msg()
  in the interrupt handler.

* i2c_dw_xfer_msg: Fixup intr_mask operation accordingly.  Make sure
  that TX_EMPTY operations need to be reversed.

* request_irq: Set IRQF_DISABLED so that we could load transmit data
  into Tx FIFO without being distracted by other interrupts.

* Remove i2c_dw_xfer_msg() in i2c_dw_xfer().

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 5a3bd74..f184d82 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -90,6 +90,11 @@
 #define DW_IC_INTR_START_DET	0x400
 #define DW_IC_INTR_GEN_CALL	0x800
 
+#define DW_IC_INTR_DEFAULT_MASK		(DW_IC_INTR_RX_FULL | \
+					 DW_IC_INTR_TX_EMPTY | \
+					 DW_IC_INTR_TX_ABRT | \
+					 DW_IC_INTR_STOP_DET)
+
 #define DW_IC_STATUS_ACTIVITY	0x1
 
 #define DW_IC_ERR_TX_ABRT	0x1
@@ -347,13 +352,16 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 
 	/* Enable the adapter */
 	writel(1, dev->base + DW_IC_ENABLE);
+
+	/* Enable interrupts */
+	writel(DW_IC_INTR_DEFAULT_MASK, dev->base + DW_IC_INTR_MASK);
 }
 
 /*
- * Initiate low level master read/write transaction.
- * This function is called from i2c_dw_xfer when starting a transfer.
- * This function is also called from i2c_dw_isr to continue a transfer
- * that is longer than the size of the TX FIFO.
+ * Initiate (and continue) low level master read/write transaction.
+ * This function is only called from i2c_dw_isr, and pumping i2c_msg
+ * messages into the tx buffer.  Even if the size of i2c_msg data is
+ * longer than the size of the tx buffer, it handles everything.
  */
 static void
 i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
@@ -365,7 +373,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 	u32 buf_len = dev->tx_buf_len;
 	u8 *buf = dev->tx_buf;;
 
-	intr_mask = DW_IC_INTR_STOP_DET | DW_IC_INTR_TX_ABRT | DW_IC_INTR_RX_FULL;
+	intr_mask = DW_IC_INTR_DEFAULT_MASK;
 
 	for (; dev->msg_write_idx < dev->msgs_num; dev->msg_write_idx++) {
 		/* if target address has changed, we need to
@@ -405,11 +413,12 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 
 		if (buf_len > 0) {
 			/* more bytes to be written */
-			intr_mask |= DW_IC_INTR_TX_EMPTY;
 			dev->status |= STATUS_WRITE_IN_PROGRESS;
 			break;
-		} else
+		} else {
 			dev->status &= ~STATUS_WRITE_IN_PROGRESS;
+			intr_mask &= ~DW_IC_INTR_TX_EMPTY;
+		}
 	}
 
 	writel(intr_mask, dev->base + DW_IC_INTR_MASK);
@@ -479,7 +488,6 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	/* start the transfers */
 	i2c_dw_xfer_init(dev);
-	i2c_dw_xfer_msg(dev);
 
 	/* wait for tx to complete */
 	ret = wait_for_completion_interruptible_timeout(&dev->cmd_complete, HZ);
@@ -687,7 +695,7 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	i2c_dw_init(dev);
 
 	writel(0, dev->base + DW_IC_INTR_MASK); /* disable IRQ */
-	r = request_irq(dev->irq, i2c_dw_isr, 0, pdev->name, dev);
+	r = request_irq(dev->irq, i2c_dw_isr, IRQF_DISABLED, pdev->name, dev);
 	if (r) {
 		dev_err(&pdev->dev, "failure requesting irq %i\n", dev->irq);
 		goto err_iounmap;
-- 
1.6.5.2
