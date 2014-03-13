From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v3 2/2] ARM: sunxi: dt: Convert to the new i2c compatibles
Date: Thu, 13 Mar 2014 12:37:23 +0100
Message-ID: <1394710643-3411-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1394710643-3411-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1394710643-3411-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Switch the device tree to the new compatibles introduced in the i2c drivers
to have a common pattern accross all Allwinner SoCs.

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  |  6 +++---
 arch/arm/boot/dts/sun5i-a10s.dtsi |  6 +++---
 arch/arm/boot/dts/sun5i-a13.dtsi  |  6 +++---
 arch/arm/boot/dts/sun7i-a20.dtsi  | 10 +++++-----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 27dc6ee8d0d6..6d3e39b8bb29 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -641,7 +641,7 @@
 		};
 
 		i2c0: i2c@01c2ac00 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <7>;
 			clocks = <&apb1_gates 0>;
@@ -650,7 +650,7 @@
 		};
 
 		i2c1: i2c@01c2b000 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <8>;
 			clocks = <&apb1_gates 1>;
@@ -659,7 +659,7 @@
 		};
 
 		i2c2: i2c@01c2b400 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <9>;
 			clocks = <&apb1_gates 2>;
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index f34e0d85c9be..4977f47aeab3 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -519,7 +519,7 @@
 		i2c0: i2c@01c2ac00 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <7>;
 			clocks = <&apb1_gates 0>;
@@ -530,7 +530,7 @@
 		i2c1: i2c@01c2b000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <8>;
 			clocks = <&apb1_gates 1>;
@@ -541,7 +541,7 @@
 		i2c2: i2c@01c2b400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <9>;
 			clocks = <&apb1_gates 2>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 0e9c239af689..7e0ef8374bbf 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -461,7 +461,7 @@
 		};
 
 		i2c0: i2c@01c2ac00 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <7>;
 			clocks = <&apb1_gates 0>;
@@ -470,7 +470,7 @@
 		};
 
 		i2c1: i2c@01c2b000 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <8>;
 			clocks = <&apb1_gates 1>;
@@ -479,7 +479,7 @@
 		};
 
 		i2c2: i2c@01c2b400 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <9>;
 			clocks = <&apb1_gates 2>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 4cc2f5f2ecad..c1fd510fd2c4 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -762,7 +762,7 @@
 		};
 
 		i2c0: i2c@01c2ac00 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <0 7 4>;
 			clocks = <&apb1_gates 0>;
@@ -771,7 +771,7 @@
 		};
 
 		i2c1: i2c@01c2b000 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <0 8 4>;
 			clocks = <&apb1_gates 1>;
@@ -780,7 +780,7 @@
 		};
 
 		i2c2: i2c@01c2b400 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <0 9 4>;
 			clocks = <&apb1_gates 2>;
@@ -789,7 +789,7 @@
 		};
 
 		i2c3: i2c@01c2b800 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b800 0x400>;
 			interrupts = <0 88 4>;
 			clocks = <&apb1_gates 3>;
@@ -798,7 +798,7 @@
 		};
 
 		i2c4: i2c@01c2bc00 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2bc00 0x400>;
 			interrupts = <0 89 4>;
 			clocks = <&apb1_gates 15>;
-- 
1.9.0
