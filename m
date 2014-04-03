From: Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 3/3] ARM: zynq: dt: Add I2C nodes to Zynq device tree
Date: Thu,  3 Apr 2014 10:59:27 -0700
Message-ID: <1396547967-19260-3-git-send-email-soren.brinkmann@xilinx.com>
References: <1396547967-19260-1-git-send-email-soren.brinkmann@xilinx.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1396547967-19260-1-git-send-email-soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Tested-by: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2:
 - replace 'pmbus' with 'ti' in compatibility strings of UCD devices

Signed-off-by: Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/zynq-7000.dtsi | 22 ++++++++++++
 arch/arm/boot/dts/zynq-zc702.dts | 76 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/zynq-zc706.dts | 68 +++++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 789d0bacc110..e4f0820527b1 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -54,6 +54,28 @@
 		interrupt-parent = <&intc>;
 		ranges;
 
+		i2c0: zynq-i2c@e0004000 {
+			compatible = "cdns,i2c-r1p10";
+			status = "disabled";
+			clocks = <&clkc 38>;
+			interrupt-parent = <&intc>;
+			interrupts = <0 25 4>;
+			reg = <0xE0004000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c1: zynq-i2c@e0005000 {
+			compatible = "cdns,i2c-r1p10";
+			status = "disabled";
+			clocks = <&clkc 39>;
+			interrupt-parent = <&intc>;
+			interrupts = <0 48 4>;
+			reg = <0xE0005000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		intc: interrupt-controller@f8f01000 {
 			compatible = "arm,cortex-a9-gic";
 			#interrupt-cells = <3>;
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index c913f77a21eb..5e09cee33d42 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -34,6 +34,82 @@
 	phy-mode = "rgmii";
 };
 
+&i2c0 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	i2cswitch@74 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x74>;
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			si570: clock-generator@5d {
+				#clock-cells = <0>;
+				compatible = "silabs,si570";
+				temperature-stability = <50>;
+				reg = <0x5d>;
+				factory-fout = <156250000>;
+				clock-frequency = <148500000>;
+			};
+		};
+
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			eeprom@54 {
+				compatible = "at,24c08";
+				reg = <0x54>;
+			};
+		};
+
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			gpio@21 {
+				compatible = "ti,tca6416";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+		};
+
+		i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			rtc@51 {
+				compatible = "nxp,pcf8563";
+				reg = <0x51>;
+			};
+		};
+
+		i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			hwmon@52 {
+				compatible = "ti,ucd9248";
+				reg = <52>;
+			};
+			hwmon@53 {
+				compatible = "ti,ucd9248";
+				reg = <53>;
+			};
+			hwmon@54 {
+				compatible = "ti,ucd9248";
+				reg = <54>;
+			};
+		};
+	};
+};
+
 &sdhci0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index 88f62c50382e..4cc9913078cd 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -35,6 +35,74 @@
 	phy-mode = "rgmii";
 };
 
+&i2c0 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	i2cswitch@74 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x74>;
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			si570: clock-generator@5d {
+				#clock-cells = <0>;
+				compatible = "silabs,si570";
+				temperature-stability = <50>;
+				reg = <0x5d>;
+				factory-fout = <156250000>;
+				clock-frequency = <148500000>;
+			};
+		};
+
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			eeprom@54 {
+				compatible = "at,24c08";
+				reg = <0x54>;
+			};
+		};
+
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			gpio@21 {
+				compatible = "ti,tca6416";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+		};
+
+		i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			rtc@51 {
+				compatible = "nxp,pcf8563";
+				reg = <0x51>;
+			};
+		};
+
+		i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			ucd90120@65 {
+				compatible = "ti,ucd90120";
+				reg = <0x65>;
+			};
+		};
+	};
+};
+
 &sdhci0 {
 	status = "okay";
 };
-- 
1.9.1.1.gbb9f595
