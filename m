From: Maxime COQUELIN <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 3/4] ARM: STi: Supply I2C configuration to STiH415 SoC
Date: Tue,  1 Oct 2013 12:39:11 +0200
Message-ID: <1380623952-4252-4-git-send-email-maxime.coquelin@st.com>
References: <1380623952-4252-1-git-send-email-maxime.coquelin@st.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380623952-4252-1-git-send-email-maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, srinivas.kandagatla-qxv4g6HH51o@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: stephen.gallimore-qxv4g6HH51o@public.gmane.org, stuart.menefy-qxv4g6HH51o@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, gabriel.fernandez-qxv4g6HH51o@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch supplies I2C configuration to STiH415 SoC.

Cc: Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
---
 arch/arm/boot/dts/stih415-pinctrl.dtsi |   36 ++++++++++++++++++++++
 arch/arm/boot/dts/stih415.dtsi         |   53 ++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/arch/arm/boot/dts/stih415-pinctrl.dtsi b/arch/arm/boot/dts/stih415-pinctrl.dtsi
index 1d322b2..e56449d 100644
--- a/arch/arm/boot/dts/stih415-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih415-pinctrl.dtsi
@@ -86,6 +86,24 @@
 					};
 				};
 			};
+
+			sbc_i2c0 {
+				pinctrl_sbc_i2c0_default: sbc_i2c0-default {
+					st,pins {
+						sda = <&PIO4 6 ALT1 BIDIR>;
+						scl = <&PIO4 5 ALT1 BIDIR>;
+					};
+				};
+			};
+
+			sbc_i2c1 {
+				pinctrl_sbc_i2c1_default: sbc_i2c1-default {
+					st,pins {
+						sda = <&PIO3 2 ALT2 BIDIR>;
+						scl = <&PIO3 1 ALT2 BIDIR>;
+					};
+				};
+			};
 		};
 
 		pin-controller-front {
@@ -143,6 +161,24 @@
 				reg		= <0x7000 0x100>;
 				st,bank-name	= "PIO12";
 			};
+
+			i2c0 {
+				pinctrl_i2c0_default: i2c0-default {
+					st,pins {
+						sda = <&PIO9 3 ALT1 BIDIR>;
+						scl = <&PIO9 2 ALT1 BIDIR>;
+					};
+				};
+			};
+
+			i2c1 {
+				pinctrl_i2c1_default: i2c1-default {
+					st,pins {
+						sda = <&PIO12 1 ALT1 BIDIR>;
+						scl = <&PIO12 0 ALT1 BIDIR>;
+					};
+				};
+			};
 		};
 
 		pin-controller-rear {
diff --git a/arch/arm/boot/dts/stih415.dtsi b/arch/arm/boot/dts/stih415.dtsi
index 74ab8de..eb4fccb 100644
--- a/arch/arm/boot/dts/stih415.dtsi
+++ b/arch/arm/boot/dts/stih415.dtsi
@@ -9,6 +9,7 @@
 #include "stih41x.dtsi"
 #include "stih415-clock.dtsi"
 #include "stih415-pinctrl.dtsi"
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 / {
 
 	L2: cache-controller {
@@ -83,5 +84,57 @@
 			pinctrl-names 	= "default";
 			pinctrl-0	= <&pinctrl_sbc_serial1>;
 		};
+
+		i2c@fed40000 {
+			compatible	= "st,comms-ssc-i2c";
+			reg		= <0xfed40000 0x110>;
+			interrupts	=  <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
+			clocks		= <&CLKS_ICN_REG_0>;
+			clock-names	= "ssc";
+			clock-frequency = <400000>;
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_i2c0_default>;
+
+			status		= "disabled";
+		};
+
+		i2c@fed41000 {
+			compatible	= "st,comms-ssc-i2c";
+			reg		= <0xfed41000 0x110>;
+			interrupts	=  <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>;
+			clocks		= <&CLKS_ICN_REG_0>;
+			clock-names	= "ssc";
+			clock-frequency = <400000>;
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_i2c1_default>;
+
+			status		= "disabled";
+		};
+
+		i2c@fe540000 {
+			compatible	= "st,comms-ssc-i2c";
+			reg		= <0xfe540000 0x110>;
+			interrupts	=  <GIC_SPI 206 IRQ_TYPE_EDGE_RISING>;
+			clocks		= <&CLK_SYSIN>;
+			clock-names	= "ssc";
+			clock-frequency = <400000>;
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_sbc_i2c0_default>;
+
+			status		= "disabled";
+		};
+
+		i2c@fe541000 {
+			compatible	= "st,comms-ssc-i2c";
+			reg		= <0xfe541000 0x110>;
+			interrupts	=  <GIC_SPI 207 IRQ_TYPE_EDGE_RISING>;
+			clocks		= <&CLK_SYSIN>;
+			clock-names	= "ssc";
+			clock-frequency = <400000>;
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_sbc_i2c1_default>;
+
+			status		= "disabled";
+		};
 	};
 };
-- 
1.7.9.5
