From: =?utf-8?q?Daniel=20Gl=C3=B6ckner?= <dg-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
Subject: [patch 4/5] xtensa: enable s6000 i2c host driver in s6105_defconfig
Date: Mon, 23 Mar 2009 16:05:17 +0100
Message-ID: <1237820718-30607-4-git-send-email-dg@emlix.com>
References: <1237820718-30607-1-git-send-email-dg@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1237820718-30607-1-git-send-email-dg-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?q?Daniel=20Gl=C3=B6ckner?= <dg-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Daniel Gl=C3=B6ckner <dg-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
---
 arch/xtensa/configs/s6105_defconfig |   54 +++++++++++++++++++++++++++=
++++++-
 1 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/configs/s6105_defconfig b/arch/xtensa/configs/=
s6105_defconfig
index a130c8d..a9a0de9 100644
--- a/arch/xtensa/configs/s6105_defconfig
+++ b/arch/xtensa/configs/s6105_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.29-rc7-s6
-# Tue Mar 10 11:09:26 2009
+# Wed Mar 11 13:38:31 2009
 #
 # CONFIG_FRAME_POINTER is not set
 CONFIG_ZONE_DMA=3Dy
@@ -357,7 +357,48 @@ CONFIG_UNIX98_PTYS=3Dy
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
-# CONFIG_I2C is not set
+CONFIG_I2C=3Dy
+CONFIG_I2C_BOARDINFO=3Dy
+# CONFIG_I2C_CHARDEV is not set
+CONFIG_I2C_HELPER_AUTO=3Dy
+
+#
+# I2C Hardware Bus support
+#
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
+# CONFIG_I2C_GPIO is not set
+# CONFIG_I2C_OCORES is not set
+CONFIG_I2C_S6000=3Dy
+# CONFIG_I2C_SIMTEC is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_TAOS_EVM is not set
+
+#
+# Other I2C/SMBus bus drivers
+#
+# CONFIG_I2C_PCA_PLATFORM is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_DS1682 is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_PCF8575 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
 # CONFIG_SPI is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=3Dy
 CONFIG_GPIOLIB=3Dy
@@ -371,6 +412,9 @@ CONFIG_GPIOLIB=3Dy
 #
 # I2C GPIO expanders:
 #
+# CONFIG_GPIO_MAX732X is not set
+# CONFIG_GPIO_PCA953X is not set
+# CONFIG_GPIO_PCF857X is not set
=20
 #
 # PCI GPIO expanders:
@@ -398,7 +442,13 @@ CONFIG_SSB_POSSIBLE=3Dy
 # CONFIG_MFD_CORE is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set
+# CONFIG_TPS65010 is not set
+# CONFIG_TWL4030_CORE is not set
 # CONFIG_MFD_TMIO is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_PCF50633 is not set
 # CONFIG_REGULATOR is not set
=20
 #
--=20
1.6.2.107.ge47ee
