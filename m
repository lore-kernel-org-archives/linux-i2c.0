From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 09/18] i2c: i2c-img-scb: use new 8 bit address helper function
Date: Sun,  3 Apr 2016 20:44:52 +0200
Message-ID: <1459709101-24462-10-git-send-email-wsa@the-dreams.de>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51925 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752745AbcDCSp0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Apr 2016 14:45:26 -0400
In-Reply-To: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-img-scb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 379ef9c316645a..ea20425b697217 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -751,9 +751,7 @@ static unsigned int img_i2c_atomic(struct img_i2c *i2c,
 	switch (i2c->at_cur_cmd) {
 	case CMD_GEN_START:
 		next_cmd = CMD_GEN_DATA;
-		next_data = (i2c->msg.addr << 1);
-		if (i2c->msg.flags & I2C_M_RD)
-			next_data |= 0x1;
+		next_data = i2c_8bit_addr_from_msg(&i2c->msg);
 		break;
 	case CMD_GEN_DATA:
 		if (i2c->line_status & LINESTAT_INPUT_HELD_V)
-- 
2.7.0
