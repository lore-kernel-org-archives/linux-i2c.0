From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 11/18] i2c: i2c-lpc2k: use new 8 bit address helper function
Date: Sun,  3 Apr 2016 20:44:54 +0200
Message-ID: <1459709101-24462-12-git-send-email-wsa@the-dreams.de>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51929 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752761AbcDCSp1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Apr 2016 14:45:27 -0400
In-Reply-To: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-lpc2k.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-lpc2k.c b/drivers/i2c/busses/i2c-lpc2k.c
index 8560a13bf1b308..586a15205e61de 100644
--- a/drivers/i2c/busses/i2c-lpc2k.c
+++ b/drivers/i2c/busses/i2c-lpc2k.c
@@ -133,9 +133,7 @@ static void i2c_lpc2k_pump_msg(struct lpc2k_i2c *i2c)
 	case M_START:
 	case M_REPSTART:
 		/* Start bit was just sent out, send out addr and dir */
-		data = i2c->msg->addr << 1;
-		if (i2c->msg->flags & I2C_M_RD)
-			data |= 1;
+		data = i2c_8bit_addr_from_msg(i2c->msg);
 
 		writel(data, i2c->base + LPC24XX_I2DAT);
 		writel(LPC24XX_STA, i2c->base + LPC24XX_I2CONCLR);
-- 
2.7.0
