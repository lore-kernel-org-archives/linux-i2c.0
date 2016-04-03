From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 13/18] i2c: i2c-ocores: use new 8 bit address helper function
Date: Sun,  3 Apr 2016 20:44:56 +0200
Message-ID: <1459709101-24462-14-git-send-email-wsa@the-dreams.de>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51934 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817AbcDCSp3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Apr 2016 14:45:29 -0400
In-Reply-To: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-ocores.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 11b7b87311ed2f..dfa7a4b4a91d78 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -178,10 +178,7 @@ static void ocores_process(struct ocores_i2c *i2c)
 		if (i2c->nmsgs) {	/* end? */
 			/* send start? */
 			if (!(msg->flags & I2C_M_NOSTART)) {
-				u8 addr = (msg->addr << 1);
-
-				if (msg->flags & I2C_M_RD)
-					addr |= 1;
+				u8 addr = i2c_8bit_addr_from_msg(msg);
 
 				i2c->state = STATE_START;
 
-- 
2.7.0
