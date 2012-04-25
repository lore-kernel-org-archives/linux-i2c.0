From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c: muxes: rename first set of drivers to a standard pattern
Date: Wed, 25 Apr 2012 22:43:56 +0200
Message-ID: <1335386636-23892-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Apply a naming pattern like in the rest of the subsystem to a first set
of mux drivers. Those drivers are the low-hanging fruit; we want to pick
them to motivate upcoming drivers to follow the new pattern. The missing
GPIO driver will be converted in a later patch.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Acked-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org> (pca9541)
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/muxes/Kconfig                          |    4 ++--
 drivers/i2c/muxes/Makefile                         |    4 ++--
 drivers/i2c/muxes/{pca9541.c => i2c-mux-pca9541.c} |    0
 drivers/i2c/muxes/{pca954x.c => i2c-mux-pca954x.c} |    0
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename drivers/i2c/muxes/{pca9541.c => i2c-mux-pca9541.c} (100%)
 rename drivers/i2c/muxes/{pca954x.c => i2c-mux-pca954x.c} (100%)

diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index 90b7a01..e14a420 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -25,7 +25,7 @@ config I2C_MUX_PCA9541
 	  I2C Master Selector.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called pca9541.
+	  will be called i2c-mux-pca9541.
 
 config I2C_MUX_PCA954x
 	tristate "Philips PCA954x I2C Mux/switches"
@@ -35,6 +35,6 @@ config I2C_MUX_PCA954x
 	  I2C mux/switch devices.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called pca954x.
+	  will be called i2c-mux-pca954x.
 
 endmenu
diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
index 4640436..0868335 100644
--- a/drivers/i2c/muxes/Makefile
+++ b/drivers/i2c/muxes/Makefile
@@ -2,7 +2,7 @@
 # Makefile for multiplexer I2C chip drivers.
 
 obj-$(CONFIG_I2C_MUX_GPIO)	+= gpio-i2cmux.o
-obj-$(CONFIG_I2C_MUX_PCA9541)	+= pca9541.o
-obj-$(CONFIG_I2C_MUX_PCA954x)	+= pca954x.o
+obj-$(CONFIG_I2C_MUX_PCA9541)	+= i2c-mux-pca9541.o
+obj-$(CONFIG_I2C_MUX_PCA954x)	+= i2c-mux-pca954x.o
 
 ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
diff --git a/drivers/i2c/muxes/pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
similarity index 100%
rename from drivers/i2c/muxes/pca9541.c
rename to drivers/i2c/muxes/i2c-mux-pca9541.c
diff --git a/drivers/i2c/muxes/pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
similarity index 100%
rename from drivers/i2c/muxes/pca954x.c
rename to drivers/i2c/muxes/i2c-mux-pca954x.c
-- 
1.7.10
