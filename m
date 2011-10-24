From: Rajeev Kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH] i2c-designware: Change readl to readw and writel to writew
Date: Mon, 24 Oct 2011 09:54:53 +0530
Message-ID: <1319430293-2624-1-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: shiraz.hashim-qxv4g6HH51o@public.gmane.org, viresh.kumar-qxv4g6HH51o@public.gmane.org, bhupesh.sharma-qxv4g6HH51o@public.gmane.org, pratyush.anand-qxv4g6HH51o@public.gmane.org, vipin.kumar-qxv4g6HH51o@public.gmane.org, deepak.sikri-qxv4g6HH51o@public.gmane.org, amit.virdi-qxv4g6HH51o@public.gmane.org, vipulkumar.samar-qxv4g6HH51o@public.gmane.org, armando.visconti-qxv4g6HH51o@public.gmane.org, Rajeev Kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Since I2C designware registers are 16 bit wide and so we should use
readw/writew.

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |   84 +++++++++++++++++-----------------
 1 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 6eaa681..f3b2bba 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -289,7 +289,7 @@ static void i2c_dw_init(struct dw_i2c_dev *dev)
 	u32 ic_con, hcnt, lcnt;
 
 	/* Disable the adapter */
-	writel(0, dev->base + DW_IC_ENABLE);
+	writew(0, dev->base + DW_IC_ENABLE);
 
 	/* set standard and fast speed deviders for high/low periods */
 
@@ -303,8 +303,8 @@ static void i2c_dw_init(struct dw_i2c_dev *dev)
 				47,	/* tLOW = 4.7 us */
 				3,	/* tf = 0.3 us */
 				0);	/* No offset */
-	writel(hcnt, dev->base + DW_IC_SS_SCL_HCNT);
-	writel(lcnt, dev->base + DW_IC_SS_SCL_LCNT);
+	writew(hcnt, dev->base + DW_IC_SS_SCL_HCNT);
+	writew(lcnt, dev->base + DW_IC_SS_SCL_LCNT);
 	dev_dbg(dev->dev, "Standard-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
 
 	/* Fast-mode */
@@ -317,18 +317,18 @@ static void i2c_dw_init(struct dw_i2c_dev *dev)
 				13,	/* tLOW = 1.3 us */
 				3,	/* tf = 0.3 us */
 				0);	/* No offset */
-	writel(hcnt, dev->base + DW_IC_FS_SCL_HCNT);
-	writel(lcnt, dev->base + DW_IC_FS_SCL_LCNT);
+	writew(hcnt, dev->base + DW_IC_FS_SCL_HCNT);
+	writew(lcnt, dev->base + DW_IC_FS_SCL_LCNT);
 	dev_dbg(dev->dev, "Fast-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
 
 	/* Configure Tx/Rx FIFO threshold levels */
-	writel(dev->tx_fifo_depth - 1, dev->base + DW_IC_TX_TL);
-	writel(0, dev->base + DW_IC_RX_TL);
+	writew(dev->tx_fifo_depth - 1, dev->base + DW_IC_TX_TL);
+	writew(0, dev->base + DW_IC_RX_TL);
 
 	/* configure the i2c master */
 	ic_con = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
 		DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
-	writel(ic_con, dev->base + DW_IC_CON);
+	writew(ic_con, dev->base + DW_IC_CON);
 }
 
 /*
@@ -338,7 +338,7 @@ static int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
 {
 	int timeout = TIMEOUT;
 
-	while (readl(dev->base + DW_IC_STATUS) & DW_IC_STATUS_ACTIVITY) {
+	while (readw(dev->base + DW_IC_STATUS) & DW_IC_STATUS_ACTIVITY) {
 		if (timeout <= 0) {
 			dev_warn(dev->dev, "timeout waiting for bus ready\n");
 			return -ETIMEDOUT;
@@ -356,24 +356,24 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	u32 ic_con;
 
 	/* Disable the adapter */
-	writel(0, dev->base + DW_IC_ENABLE);
+	writew(0, dev->base + DW_IC_ENABLE);
 
 	/* set the slave (target) address */
-	writel(msgs[dev->msg_write_idx].addr, dev->base + DW_IC_TAR);
+	writew(msgs[dev->msg_write_idx].addr, dev->base + DW_IC_TAR);
 
 	/* if the slave address is ten bit address, enable 10BITADDR */
