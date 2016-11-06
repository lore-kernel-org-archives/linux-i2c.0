From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v4 11/14] ARM: dts: alt: use demuxer for I2C1
Date: Sun,  6 Nov 2016 21:20:29 +0100
Message-ID: <20161106202032.5227-12-wsa+renesas@sang-engineering.com>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: linux-i2c@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

From: Simon Horman <horms+renesas@verge.net.au>

Create a separate bus for HDMI related I2C1 and provide fallback to GPIO.

Based on work for the r8a7790/lager by Wolfram Sang.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[wsa: rebased and fixed aliases]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 53 ++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index ccb80d66076f3d..81368d11e4d3be 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -18,6 +18,8 @@
 
 	aliases {
 		serial0 = &scif2;
+		i2c9 = &gpioi2c1;
+		i2c11 = &i2chdmi;
 	};
 
 	chosen {
@@ -135,6 +137,41 @@
 		#clock-cells = <0>;
 		clock-frequency = <148500000>;
 	};
+
+	gpioi2c1: i2c-9 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "i2c-gpio";
+		status = "disabled";
+		gpios = <&gpio4 1 GPIO_ACTIVE_HIGH /* sda */
+			 &gpio4 0 GPIO_ACTIVE_HIGH /* scl */
+			>;
+		i2c-gpio,delay-us = <5>;
+	};
+
+	/*
+	 * A fallback to GPIO is provided for I2C1.
+	 */
+	i2chdmi: i2c-11 {
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&i2c1>, <&gpioi2c1>;
+		i2c-bus-name = "i2c-hdmi";
+		#address-cells = <1>;
+		#size-cells = <0>;
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
+	};
 };
 
 &du {
@@ -296,23 +333,9 @@
 
 &i2c1 {
 	pinctrl-0 = <&i2c1_pins>;
-	pinctrl-names = "default";
+	pinctrl-names = "i2c-hdmi";
 
-	status = "okay";
 	clock-frequency = <400000>;
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
 };
 
 &vin0 {
-- 
2.9.3
