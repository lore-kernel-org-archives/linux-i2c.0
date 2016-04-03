From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 18/18] i2c: i2c-st: use new 8 bit address helper function
Date: Sun,  3 Apr 2016 20:45:01 +0200
Message-ID: <1459709101-24462-19-git-send-email-wsa@the-dreams.de>
References: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51946 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752873AbcDCSpe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Apr 2016 14:45:34 -0400
In-Reply-To: <1459709101-24462-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-st.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
index 6ee77159ac57a3..b3c182fea165e9 100644
--- a/drivers/i2c/busses/i2c-st.c
+++ b/drivers/i2c/busses/i2c-st.c
@@ -614,8 +614,7 @@ static int st_i2c_xfer_msg(struct st_i2c_dev *i2c_dev, struct i2c_msg *msg,
 	unsigned long timeout;
 	int ret;
 
-	c->addr		= (u8)(msg->addr << 1);
-	c->addr		|= (msg->flags & I2C_M_RD);
+	c->addr		= i2c_8bit_addr_from_msg(msg);
 	c->buf		= msg->buf;
 	c->count	= msg->len;
 	c->xfered	= 0;
-- 
2.7.0
