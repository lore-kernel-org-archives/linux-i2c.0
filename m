From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 08/18] i2c: i2c-ibm_iic: use new 8 bit address helper function
Date: Sun,  3 Apr 2016 20:44:51 +0200
Message-ID: <1459709101-24462-9-git-send-email-wsa@the-dreams.de>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51907 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734AbcDCSpU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Apr 2016 14:45:20 -0400
In-Reply-To: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-ibm_iic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index b6c08033429734..cdaa7be2cd1b94 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -269,7 +269,7 @@ static int iic_smbus_quick(struct ibm_iic_private* dev, const struct i2c_msg* p)
 	ndelay(t->hd_sta);
 
 	/* Send address */
-	v = (u8)((p->addr << 1) | ((p->flags & I2C_M_RD) ? 1 : 0));
+	v = i2c_8bit_addr_from_msg(p);
 	for (i = 0, mask = 0x80; i < 8; ++i, mask >>= 1){
 		out_8(&iic->directcntl, sda);
 		ndelay(t->low / 2);
-- 
2.7.0
