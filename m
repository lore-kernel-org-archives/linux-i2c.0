From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v4 02/14] ARM: dts: lager: use demuxer for IIC1/I2C1
Date: Sun,  6 Nov 2016 21:20:20 +0100
Message-ID: <20161106202032.5227-3-wsa+renesas@sang-engineering.com>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46878 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751829AbcKFUUy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 6 Nov 2016 15:20:54 -0500
In-Reply-To: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: linux-i2c@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>

From: Simon Horman <horms+renesas@verge.net.au>

Make it possible to select which I2C1 IP core you want to run on the
EXIO-A connector.

This is based on reference work for the I2C0 core of the lager board
by Wolfram Sang.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[wsa: rebased and fixed aliases]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 39 +++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index dafa49f837118e..bd512c86e85222 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -50,7 +50,9 @@
 	aliases {
 		serial0 = &scif0;
 		serial1 = &scifa1;
+		i2c8 = &gpioi2c1;
 		i2c10 = &i2cexio0;
+		i2c11 = &i2cexio1;
 	};
 
 	chosen {
@@ -265,6 +267,17 @@
 		clock-frequency = <148500000>;
 	};
 
+	gpioi2c1: i2c-8 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "i2c-gpio";
+		status = "disabled";
+		gpios = <&gpio1 17 GPIO_ACTIVE_HIGH /* sda */
+			 &gpio1 16 GPIO_ACTIVE_HIGH /* scl */
+			>;
+		i2c-gpio,delay-us = <5>;
+	};
+
 	/*
 	 * IIC0/I2C0 is routed to EXIO connector A, pins 114 (SCL) + 116 (SDA) only.
 	 * We use the I2C demuxer, so the desired IP core can be selected at runtime
@@ -283,6 +296,19 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
+
+	/*
+	 * IIC1/I2C1 is routed to EXIO connector A, pins 78 (SCL) + 80 (SDA).
+	 * This is similar to the arangement described for i2cexio0 (above)
+	 * with a fallback to GPIO also provided.
+	 */
+	i2cexio1: i2c-11 {
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&iic1>, <&i2c1>, <&gpioi2c1>;
+		i2c-bus-name = "i2c-exio1";
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
 };
 
 &du {
@@ -405,6 +431,11 @@
 		function = "iic0";
 	};
 
+	i2c1_pins: i2c1 {
+		groups = "i2c1";
+		function = "i2c1";
+	};
+
 	iic1_pins: iic1 {
 		groups = "iic1";
 		function = "iic1";
@@ -607,10 +638,14 @@
 	pinctrl-names = "i2c-exio0";
 };
 
+&i2c1	{
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "i2c-exio1";
+};
+
 &iic1	{
-	status = "okay";
 	pinctrl-0 = <&iic1_pins>;
-	pinctrl-names = "default";
+	pinctrl-names = "i2c-exio1";
 };
 
 &iic2	{
-- 
2.9.3
