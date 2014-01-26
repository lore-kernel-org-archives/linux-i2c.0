From: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/4] i2c: rename Blackfin TWI I2C driver to i2c-adi-twi.c
Date: Sun, 26 Jan 2014 15:16:44 +0800
Message-ID: <1390720607-447-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Rename twi arch header as well.

Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 arch/blackfin/include/asm/{bfin_twi.h => twi.h}      |  0
 drivers/i2c/busses/Kconfig                           | 14 +++++++-------
 drivers/i2c/busses/Makefile                          |  2 +-
 drivers/i2c/busses/{i2c-bfin-twi.c => i2c-adi-twi.c} |  0
 4 files changed, 8 insertions(+), 8 deletions(-)
 rename arch/blackfin/include/asm/{bfin_twi.h => twi.h} (100%)
 rename drivers/i2c/busses/{i2c-bfin-twi.c => i2c-adi-twi.c} (100%)

diff --git a/arch/blackfin/include/asm/bfin_twi.h b/arch/blackfin/include/asm/twi.h
similarity index 100%
rename from arch/blackfin/include/asm/bfin_twi.h
rename to arch/blackfin/include/asm/twi.h
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 6bcdea5..1ff862f 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -356,19 +356,19 @@ config I2C_BCM_KONA
 
 	  If you do not need KONA I2C inteface, say N.
 
-config I2C_BLACKFIN_TWI
-	tristate "Blackfin TWI I2C support"
+config I2C_ADI_TWI
+	tristate "ADI TWI I2C support"
 	depends on BLACKFIN
 	depends on !BF561 && !BF531 && !BF532 && !BF533
 	help
-	  This is the I2C bus driver for Blackfin on-chip TWI interface.
+	  This is the I2C bus driver for ADI processors' TWI interface.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-bfin-twi.
+	  will be called i2c-adi-twi.
 
-config I2C_BLACKFIN_TWI_CLK_KHZ
-	int "Blackfin TWI I2C clock (kHz)"
-	depends on I2C_BLACKFIN_TWI
+config I2C_ADI_TWI_CLK_KHZ
+	int "ADI TWI I2C clock (kHz)"
+	depends on I2C_ADI_TWI
 	range 21 400
 	default 50
 	help
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index a08931f..9bb2e13 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -32,7 +32,7 @@ obj-$(CONFIG_I2C_POWERMAC)	+= i2c-powermac.o
 obj-$(CONFIG_I2C_AT91)		+= i2c-at91.o
 obj-$(CONFIG_I2C_AU1550)	+= i2c-au1550.o
 obj-$(CONFIG_I2C_BCM2835)	+= i2c-bcm2835.o
-obj-$(CONFIG_I2C_BLACKFIN_TWI)	+= i2c-bfin-twi.o
+obj-$(CONFIG_I2C_ADI_TWI)	+= i2c-adi-twi.o
 obj-$(CONFIG_I2C_CBUS_GPIO)	+= i2c-cbus-gpio.o
 obj-$(CONFIG_I2C_CPM)		+= i2c-cpm.o
 obj-$(CONFIG_I2C_DAVINCI)	+= i2c-davinci.o
diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-adi-twi.c
similarity index 100%
rename from drivers/i2c/busses/i2c-bfin-twi.c
rename to drivers/i2c/busses/i2c-adi-twi.c
-- 
1.8.2.3
