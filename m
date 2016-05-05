From: Naveen Kaje <nkaje@codeaurora.org>
Subject: [PATCH] i2c: qup: use address helper function in read transfer
Date: Thu,  5 May 2016 12:33:17 -0600
Message-ID: <1462473197-28393-1-git-send-email-nkaje@codeaurora.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45007 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756001AbcEESdY (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 5 May 2016 14:33:24 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Naveen Kaje <nkaje@codeaurora.org>

qup_i2c_issue_read() derives the address from i2c_msg.
This called in the read path when I2C_M_RD flag is set.
Therefore, use the 8 bit address helper function.

Signed-off-by: Naveen Kaje <nkaje@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 8082919..072e352 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1038,7 +1038,7 @@ static void qup_i2c_issue_read(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 {
 	u32 addr, len, val;
 
-	addr = (msg->addr << 1) | 1;
+	addr = i2c_8bit_addr_from_msg(msg);
 
 	/* 0 is used to specify a length 256 (QUP_READ_LIMIT) */
 	len = (msg->len == QUP_READ_LIMIT) ? 0 : msg->len;
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
