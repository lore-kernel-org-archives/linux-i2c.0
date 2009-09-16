From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] MAINTAINERS: add maintainer for AT24 and PCA9564/PCA9665
Date: Wed, 16 Sep 2009 11:30:33 +0200
Message-ID: <1253093433-6988-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add me as the maintainer for the i2c-drivers I feel responsible for as I found
patches going mainline I missed due to no cc.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---

AT24 is negotiated with David before and Ian was unavailable for the
PCA-drivers (due to no hardware) in January 2008 already.

Based on linus-git (is that okay, Jean?)

 MAINTAINERS |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 837b598..396870e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -894,6 +894,13 @@ F:	drivers/dma/
 F:	include/linux/dmaengine.h
 F:	include/linux/async_tx.h
 
+AT24 EEPROM DRIVER
+M:	Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
+L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+S:	Maintained
+F:	drivers/misc/eeprom/at24.c
+F:	include/linux/i2c/at24.h
+
 ATA OVER ETHERNET (AOE) DRIVER
 M:	"Ed L. Cashin" <ecashin-kFqnmIA2sJXQT0dZR+AlfA@public.gmane.org>
 W:	http://www.coraid.com/support/linux
@@ -3935,6 +3942,15 @@ M:	Jim Cromie <jim.cromie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
 S:	Maintained
 F:	drivers/char/pc8736x_gpio.c
 
+PCA9564/PCA9665 I2C BUS DRIVER
+M:	Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
+L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+S:	Maintained
+F:	drivers/i2c/algos/i2c-algo-pca.c
+F:	drivers/i2c/busses/i2c-pca*
+F:	include/linux/i2c-algo-pca.h
+F:	include/linux/i2c-pca-platform.h
+
 PCA9532 LED DRIVER
 M:	Riku Voipio <riku.voipio-X3B1VOXEql0@public.gmane.org>
 S:	Maintained
-- 
1.6.3.3
