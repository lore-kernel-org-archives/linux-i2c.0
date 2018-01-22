From: Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH vY 2/2] ARM: dts: iwg22d-sodimm: use demuxer for I2C5
Date: Mon, 22 Jan 2018 11:29:23 +0000
Message-ID: <1516620563-7965-3-git-send-email-biju.das@bp.renesas.com>
References: <1516620563-7965-1-git-send-email-biju.das@bp.renesas.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:44872 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751058AbeAVLcZ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 22 Jan 2018 06:32:25 -0500
In-Reply-To: <1516620563-7965-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>

Create a separate bus for audiocodec related I2C5 and provide fallback to GPIO.

Based on work for r8a7794/Alt by Wolfram Sang: "ARM: dts: alt: use demuxer
for I2C1"

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
---
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 44 +++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
index a4058f4..b2ea43f 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
@@ -42,6 +42,8 @@
 		ethernet0 = &avb;
 		serial3 = &scif4;
 		serial5 = &hscif1;
+		i2c9 = &gpioi2c5;
+		i2c11 = &i2caudiocodec;
 	};
 
 	chosen {
@@ -55,6 +57,36 @@
 		clock-frequency = <26000000>;
 	};
 
+	gpioi2c5: i2c-9 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "i2c-gpio";
+		status = "disabled";
+		scl-gpios = <&gpio0 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		sda-gpios = <&gpio0 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <5>;
+	};
+
+	/*
+	 * A fallback to GPIO is provided for I2C5.
+	 */
+	i2caudiocodec: i2c-11 {
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&i2c5>, <&gpioi2c5>;
+		i2c-bus-name = "i2c-audiocodec";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sgtl5000: codec@a {
+			compatible = "fsl,sgtl5000";
+			#sound-dai-cells = <0>;
+			reg = <0x0a>;
+			clocks = <&audio_clock>;
+			VDDA-supply = <&reg_3p3v>;
+			VDDIO-supply = <&reg_3p3v>;
+		};
+	};
+
 	rsnd_sgtl5000: sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,format = "i2s";
@@ -126,19 +158,9 @@
 
 &i2c5 {
 	pinctrl-0 = <&i2c5_pins>;
-	pinctrl-names = "default";
+	pinctrl-names = "i2c-audiocodec";
 
-	status = "okay";
 	clock-frequency = <400000>;
-
-	sgtl5000: codec@a {
-		compatible = "fsl,sgtl5000";
-		#sound-dai-cells = <0>;
-		reg = <0x0a>;
-		clocks = <&audio_clock>;
-		VDDA-supply = <&reg_3p3v>;
-		VDDIO-supply = <&reg_3p3v>;
-	};
 };
 
 &pci1 {
-- 
2.7.4
