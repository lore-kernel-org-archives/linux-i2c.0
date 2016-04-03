From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 12/18] i2c: i2c-mt65xx: use new 8 bit address helper function
Date: Sun,  3 Apr 2016 20:44:55 +0200
Message-ID: <1459709101-24462-13-git-send-email-wsa@the-dreams.de>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51931 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752745AbcDCSp2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Apr 2016 14:45:28 -0400
In-Reply-To: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-mt65xx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 453358b4d9ca7a..d9373e60be8ae3 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -413,10 +413,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 	else
 		writew(I2C_FS_START_CON, i2c->base + OFFSET_EXT_CONF);
 
-	addr_reg = msgs->addr << 1;
-	if (i2c->op == I2C_MASTER_RD)
-		addr_reg |= 0x1;
-
+	addr_reg = i2c_8bit_addr_from_msg(msgs);
 	writew(addr_reg, i2c->base + OFFSET_SLAVE_ADDR);
 
 	/* Clear interrupt status */
-- 
2.7.0
