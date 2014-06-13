From: Christoph Jaeger <christophjaeger-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c-taos-evm: Use module_serio_driver()
Date: Fri, 13 Jun 2014 21:52:24 +0200
Message-ID: <1402689144-20259-1-git-send-email-christophjaeger@linux.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jdelvare-l3A5Bk7waGM@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christoph Jaeger <christophjaeger-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Get rid of some boilerplate code by using module_serio_driver().

Signed-off-by: Christoph Jaeger <christophjaeger-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-taos-evm.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-taos-evm.c b/drivers/i2c/busses/i2c-taos-evm.c
index 0576026..10855a0 100644
--- a/drivers/i2c/busses/i2c-taos-evm.c
+++ b/drivers/i2c/busses/i2c-taos-evm.c
@@ -311,19 +311,8 @@ static struct serio_driver taos_drv = {
 	.interrupt	= taos_interrupt,
 };
 
-static int __init taos_init(void)
-{
-	return serio_register_driver(&taos_drv);
-}
-
-static void __exit taos_exit(void)
-{
-	serio_unregister_driver(&taos_drv);
-}
+module_serio_driver(taos_drv);
 
 MODULE_AUTHOR("Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>");
 MODULE_DESCRIPTION("TAOS evaluation module driver");
 MODULE_LICENSE("GPL");
-
-module_init(taos_init);
-module_exit(taos_exit);
-- 
1.9.3
