From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/5] i2c: Separate Kconfig option for i2c-smbus
Date: Sat, 13 Feb 2010 23:07:50 +0100
Message-ID: <20100213230750.4e001517@hyperion.delvare>
References: <20100213230438.31fd0fd7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100213230438.31fd0fd7-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Having a separate Kconfig option for i2c-smbus makes it possible to
build that support as a module even when i2c-core itself is built-in.
Bus drivers which implement SMBus alert should select this option, so
in most cases this option is hidden and the user doesn't have to care
about it.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/Kconfig  |   10 ++++++++++
 drivers/i2c/Makefile |    3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

--- linux-2.6.33-rc7.orig/drivers/i2c/Kconfig	2010-02-12 14:20:30.000000000 +0100
+++ linux-2.6.33-rc7/drivers/i2c/Kconfig	2010-02-12 14:20:35.000000000 +0100
@@ -61,6 +61,16 @@ config I2C_HELPER_AUTO
 
 	  In doubt, say Y.
 
+config I2C_SMBUS
+	tristate "SMBus-specific protocols" if !I2C_HELPER_AUTO
+	help
+	  Say Y here if you want support for SMBus extensions to the I2C
+	  specification. At the moment, the only supported extension is
+	  the SMBus alert protocol.
+
+	  This support is also available as a module.  If so, the module
+	  will be called i2c-smbus.
+
 source drivers/i2c/algos/Kconfig
 source drivers/i2c/busses/Kconfig
 source drivers/i2c/chips/Kconfig
--- linux-2.6.33-rc7.orig/drivers/i2c/Makefile	2010-02-12 14:20:30.000000000 +0100
+++ linux-2.6.33-rc7/drivers/i2c/Makefile	2010-02-12 14:20:35.000000000 +0100
@@ -3,7 +3,8 @@
 #
 
 obj-$(CONFIG_I2C_BOARDINFO)	+= i2c-boardinfo.o
-obj-$(CONFIG_I2C)		+= i2c-core.o i2c-smbus.o
+obj-$(CONFIG_I2C)		+= i2c-core.o
+obj-$(CONFIG_I2C_SMBUS)		+= i2c-smbus.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
 obj-y				+= busses/ chips/ algos/
 

-- 
Jean Delvare
