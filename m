From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/2] video: adp8860: move header file out of I2C realm
Date: Mon, 22 May 2017 00:09:52 +0200
Message-ID: <20170521220953.2602-2-wsa@the-dreams.de>
References: <20170521220953.2602-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55526 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753915AbdEUWJ5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 21 May 2017 18:09:57 -0400
In-Reply-To: <20170521220953.2602-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Steven Miao <realmz6@gmail.com>, Michael Hennerich <michael.hennerich@analog.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, adi-buildroot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

include/linux/i2c is not for client devices. Move the header file to a
more appropriate location.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 arch/blackfin/mach-bf537/boards/stamp.c        | 2 +-
 drivers/video/backlight/adp8860_bl.c           | 2 +-
 include/linux/{i2c => platform_data}/adp8860.h | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/linux/{i2c => platform_data}/adp8860.h (100%)

diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/mach-bf537/boards/stamp.c
index 24985e658c19cd..7db90c72bd8ddc 100644
--- a/arch/blackfin/mach-bf537/boards/stamp.c
+++ b/arch/blackfin/mach-bf537/boards/stamp.c
@@ -2047,7 +2047,7 @@ static struct adp8870_backlight_platform_data adp8870_pdata = {
 #endif
 
 #if IS_ENABLED(CONFIG_BACKLIGHT_ADP8860)
-#include <linux/i2c/adp8860.h>
+#include <linux/platform_data/adp8860.h>
 static struct led_info adp8860_leds[] = {
 	{
 		.name = "adp8860-led7",
diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
index 510e559c060e59..e7315bf14d6015 100644
--- a/drivers/video/backlight/adp8860_bl.c
+++ b/drivers/video/backlight/adp8860_bl.c
@@ -18,7 +18,7 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
-#include <linux/i2c/adp8860.h>
+#include <linux/platform_data/adp8860.h>
 #define ADP8860_EXT_FEATURES
 #define ADP8860_USE_LEDS
 
diff --git a/include/linux/i2c/adp8860.h b/include/linux/platform_data/adp8860.h
similarity index 100%
rename from include/linux/i2c/adp8860.h
rename to include/linux/platform_data/adp8860.h
-- 
2.11.0
