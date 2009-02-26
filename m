From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH] i2c: Initialise Samsung I2C controller early
Date: Thu, 26 Feb 2009 16:29:22 +0000
Message-ID: <1235665762-20400-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is required in order to ensure that core system devices such as
voltage regulators attached via I2C are avaiable early in boot.

Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 drivers/i2c/busses/i2c-s3c2410.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 5b7f956..91f6a1e 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -1018,14 +1018,13 @@ static int __init i2c_adap_s3c_init(void)
 
 	return ret;
 }
+subsys_initcall(i2c_adap_s3c_init);
 
 static void __exit i2c_adap_s3c_exit(void)
 {
 	platform_driver_unregister(&s3c2410_i2c_driver);
 	platform_driver_unregister(&s3c2440_i2c_driver);
 }
-
-module_init(i2c_adap_s3c_init);
 module_exit(i2c_adap_s3c_exit);
 
 MODULE_DESCRIPTION("S3C24XX I2C Bus driver");
-- 
1.6.1.3
