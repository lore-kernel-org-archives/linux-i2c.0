From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 10/18] i2c: i2c-iop3xx: use new 8 bit address helper function
Date: Sun,  3 Apr 2016 20:44:53 +0200
Message-ID: <1459709101-24462-11-git-send-email-wsa@the-dreams.de>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51927 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752745AbcDCSp1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Apr 2016 14:45:27 -0400
In-Reply-To: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-iop3xx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
index 72d6161cf77c0d..85cbe4b5557861 100644
--- a/drivers/i2c/busses/i2c-iop3xx.c
+++ b/drivers/i2c/busses/i2c-iop3xx.c
@@ -50,10 +50,7 @@ iic_cook_addr(struct i2c_msg *msg)
 {
 	unsigned char addr;
 
-	addr = (msg->addr << 1);
-
-	if (msg->flags & I2C_M_RD)
-		addr |= 1;
+	addr = i2c_8bit_addr_from_msg(msg);
 
 	return addr;
 }
-- 
2.7.0
