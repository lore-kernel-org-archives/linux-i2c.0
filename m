From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 35/47] i2c: remove bfin-twi driver
Date: Wed, 14 Mar 2018 16:35:48 +0100
Message-ID: <20180314153603.3127932-36-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The blackfin architecture is getting removed, so the
twi driver can also be removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/i2c/busses/Kconfig        |  18 -
 drivers/i2c/busses/Makefile       |   1 -
 drivers/i2c/busses/i2c-bfin-twi.c | 737 --------------------------------------
 3 files changed, 756 deletions(-)
 delete mode 100644 drivers/i2c/busses/i2c-bfin-twi.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 68ceac7617ff..4c0895165727 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -445,24 +445,6 @@ config I2C_BRCMSTB
 
 	  If you do not need I2C interface, say N.
 
-config I2C_BLACKFIN_TWI
-	tristate "Blackfin TWI I2C support"
-	depends on BLACKFIN
-	depends on !BF561 && !BF531 && !BF532 && !BF533
-	help
-	  This is the I2C bus driver for Blackfin on-chip TWI interface.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-bfin-twi.
-
-config I2C_BLACKFIN_TWI_CLK_KHZ
-	int "Blackfin TWI I2C clock (kHz)"
-	depends on I2C_BLACKFIN_TWI
-	range 21 400
-	default 50
-	help
-	  The unit of the TWI clock is kHz.
-
 config I2C_CADENCE
 	tristate "Cadence I2C Controller"
 	depends on ARCH_ZYNQ || ARM64 || XTENSA
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 2ce8576540a2..9e475a54e36e 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -38,7 +38,6 @@ obj-$(CONFIG_I2C_AU1550)	+= i2c-au1550.o
 obj-$(CONFIG_I2C_AXXIA)		+= i2c-axxia.o
 obj-$(CONFIG_I2C_BCM2835)	+= i2c-bcm2835.o
 obj-$(CONFIG_I2C_BCM_IPROC)	+= i2c-bcm-iproc.o
-obj-$(CONFIG_I2C_BLACKFIN_TWI)	+= i2c-bfin-twi.o
 obj-$(CONFIG_I2C_CADENCE)	+= i2c-cadence.o
 obj-$(CONFIG_I2C_CBUS_GPIO)	+= i2c-cbus-gpio.o
 obj-$(CONFIG_I2C_CPM)		+= i2c-cpm.o
diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
deleted file mode 100644
index ff3343186a82..000000000000
-- 
2.9.0
