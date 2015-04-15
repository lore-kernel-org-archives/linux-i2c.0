From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] i2c: jz4780: Explicitly include linux/io.h
Date: Wed, 15 Apr 2015 19:08:11 +0100
Message-ID: <1429121291-28643-1-git-send-email-broonie@kernel.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This driver uses readw() and writew() which are declared in asm/io.h but
does not explicitly include that header, causing build failures on
architectures where there is not an implicit inclusion such as arm and
arm64:

../drivers/i2c/busses/i2c-jz4780.c:181:2: error: implicit declaration of function 'readw' [-Werror=implicit-function-declaration]
../drivers/i2c/busses/i2c-jz4780.c:187:2: error: implicit declaration of function 'writew' [-Werror=implicit-function-declaration]

Add an explicit inclusion to fix this.

Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-jz4780.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-jz4780.c b/drivers/i2c/busses/i2c-jz4780.c
index ce1d69324169..19b2d689a5ef 100644
--- a/drivers/i2c/busses/i2c-jz4780.c
+++ b/drivers/i2c/busses/i2c-jz4780.c
@@ -23,6 +23,7 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-- 
2.1.4
