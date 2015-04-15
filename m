From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH] i2c: jz4780: Fix build for m68k and sparc64
Date: Tue, 14 Apr 2015 20:21:13 -0700
Message-ID: <1429068073-7595-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Fix:

drivers/i2c/busses/i2c-jz4780.c: In function 'jz4780_i2c_readw':
drivers/i2c/busses/i2c-jz4780.c:181:2: error:
		implicit declaration of function 'readw'
drivers/i2c/busses/i2c-jz4780.c: In function 'jz4780_i2c_writew':
drivers/i2c/busses/i2c-jz4780.c:187:2: error:
		implicit declaration of function 'writew'

seen with sparc64:allmodconfig and m68k:allmodconfig.

The driver depends on HAS_IOMEM, and must include linux/io.h.

Fixes: ba92222ed63a ("i2c: jz4780: Add i2c bus controller driver
	for Ingenic JZ4780")
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
 drivers/i2c/busses/Kconfig      | 1 +
 drivers/i2c/busses/i2c-jz4780.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 2255af23b9c7..c78b6cbd1106 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -586,6 +586,7 @@ config I2C_IOP3XX
 config I2C_JZ4780
 	tristate "JZ4780 I2C controller interface support"
 	depends on MACH_JZ4780 || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	 If you say yes to this option, support will be included for the
 	 Ingenic JZ4780 I2C controller.
diff --git a/drivers/i2c/busses/i2c-jz4780.c b/drivers/i2c/busses/i2c-jz4780.c
index ce1d69324169..f2761ab2ef32 100644
--- a/drivers/i2c/busses/i2c-jz4780.c
+++ b/drivers/i2c/busses/i2c-jz4780.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
+#include <linux/io.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-- 
2.1.0
