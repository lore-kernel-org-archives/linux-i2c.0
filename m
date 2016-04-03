From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 16/18] i2c: i2c-sh_mobile: use new 8 bit address helper function
Date: Sun,  3 Apr 2016 20:44:59 +0200
Message-ID: <1459709101-24462-17-git-send-email-wsa@the-dreams.de>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51940 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817AbcDCSpd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Apr 2016 14:45:33 -0400
In-Reply-To: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 7d2bd3ec2d2d25..6fb3e264599229 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -398,8 +398,7 @@ static void sh_mobile_i2c_get_data(struct sh_mobile_i2c_data *pd,
 {
 	switch (pd->pos) {
 	case -1:
-		*buf = (pd->msg->addr & 0x7f) << 1;
-		*buf |= (pd->msg->flags & I2C_M_RD) ? 1 : 0;
+		*buf = i2c_8bit_addr_from_msg(pd->msg);
 		break;
 	default:
 		*buf = pd->msg->buf[pd->pos];
-- 
2.7.0
