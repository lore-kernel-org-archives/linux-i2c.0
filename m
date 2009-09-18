From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Clearly mark ACPI drivers as such
Date: Fri, 18 Sep 2009 13:26:53 +0200
Message-ID: <20090918132653.3ea97bd8@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Now that we have ACPI-based SMBus controller drivers, and we will start
telling users to use them instead of native drivers when I/O resources
conflict, I think it would be good to clearly mark ACPI drivers as such
in Kconfig.

This is exactly the same as we just did for hwmon drivers.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
---
 drivers/i2c/busses/Kconfig  |   27 ++++++++++++++++-----------
 drivers/i2c/busses/Makefile |    2 +-
 2 files changed, 17 insertions(+), 12 deletions(-)

--- linux-2.6.32-pre.orig/drivers/i2c/busses/Kconfig	2009-09-18 11:42:33.000000000 +0200
+++ linux-2.6.32-pre/drivers/i2c/busses/Kconfig	2009-09-18 12:55:21.000000000 +0200
@@ -639,6 +639,22 @@ config I2C_VOODOO3
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-voodoo3.
+if ACPI
+
+comment "ACPI drivers"
+
+config I2C_SCMI
+	tristate "SMBus Control Method Interface"
+	depends on ACPI
+	help
+	  This driver supports the SMBus Control Method Interface. It needs the
+	  BIOS to declare ACPI control methods as described in the SMBus Control
+	  Method Interface specification.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called i2c-scmi.
+
+endif # ACPI
 
 comment "Other I2C/SMBus bus drivers"
 
@@ -762,15 +778,4 @@ config SCx200_ACB
 	  This support is also available as a module.  If so, the module
 	  will be called scx200_acb.
 
-config I2C_SCMI
-	tristate "SMBus Control Method Interface"
-	depends on ACPI
-	help
-	  This driver supports the SMBus Control Method Interface. It needs the
-	  BIOS to declare ACPI control methods as described in the SMBus Control
-	  Method Interface specification.
-
-	  To compile this driver as a module, choose M here:
-	  the module will be called i2c-scmi.
-
 endmenu
--- linux-2.6.32-pre.orig/drivers/i2c/busses/Makefile	2009-09-18 11:42:33.000000000 +0200
+++ linux-2.6.32-pre/drivers/i2c/busses/Makefile	2009-09-18 12:53:29.000000000 +0200
@@ -2,7 +2,7 @@
 # Makefile for the i2c bus drivers.
 #
 
-# SMBus CMI driver
+# ACPI drivers
 obj-$(CONFIG_I2C_SCMI)		+= i2c-scmi.o
 
 # PC SMBus host controller drivers


-- 
Jean Delvare
