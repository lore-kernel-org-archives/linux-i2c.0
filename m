From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 7/9] i2c-designware: Allow mixed endianness accesses
Date: Fri, 14 Jan 2011 11:27:34 -0800
Message-ID: <1295033256-30077-8-git-send-email-dirk.brandewie@gmail.com>
References: <1295033256-30077-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1295033256-30077-1-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Allows CPUs of a given endianness to access a dw controller of a different
endianness. Endianncess difference is detected at run time through the dw
component type register.

This is the hand application of a patch set by Jean-Hugues Deschenes
applied at the sugestion of Shinya Kuribayashi

Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
CC: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c |  116 +++++++++++++++++++-----------
 drivers/i2c/busses/i2c-designware-core.h |    9 ++-
 drivers/i2c/busses/i2c-designware-pci.c  |    4 +-
 drivers/i2c/busses/i2c-designware-plat.c |    5 +-
 4 files changed, 89 insertions(+), 45 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 6723f9e..746b4bb 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -48,6 +48,25 @@ static u32 i2c_dw_clk_get_rate(struct dw_i2c_dev *dev)
 #endif
 }
 
+u32 dw_readl(struct dw_i2c_dev *dev, int offset)
+{
+	u32 value = readl(dev->base + offset);
+
+	if (dev->swab)
+		return swab32(value);
+	else
+		return value;
+}
+EXPORT_SYMBOL(dw_readl);
+
+void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset)
+{
+	if (dev->swab)
+		b = swab32(b);
+
+	writel(b, dev->base + offset);
+}
+EXPORT_SYMBOL(dw_writel);
 
 static char *abort_sources[] = {
 	[ABRT_7B_ADDR_NOACK] =
@@ -137,16 +156,29 @@ u32 i2c_dw_scl_lcnt(u32 ic_clk, u32 tLOW, u32 tf, int offset)
  * This function is called during I2C init function, and in case of timeout at
  * run time.
  */
-void
+int
 i2c_dw_init(struct dw_i2c_dev *dev)
 {
 	u32 input_clock_khz;
 	u32 hcnt, lcnt;
-
+	u32 reg;
 	input_clock_khz = i2c_dw_clk_get_rate(dev);
 
+	/* Configure register endianess access */
+	reg = dw_readl(dev, DW_IC_COMP_TYPE);
+	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
+		dev->swab = 1;
+		reg = ___constant_swab32(DW_IC_COMP_TYPE_VALUE);
+	}
+
+	if (reg != DW_IC_COMP_TYPE_VALUE) {
+		dev_err(dev->dev, "Unknown Synopsys component type: "
+			"0x%08x\n", reg);
+		return -ENODEV;
+	}
+
 	/* Disable the adapter */
-	writel(0, dev->base + DW_IC_ENABLE);
+	dw_writel(dev, 0, DW_IC_ENABLE);
 
 	/* set standard and fast speed deviders for high/low periods */
 
@@ -160,8 +192,8 @@ i2c_dw_init(struct dw_i2c_dev *dev)
 				47,	/* tLOW = 4.7 us */
 				3,	/* tf = 0.3 us */
 				0);	/* No offset */
-	writel(hcnt, dev->base + DW_IC_SS_SCL_HCNT);
-	writel(lcnt, dev->base + DW_IC_SS_SCL_LCNT);
+	dw_writel(dev, hcnt, DW_IC_SS_SCL_HCNT);
+	dw_writel(dev, lcnt, DW_IC_SS_SCL_LCNT);
 	dev_dbg(dev->dev, "Standard-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
 
 	/* Fast-mode */
@@ -174,16 +206,17 @@ i2c_dw_init(struct dw_i2c_dev *dev)
 				13,	/* tLOW = 1.3 us */
 				3,	/* tf = 0.3 us */
 				0);	/* No offset */
