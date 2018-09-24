From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v3 3/3] i2c: i2c-qcom-geni: Simplify irq handler
Date: Mon, 24 Sep 2018 16:52:35 -0700
Message-ID: <20180924235235.182649-3-swboyd@chromium.org>
References: <20180924235235.182649-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924235235.182649-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>, Doug Anderson <dianders@chromium.org>
List-Id: linux-i2c@vger.kernel.org

We don't need to use goto here, we can just collapse the if statement
and goto chain into multiple branches and then combine some duplicate
completion calls into one big if statement. Let's do it to clean up code
some more.

Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: Sagar Dharia <sdharia@codeaurora.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 70 +++++++++++++-----------------
 1 file changed, 29 insertions(+), 41 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 0b466835cf40..527f55c8c4c7 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -201,21 +201,23 @@ static void geni_i2c_err(struct geni_i2c_dev *gi2c, int err)
 static irqreturn_t geni_i2c_irq(int irq, void *dev)
 {
 	struct geni_i2c_dev *gi2c = dev;
-	int j;
+	void __iomem *base = gi2c->se.base;
+	int j, p;
 	u32 m_stat;
 	u32 rx_st;
 	u32 dm_tx_st;
 	u32 dm_rx_st;
 	u32 dma;
+	u32 val;
 	struct i2c_msg *cur;
 	unsigned long flags;
 
 	spin_lock_irqsave(&gi2c->lock, flags);
-	m_stat = readl_relaxed(gi2c->se.base + SE_GENI_M_IRQ_STATUS);
-	rx_st = readl_relaxed(gi2c->se.base + SE_GENI_RX_FIFO_STATUS);
-	dm_tx_st = readl_relaxed(gi2c->se.base + SE_DMA_TX_IRQ_STAT);
-	dm_rx_st = readl_relaxed(gi2c->se.base + SE_DMA_RX_IRQ_STAT);
-	dma = readl_relaxed(gi2c->se.base + SE_GENI_DMA_MODE_EN);
+	m_stat = readl_relaxed(base + SE_GENI_M_IRQ_STATUS);
+	rx_st = readl_relaxed(base + SE_GENI_RX_FIFO_STATUS);
+	dm_tx_st = readl_relaxed(base + SE_DMA_TX_IRQ_STAT);
+	dm_rx_st = readl_relaxed(base + SE_DMA_RX_IRQ_STAT);
+	dma = readl_relaxed(base + SE_GENI_DMA_MODE_EN);
 	cur = gi2c->cur;
 
 	if (!cur ||
@@ -238,26 +240,17 @@ static irqreturn_t geni_i2c_irq(int irq, void *dev)
 
 		/* Disable the TX Watermark interrupt to stop TX */
 		if (!dma)
-			writel_relaxed(0, gi2c->se.base +
-					   SE_GENI_TX_WATERMARK_REG);
-		goto irqret;
-	}
-
-	if (dma) {
+			writel_relaxed(0, base + SE_GENI_TX_WATERMARK_REG);
+	} else if (dma) {
 		dev_dbg(gi2c->se.dev, "i2c dma tx:0x%x, dma rx:0x%x\n",
 			dm_tx_st, dm_rx_st);
-		goto irqret;
-	}
-
-	if (cur->flags & I2C_M_RD &&
-	    m_stat & (M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN)) {
+	} else if (cur->flags & I2C_M_RD &&
+		   m_stat & (M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN)) {
 		u32 rxcnt = rx_st & RX_FIFO_WC_MSK;
 
 		for (j = 0; j < rxcnt; j++) {
-			u32 val;
-			int p = 0;
-
-			val = readl_relaxed(gi2c->se.base + SE_GENI_RX_FIFOn);
+			p = 0;
+			val = readl_relaxed(base + SE_GENI_RX_FIFOn);
 			while (gi2c->cur_rd < cur->len && p < sizeof(val)) {
 				cur->buf[gi2c->cur_rd++] = val & 0xff;
 				val >>= 8;
@@ -270,44 +263,39 @@ static irqreturn_t geni_i2c_irq(int irq, void *dev)
 		   m_stat & M_TX_FIFO_WATERMARK_EN) {
 		for (j = 0; j < gi2c->tx_wm; j++) {
 			u32 temp;
-			u32 val = 0;
-			int p = 0;
 
+			val = 0;
+			p = 0;
 			while (gi2c->cur_wr < cur->len && p < sizeof(val)) {
 				temp = cur->buf[gi2c->cur_wr++];
 				val |= temp << (p * 8);
 				p++;
 			}
-			writel_relaxed(val, gi2c->se.base + SE_GENI_TX_FIFOn);
+			writel_relaxed(val, base + SE_GENI_TX_FIFOn);
 			/* TX Complete, Disable the TX Watermark interrupt */
 			if (gi2c->cur_wr == cur->len) {
-				writel_relaxed(0, gi2c->se.base +
-						SE_GENI_TX_WATERMARK_REG);
+				writel_relaxed(0, base + SE_GENI_TX_WATERMARK_REG);
 				break;
 			}
 		}
 	}
-irqret:
+
 	if (m_stat)
-		writel_relaxed(m_stat, gi2c->se.base + SE_GENI_M_IRQ_CLEAR);
+		writel_relaxed(m_stat, base + SE_GENI_M_IRQ_CLEAR);
+
+	if (dma && dm_tx_st)
+		writel_relaxed(dm_tx_st, base + SE_DMA_TX_IRQ_CLR);
+	if (dma && dm_rx_st)
+		writel_relaxed(dm_rx_st, base + SE_DMA_RX_IRQ_CLR);
 
-	if (dma) {
-		if (dm_tx_st)
-			writel_relaxed(dm_tx_st, gi2c->se.base +
-						SE_DMA_TX_IRQ_CLR);
-		if (dm_rx_st)
-			writel_relaxed(dm_rx_st, gi2c->se.base +
-						SE_DMA_RX_IRQ_CLR);
-	}
 	/* if this is err with done-bit not set, handle that through timeout. */
-	if (m_stat & M_CMD_DONE_EN || m_stat & M_CMD_ABORT_EN)
-		complete(&gi2c->done);
-	else if (dm_tx_st & TX_DMA_DONE || dm_tx_st & TX_RESET_DONE)
-		complete(&gi2c->done);
-	else if (dm_rx_st & RX_DMA_DONE || dm_rx_st & RX_RESET_DONE)
+	if (m_stat & M_CMD_DONE_EN || m_stat & M_CMD_ABORT_EN ||
+	    dm_tx_st & TX_DMA_DONE || dm_tx_st & TX_RESET_DONE ||
+	    dm_rx_st & RX_DMA_DONE || dm_rx_st & RX_RESET_DONE)
 		complete(&gi2c->done);
 
 	spin_unlock_irqrestore(&gi2c->lock, flags);
+
 	return IRQ_HANDLED;
 }
 
-- 
Sent by a computer through tubes
