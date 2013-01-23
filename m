From: Liu Ying <Ying.Liu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 2/2] ARM: dts: imx51-babbage: Add at24c512b eeprom support
Date: Wed, 23 Jan 2013 14:32:44 +0800
Message-ID: <1358922764-31654-2-git-send-email-Ying.Liu@freescale.com>
References: <1358922764-31654-1-git-send-email-Ying.Liu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358922764-31654-1-git-send-email-Ying.Liu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, liu.y.victor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Liu Ying <Ying.Liu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch adds at24c512b i2c device to the device tree
along with the necessary i2c device node and pinctrl
settings for i2c bus.
The eeprom chip is populated on the accessory board of
the imx51-babbage board.

Signed-off-by: Liu Ying <Ying.Liu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 arch/arm/boot/dts/imx51-babbage.dts |   12 ++++++++++++
 arch/arm/boot/dts/imx51.dtsi        |    9 +++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 567e7ee..4f0fc75 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -241,6 +241,18 @@
 				};
 			};
 
+			i2c@83fc8000 { /* I2C1 */
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c1_1>;
+				status = "okay";
+
+				at24@50 {
+					compatible = "at24,24c512b";
+					pagesize = <128>;
+					reg = <0x50>;
+				};
+			};
+
 			audmux@83fd0000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_audmux_1>;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 1f5d45e..6495c69 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -311,6 +311,15 @@
 					};
 				};
 
+				i2c1 {
+					pinctrl_i2c1_1: i2c1grp-1 {
+						fsl,pins = <
+							4  0x400001ed	/* MX51_PAD_EIM_D16__I2C1_SDA */
+							23 0x400001ed	/* MX51_PAD_EIM_D19__I2C1_SCL */
+						>;
+					};
+				};
+
 				i2c2 {
 					pinctrl_i2c2_1: i2c2grp-1 {
 						fsl,pins = <
-- 
1.7.1
