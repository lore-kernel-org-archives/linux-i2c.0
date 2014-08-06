From: Pramod Gurav <pramod.gurav-edOiRQu9Xnj5XLMNweQjbQ@public.gmane.org>
Subject: [PATCH] i2c: qup: disable clks and return instead of just returning error
Date: Wed,  6 Aug 2014 18:03:25 +0530
Message-ID: <1407328405-25170-1-git-send-email-pramod.gurav@smartplayin.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Pramod Gurav <pramod.gurav-edOiRQu9Xnj5XLMNweQjbQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This fixes a error handling scenario where clocks were not being disabled
when QUP_OUTPUT_BLOCK_SIZE returns a size greater than the size of blk_sizes
array. So this patch adds a statement to jump to the fail lable to release the
clocks.

CC: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
CC: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
CC: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
CC: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
CC: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>

Signed-off-by: Pramod Gurav <pramod.gurav-edOiRQu9Xnj5XLMNweQjbQ@public.gmane.org>
---

Resending the patch by updating CCs list.
Fixed Typos in commit message noticed by Christopher.

 drivers/i2c/busses/i2c-qup.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 2a5efb5..3a4d64e 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -633,13 +633,17 @@ static int qup_i2c_probe(struct platform_device *pdev)
 	 * associated with each byte written/received
 	 */
 	size = QUP_OUTPUT_BLOCK_SIZE(io_mode);
-	if (size >= ARRAY_SIZE(blk_sizes))
-		return -EIO;
+	if (size >= ARRAY_SIZE(blk_sizes)) {
+		ret = -EIO;
+		goto fail;
+	}
 	qup->out_blk_sz = blk_sizes[size] / 2;
 
 	size = QUP_INPUT_BLOCK_SIZE(io_mode);
-	if (size >= ARRAY_SIZE(blk_sizes))
-		return -EIO;
+	if (size >= ARRAY_SIZE(blk_sizes)) {
+		ret = -EIO;
+		goto fail;
+	}
 	qup->in_blk_sz = blk_sizes[size] / 2;
 
 	size = QUP_OUTPUT_FIFO_SIZE(io_mode);
-- 
1.7.9.5