-	writel(hcnt, dev->base + DW_IC_FS_SCL_HCNT);
-	writel(lcnt, dev->base + DW_IC_FS_SCL_LCNT);
+	dw_writel(dev, hcnt, DW_IC_FS_SCL_HCNT);
+	dw_writel(dev, lcnt, DW_IC_FS_SCL_LCNT);
 	dev_dbg(dev->dev, "Fast-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
 
 	/* Configure Tx/Rx FIFO threshold levels */
-	writel(dev->tx_fifo_depth - 1, dev->base + DW_IC_TX_TL);
-	writel(0, dev->base + DW_IC_RX_TL);
+	dw_writel(dev, dev->tx_fifo_depth - 1, DW_IC_TX_TL);
+	dw_writel(dev, 0, DW_IC_RX_TL);
 
 	/* configure the i2c master */
-	writel(dev->master_cfg, dev->base + DW_IC_CON);
+	dw_writel(dev, dev->master_cfg, DW_IC_CON);
+	return 0;
 }
 EXPORT_SYMBOL(i2c_dw_init);
 
@@ -195,7 +228,7 @@ i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
 {
 	int timeout = TIMEOUT;
 
-	while (readl(dev->base + DW_IC_STATUS) & DW_IC_STATUS_ACTIVITY) {
+	while (dw_readl(dev, DW_IC_STATUS) & DW_IC_STATUS_ACTIVITY) {
 		if (timeout <= 0) {
 			dev_warn(dev->dev, "timeout waiting for bus ready\n");
 			return -ETIMEDOUT;
@@ -214,24 +247,24 @@ i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	u32 ic_con;
 
 	/* Disable the adapter */
-	writel(0, dev->base + DW_IC_ENABLE);
+	dw_writel(dev, 0, DW_IC_ENABLE);
 
 	/* set the slave (target) address */
-	writel(msgs[dev->msg_write_idx].addr, dev->base + DW_IC_TAR);
+	dw_writel(dev, msgs[dev->msg_write_idx].addr, DW_IC_TAR);
 
 	/* if the slave address is ten bit address, enable 10BITADDR */
-	ic_con = readl(dev->base + DW_IC_CON);
+	ic_con = dw_readl(dev, DW_IC_CON);
 	if (msgs[dev->msg_write_idx].flags & I2C_M_TEN)
 		ic_con |= DW_IC_CON_10BITADDR_MASTER;
 	else
 		ic_con &= ~DW_IC_CON_10BITADDR_MASTER;
-	writel(ic_con, dev->base + DW_IC_CON);
+	dw_writel(dev, ic_con, DW_IC_CON);
 
 	/* Enable the adapter */
-	writel(1, dev->base + DW_IC_ENABLE);
+	dw_writel(dev, 1, DW_IC_ENABLE);
 
 	/* Enable interrupts */
-	writel(DW_IC_INTR_DEFAULT_MASK, dev->base + DW_IC_INTR_MASK);
+	dw_writel(dev, DW_IC_INTR_DEFAULT_MASK, DW_IC_INTR_MASK);
 }
 
 /*
@@ -278,15 +311,15 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 			buf_len = msgs[dev->msg_write_idx].len;
 		}
 
-		tx_limit = dev->tx_fifo_depth - readl(dev->base + DW_IC_TXFLR);
-		rx_limit = dev->rx_fifo_depth - readl(dev->base + DW_IC_RXFLR);
+		tx_limit = dev->tx_fifo_depth - dw_readl(dev, DW_IC_TXFLR);
+		rx_limit = dev->rx_fifo_depth - dw_readl(dev, DW_IC_RXFLR);
 
 		while (buf_len > 0 && tx_limit > 0 && rx_limit > 0) {
 			if (msgs[dev->msg_write_idx].flags & I2C_M_RD) {
-				writel(0x100, dev->base + DW_IC_DATA_CMD);
+				dw_writel(dev, 0x100, DW_IC_DATA_CMD);
 				rx_limit--;
 			} else
-				writel(*buf++, dev->base + DW_IC_DATA_CMD);
+				dw_writel(dev, *buf++, DW_IC_DATA_CMD);
 			tx_limit--; buf_len--;
 		}
 
@@ -311,7 +344,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 	if (dev->msg_err)
 		intr_mask = 0;
 
-	writel(intr_mask, dev->base + DW_IC_INTR_MASK);
+	dw_writel(dev, intr_mask, DW_IC_INTR_MASK);
 }
 
 void
@@ -335,10 +368,10 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 			buf = dev->rx_buf;
 		}
 
-		rx_valid = readl(dev->base + DW_IC_RXFLR);
+		rx_valid = dw_readl(dev, DW_IC_RXFLR);
 
 		for (; len > 0 && rx_valid > 0; len--, rx_valid--)
-			*buf++ = readl(dev->base + DW_IC_DATA_CMD);
+			*buf++ = dw_readl(dev, DW_IC_DATA_CMD);
 
 		if (len > 0) {
 			dev->status |= STATUS_READ_IN_PROGRESS;
@@ -422,7 +455,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	/* no error */
 	if (likely(!dev->cmd_err)) {
 		/* Disable the adapter */
-		writel(0, dev->base + DW_IC_ENABLE);
+		dw_writel(dev, 0, DW_IC_ENABLE);
 		ret = num;
 		goto done;
 	}
@@ -458,47 +491,47 @@ u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
 	 * in the IC_RAW_INTR_STAT register.
 	 *
 	 * That is,
-	 *   stat = readl(IC_INTR_STAT);
+	 *   stat = dw_readl(IC_INTR_STAT);
 	 * equals to,
-	 *   stat = readl(IC_RAW_INTR_STAT) & readl(IC_INTR_MASK);
+	 *   stat = dw_readl(IC_RAW_INTR_STAT) & dw_readl(IC_INTR_MASK);
 	 *
 	 * The raw version might be useful for debugging purposes.
 	 */
-	stat = readl(dev->base + DW_IC_INTR_STAT);
+	stat = dw_readl(dev, DW_IC_INTR_STAT);
 
 	/*
 	 * Do not use the IC_CLR_INTR register to clear interrupts, or
 	 * you'll miss some interrupts, triggered during the period from
-	 * readl(IC_INTR_STAT) to readl(IC_CLR_INTR).
+	 * dw_readl(IC_INTR_STAT) to dw_readl(IC_CLR_INTR).
 	 *
 	 * Instead, use the separately-prepared IC_CLR_* registers.
 	 */
 	if (stat & DW_IC_INTR_RX_UNDER)
-		readl(dev->base + DW_IC_CLR_RX_UNDER);
+		dw_readl(dev, DW_IC_CLR_RX_UNDER);
 	if (stat & DW_IC_INTR_RX_OVER)
-		readl(dev->base + DW_IC_CLR_RX_OVER);
+		dw_readl(dev, DW_IC_CLR_RX_OVER);
 	if (stat & DW_IC_INTR_TX_OVER)
-		readl(dev->base + DW_IC_CLR_TX_OVER);
+		dw_readl(dev, DW_IC_CLR_TX_OVER);
 	if (stat & DW_IC_INTR_RD_REQ)
-		readl(dev->base + DW_IC_CLR_RD_REQ);
+		dw_readl(dev, DW_IC_CLR_RD_REQ);
 	if (stat & DW_IC_INTR_TX_ABRT) {
 		/*
 		 * The IC_TX_ABRT_SOURCE register is cleared whenever
 		 * the IC_CLR_TX_ABRT is read.  Preserve it beforehand.
 		 */
-		dev->abort_source = readl(dev->base + DW_IC_TX_ABRT_SOURCE);
-		readl(dev->base + DW_IC_CLR_TX_ABRT);
+		dev->abort_source = dw_readl(dev, DW_IC_TX_ABRT_SOURCE);
+		dw_readl(dev, DW_IC_CLR_TX_ABRT);
 	}
 	if (stat & DW_IC_INTR_RX_DONE)
-		readl(dev->base + DW_IC_CLR_RX_DONE);
+		dw_readl(dev, DW_IC_CLR_RX_DONE);
 	if (stat & DW_IC_INTR_ACTIVITY)
-		readl(dev->base + DW_IC_CLR_ACTIVITY);
+		dw_readl(dev, DW_IC_CLR_ACTIVITY);
 	if (stat & DW_IC_INTR_STOP_DET)
-		readl(dev->base + DW_IC_CLR_STOP_DET);
+		dw_readl(dev, DW_IC_CLR_STOP_DET);
 	if (stat & DW_IC_INTR_START_DET)
-		readl(dev->base + DW_IC_CLR_START_DET);
+		dw_readl(dev, DW_IC_CLR_START_DET);
 	if (stat & DW_IC_INTR_GEN_CALL)
-		readl(dev->base + DW_IC_CLR_GEN_CALL);
+		dw_readl(dev, DW_IC_CLR_GEN_CALL);
 
 	return stat;
 }
@@ -523,7 +556,7 @@ irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 		 * Anytime TX_ABRT is set, the contents of the tx/rx
 		 * buffers are flushed.  Make sure to skip them.
 		 */
-		writel(0, dev->base + DW_IC_INTR_MASK);
+		dw_writel(dev, 0, DW_IC_INTR_MASK);
 		goto tx_aborted;
 	}
 
@@ -546,3 +579,4 @@ tx_aborted:
 	return IRQ_HANDLED;
 }
 EXPORT_SYMBOL(i2c_dw_isr);
