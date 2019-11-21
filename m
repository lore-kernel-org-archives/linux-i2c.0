From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] i2c: Fix Kconfig indentation
Date: Thu, 21 Nov 2019 04:19:23 +0100
Message-ID: <1574306363-29424-1-git-send-email-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 drivers/i2c/busses/Kconfig | 22 +++++++++++-----------
 drivers/i2c/muxes/Kconfig  | 18 +++++++++---------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 45ca099e7315..da243f153319 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -293,7 +293,7 @@ config I2C_VIA
 	select I2C_ALGOBIT
 	help
 	  If you say yes to this option, support will be included for the VIA
-          82C586B I2C interface
+	  82C586B I2C interface
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-via.
@@ -678,11 +678,11 @@ config I2C_IMX_LPI2C
 	tristate "IMX Low Power I2C interface"
 	depends on ARCH_MXC || COMPILE_TEST
 	help
-          Say Y here if you want to use the Low Power IIC bus controller
-          on the Freescale i.MX processors.
+	  Say Y here if you want to use the Low Power IIC bus controller
+	  on the Freescale i.MX processors.
 
-          This driver can also be built as a module. If so, the module
-          will be called i2c-imx-lpi2c.
+	  This driver can also be built as a module. If so, the module
+	  will be called i2c-imx-lpi2c.
 
 config I2C_IOP3XX
 	tristate "Intel IOPx3xx and IXP4xx on-chip I2C interface"
@@ -1184,9 +1184,9 @@ config I2C_DIOLAN_U2C
 	  will be called i2c-diolan-u2c.
 
 config I2C_DLN2
-       tristate "Diolan DLN-2 USB I2C adapter"
-       depends on MFD_DLN2
-       help
+	tristate "Diolan DLN-2 USB I2C adapter"
+	depends on MFD_DLN2
+	help
 	 If you say yes to this option, support will be included for Diolan
 	 DLN2, a USB to I2C interface.
 
@@ -1285,9 +1285,9 @@ config I2C_VIPERBOARD
 	help
 	  Say yes here to access the I2C part of the Nano River
 	  Technologies Viperboard as I2C master.
-          See viperboard API specification and Nano
-          River Tech's viperboard.h for detailed meaning
-          of the module parameters.
+	  See viperboard API specification and Nano
+	  River Tech's viperboard.h for detailed meaning
+	  of the module parameters.
 
 comment "Other I2C/SMBus bus drivers"
 
diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index c6040aa839ac..1708b1a82da2 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -109,14 +109,14 @@ config I2C_DEMUX_PINCTRL
 	  want to change the I2C master at run-time depending on features.
 
 config I2C_MUX_MLXCPLD
-        tristate "Mellanox CPLD based I2C multiplexer"
-        help
-          If you say yes to this option, support will be included for a
-          CPLD based I2C multiplexer. This driver provides access to
-          I2C busses connected through a MUX, which is controlled
-          by a CPLD register.
-
-          This driver can also be built as a module.  If so, the module
-          will be called i2c-mux-mlxcpld.
+	tristate "Mellanox CPLD based I2C multiplexer"
+	help
+	  If you say yes to this option, support will be included for a
+	  CPLD based I2C multiplexer. This driver provides access to
+	  I2C busses connected through a MUX, which is controlled
+	  by a CPLD register.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-mux-mlxcpld.
 
 endmenu
-- 
2.7.4
