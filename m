From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v4 08/14] ARM: dts: porter: use demuxer for I2C2
Date: Sun,  6 Nov 2016 21:20:26 +0100
Message-ID: <20161106202032.5227-9-wsa+renesas@sang-engineering.com>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46895 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751765AbcKFUVA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 6 Nov 2016 15:21:00 -0500
In-Reply-To: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: linux-i2c@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>

From: Simon Horman <horms+renesas@verge.net.au>

Create a separate bus for HDMI related I2C2 and provide fallback to GPIO.

Based on work for the r8a7790/lager by Wolfram Sang.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[wsa: rebased and fixed aliases]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 129 +++++++++++++++++++++--------------
 1 file changed, 76 insertions(+), 53 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index 6761d11d3f9e13..f4d296e0f67cb5 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -29,6 +29,8 @@
 
 	aliases {
 		serial0 = &scif0;
+		i2c9 = &gpioi2c2;
+		i2c10 = &i2chdmi;
 	};
 
 	chosen {
@@ -135,6 +137,79 @@
 			clocks = <&x14_clk>;
 		};
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
+	i2chdmi: i2c-10 {
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&i2c2>, <&gpioi2c2>;
+		i2c-bus-name = "i2c-hdmi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ak4642: codec@12 {
+			compatible = "asahi-kasei,ak4642";
+			#sound-dai-cells = <0>;
+			reg = <0x12>;
+		};
+
+		composite-in@20 {
+			compatible = "adi,adv7180";
+			reg = <0x20>;
+			remote = <&vin0>;
+
+			port {
+				adv7180: endpoint {
+					bus-width = <8>;
+					remote-endpoint = <&vin0ep>;
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
+	};
 };
 
 &extal_clk {
@@ -296,61 +371,9 @@
 
 &i2c2 {
 	pinctrl-0 = <&i2c2_pins>;
-	pinctrl-names = "default";
+	pinctrl-names = "i2c-hdmi";
 
-	status = "okay";
 	clock-frequency = <400000>;
-
-	ak4642: codec@12 {
-		compatible = "asahi-kasei,ak4642";
-		#sound-dai-cells = <0>;
-		reg = <0x12>;
-	};
-
-	composite-in@20 {
-		compatible = "adi,adv7180";
-		reg = <0x20>;
-		remote = <&vin0>;
-
-		port {
-			adv7180: endpoint {
-				bus-width = <8>;
-				remote-endpoint = <&vin0ep>;
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
 };
 
 &sata0 {
-- 
2.9.3
