From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH] i2c: elektor: Utilize the module_isa_driver macro
Date: Tue, 31 May 2016 11:37:13 -0400
Message-ID: <20160531153713.GA31615@sophia>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36507 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbcEaPhV (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 31 May 2016 11:37:21 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

This driver does not do anything special in module init/exit. This patch
eliminates the module init/exit boilerplate code by utilizing the
module_isa_driver macro.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/i2c/busses/i2c-elektor.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
index 92e8c0c..aa0cc5c 100644
--- a/drivers/i2c/busses/i2c-elektor.c
+++ b/drivers/i2c/busses/i2c-elektor.c
@@ -319,16 +319,6 @@ static struct isa_driver i2c_elektor_driver = {
 	},
 };
 
-static int __init i2c_pcfisa_init(void)
-{
-	return isa_register_driver(&i2c_elektor_driver, 1);
-}
-
-static void __exit i2c_pcfisa_exit(void)
-{
-	isa_unregister_driver(&i2c_elektor_driver);
-}
-
 MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
 MODULE_DESCRIPTION("I2C-Bus adapter routines for PCF8584 ISA bus adapter");
 MODULE_LICENSE("GPL");
@@ -339,5 +329,4 @@ module_param(clock, int, 0);
 module_param(own, int, 0);
 module_param(mmapped, int, 0);
 
-module_init(i2c_pcfisa_init);
-module_exit(i2c_pcfisa_exit);
+module_isa_driver(i2c_elektor_driver, 1);
-- 
2.7.3
