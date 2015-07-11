From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH v2 4/5] ARM: shmobile: emev2: add IIC cores to dtsi
Date: Sat, 11 Jul 2015 09:46:25 +0200
Message-ID: <1436600786-3068-5-git-send-email-wsa@the-dreams.de>
References: <1436600786-3068-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436600786-3068-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ian Molton <ian.molton-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
---
 arch/arm/boot/dts/emev2.dtsi | 48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index bb45694d91bc1e..edad0c4eea3505 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -21,6 +21,8 @@
 		gpio2 = &gpio2;
 		gpio3 = &gpio3;
 		gpio4 = &gpio4;
+		i2c0 = &iic0;
+		i2c1 = &iic1;
 	};
 
 	cpus {
@@ -66,6 +68,30 @@
 			clock-frequency = <32768>;
 			#clock-cells = <0>;
 		};
+		iic0_sclkdiv: iic0_sclkdiv {
+			compatible = "renesas,emev2-smu-clkdiv";
+			reg = <0x624 0>;
+			clocks = <&pll3_fo>;
+			#clock-cells = <0>;
+		};
+		iic0_sclk: iic0_sclk {
+			compatible = "renesas,emev2-smu-gclk";
+			reg = <0x48c 1>;
+			clocks = <&iic0_sclkdiv>;
+			#clock-cells = <0>;
+		};
+		iic1_sclkdiv: iic1_sclkdiv {
+			compatible = "renesas,emev2-smu-clkdiv";
+			reg = <0x624 16>;
+			clocks = <&pll3_fo>;
+			#clock-cells = <0>;
+		};
+		iic1_sclk: iic1_sclk {
+			compatible = "renesas,emev2-smu-gclk";
+			reg = <0x490 1>;
+			clocks = <&iic1_sclkdiv>;
+			#clock-cells = <0>;
+		};
 		pll3_fo: pll3_fo {
 			compatible = "fixed-factor-clock";
 			clocks = <&c32ki>;
@@ -234,4 +260,26 @@
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
+
+	iic0: i2c@e0070000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,iic-emev2";
+		reg = <0xe0070000 0x28>;
+		interrupts = <0 32 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&iic0_sclk>;
+		clock-names = "sclk";
+		status = "disabled";
+	};
+
+	iic1: i2c@e10a0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,iic-emev2";
+		reg = <0xe10a0000 0x28>;
+		interrupts = <0 33 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&iic1_sclk>;
+		clock-names = "sclk";
+		status = "disabled";
+	};
 };
-- 
2.1.4
