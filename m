From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v3 2/3] i2c: i2c-qcom-geni: Simplify tx/rx functions
Date: Mon, 24 Sep 2018 16:52:34 -0700
Message-ID: <20180924235235.182649-2-swboyd@chromium.org>
References: <20180924235235.182649-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924235235.182649-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>, Doug Anderson <dianders@chromium.org>
List-Id: linux-i2c@vger.kernel.org

We never really look at the 'ret' local variable in these functions, so
let's remove it to make way for shorter and simpler code. Furthermore,
we can shorten some lines by adding two local variables for the SE and
the message length so that everything fits in 80 columns and testing the
'dma_buf' local variable in lieu of the 'mode' local variable.  And
kernel style is to leave the return statement by itself, detached from
the rest of the function.

Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: Sagar Dharia <sdharia@codeaurora.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 79 ++++++++++++++----------------
 1 file changed, 36 insertions(+), 43 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 9f2eb02481d3..0b466835cf40 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -365,29 +365,24 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 				u32 m_param)
 {
 	dma_addr_t rx_dma;
-	enum geni_se_xfer_mode mode;
-	unsigned long time_left = XFER_TIMEOUT;
+	unsigned long time_left;
 	void *dma_buf;
+	struct geni_se *se = &gi2c->se;
+	size_t len = msg->len;
 
-	gi2c->cur = msg;
-	mode = GENI_SE_FIFO;
 	dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
 	if (dma_buf)
-		mode = GENI_SE_DMA;
-
-	geni_se_select_mode(&gi2c->se, mode);
-	writel_relaxed(msg->len, gi2c->se.base + SE_I2C_RX_TRANS_LEN);
-	geni_se_setup_m_cmd(&gi2c->se, I2C_READ, m_param);
-	if (mode == GENI_SE_DMA) {
-		int ret;
-
-		ret = geni_se_rx_dma_prep(&gi2c->se, dma_buf, msg->len,
-								&rx_dma);
-		if (ret) {
-			mode = GENI_SE_FIFO;
-			geni_se_select_mode(&gi2c->se, mode);
-			i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
-		}
+		geni_se_select_mode(se, GENI_SE_DMA);
+	else
+		geni_se_select_mode(se, GENI_SE_FIFO);
+
+	writel_relaxed(len, se->base + SE_I2C_RX_TRANS_LEN);
+	geni_se_setup_m_cmd(se, I2C_READ, m_param);
+
+	if (dma_buf && geni_se_rx_dma_prep(se, dma_buf, len, &rx_dma)) {
+		geni_se_select_mode(se, GENI_SE_FIFO);
+		i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
+		dma_buf = NULL;
 	}
 
 	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
@@ -395,12 +390,13 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 		geni_i2c_abort_xfer(gi2c);
 
 	gi2c->cur_rd = 0;
-	if (mode == GENI_SE_DMA) {
+	if (dma_buf) {
 		if (gi2c->err)
 			geni_i2c_rx_fsm_rst(gi2c);
-		geni_se_rx_dma_unprep(&gi2c->se, rx_dma, msg->len);
+		geni_se_rx_dma_unprep(se, rx_dma, len);
 		i2c_put_dma_safe_msg_buf(dma_buf, msg, !gi2c->err);
 	}
+
 	return gi2c->err;
 }
 
@@ -408,45 +404,41 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 				u32 m_param)
 {
 	dma_addr_t tx_dma;
-	enum geni_se_xfer_mode mode;
 	unsigned long time_left;
 	void *dma_buf;
+	struct geni_se *se = &gi2c->se;
+	size_t len = msg->len;
 
-	gi2c->cur = msg;
-	mode = GENI_SE_FIFO;
 	dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
 	if (dma_buf)
-		mode = GENI_SE_DMA;
-
-	geni_se_select_mode(&gi2c->se, mode);
-	writel_relaxed(msg->len, gi2c->se.base + SE_I2C_TX_TRANS_LEN);
-	geni_se_setup_m_cmd(&gi2c->se, I2C_WRITE, m_param);
-	if (mode == GENI_SE_DMA) {
-		int ret;
-
-		ret = geni_se_tx_dma_prep(&gi2c->se, dma_buf, msg->len,
-								&tx_dma);
-		if (ret) {
-			mode = GENI_SE_FIFO;
-			geni_se_select_mode(&gi2c->se, mode);
-			i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
-		}
+		geni_se_select_mode(se, GENI_SE_DMA);
+	else
+		geni_se_select_mode(se, GENI_SE_FIFO);
+
+	writel_relaxed(len, se->base + SE_I2C_TX_TRANS_LEN);
+	geni_se_setup_m_cmd(se, I2C_WRITE, m_param);
+
+	if (dma_buf && geni_se_tx_dma_prep(se, dma_buf, len, &tx_dma)) {
+		geni_se_select_mode(se, GENI_SE_FIFO);
+		i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
+		dma_buf = NULL;
 	}
 
-	if (mode == GENI_SE_FIFO) /* Get FIFO IRQ */
-		writel_relaxed(1, gi2c->se.base + SE_GENI_TX_WATERMARK_REG);
+	if (!dma_buf) /* Get FIFO IRQ */
+		writel_relaxed(1, se->base + SE_GENI_TX_WATERMARK_REG);
 
 	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
 	if (!time_left)
 		geni_i2c_abort_xfer(gi2c);
 
 	gi2c->cur_wr = 0;
-	if (mode == GENI_SE_DMA) {
+	if (dma_buf) {
 		if (gi2c->err)
 			geni_i2c_tx_fsm_rst(gi2c);
-		geni_se_tx_dma_unprep(&gi2c->se, tx_dma, msg->len);
+		geni_se_tx_dma_unprep(se, tx_dma, len);
 		i2c_put_dma_safe_msg_buf(dma_buf, msg, !gi2c->err);
 	}
+
 	return gi2c->err;
 }
 
@@ -474,6 +466,7 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
 
 		m_param |= ((msgs[i].addr << SLV_ADDR_SHFT) & SLV_ADDR_MSK);
 
+		gi2c->cur = &msgs[i];
 		if (msgs[i].flags & I2C_M_RD)
 			ret = geni_i2c_rx_one_msg(gi2c, &msgs[i], m_param);
 		else
-- 
Sent by a computer through tubes
