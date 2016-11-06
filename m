From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v4 09/14] ARM: dts: gose: use demuxer for I2C2
Date: Sun,  6 Nov 2016 21:20:27 +0100
Message-ID: <20161106202032.5227-10-wsa+renesas@sang-engineering.com>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: linux-i2c@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

From: Simon Horman <horms+renesas@verge.net.au>

Create a separate bus for HDMI related I2C2 and provide fallback to GPIO.

Based on work for the r8a7790/lager by Wolfram Sang.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[wsa: rebased, corrected board name in subject, and fixed aliases]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 170 +++++++++++++++++++++----------------
 1 file changed, 97 insertions(+), 73 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 6329d9d2e8a3e3..df07dc252537fe 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -48,6 +48,8 @@
 	aliases {
 		serial0 = &scif0;
 		serial1 = &scif1;
+		i2c9 = &gpioi2c2;
+		i2c11 = &i2chdmi;
 	};
 
 	chosen {
@@ -275,6 +277,100 @@
 		#clock-cells = <0>;
 		clock-frequency = <148500000>;
 	};
+
+	gpioi2c2: i2c-9 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "i2c-gpio";
+		status = "disabled";
+		gpios = <&gpio2 7 GPIO_ACTIVE_HIGH /* sda */
+			 &gpio2 6 GPIO_ACTIVE_HIGH /* scl */
+			>;
+		i2c-gpio,delay-us = <5>;
+	};
+
+	/*
+	 * A fallback to GPIO is provided for I2C2.
+	 */
+	i2chdmi: i2c-11 {
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&i2c2>, <&gpioi2c2>;
+		i2c-bus-name = "i2c-hdmi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ak4643: codec@12 {
+			compatible = "asahi-kasei,ak4643";
+			#sound-dai-cells = <0>;
+			reg = <0x12>;
+		};
+
+		composite-in@20 {
+			compatible = "adi,adv7180";
+			reg = <0x20>;
+			remote = <&vin1>;
+
+			port {
+				adv7180: endpoint {
+					bus-width = <8>;
+					remote-endpoint = <&vin1ep>;
+				};
+			};
+		};
+
+		hdmi@39 {
+			compatible = "adi,adv7511w";
+			reg = <0x39>;
+			interrupt-parent = <&gpio3>;
+			interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
+
+			adi,input-depth = <8>;
+			adi,input-colorspace = "rgb";
+			adi,input-clock = "1x";
+			adi,input-style = <1>;
+			adi,input-justification = "evenly";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					adv7511_in: endpoint {
+						remote-endpoint = <&du_out_rgb>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					adv7511_out: endpoint {
+						remote-endpoint = <&hdmi_con>;
+					};
+				};
+			};
+		};
+
+		hdmi-in@4c {
+			compatible = "adi,adv7612";
+			reg = <0x4c>;
+			interrupt-parent = <&gpio1>;
+			interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
+			remote = <&vin0>;
+			default-input = <0>;
+
+			port {
+				adv7612: endpoint {
+					remote-endpoint = <&vin0ep>;
+				};
+			};
+		};
+
+		eeprom@50 {
+			compatible = "renesas,r1ex24002", "atmel,24c02";
+			reg = <0x50>;
+			pagesize = <16>;
+		};
+	};
 };
 
 &du {
@@ -498,82 +594,10 @@
 
 &i2c2 {
 	pinctrl-0 = <&i2c2_pins>;
-	pinctrl-names = "default";
+	pinctrl-names = "i2c-hdmi";
 
 	status = "okay";
 	clock-frequency = <100000>;
-
-	ak4643: codec@12 {
-		compatible = "asahi-kasei,ak4643";
-		#sound-dai-cells = <0>;
-		reg = <0x12>;
-	};
-
-	composite-in@20 {
-		compatible = "adi,adv7180";
-		reg = <0x20>;
-		remote = <&vin1>;
-
-		port {
-			adv7180: endpoint {
-				bus-width = <8>;
-				remote-endpoint = <&vin1ep>;
-			};
-		};
-	};
-
-	hdmi@39 {
-		compatible = "adi,adv7511w";
-		reg = <0x39>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
-
-		adi,input-depth = <8>;
-		adi,input-colorspace = "rgb";
-		adi,input-clock = "1x";
-		adi,input-style = <1>;
-		adi,input-justification = "evenly";
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-				adv7511_in: endpoint {
-					remote-endpoint = <&du_out_rgb>;
-				};
-			};
-
-			port@1 {
-				reg = <1>;
-				adv7511_out: endpoint {
-					remote-endpoint = <&hdmi_con>;
-				};
-			};
-		};
-	};
-
-	hdmi-in@4c {
-		compatible = "adi,adv7612";
-		reg = <0x4c>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
-		remote = <&vin0>;
-		default-input = <0>;
-
-		port {
-			adv7612: endpoint {
-				remote-endpoint = <&vin0ep>;
-			};
-		};
-	};
-
-	eeprom@50 {
-		compatible = "renesas,r1ex24002", "atmel,24c02";
-		reg = <0x50>;
-		pagesize = <16>;
-	};
 };
 
 &rcar_sound {
-- 
2.9.3
