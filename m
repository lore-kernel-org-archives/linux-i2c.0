From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] i2c: algo-bit: Move debug variable
Date: Fri, 16 Feb 2018 13:44:55 +0100
Message-ID: <20180216124455.20491-1-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38649 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967416AbeBPMpC (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 16 Feb 2018 07:45:02 -0500
Received: by mail-lf0-f67.google.com with SMTP id g72so3876204lfg.5
        for <linux-i2c@vger.kernel.org>; Fri, 16 Feb 2018 04:45:01 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>

The variable "i2c_debug" is in a real weird place. If DEBUG
happens to be defined (because someone wants to do debugging)
the macro bit_dbg() is already using it some lines up in
the code, so compilation will fail.

After this patch, it is possible to define DEBUG and then
pass a debug level to the module with the i2c_debug
parameter, which is probably what is intended.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/i2c/algos/i2c-algo-bit.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 3df0efd69ae3..47e0088ab904 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -29,6 +29,10 @@
 /* ----- global defines ----------------------------------------------- */
 
 #ifdef DEBUG
+static int i2c_debug = 1;
+module_param(i2c_debug, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(i2c_debug,
+		 "debug level - 0 off; 1 normal; 2 verbose; 3 very verbose");
 #define bit_dbg(level, dev, format, args...) \
 	do { \
 		if (i2c_debug >= level) \
@@ -45,13 +49,6 @@ static int bit_test;	/* see if the line-setting functions work	*/
 module_param(bit_test, int, S_IRUGO);
 MODULE_PARM_DESC(bit_test, "lines testing - 0 off; 1 report; 2 fail if stuck");
 
-#ifdef DEBUG
-static int i2c_debug = 1;
-module_param(i2c_debug, int, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(i2c_debug,
-		 "debug level - 0 off; 1 normal; 2 verbose; 3 very verbose");
-#endif
-
 /* --- setting states on the bus with the right timing: ---------------	*/
 
 #define setsda(adap, val)	adap->setsda(adap->data, val)
-- 
2.14.3
