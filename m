From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v4 12/14] ARM: dts: alt: use demuxer for I2C4
Date: Sun,  6 Nov 2016 21:20:30 +0100
Message-ID: <20161106202032.5227-13-wsa+renesas@sang-engineering.com>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: linux-i2c@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

From: Simon Horman <horms+renesas@verge.net.au>

Make it possible to fallback to GPIO for I2C4 on the EXIO-B connector.

This is based on reference work for the I2C0 core of the lager/r8a7790
by Wolfram Sang.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[wsa: rebased and fixed aliases]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index 81368d11e4d3be..bd5b2d2c568c52 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -19,7 +19,9 @@
 	aliases {
 		serial0 = &scif2;
 		i2c9 = &gpioi2c1;
+		i2c10 = &gpioi2c4;
 		i2c11 = &i2chdmi;
+		i2c12 = &i2cexio4;
 	};
 
 	chosen {
@@ -149,6 +151,17 @@
 		i2c-gpio,delay-us = <5>;
 	};
 
+	gpioi2c4: i2c-10 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "i2c-gpio";
+		status = "disabled";
+		gpios = <&gpio4 9 GPIO_ACTIVE_HIGH /* sda */
+			 &gpio4 8 GPIO_ACTIVE_HIGH /* scl */
+			>;
+		i2c-gpio,delay-us = <5>;
+	};
+
 	/*
 	 * A fallback to GPIO is provided for I2C1.
 	 */
@@ -172,6 +185,18 @@
 			};
 		};
 	};
+
+	/*
+	 * I2C4 is routed to EXIO connector B, pins 73 (SCL) + 74 (SDA).
+	 * A fallback to GPIO is provided.
+	 */
+	i2cexio4: i2c-14 {
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&i2c4>, <&gpioi2c4>;
+		i2c-bus-name = "i2c-exio4";
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
 };
 
 &du {
@@ -231,6 +256,11 @@
 		function = "i2c1";
 	};
 
+	i2c4_pins: i2c4 {
+		groups = "i2c4";
+		function = "i2c4";
+	};
+
 	vin0_pins: vin0 {
 		groups = "vin0_data8", "vin0_clk";
 		function = "vin0";
@@ -338,6 +368,11 @@
 	clock-frequency = <400000>;
 };
 
+&i2c4 {
+	pinctrl-0 = <&i2c4_pins>;
+	pinctrl-names = "i2c-exio4";
+};
+
 &vin0 {
 	status = "okay";
 	pinctrl-0 = <&vin0_pins>;
-- 
2.9.3