+
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 9aefe89..148717f 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -68,8 +68,10 @@
 #define DW_IC_STATUS		0x70
 #define DW_IC_TXFLR		0x74
 #define DW_IC_RXFLR		0x78
-#define DW_IC_COMP_PARAM_1	0xf4
 #define DW_IC_TX_ABRT_SOURCE	0x80
+#define DW_IC_COMP_PARAM_1	0xf4
+#define DW_IC_COMP_TYPE		0xfc
+#define DW_IC_COMP_TYPE_VALUE	0x44570140
 
 #define DW_IC_CON_MASTER		0x1
 #define DW_IC_CON_SPEED_STD		0x2
@@ -192,6 +194,7 @@ struct dw_i2c_dev {
 	unsigned int		status;
 	u32			abort_source;
 	int			irq;
+	int			swab;
 	struct i2c_adapter	adapter;
 	u32			functionality;
 	u32			master_cfg;
@@ -200,8 +203,10 @@ struct dw_i2c_dev {
 };
 
 
-extern void i2c_dw_init(struct dw_i2c_dev *dev);
+extern int i2c_dw_init(struct dw_i2c_dev *dev);
 extern int i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 		int num);
 extern u32 i2c_dw_func(struct i2c_adapter *adap);
 extern irqreturn_t i2c_dw_isr(int this_irq, void *dev_id);
