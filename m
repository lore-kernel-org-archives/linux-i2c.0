From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH v2] i2c: jz4780: Fix build for m68k and sparc64
Date: Wed, 15 Apr 2015 08:48:47 -0700
Message-ID: <1429112927-19789-1-git-send-email-linux@roeck-us.net>
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

The driver has to include linux/io.h.

Fixes: ba92222ed63a ("i2c: jz4780: Add i2c bus controller driver
	for Ingenic JZ4780")
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
v2: HAS_IOMEM dependency already existed
    Fixed include file order

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
2.1.0
