From: Joshua Frkuska <joshua_frkuska@mentor.com>
Subject: [RFC V4 2/2] ARM: imx_v6_v7_defconfig: Test imx i2c slave support
Date: Thu, 8 Jun 2017 11:51:04 +0900
Message-ID: <1496890264-10150-3-git-send-email-joshua_frkuska@mentor.com>
References: <1496890264-10150-1-git-send-email-joshua_frkuska@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:54718 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbdFHCvY (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 7 Jun 2017 22:51:24 -0400
In-Reply-To: <1496890264-10150-1-git-send-email-joshua_frkuska@mentor.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, vladimir_zapolskiy@mentor.com, wsa@the-dreams.de
Cc: joshua_frkuska@mentor.com, peda@axentia.se, syrchin@dev.rtsoft.ru

This commit enables the kernel options needed for testing i2c slave
support.

Signed-off-by: Joshua Frkuska <joshua_frkuska@mentor.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index bb6fa568b620..5ac79a5ceaa7 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -163,9 +163,9 @@ CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=y
 CONFIG_TOUCHSCREEN_EGALAX=y
+CONFIG_TOUCHSCREEN_MAX11801=y
 CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
 CONFIG_TOUCHSCREEN_EDT_FT5X06=y
-CONFIG_TOUCHSCREEN_MAX11801=y
 CONFIG_TOUCHSCREEN_MC13783=y
 CONFIG_TOUCHSCREEN_TSC2004=y
 CONFIG_TOUCHSCREEN_TSC2007=y
@@ -174,7 +174,6 @@ CONFIG_TOUCHSCREEN_SX8654=y
 CONFIG_TOUCHSCREEN_COLIBRI_VF50=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MMA8450=y
-CONFIG_HID_MULTITOUCH=y
 CONFIG_SERIO_SERPORT=m
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_IMX=y
@@ -189,6 +188,8 @@ CONFIG_I2C_ALGOPCF=m
 CONFIG_I2C_ALGOPCA=m
 CONFIG_I2C_GPIO=y
 CONFIG_I2C_IMX=y
+CONFIG_I2C_SLAVE=y
+CONFIG_I2C_SLAVE_EEPROM=m
 CONFIG_SPI=y
 CONFIG_SPI_IMX=y
 CONFIG_SPI_FSL_DSPI=y
@@ -231,7 +232,6 @@ CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_SOC_CAMERA=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_CODA=y
-CONFIG_SOC_CAMERA_OV2640=y
 CONFIG_IMX_IPUV3_CORE=y
 CONFIG_DRM=y
 CONFIG_DRM_PANEL_SIMPLE=y
@@ -268,6 +268,7 @@ CONFIG_SND_SOC_CS42XX8_I2C=y
 CONFIG_SND_SOC_TLV320AIC3X=y
 CONFIG_SND_SOC_WM8960=y
 CONFIG_SND_SIMPLE_CARD=y
+CONFIG_HID_MULTITOUCH=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MXC=y
-- 
2.5.5
