From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v2 2/2] i2c: i2c-qcom-geni: Simplify tx/rx functions
Date: Thu, 20 Sep 2018 11:03:23 -0700
Message-ID: <20180920180323.217377-3-swboyd@chromium.org>
References: <20180920180323.217377-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920180323.217377-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

We never really look at the 'ret' local variable in these functions, so
let's remove it to make way for shorter and simpler code. Furthermore,
we can shorten some lines by adding two local variables for the SE and
the message length so that everything fits in 80 columns. And kernel
style is to leave the return statement by itself, detached from the rest
of the function.

Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: Sagar Dharia <sdharia@codeaurora.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 54 ++++++++++++++----------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 9f2eb02481d3..1215bb21c9f1 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -368,6 +368,8 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	enum geni_se_xfer_mode mode;
 	unsigned long time_left = XFER_TIMEOUT;
 	void *dma_buf;
+	struct geni_se *se = &gi2c->se;
+	size_t len = msg->len;
 
 	gi2c->cur = msg;
 	mode = GENI_SE_FIFO;
@@ -375,19 +377,14 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	if (dma_buf)
 		mode = GENI_SE_DMA;
 
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
+	geni_se_select_mode(se, mode);
+	writel_relaxed(len, se->base + SE_I2C_RX_TRANS_LEN);
+	geni_se_setup_m_cmd(se, I2C_READ, m_param);
+
+	if (dma_buf && geni_se_rx_dma_prep(se, dma_buf, len, &rx_dma)) {
+		mode = GENI_SE_FIFO;
+		geni_se_select_mode(se, mode);
+		i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
 	}
 
 	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
@@ -398,9 +395,10 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	if (mode == GENI_SE_DMA) {
 		if (gi2c->err)
 			geni_i2c_rx_fsm_rst(gi2c);
-		geni_se_rx_dma_unprep(&gi2c->se, rx_dma, msg->len);
+		geni_se_rx_dma_unprep(se, rx_dma, len);
 		i2c_put_dma_safe_msg_buf(dma_buf, msg, !gi2c->err);
 	}
+
 	return gi2c->err;
 }
 
@@ -411,6 +409,8 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	enum geni_se_xfer_mode mode;
 	unsigned long time_left;
 	void *dma_buf;
+	struct geni_se *se = &gi2c->se;
+	size_t len = msg->len;
 
 	gi2c->cur = msg;
 	mode = GENI_SE_FIFO;
@@ -418,23 +418,18 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	if (dma_buf)
 		mode = GENI_SE_DMA;
 
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
+	geni_se_select_mode(se, mode);
+	writel_relaxed(len, se->base + SE_I2C_TX_TRANS_LEN);
+	geni_se_setup_m_cmd(se, I2C_WRITE, m_param);
+
+	if (dma_buf && geni_se_tx_dma_prep(se, dma_buf, len, &tx_dma)) {
+		mode = GENI_SE_FIFO;
+		geni_se_select_mode(se, mode);
+		i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
 	}
 
 	if (mode == GENI_SE_FIFO) /* Get FIFO IRQ */
-		writel_relaxed(1, gi2c->se.base + SE_GENI_TX_WATERMARK_REG);
+		writel_relaxed(1, se->base + SE_GENI_TX_WATERMARK_REG);
 
 	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
 	if (!time_left)
@@ -444,9 +439,10 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	if (mode == GENI_SE_DMA) {
 		if (gi2c->err)
 			geni_i2c_tx_fsm_rst(gi2c);
-		geni_se_tx_dma_unprep(&gi2c->se, tx_dma, msg->len);
+		geni_se_tx_dma_unprep(se, tx_dma, len);
 		i2c_put_dma_safe_msg_buf(dma_buf, msg, !gi2c->err);
 	}
+
 	return gi2c->err;
 }
 
-- 
Sent by a computer through tubes
