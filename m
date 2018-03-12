From: Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH v2 03/13] i2c: qup: minor code reorganization for use_dma
Date: Mon, 12 Mar 2018 18:44:52 +0530
Message-ID: <1520860502-14886-4-git-send-email-absahu@codeaurora.org>
References: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>, Sricharan R <sricharan@codeaurora.org>, Austin Christ <austinwc@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Abhishek Sahu <absahu@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

1. Assigns use_dma in qup_dev structure itself which will
   help in subsequent patches to determine the mode in IRQ handler.
2. Does minor code reorganization for loops to reduce the
   unnecessary comparison and assignment.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
Reviewed-by: Austin Christ <austinwc@codeaurora.org>
Reviewed-by: Andy Gross <andy.gross@linaro.org>
---

* Changes from v1: None

 drivers/i2c/busses/i2c-qup.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 75e9819..f6ea074 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -181,6 +181,8 @@ struct qup_i2c_dev {
 
 	/* dma parameters */
 	bool			is_dma;
+	/* To check if the current transfer is using DMA */
+	bool			use_dma;
 	struct			dma_pool *dpool;
 	struct			qup_i2c_tag start_tag;
 	struct			qup_i2c_bam brx;
@@ -1288,7 +1290,7 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
 			   int num)
 {
 	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
-	int ret, len, idx = 0, use_dma = 0;
+	int ret, len, idx = 0;
 
 	qup->bus_err = 0;
 	qup->qup_err = 0;
@@ -1317,13 +1319,12 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
 			len = (msgs[idx].len > qup->out_fifo_sz) ||
 			      (msgs[idx].len > qup->in_fifo_sz);
 
-			if ((!is_vmalloc_addr(msgs[idx].buf)) && len) {
-				use_dma = 1;
-			 } else {
-				use_dma = 0;
+			if (is_vmalloc_addr(msgs[idx].buf) || !len)
 				break;
-			}
 		}
+
+		if (idx == num)
+			qup->use_dma = true;
 	}
 
 	idx = 0;
@@ -1347,15 +1348,17 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
 
 		reinit_completion(&qup->xfer);
 
-		if (use_dma) {
+		if (qup->use_dma) {
 			ret = qup_i2c_bam_xfer(adap, &msgs[idx], num);
+			qup->use_dma = false;
+			break;
 		} else {
 			if (msgs[idx].flags & I2C_M_RD)
 				ret = qup_i2c_read_one_v2(qup, &msgs[idx]);
 			else
 				ret = qup_i2c_write_one_v2(qup, &msgs[idx]);
 		}
-	} while ((idx++ < (num - 1)) && !use_dma && !ret);
+	} while ((idx++ < (num - 1)) && !ret);
 
 	if (!ret)
 		ret = qup_i2c_change_state(qup, QUP_RESET_STATE);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
