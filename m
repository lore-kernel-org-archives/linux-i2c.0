From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 17/18] i2c: i2c-sirf: use new 8 bit address helper function
Date: Sun,  3 Apr 2016 20:45:00 +0200
Message-ID: <1459709101-24462-18-git-send-email-wsa@the-dreams.de>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51943 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858AbcDCSpd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Apr 2016 14:45:33 -0400
In-Reply-To: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-sirf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 13e51ef6af73df..792a42bdd335b9 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -190,9 +190,7 @@ static void i2c_sirfsoc_set_address(struct sirfsoc_i2c *siic,
 
 	writel(regval, siic->base + SIRFSOC_I2C_CMD(siic->cmd_ptr++));
 
-	addr = msg->addr << 1;	/* Generate address */
-	if (msg->flags & I2C_M_RD)
-		addr |= 1;
+	addr = i2c_8bit_addr_from_msg(msg);
 
 	/* Reverse direction bit */
 	if (msg->flags & I2C_M_REV_DIR_ADDR)
-- 
2.7.0
