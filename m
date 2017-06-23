From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: zx2967: always use the same device when printing errors
Date: Fri, 23 Jun 2017 21:05:30 +0200
Message-ID: <20170623190530.19614-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41285 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754327AbdFWTFh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 23 Jun 2017 15:05:37 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@the-dreams.de>

Let's always use the platform device for dev_* and not sometimes the
adapter device as well. Also fix this checkpatch check:

CHECK: Macro argument 'i2c' may be better as '(i2c)' to avoid precedence issues

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-zx2967.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-zx2967.c b/drivers/i2c/busses/i2c-zx2967.c
index 3e381edc0f223a..48281c1b30c6d5 100644
--- a/drivers/i2c/busses/i2c-zx2967.c
+++ b/drivers/i2c/busses/i2c-zx2967.c
@@ -53,7 +53,7 @@
 
 #define I2C_TIMEOUT			msecs_to_jiffies(1000)
 
-#define DEV(i2c)			(&i2c->adap.dev)
+#define DEV(i2c)			((i2c)->adap.dev.parent)
 
 struct zx2967_i2c {
 	struct i2c_adapter	adap;
-- 
2.11.0
