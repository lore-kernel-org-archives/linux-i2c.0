From: Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH vY 1/2] ARM: dts: iwg22d-sodimm-dbhd-ca: use demuxer for I2C1
Date: Mon, 22 Jan 2018 11:29:22 +0000
Message-ID: <1516620563-7965-2-git-send-email-biju.das@bp.renesas.com>
References: <1516620563-7965-1-git-send-email-biju.das@bp.renesas.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:44872 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751037AbeAVLcX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 22 Jan 2018 06:32:23 -0500
In-Reply-To: <1516620563-7965-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>

Create a separate bus for HDMI related I2C1 and provide fallback to GPIO.

Based on work for r8a7794/Alt by Wolfram Sang: "ARM: dts: alt: use demuxer
 for I2C1"

Add Fixes: 97b94d256d432ba9 ("ARM: dts: iwg22d-sodimm-dbhd-ca: Add HDMI
video output")
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
---
We have observed that randomly HDMI slave device is holding data line after a soft reboot.

We applied this patch and using an oscilloscope verified that i2c recovery works on the
failure condition.

 .../arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts | 96 +++++++++++++---------
 1 file changed, 59 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts
index d34de82..de120a3 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts
@@ -19,6 +19,8 @@
 		serial0 = &scif1;
 		serial4 = &scif5;
 		serial6 = &hscif2;
+		i2c8 = &gpioi2c1;
+		i2c10 = &i2chdmi;
 	};
 
 	cec_clock: cec-clock {
@@ -27,6 +29,16 @@
 		clock-frequency = <12000000>;
 	};
 
+	gpioi2c1: i2c-8 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "i2c-gpio";
+		status = "disabled";
+		scl-gpios = <&gpio0 11 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		sda-gpios = <&gpio0 12 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <5>;
+	};
+
 	hdmi-out {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -37,6 +49,52 @@
 			};
 		};
 	};
+
+	/*
+	 * A fallback to GPIO is provided for I2C1.
+	 */
+	i2chdmi: i2c-10 {
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&i2c1>, <&gpioi2c1>;
+		i2c-bus-name = "i2c-hdmi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hdmi@39 {
+			compatible = "adi,adv7511w";
+			reg = <0x39>;
+			interrupt-parent = <&gpio1>;
+			interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&cec_clock>;
+			clock-names = "cec";
+			pd-gpios = <&gpio2 24 GPIO_ACTIVE_HIGH>;
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
+						remote-endpoint = <&du_out_rgb0>;
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
 
 &du {
@@ -70,45 +128,9 @@
 
 &i2c1 {
 	pinctrl-0 = <&i2c1_pins>;
-	pinctrl-names = "default";
+	pinctrl-names = "i2c-hdmi";
 
-	status = "okay";
 	clock-frequency = <400000>;
-
-	hdmi@39 {
-		compatible = "adi,adv7511w";
-		reg = <0x39>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&cec_clock>;
-		clock-names = "cec";
-		pd-gpios = <&gpio2 24 GPIO_ACTIVE_HIGH>;
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
-					remote-endpoint = <&du_out_rgb0>;
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
 
 &pfc {
-- 
2.7.4
