From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v4 07/14] ARM: dts: koelsch: use demuxer for I2C4
Date: Sun,  6 Nov 2016 21:20:25 +0100
Message-ID: <20161106202032.5227-8-wsa+renesas@sang-engineering.com>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: linux-i2c@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

From: Simon Horman <horms+renesas@verge.net.au>

Make it possible to fallback to GPIO for I2C4 on the EXIO-E connector.

This is based on reference work for the I2C0 core of the lager/r8a7790
by Wolfram Sang.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[wsa: rebased and fixed aliases]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 8d653920957a4b..442d1512a8fa9c 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -52,8 +52,10 @@
 		serial1 = &scif1;
 		i2c9 = &gpioi2c1;
 		i2c10 = &gpioi2c2;
+		i2c11 = &gpioi2c4;
 		i2c12 = &i2cexio1;
 		i2c13 = &i2chdmi;
+		i2c14 = &i2cexio4;
 	};
 
 	chosen {
@@ -325,6 +327,17 @@
 		i2c-gpio,delay-us = <5>;
 	};
 
+	gpioi2c4: i2c-11 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "i2c-gpio";
+		status = "disabled";
+		gpios = <&gpio7 14 GPIO_ACTIVE_HIGH /* sda */
+			 &gpio7 13 GPIO_ACTIVE_HIGH /* scl */
+			>;
+		i2c-gpio,delay-us = <5>;
+	};
+
 	/*
 	 * I2C1 is routed to EXIO connector B, pins 64 (SCL) + 66 (SDA).
 	 * A fallback to GPIO is provided.
@@ -431,6 +444,18 @@
 			pagesize = <16>;
 		};
 	};
+
+	/*
+	 * I2C4 is routed to EXIO connector E, pins 37 (SCL) + 39 (SDA).
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
@@ -476,6 +501,11 @@
 		function = "i2c2";
 	};
 
+	i2c4_pins: i2c4 {
+		groups = "i2c4";
+		function = "i2c4";
+	};
+
 	du_pins: du {
 		groups = "du_rgb888", "du_sync", "du_disp", "du_clk_out_0";
 		function = "du";
@@ -732,6 +762,11 @@
 	clock-frequency = <100000>;
 };
 
+&i2c4 {
+	pinctrl-0 = <&i2c4_pins>;
+	pinctrl-names = "i2c-exio4";
+};
+
 &i2c6 {
 	status = "okay";
 	clock-frequency = <100000>;
-- 
2.9.3
