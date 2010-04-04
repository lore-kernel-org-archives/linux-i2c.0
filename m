From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] blackfin/acvilon: Fix timeout usage for I2C
Date: Sun,  4 Apr 2010 16:04:16 +0200
Message-ID: <1270389856-32003-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, Valentin Yakovenkov <yakovenkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The timeout value is in jiffies, so it should be using HZ, not a plain
number. As '10000' is ambiguous, 1HZ is used as conservative default.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: Valentin Yakovenkov <yakovenkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/blackfin/mach-bf561/boards/acvilon.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/blackfin/mach-bf561/boards/acvilon.c b/arch/blackfin/mach-bf561/boards/acvilon.c
index 5163e2c..bfcfa86 100644
--- a/arch/blackfin/mach-bf561/boards/acvilon.c
+++ b/arch/blackfin/mach-bf561/boards/acvilon.c
@@ -44,6 +44,7 @@
 #include <linux/spi/flash.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/jiffies.h>
 #include <linux/i2c-pca-platform.h>
 #include <linux/delay.h>
 #include <linux/io.h>
@@ -112,7 +113,7 @@ static struct resource bfin_i2c_pca_resources[] = {
 struct i2c_pca9564_pf_platform_data pca9564_platform_data = {
 	.gpio = -1,
 	.i2c_clock_speed = 330000,
-	.timeout = 10000
+	.timeout = HZ,
 };
 
 /* PCA9564 I2C Bus driver */
-- 
1.7.0
