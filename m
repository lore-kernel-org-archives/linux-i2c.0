From: Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH 08/12] i2c: qup: change completion timeout according to transfer length
Date: Sat,  3 Feb 2018 13:28:13 +0530
Message-ID: <1517644697-30806-9-git-send-email-absahu@codeaurora.org>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>, Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Abhishek Sahu <absahu@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

Currently the completion timeout is being taken according to
maximum transfer length which is too high if SCL is operating in
high frequency. This patch calculates timeout on the basis of
one-byte transfer time and uses the same for completion timeout.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index a91fc70..6df65ea 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -130,8 +130,8 @@
 #define MX_TX_RX_LEN			SZ_64K
 #define MX_BLOCKS			(MX_TX_RX_LEN / QUP_READ_LIMIT)
 
-/* Max timeout in ms for 32k bytes */
-#define TOUT_MAX			300
+/* Min timeout for i2c transfers */
+#define TOUT_MIN			2
 
 /* Default values. Use these if FW query fails */
 #define DEFAULT_CLK_FREQ 100000
@@ -172,6 +172,7 @@ struct qup_i2c_dev {
 	int			in_blk_sz;
 
 	unsigned long		one_byte_t;
+	unsigned long		xfer_timeout;
 	struct qup_i2c_block	blk;
 
 	struct i2c_msg		*msg;
@@ -845,7 +846,7 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
 		dma_async_issue_pending(qup->brx.dma);
 	}
 
-	if (!wait_for_completion_timeout(&qup->xfer, TOUT_MAX * HZ)) {
+	if (!wait_for_completion_timeout(&qup->xfer, qup->xfer_timeout)) {
 		dev_err(qup->dev, "normal trans timed out\n");
 		ret = -ETIMEDOUT;
 	}
@@ -1601,6 +1602,8 @@ static int qup_i2c_probe(struct platform_device *pdev)
 	 */
 	one_bit_t = (USEC_PER_SEC / clk_freq) + 1;
 	qup->one_byte_t = one_bit_t * 9;
+	qup->xfer_timeout = TOUT_MIN * HZ +
+			    usecs_to_jiffies(MX_TX_RX_LEN * qup->one_byte_t);
 
 	dev_dbg(qup->dev, "IN:block:%d, fifo:%d, OUT:block:%d, fifo:%d\n",
 		qup->in_blk_sz, qup->in_fifo_sz,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
