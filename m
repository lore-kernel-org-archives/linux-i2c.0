From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 2/2] ARM: dts: cfa10049: Add the i2c muxer buses to the CFA-10049
Date: Thu, 18 Oct 2012 16:13:43 +0200
Message-ID: <1350569623-4699-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1350569623-4699-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1350569623-4699-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, brian-ZKiFAVwZFM2FeswfMrDH8w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This will allow to add the 3 Nuvoton NAU7802 ADCs and the NXP PCA9555
GPIO expander eventually.

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 arch/arm/boot/dts/imx28-cfa10049.dts |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index 97ee098..2cda823 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -76,6 +76,30 @@
 				status = "okay";
 			};
 
+			i2cmux {
+				compatible = "i2c-mux-gpio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				mux-gpios = <&gpio1 22 0 &gpio1 23 0>;
+				i2c-parent = <&i2c1>;
+
+				i2c@0 {
+					reg = <0>;
+				};
+
+				i2c@1 {
+					reg = <1>;
+				};
+
+				i2c@2 {
+					reg = <2>;
+				};
+
+				i2c@3 {
+					reg = <3>;
+				};
+			};
+
 			usbphy1: usbphy@8007e000 {
 				status = "okay";
 			};
-- 
1.7.9.5
