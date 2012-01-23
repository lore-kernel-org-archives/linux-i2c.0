From: "Jayachandran C." <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Subject: [PATCH] i2c: Move I2C_EG20T option to the right place.
Date: Mon, 23 Jan 2012 18:01:29 +0530
Message-ID: <1327321889-6393-1-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>

Move Kconfig option for I2C_EG20T to the correct position and keep
the options sorted.

Also, use tabs in Makefile and move the I2C_EG20T entry to its
position.

Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
---
 drivers/i2c/busses/Kconfig  |   30 +++++++++++++++---------------
 drivers/i2c/busses/Makefile |    2 +-
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 7726c79..e99bfa8 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -369,6 +369,21 @@ config I2C_DESIGNWARE_PCI
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-designware-pci.
 
+config I2C_EG20T
+	tristate "Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) I2C"
+	depends on PCI
+	help
+	  This driver is for PCH(Platform controller Hub) I2C of EG20T which
+	  is an IOH(Input/Output Hub) for x86 embedded processor.
+	  This driver can access PCH I2C bus device.
+
+	  This driver also can be used for LAPIS Semiconductor IOH(Input/
+	  Output Hub), ML7213, ML7223 and ML7831.
+	  ML7213 IOH is for IVI(In-Vehicle Infotainment) use, ML7223 IOH is
+	  for MP(Media Phone) use and ML7831 IOH is for general purpose use.
+	  ML7213/ML7223/ML7831 is companion chip for Intel Atom E6xx series.
+	  ML7213/ML7223/ML7831 is completely compatible for Intel EG20T PCH.
+
 config I2C_GPIO
 	tristate "GPIO-based bitbanging I2C"
 	depends on GENERIC_GPIO
@@ -691,21 +706,6 @@ config I2C_XLR
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-xlr.
 
-config I2C_EG20T
-	tristate "Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) I2C"
-	depends on PCI
-	help
-	  This driver is for PCH(Platform controller Hub) I2C of EG20T which
-	  is an IOH(Input/Output Hub) for x86 embedded processor.
-	  This driver can access PCH I2C bus device.
-
-	  This driver also can be used for LAPIS Semiconductor IOH(Input/
-	  Output Hub), ML7213, ML7223 and ML7831.
-	  ML7213 IOH is for IVI(In-Vehicle Infotainment) use, ML7223 IOH is
-	  for MP(Media Phone) use and ML7831 IOH is for general purpose use.
-	  ML7213/ML7223/ML7831 is companion chip for Intel Atom E6xx series.
-	  ML7213/ML7223/ML7831 is completely compatible for Intel EG20T PCH.
-
 comment "External I2C/SMBus adapter drivers"
 
 config I2C_DIOLAN_U2C
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index a0c644d..8f9e7b6 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_I2C_DESIGNWARE_PLATFORM)	+= i2c-designware-platform.o
 i2c-designware-platform-objs := i2c-designware-platdrv.o i2c-designware-core.o
 obj-$(CONFIG_I2C_DESIGNWARE_PCI)	+= i2c-designware-pci.o
 i2c-designware-pci-objs := i2c-designware-pcidrv.o i2c-designware-core.o
+obj-$(CONFIG_I2C_EG20T)		+= i2c-eg20t.o
 obj-$(CONFIG_I2C_GPIO)		+= i2c-gpio.o
 obj-$(CONFIG_I2C_HIGHLANDER)	+= i2c-highlander.o
 obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
@@ -69,7 +70,6 @@ obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
 obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
 obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
 obj-$(CONFIG_I2C_XLR)		+= i2c-xlr.o
-obj-$(CONFIG_I2C_EG20T)         += i2c-eg20t.o
 
 # External I2C/SMBus adapter drivers
 obj-$(CONFIG_I2C_DIOLAN_U2C)	+= i2c-diolan-u2c.o
-- 
1.7.5.4