-	ic_con = readl(dev->base + DW_IC_CON);
+	ic_con = readw(dev->base + DW_IC_CON);
 	if (msgs[dev->msg_write_idx].flags & I2C_M_TEN)
 		ic_con |= DW_IC_CON_10BITADDR_MASTER;
 	else
 		ic_con &= ~DW_IC_CON_10BITADDR_MASTER;
-	writel(ic_con, dev->base + DW_IC_CON);
+	writew(ic_con, dev->base + DW_IC_CON);
 
 	/* Enable the adapter */
-	writel(1, dev->base + DW_IC_ENABLE);
+	writew(1, dev->base + DW_IC_ENABLE);
 
 	/* Enable interrupts */
-	writel(DW_IC_INTR_DEFAULT_MASK, dev->base + DW_IC_INTR_MASK);
+	writew(DW_IC_INTR_DEFAULT_MASK, dev->base + DW_IC_INTR_MASK);
 }
 
 /*
@@ -420,15 +420,15 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 			buf_len = msgs[dev->msg_write_idx].len;
 		}
 
-		tx_limit = dev->tx_fifo_depth - readl(dev->base + DW_IC_TXFLR);
-		rx_limit = dev->rx_fifo_depth - readl(dev->base + DW_IC_RXFLR);
+		tx_limit = dev->tx_fifo_depth - readw(dev->base + DW_IC_TXFLR);
+		rx_limit = dev->rx_fifo_depth - readw(dev->base + DW_IC_RXFLR);
 
 		while (buf_len > 0 && tx_limit > 0 && rx_limit > 0) {
 			if (msgs[dev->msg_write_idx].flags & I2C_M_RD) {
-				writel(0x100, dev->base + DW_IC_DATA_CMD);
+				writew(0x100, dev->base + DW_IC_DATA_CMD);
 				rx_limit--;
 			} else
-				writel(*buf++, dev->base + DW_IC_DATA_CMD);
+				writew(*buf++, dev->base + DW_IC_DATA_CMD);
 			tx_limit--; buf_len--;
 		}
 
@@ -453,7 +453,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 	if (dev->msg_err)
 		intr_mask = 0;
 
-	writel(intr_mask, dev->base + DW_IC_INTR_MASK);
+	writew(intr_mask, dev->base + DW_IC_INTR_MASK);
 }
 
 static void
@@ -477,10 +477,10 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 			buf = dev->rx_buf;
 		}
 
-		rx_valid = readl(dev->base + DW_IC_RXFLR);
+		rx_valid = readw(dev->base + DW_IC_RXFLR);
 
 		for (; len > 0 && rx_valid > 0; len--, rx_valid--)
-			*buf++ = readl(dev->base + DW_IC_DATA_CMD);
+			*buf++ = readw(dev->base + DW_IC_DATA_CMD);
 
 		if (len > 0) {
 			dev->status |= STATUS_READ_IN_PROGRESS;
@@ -563,7 +563,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	/* no error */
 	if (likely(!dev->cmd_err)) {
 		/* Disable the adapter */
-		writel(0, dev->base + DW_IC_ENABLE);
+		writew(0, dev->base + DW_IC_ENABLE);
 		ret = num;
 		goto done;
 	}
@@ -601,47 +601,47 @@ static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
 	 * in the IC_RAW_INTR_STAT register.
 	 *
 	 * That is,
-	 *   stat = readl(IC_INTR_STAT);
+	 *   stat = readw(IC_INTR_STAT);
 	 * equals to,
-	 *   stat = readl(IC_RAW_INTR_STAT) & readl(IC_INTR_MASK);
+	 *   stat = readw(IC_RAW_INTR_STAT) & readw(IC_INTR_MASK);
 	 *
 	 * The raw version might be useful for debugging purposes.
 	 */
-	stat = readl(dev->base + DW_IC_INTR_STAT);
+	stat = readw(dev->base + DW_IC_INTR_STAT);
 
 	/*
 	 * Do not use the IC_CLR_INTR register to clear interrupts, or
 	 * you'll miss some interrupts, triggered during the period from
-	 * readl(IC_INTR_STAT) to readl(IC_CLR_INTR).
+	 * readw(IC_INTR_STAT) to readw(IC_CLR_INTR).
 	 *
 	 * Instead, use the separately-prepared IC_CLR_* registers.
 	 */
 	if (stat & DW_IC_INTR_RX_UNDER)
