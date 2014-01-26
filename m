From: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] video: Update dependant blackfin i2c driver name string
Date: Sun, 26 Jan 2014 15:16:47 +0800
Message-ID: <1390720607-447-4-git-send-email-sonic.adi@gmail.com>
References: <1390720607-447-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390720607-447-1-git-send-email-sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

rename i2c bus driver name i2c-bfin-twi to i2c-adi-twi
rename I2C_BLACKFIN_TWI with I2C_ADI_TWI in framebuffer driver config options

Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 drivers/video/Kconfig          | 2 +-
 drivers/video/bf537-lq035.c    | 2 +-
 drivers/video/bfin_adv7393fb.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 22262a3..18d44b5 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -614,7 +614,7 @@ config FB_BFIN_LQ035Q1
 
 config FB_BF537_LQ035
 	tristate "SHARP LQ035 TFT LCD (BF537 STAMP)"
-	depends on FB && (BF534 || BF536 || BF537) && I2C_BLACKFIN_TWI
+	depends on FB && (BF534 || BF536 || BF537) && I2C_ADI_TWI
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff --git a/drivers/video/bf537-lq035.c b/drivers/video/bf537-lq035.c
index a82d257..e934491 100644
--- a/drivers/video/bf537-lq035.c
+++ b/drivers/video/bf537-lq035.c
@@ -900,7 +900,7 @@ static struct platform_driver bfin_lq035_driver = {
 
 static int __init bfin_lq035_driver_init(void)
 {
-	request_module("i2c-bfin-twi");
+	request_module("i2c-adi-twi");
 	return platform_driver_register(&bfin_lq035_driver);
 }
 module_init(bfin_lq035_driver_init);
diff --git a/drivers/video/bfin_adv7393fb.c b/drivers/video/bfin_adv7393fb.c
index a54f7f7..4664343 100644
--- a/drivers/video/bfin_adv7393fb.c
+++ b/drivers/video/bfin_adv7393fb.c
@@ -795,8 +795,8 @@ static struct i2c_driver bfin_adv7393_fb_driver = {
 
 static int __init bfin_adv7393_fb_driver_init(void)
 {
-#if  defined(CONFIG_I2C_BLACKFIN_TWI) || defined(CONFIG_I2C_BLACKFIN_TWI_MODULE)
-	request_module("i2c-bfin-twi");
+#if IS_ENABLED(CONFIG_I2C_ADI_TWI)
+	request_module("i2c-adi-twi");
 #else
 	request_module("i2c-gpio");
 #endif
-- 
1.8.2.3
