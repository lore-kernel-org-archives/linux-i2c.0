From: Austin Christ <austinwc@codeaurora.org>
Subject: [PATCH] i2c-qup: reduce verbosity on DMA channel not found messages
Date: Tue, 16 Jan 2018 14:35:34 -0700
Message-ID: <1516138534-30842-2-git-send-email-austinwc@codeaurora.org>
References: <1516138534-30842-1-git-send-email-austinwc@codeaurora.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56348 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeAPVfn (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 16 Jan 2018 16:35:43 -0500
In-Reply-To: <1516138534-30842-1-git-send-email-austinwc@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: Sinan Kaya <okaya@codeaurora.org>, Austin Christ <austinwc@codeaurora.org>

From: Sinan Kaya <okaya@codeaurora.org>

QDF2400 product doesn't have any BAM DMA attached to the I2C channel. This
causes code to spit an unnecessary error message during boot.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Signed-off-by: Austin Christ <austinwc@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 08f8e01..c28d267 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -666,7 +666,7 @@ static int qup_i2c_req_dma(struct qup_i2c_dev *qup)
 		if (IS_ERR(qup->btx.dma)) {
 			err = PTR_ERR(qup->btx.dma);
 			qup->btx.dma = NULL;
-			dev_err(qup->dev, "\n tx channel not available");
+			dev_info(qup->dev, "\n tx channel not available");
 			return err;
 		}
 	}
@@ -674,7 +674,7 @@ static int qup_i2c_req_dma(struct qup_i2c_dev *qup)
 	if (!qup->brx.dma) {
 		qup->brx.dma = dma_request_slave_channel_reason(qup->dev, "rx");
 		if (IS_ERR(qup->brx.dma)) {
-			dev_err(qup->dev, "\n rx channel not available");
+			dev_info(qup->dev, "\n rx channel not available");
 			err = PTR_ERR(qup->brx.dma);
 			qup->brx.dma = NULL;
 			qup_i2c_rel_dma(qup);
-- 
1.9.1
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