+extern u32 dw_readl(struct dw_i2c_dev *dev, int offset);
+extern void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset);
diff --git a/drivers/i2c/busses/i2c-designware-pci.c b/drivers/i2c/busses/i2c-designware-pci.c
index 4e8681e..1d57761 100644
--- a/drivers/i2c/busses/i2c-designware-pci.c
+++ b/drivers/i2c/busses/i2c-designware-pci.c
@@ -212,7 +212,9 @@ const struct pci_device_id *id)
 	dev->tx_fifo_depth = controller->tx_fifo_depth;
 	dev->rx_fifo_depth = controller->rx_fifo_depth;
 
-	i2c_dw_init(dev);
+	r = i2c_dw_init(dev);
+	if (r)
+		goto err_iounmap;
 
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
diff --git a/drivers/i2c/busses/i2c-designware-plat.c b/drivers/i2c/busses/i2c-designware-plat.c
index 843aa01..4b9fe33 100644
--- a/drivers/i2c/busses/i2c-designware-plat.c
+++ b/drivers/i2c/busses/i2c-designware-plat.c
@@ -112,7 +112,10 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 		dev->tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;
 		dev->rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
 	}
-	i2c_dw_init(dev);
+
+	r = i2c_dw_init(dev);
+	if (r)
+		goto err_iounmap;
 
 	writel(0, dev->base + DW_IC_INTR_MASK); /* disable IRQ */
 	r = request_irq(dev->irq, i2c_dw_isr, IRQF_DISABLED, pdev->name, dev);
-- 
1.7.3.4
