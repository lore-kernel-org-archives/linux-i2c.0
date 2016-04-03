From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 15/18] i2c: i2c-qup: use new 8 bit address helper function
Date: Sun,  3 Apr 2016 20:44:58 +0200
Message-ID: <1459709101-24462-16-git-send-email-wsa@the-dreams.de>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51938 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817AbcDCSpb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Apr 2016 14:45:31 -0400
In-Reply-To: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-qup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 23eaabb19f961a..cc6439ab3f7141 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -515,7 +515,7 @@ static int qup_i2c_get_data_len(struct qup_i2c_dev *qup)
 static int qup_i2c_set_tags(u8 *tags, struct qup_i2c_dev *qup,
 			    struct i2c_msg *msg,  int is_dma)
 {
-	u16 addr = (msg->addr << 1) | ((msg->flags & I2C_M_RD) == I2C_M_RD);
+	u16 addr = i2c_8bit_addr_from_msg(msg);
 	int len = 0;
 	int data_len;
 
-- 
2.7.0
