From: Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH 07/12] i2c: qup: use the complete transfer length to choose DMA mode
Date: Sat,  3 Feb 2018 13:28:12 +0530
Message-ID: <1517644697-30806-8-git-send-email-absahu@codeaurora.org>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>, Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Abhishek Sahu <absahu@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

Currently each message length in complete transfer is being
checked for determining DMA mode and if any of the message length
is less than FIFO length then non DMA mode is being used which
will increase overhead. DMA can be used for any length and it
should be determined with complete transfer length. Now, this
patch introduces DMA threshold length and the transfer will be
done in DMA mode if the total length is greater than this
threshold length.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 6227a5c..a91fc70 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -192,6 +192,8 @@ struct qup_i2c_dev {
 	bool			is_dma;
 	/* To check if the current transfer is using DMA */
 	bool			use_dma;
+	/* The threshold length above which DMA will be used */
+	unsigned int		dma_threshold;
 	struct			dma_pool *dpool;
 	struct			qup_i2c_tag start_tag;
 	struct			qup_i2c_bam brx;
@@ -1294,7 +1296,8 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
 			   int num)
 {
 	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
-	int ret, len, idx = 0;
+	int ret, idx = 0;
+	unsigned int total_len = 0;
 
 	qup->bus_err = 0;
 	qup->qup_err = 0;
@@ -1320,14 +1323,13 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
 				goto out;
 			}
 
-			len = (msgs[idx].len > qup->out_fifo_sz) ||
-			      (msgs[idx].len > qup->in_fifo_sz);
-
-			if (is_vmalloc_addr(msgs[idx].buf) || !len)
+			if (is_vmalloc_addr(msgs[idx].buf))
 				break;
+
+			total_len += msgs[idx].len;
 		}
 
-		if (idx == num)
+		if (idx == num && total_len > qup->dma_threshold)
 			qup->use_dma = true;
 	}
 
@@ -1587,6 +1589,7 @@ static int qup_i2c_probe(struct platform_device *pdev)
 
 	size = QUP_INPUT_FIFO_SIZE(io_mode);
 	qup->in_fifo_sz = qup->in_blk_sz * (2 << size);
+	qup->dma_threshold = min(qup->out_fifo_sz, qup->in_fifo_sz);
 
 	fs_div = ((src_clk_freq / clk_freq) / 2) - 3;
 	hs_div = 3;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
