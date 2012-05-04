From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 05/15] ARM: ux500: Enable the user LED on Snowball via Device Tree
Date: Fri,  4 May 2012 19:23:15 +0100
Message-ID: <1336155805-18554-6-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336155805-18554-1-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch enables and illuminates the user_led on the
Snowball low-cost development board using DT. It also
removes initialisation carried out from platform code.

Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/boot/dts/snowball.dts     |    1 +
 arch/arm/mach-ux500/board-mop500.c |    3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index 56f8a76..579c304 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -67,6 +67,7 @@
 		used-led {
 			label = "user_led";
 			gpios = <&gpio4 14 0x4>;
+			default-state = "on";
 		};
 	};
 
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 4b847cb..7810334 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -579,7 +579,6 @@ static struct platform_device *snowball_platform_devs[] __initdata = {
 };
 
 static struct platform_device *snowball_of_platform_devs[] __initdata = {
-	&snowball_led_dev,
 	&snowball_key_dev,
 	&ab8500_device,
 };
@@ -783,7 +782,7 @@ static void __init u8500_init_machine(void)
 
 		/*
 		 * Devices to be DT:ed:
-		 *   snowball_led_dev   = todo
+		 *   snowball_led_dev   = done
 		 *   snowball_key_dev   = todo
 		 *   snowball_sbnet_dev = done
 		 *   ab8500_device      = todo
-- 
1.7.9.5
