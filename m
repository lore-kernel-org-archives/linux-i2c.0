From: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] MAINTAINERS: change my email and repos
Date: Fri,  8 Feb 2013 21:34:16 +0100
Message-ID: <1360355656-25714-1-git-send-email-wolfram@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Change to my private email, change to my shiny new kernel.org repos,
and drop outdated entry from the former maintainer. Drop my PCA entry,
too, since it belongs to the I2C realm anyhow.

Signed-off-by: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 MAINTAINERS |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8ae709e..8c13cc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1303,7 +1303,7 @@ F:	include/linux/dmaengine.h
 F:	include/linux/async_tx.h
 
 AT24 EEPROM DRIVER
-M:	Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
+M:	Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
 L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Maintained
 F:	drivers/misc/eeprom/at24.c
@@ -3757,12 +3757,11 @@ S:	Maintained
 F:	drivers/i2c/i2c-stub.c
 
 I2C SUBSYSTEM
-M:	Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
+M:	Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
 M:	"Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
 L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 W:	http://i2c.wiki.kernel.org/
-T:	quilt kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/
-T:	git git://git.pengutronix.de/git/wsa/linux.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
 S:	Maintained
 F:	Documentation/i2c/
 F:	drivers/i2c/
@@ -5778,15 +5777,6 @@ L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Maintained
 F:	drivers/i2c/muxes/i2c-mux-pca9541.c
 
-PCA9564/PCA9665 I2C BUS DRIVER
-M:	Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
-L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
-S:	Maintained
-F:	drivers/i2c/algos/i2c-algo-pca.c
-F:	drivers/i2c/busses/i2c-pca-*
-F:	include/linux/i2c-algo-pca.h
-F:	include/linux/i2c-pca-platform.h
-
 PCDP - PRIMARY CONSOLE AND DEBUG PORT
 M:	Khalid Aziz <khalid-21RPF02GE+GXwddmVfQv5g@public.gmane.org>
 S:	Maintained
-- 
1.7.10.4
