From: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/3] Use local version of readl & writel
Date: Wed, 13 Jan 2010 14:32:25 -0500
Message-ID: <20100113193421.068608000@octasic.com>
References: <20100113193224.753273000@octasic.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=use_local_readl_writel
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use local versions of readl & writel, so per-access manipulations may be performed
---
 drivers/i2c/busses/i2c-designware.c |   88 ++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 39 deletions(-)

Index: linux-2.6_i2c/drivers/i2c/busses/i2c-designware.c
===================================================================
--- linux-2.6_i2c.orig/drivers/i2c/busses/i2c-designware.c
+++ linux-2.6_i2c/drivers/i2c/busses/i2c-designware.c
@@ -219,6 +219,16 @@ struct dw_i2c_dev {
 	unsigned int		rx_fifo_depth;
 };
 
+static u32 i2c_dw_readl(struct dw_i2c_dev *dev, int addr)
+{
+	return readl(dev->base + addr);
+}
+
+static void i2c_dw_writel(struct dw_i2c_dev *dev, u32 b, int addr)
+{
+	writel(b, dev->base + addr);
+}
+
 static u32
 i2c_dw_scl_hcnt(u32 ic_clk, u32 tSYMBOL, u32 tf, int cond, int offset)
 {
@@ -288,7 +298,7 @@ static void i2c_dw_init(struct dw_i2c_de
 	u32 ic_con, hcnt, lcnt;
 
 	/* Disable the adapter */
-	writel(0, dev->base + DW_IC_ENABLE);
+	i2c_dw_writel(dev, 0, DW_IC_ENABLE);
 
 	/* set standard and fast speed deviders for high/low periods */
 
@@ -302,8 +312,8 @@ static void i2c_dw_init(struct dw_i2c_de
 				47,	/* tLOW = 4.7 us */
 				3,	/* tf = 0.3 us */
 				0);	/* No offset */
-	writel(hcnt, dev->base + DW_IC_SS_SCL_HCNT);
-	writel(lcnt, dev->base + DW_IC_SS_SCL_LCNT);
+	i2c_dw_writel(dev, hcnt, DW_IC_SS_SCL_HCNT);
+	i2c_dw_writel(dev, lcnt, DW_IC_SS_SCL_LCNT);
 	dev_dbg(dev->dev, "Standard-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
 
 	/* Fast-mode */
@@ -316,18 +326,18 @@ static void i2c_dw_init(struct dw_i2c_de
 				13,	/* tLOW = 1.3 us */
 				3,	/* tf = 0.3 us */
 				0);	/* No offset */
-	writel(hcnt, dev->base + DW_IC_FS_SCL_HCNT);
-	writel(lcnt, dev->base + DW_IC_FS_SCL_LCNT);
+	i2c_dw_writel(dev, hcnt, DW_IC_FS_SCL_HCNT);
+	i2c_dw_writel(dev, lcnt, DW_IC_FS_SCL_LCNT);
 	dev_dbg(dev->dev, "Fast-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
 
 	/* Configure Tx/Rx FIFO threshold levels */
-	writel(dev->tx_fifo_depth - 1, dev->base + DW_IC_TX_TL);
-	writel(0, dev->base + DW_IC_RX_TL);
+	i2c_dw_writel(dev, dev->tx_fifo_depth - 1, DW_IC_TX_TL);
+	i2c_dw_writel(dev, 0, DW_IC_RX_TL);
 
 	/* configure the i2c master */
 	ic_con = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
 		DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
-	writel(ic_con, dev->base + DW_IC_CON);
+	i2c_dw_writel(dev, ic_con, DW_IC_CON);
 }
 
 /*
@@ -337,7 +347,7 @@ static int i2c_dw_wait_bus_not_busy(stru
 {
 	int timeout = TIMEOUT;
 
-	while (readl(dev->base + DW_IC_STATUS) & DW_IC_STATUS_ACTIVITY) {
+	while (i2c_dw_readl(dev, DW_IC_STATUS) & DW_IC_STATUS_ACTIVITY) {
 		if (timeout <= 0) {
 			dev_warn(dev->dev, "timeout waiting for bus ready\n");
 			return -ETIMEDOUT;
@@ -355,24 +365,24 @@ static void i2c_dw_xfer_init(struct dw_i
 	u32 ic_con;
 
 	/* Disable the adapter */
-	writel(0, dev->base + DW_IC_ENABLE);
+	i2c_dw_writel(dev, 0, DW_IC_ENABLE);
 
 	/* set the slave (target) address */
-	writel(msgs[dev->msg_write_idx].addr, dev->base + DW_IC_TAR);
+	i2c_dw_writel(dev, msgs[dev->msg_write_idx].addr, DW_IC_TAR);
 
 	/* if the slave address is ten bit address, enable 10BITADDR */
-	ic_con = readl(dev->base + DW_IC_CON);
+	ic_con = i2c_dw_readl(dev, DW_IC_CON);
 	if (msgs[dev->msg_write_idx].flags & I2C_M_TEN)
 		ic_con |= DW_IC_CON_10BITADDR_MASTER;
 	else
 		ic_con &= ~DW_IC_CON_10BITADDR_MASTER;
-	writel(ic_con, dev->base + DW_IC_CON);
+	i2c_dw_writel(dev, ic_con, DW_IC_CON);
 
 	/* Enable the adapter */
-	writel(1, dev->base + DW_IC_ENABLE);
+	i2c_dw_writel(dev, 1, DW_IC_ENABLE);
 
 	/* Enable interrupts */
-	writel(DW_IC_INTR_DEFAULT_MASK, dev->base + DW_IC_INTR_MASK);
+	i2c_dw_writel(dev, DW_IC_INTR_DEFAULT_MASK, DW_IC_INTR_MASK);
 }
 
 /*
@@ -419,15 +429,15 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 			buf_len = msgs[dev->msg_write_idx].len;
 		}
 
-		tx_limit = dev->tx_fifo_depth - readl(dev->base + DW_IC_TXFLR);
-		rx_limit = dev->rx_fifo_depth - readl(dev->base + DW_IC_RXFLR);
+		tx_limit = dev->tx_fifo_depth - i2c_dw_readl(dev, DW_IC_TXFLR);
+		rx_limit = dev->rx_fifo_depth - i2c_dw_readl(dev, DW_IC_RXFLR);
 
 		while (buf_len > 0 && tx_limit > 0 && rx_limit > 0) {
 			if (msgs[dev->msg_write_idx].flags & I2C_M_RD) {
-				writel(0x100, dev->base + DW_IC_DATA_CMD);
+				i2c_dw_writel(dev, 0x100, DW_IC_DATA_CMD);
 				rx_limit--;
 			} else
-				writel(*buf++, dev->base + DW_IC_DATA_CMD);
+				i2c_dw_writel(dev, *buf++, DW_IC_DATA_CMD);
 			tx_limit--; buf_len--;
 		}
 
@@ -452,7 +462,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 	if (dev->msg_err)
 		intr_mask = 0;
 
-	writel(intr_mask, dev->base + DW_IC_INTR_MASK);
+	i2c_dw_writel(dev, intr_mask, DW_IC_INTR_MASK);
 }
 
 static void
@@ -476,10 +486,10 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 			buf = dev->rx_buf;
 		}
 
-		rx_valid = readl(dev->base + DW_IC_RXFLR);
+		rx_valid = i2c_dw_readl(dev, DW_IC_RXFLR);
 
 		for (; len > 0 && rx_valid > 0; len--, rx_valid--)
-			*buf++ = readl(dev->base + DW_IC_DATA_CMD);
+			*buf++ = i2c_dw_readl(dev, DW_IC_DATA_CMD);
 
 		if (len > 0) {
 			dev->status |= STATUS_READ_IN_PROGRESS;
@@ -562,7 +572,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, st
 	/* no error */
 	if (likely(!dev->cmd_err)) {
 		/* Disable the adapter */
-		writel(0, dev->base + DW_IC_ENABLE);
+		i2c_dw_writel(dev, 0, DW_IC_ENABLE);
 		ret = num;
 		goto done;
 	}
@@ -606,7 +616,7 @@ static u32 i2c_dw_read_clear_intrbits(st
 	 *
 	 * The raw version might be useful for debugging purposes.
 	 */
-	stat = readl(dev->base + DW_IC_INTR_STAT);
+	stat = i2c_dw_readl(dev, DW_IC_INTR_STAT);
 
 	/*
 	 * Do not use the IC_CLR_INTR register to clear interrupts, or
@@ -616,31 +626,31 @@ static u32 i2c_dw_read_clear_intrbits(st
 	 * Instead, use the separately-prepared IC_CLR_* registers.
 	 */
 	if (stat & DW_IC_INTR_RX_UNDER)
-		readl(dev->base + DW_IC_CLR_RX_UNDER);
+		i2c_dw_readl(dev, DW_IC_CLR_RX_UNDER);
 	if (stat & DW_IC_INTR_RX_OVER)
-		readl(dev->base + DW_IC_CLR_RX_OVER);
+		i2c_dw_readl(dev, DW_IC_CLR_RX_OVER);
 	if (stat & DW_IC_INTR_TX_OVER)
-		readl(dev->base + DW_IC_CLR_TX_OVER);
+		i2c_dw_readl(dev, DW_IC_CLR_TX_OVER);
 	if (stat & DW_IC_INTR_RD_REQ)
-		readl(dev->base + DW_IC_CLR_RD_REQ);
+		i2c_dw_readl(dev, DW_IC_CLR_RD_REQ);
 	if (stat & DW_IC_INTR_TX_ABRT) {
 		/*
 		 * The IC_TX_ABRT_SOURCE register is cleared whenever
 		 * the IC_CLR_TX_ABRT is read.  Preserve it beforehand.
 		 */
-		dev->abort_source = readl(dev->base + DW_IC_TX_ABRT_SOURCE);
-		readl(dev->base + DW_IC_CLR_TX_ABRT);
+		dev->abort_source = i2c_dw_readl(dev, DW_IC_TX_ABRT_SOURCE);
+		i2c_dw_readl(dev, DW_IC_CLR_TX_ABRT);
 	}
 	if (stat & DW_IC_INTR_RX_DONE)
-		readl(dev->base + DW_IC_CLR_RX_DONE);
+		i2c_dw_readl(dev, DW_IC_CLR_RX_DONE);
 	if (stat & DW_IC_INTR_ACTIVITY)
-		readl(dev->base + DW_IC_CLR_ACTIVITY);
+		i2c_dw_readl(dev, DW_IC_CLR_ACTIVITY);
 	if (stat & DW_IC_INTR_STOP_DET)
-		readl(dev->base + DW_IC_CLR_STOP_DET);
+		i2c_dw_readl(dev, DW_IC_CLR_STOP_DET);
 	if (stat & DW_IC_INTR_START_DET)
-		readl(dev->base + DW_IC_CLR_START_DET);
+		i2c_dw_readl(dev, DW_IC_CLR_START_DET);
 	if (stat & DW_IC_INTR_GEN_CALL)
-		readl(dev->base + DW_IC_CLR_GEN_CALL);
+		i2c_dw_readl(dev, DW_IC_CLR_GEN_CALL);
 
 	return stat;
 }
@@ -665,7 +675,7 @@ static irqreturn_t i2c_dw_isr(int this_i
 		 * Anytime TX_ABRT is set, the contents of the tx/rx
 		 * buffers are flushed.  Make sure to skip them.
 		 */
-		writel(0, dev->base + DW_IC_INTR_MASK);
+		i2c_dw_writel(dev, 0, DW_IC_INTR_MASK);
 		goto tx_aborted;
 	}
 
@@ -746,14 +756,14 @@ static int __devinit dw_i2c_probe(struct
 		goto err_unuse_clocks;
 	}
 	{
-		u32 param1 = readl(dev->base + DW_IC_COMP_PARAM_1);
+		u32 param1 = i2c_dw_readl(dev, DW_IC_COMP_PARAM_1);
 
 		dev->tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;
 		dev->rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
 	}
 	i2c_dw_init(dev);
 
-	writel(0, dev->base + DW_IC_INTR_MASK); /* disable IRQ */
+	i2c_dw_writel(dev, 0, DW_IC_INTR_MASK); /* disable IRQ */
 	r = request_irq(dev->irq, i2c_dw_isr, IRQF_DISABLED, pdev->name, dev);
 	if (r) {
 		dev_err(&pdev->dev, "failure requesting irq %i\n", dev->irq);
@@ -809,7 +819,7 @@ static int __devexit dw_i2c_remove(struc
 	clk_put(dev->clk);
 	dev->clk = NULL;
 
-	writel(0, dev->base + DW_IC_ENABLE);
+	i2c_dw_writel(dev, 0, DW_IC_ENABLE);
 	free_irq(dev->irq, dev);
 	kfree(dev);
 

-- 
