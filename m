From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 03/18] i2c: core: use new 8 bit address helper function
Date: Sun,  3 Apr 2016 20:44:46 +0200
Message-ID: <1459709101-24462-4-git-send-email-wsa@the-dreams.de>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51895 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752406AbcDCSpP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Apr 2016 14:45:15 -0400
In-Reply-To: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 0f2f8484e8ec1f..778d316de9f8ca 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2652,7 +2652,7 @@ static u8 i2c_smbus_pec(u8 crc, u8 *p, size_t count)
 static u8 i2c_smbus_msg_pec(u8 pec, struct i2c_msg *msg)
 {
 	/* The address will be sent first */
-	u8 addr = (msg->addr << 1) | !!(msg->flags & I2C_M_RD);
+	u8 addr = i2c_8bit_addr_from_msg(msg);
 	pec = i2c_smbus_pec(pec, &addr, 1);
 
 	/* The data buffer follows */
-- 
2.7.0
