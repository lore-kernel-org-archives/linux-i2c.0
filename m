From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH] i2c: pca-isa: Utilize the module_isa_driver macro
Date: Tue, 31 May 2016 12:22:34 -0400
Message-ID: <20160531162223.GA17106@sophia>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36119 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbcEaQWm (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 31 May 2016 12:22:42 -0400
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
 drivers/i2c/busses/i2c-pca-isa.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pca-isa.c b/drivers/i2c/busses/i2c-pca-isa.c
index e0eb4ca..d916fc4 100644
--- a/drivers/i2c/busses/i2c-pca-isa.c
+++ b/drivers/i2c/busses/i2c-pca-isa.c
@@ -193,16 +193,6 @@ static struct isa_driver pca_isa_driver = {
 	}
 };
 
-static int __init pca_isa_init(void)
-{
-	return isa_register_driver(&pca_isa_driver, 1);
-}
-
-static void __exit pca_isa_exit(void)
-{
-	isa_unregister_driver(&pca_isa_driver);
-}
-
 MODULE_AUTHOR("Ian Campbell <icampbell@arcom.com>");
 MODULE_DESCRIPTION("ISA base PCA9564/PCA9665 driver");
 MODULE_LICENSE("GPL");
@@ -221,5 +211,4 @@ MODULE_PARM_DESC(clock, "Clock rate in hertz.\n\t\t"
 		"\t\t\t\tFast+: 400100 - 10000099\n"
 		"\t\t\t\tTurbo: Up to 1265800");
 
-module_init(pca_isa_init);
-module_exit(pca_isa_exit);
+module_isa_driver(pca_isa_driver, 1);
-- 
2.7.3