-		readl(dev->base + DW_IC_CLR_RX_UNDER);
+		readw(dev->base + DW_IC_CLR_RX_UNDER);
 	if (stat & DW_IC_INTR_RX_OVER)
-		readl(dev->base + DW_IC_CLR_RX_OVER);
+		readw(dev->base + DW_IC_CLR_RX_OVER);
 	if (stat & DW_IC_INTR_TX_OVER)
-		readl(dev->base + DW_IC_CLR_TX_OVER);
+		readw(dev->base + DW_IC_CLR_TX_OVER);
 	if (stat & DW_IC_INTR_RD_REQ)
-		readl(dev->base + DW_IC_CLR_RD_REQ);
+		readw(dev->base + DW_IC_CLR_RD_REQ);
 	if (stat & DW_IC_INTR_TX_ABRT) {
 		/*
 		 * The IC_TX_ABRT_SOURCE register is cleared whenever
 		 * the IC_CLR_TX_ABRT is read.  Preserve it beforehand.
 		 */
-		dev->abort_source = readl(dev->base + DW_IC_TX_ABRT_SOURCE);
-		readl(dev->base + DW_IC_CLR_TX_ABRT);
+		dev->abort_source = readw(dev->base + DW_IC_TX_ABRT_SOURCE);
+		readw(dev->base + DW_IC_CLR_TX_ABRT);
 	}
 	if (stat & DW_IC_INTR_RX_DONE)
-		readl(dev->base + DW_IC_CLR_RX_DONE);
+		readw(dev->base + DW_IC_CLR_RX_DONE);
 	if (stat & DW_IC_INTR_ACTIVITY)
-		readl(dev->base + DW_IC_CLR_ACTIVITY);
+		readw(dev->base + DW_IC_CLR_ACTIVITY);
 	if (stat & DW_IC_INTR_STOP_DET)
-		readl(dev->base + DW_IC_CLR_STOP_DET);
+		readw(dev->base + DW_IC_CLR_STOP_DET);
 	if (stat & DW_IC_INTR_START_DET)
-		readl(dev->base + DW_IC_CLR_START_DET);
+		readw(dev->base + DW_IC_CLR_START_DET);
 	if (stat & DW_IC_INTR_GEN_CALL)
-		readl(dev->base + DW_IC_CLR_GEN_CALL);
+		readw(dev->base + DW_IC_CLR_GEN_CALL);
 
 	return stat;
 }
@@ -666,7 +666,7 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 		 * Anytime TX_ABRT is set, the contents of the tx/rx
 		 * buffers are flushed.  Make sure to skip them.
 		 */
-		writel(0, dev->base + DW_IC_INTR_MASK);
+		writew(0, dev->base + DW_IC_INTR_MASK);
 		goto tx_aborted;
 	}
 
@@ -747,14 +747,14 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 		goto err_unuse_clocks;
 	}
 	{
-		u32 param1 = readl(dev->base + DW_IC_COMP_PARAM_1);
+		u32 param1 = readw(dev->base + DW_IC_COMP_PARAM_1);
 
 		dev->tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;
 		dev->rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
 	}
 	i2c_dw_init(dev);
 
-	writel(0, dev->base + DW_IC_INTR_MASK); /* disable IRQ */
+	writew(0, dev->base + DW_IC_INTR_MASK); /* disable IRQ */
 	r = request_irq(dev->irq, i2c_dw_isr, IRQF_DISABLED, pdev->name, dev);
 	if (r) {
 		dev_err(&pdev->dev, "failure requesting irq %i\n", dev->irq);
@@ -810,7 +810,7 @@ static int __devexit dw_i2c_remove(struct platform_device *pdev)
 	clk_put(dev->clk);
 	dev->clk = NULL;
 
-	writel(0, dev->base + DW_IC_ENABLE);
+	writew(0, dev->base + DW_IC_ENABLE);
 	free_irq(dev->irq, dev);
 	kfree(dev);
 
-- 
1.6.0.2
