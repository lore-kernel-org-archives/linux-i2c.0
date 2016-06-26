From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/3] powerpc/dts: fix STMicroelectronics compatible strings
Date: Sun, 26 Jun 2016 02:34:05 -0700
Message-ID: <20160626093406.26785-2-stefan@agner.ch>
References: <20160626093406.26785-1-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160626093406.26785-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, mark.rutland@arm.com, arnd@arndb.de, shawnguo@kernel.org, mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org
Cc: scottwood@freescale.com, dinguyen@opensource.altera.com, robh+dt@kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-i2c@vger.kernel.org

Replace the non-standard vendor prefix stm and st-micro with st for
STMicroelectronics. The drivers do not specify the vendor prefixes
since the I2C Core strips them away from the DT provided compatible
string. Therefore, changing existing device trees does not have any
impact on device detection.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/powerpc/boot/dts/ac14xx.dts           | 2 +-
 arch/powerpc/boot/dts/akebono.dts          | 2 +-
 arch/powerpc/boot/dts/bluestone.dts        | 2 +-
 arch/powerpc/boot/dts/canyonlands.dts      | 2 +-
 arch/powerpc/boot/dts/currituck.dts        | 2 +-
 arch/powerpc/boot/dts/fsl/mpc8569mds.dts   | 2 +-
 arch/powerpc/boot/dts/fsl/p1022rdk.dts     | 2 +-
 arch/powerpc/boot/dts/glacier.dts          | 2 +-
 arch/powerpc/boot/dts/icon.dts             | 2 +-
 arch/powerpc/boot/dts/mpc5121ads.dts       | 2 +-
 arch/powerpc/boot/dts/mpc8349emitx.dts     | 2 +-
 arch/powerpc/boot/dts/mpc836x_rdk.dts      | 2 +-
 arch/powerpc/boot/dts/pdm360ng.dts         | 2 +-
 arch/powerpc/boot/dts/sam440ep.dts         | 2 +-
 arch/powerpc/boot/dts/xcalibur1501.dts     | 2 +-
 arch/powerpc/boot/dts/xpedite5200.dts      | 2 +-
 arch/powerpc/boot/dts/xpedite5200_xmon.dts | 2 +-
 arch/powerpc/boot/dts/xpedite5301.dts      | 2 +-
 arch/powerpc/boot/dts/xpedite5330.dts      | 2 +-
 arch/powerpc/boot/dts/xpedite5370.dts      | 2 +-
 20 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/boot/dts/ac14xx.dts b/arch/powerpc/boot/dts/ac14xx.dts
index a1b8837..27fcabc 100644
--- a/arch/powerpc/boot/dts/ac14xx.dts
+++ b/arch/powerpc/boot/dts/ac14xx.dts
@@ -231,7 +231,7 @@
 			};
 
 			rtc@68 {
-				compatible = "stm,m41t00";
+				compatible = "st,m41t00";
 				reg = <0x68>;
 			};
 		};
diff --git a/arch/powerpc/boot/dts/akebono.dts b/arch/powerpc/boot/dts/akebono.dts
index f92ecfe..e61d5dc 100644
--- a/arch/powerpc/boot/dts/akebono.dts
+++ b/arch/powerpc/boot/dts/akebono.dts
@@ -224,7 +224,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				rtc@68 {
-					compatible = "stm,m41t80", "m41st85";
+					compatible = "st,m41t80", "m41st85";
 					reg = <0x68>;
 				};
 			};
diff --git a/arch/powerpc/boot/dts/bluestone.dts b/arch/powerpc/boot/dts/bluestone.dts
index 7daaca3..b0b26d8 100644
--- a/arch/powerpc/boot/dts/bluestone.dts
+++ b/arch/powerpc/boot/dts/bluestone.dts
@@ -279,7 +279,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				rtc@68 {
-					compatible = "stm,m41t80";
+					compatible = "st,m41t80";
 					reg = <0x68>;
 					interrupt-parent = <&UIC0>;
 					interrupts = <0x9 0x8>;
diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
index 549c24c..0d6ac92 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -319,7 +319,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
                                 rtc@68 {
-                                        compatible = "stm,m41t80";
+                                        compatible = "st,m41t80";
                                         reg = <0x68>;
 					interrupt-parent = <&UIC2>;
 					interrupts = <0x19 0x8>;
diff --git a/arch/powerpc/boot/dts/currituck.dts b/arch/powerpc/boot/dts/currituck.dts
index d2c8a87..4191e18 100644
--- a/arch/powerpc/boot/dts/currituck.dts
+++ b/arch/powerpc/boot/dts/currituck.dts
@@ -116,7 +116,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
                                 rtc@68 {
-                                        compatible = "stm,m41t80", "m41st85";
+                                        compatible = "st,m41t80", "m41st85";
                                         reg = <0x68>;
                                 };
 			};
diff --git a/arch/powerpc/boot/dts/fsl/mpc8569mds.dts b/arch/powerpc/boot/dts/fsl/mpc8569mds.dts
index a95ff7d..8e94448 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8569mds.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8569mds.dts
@@ -232,7 +232,7 @@
 			mode = "cpu-qe";
 
 			serial-flash@0 {
-				compatible = "stm,m25p40";
+				compatible = "st,m25p40";
 				reg = <0>;
 				spi-max-frequency = <25000000>;
 			};
diff --git a/arch/powerpc/boot/dts/fsl/p1022rdk.dts b/arch/powerpc/boot/dts/fsl/p1022rdk.dts
index d505d7c..29e8af1 100644
--- a/arch/powerpc/boot/dts/fsl/p1022rdk.dts
+++ b/arch/powerpc/boot/dts/fsl/p1022rdk.dts
@@ -57,7 +57,7 @@
 				clock-frequency = <12288000>;
 			};
 			rtc@68 {
-				compatible = "stm,m41t62";
+				compatible = "st,m41t62";
 				reg = <0x68>;
 			};
 			adt7461@4c{
diff --git a/arch/powerpc/boot/dts/glacier.dts b/arch/powerpc/boot/dts/glacier.dts
index 2000060..a7a802f 100644
--- a/arch/powerpc/boot/dts/glacier.dts
+++ b/arch/powerpc/boot/dts/glacier.dts
@@ -287,7 +287,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				rtc@68 {
-					compatible = "stm,m41t80";
+					compatible = "st,m41t80";
 					reg = <0x68>;
 					interrupt-parent = <&UIC2>;
 					interrupts = <0x19 0x8>;
diff --git a/arch/powerpc/boot/dts/icon.dts b/arch/powerpc/boot/dts/icon.dts
index abcd0ca..9c94fd7 100644
--- a/arch/powerpc/boot/dts/icon.dts
+++ b/arch/powerpc/boot/dts/icon.dts
@@ -256,7 +256,7 @@
 				#size-cells = <0>;
 
                                 rtc@68 {
-                                        compatible = "stm,m41t00";
+                                        compatible = "st,m41t00";
                                         reg = <0x68>;
                                 };
 			};
diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
index c228a0a..75888ce 100644
--- a/arch/powerpc/boot/dts/mpc5121ads.dts
+++ b/arch/powerpc/boot/dts/mpc5121ads.dts
@@ -99,7 +99,7 @@
 			};
 
 			rtc@68 {
-				compatible = "stm,m41t62";
+				compatible = "st,m41t62";
 				reg = <0x68>;
 			};
 		};
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index cf85424..90aed3a 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -92,7 +92,7 @@
 			dfsrr;
 
 			eeprom: at24@50 {
-				compatible = "st-micro,24c256";
+				compatible = "st,24c256";
 				reg = <0x50>;
 			};
 
diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
index daeacbd..47c5fc6 100644
--- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -416,7 +416,7 @@
 			gpios = <&qe_pio_e 18 0>;
 
 			flash {
-				compatible = "stm,nand512-a";
+				compatible = "st,nand512-a";
 			};
 		};
 
diff --git a/arch/powerpc/boot/dts/pdm360ng.dts b/arch/powerpc/boot/dts/pdm360ng.dts
index 871c16d..0cec724 100644
--- a/arch/powerpc/boot/dts/pdm360ng.dts
+++ b/arch/powerpc/boot/dts/pdm360ng.dts
@@ -103,7 +103,7 @@
 			};
 
 			rtc@68 {
-				compatible = "stm,m41t00";
+				compatible = "st,m41t00";
 				reg = <0x68>;
 			};
 		};
diff --git a/arch/powerpc/boot/dts/sam440ep.dts b/arch/powerpc/boot/dts/sam440ep.dts
index f0663be..088361c 100644
--- a/arch/powerpc/boot/dts/sam440ep.dts
+++ b/arch/powerpc/boot/dts/sam440ep.dts
@@ -196,7 +196,7 @@
 				interrupt-parent = <&UIC0>;
 				interrupts = <2 4>;
 				rtc@68 {
-					compatible = "stm,m41t80";
+					compatible = "st,m41t80";
 					reg = <0x68>;
 				};
 			};
diff --git a/arch/powerpc/boot/dts/xcalibur1501.dts b/arch/powerpc/boot/dts/xcalibur1501.dts
index c409cba..1f2952d 100644
--- a/arch/powerpc/boot/dts/xcalibur1501.dts
+++ b/arch/powerpc/boot/dts/xcalibur1501.dts
@@ -238,7 +238,7 @@
 			};
 
 			rtc@68 {
-				compatible = "stm,m41t00",
+				compatible = "st,m41t00",
 				             "dallas,ds1338";
 				reg = <0x68>;
 			};
diff --git a/arch/powerpc/boot/dts/xpedite5200.dts b/arch/powerpc/boot/dts/xpedite5200.dts
index 8fd7b70..5b10e56 100644
--- a/arch/powerpc/boot/dts/xpedite5200.dts
+++ b/arch/powerpc/boot/dts/xpedite5200.dts
@@ -130,7 +130,7 @@
 			};
 
 			rtc@68 {
-				compatible = "stm,m41t00",
+				compatible = "st,m41t00",
 					     "dallas,ds1338";
 				reg = <0x68>;
 			};
diff --git a/arch/powerpc/boot/dts/xpedite5200_xmon.dts b/arch/powerpc/boot/dts/xpedite5200_xmon.dts
index 0baa828..646acfb 100644
--- a/arch/powerpc/boot/dts/xpedite5200_xmon.dts
+++ b/arch/powerpc/boot/dts/xpedite5200_xmon.dts
@@ -134,7 +134,7 @@
 			};
 
 			rtc@68 {
-				compatible = "stm,m41t00",
+				compatible = "st,m41t00",
 					     "dallas,ds1338";
 				reg = <0x68>;
 			};
diff --git a/arch/powerpc/boot/dts/xpedite5301.dts b/arch/powerpc/boot/dts/xpedite5301.dts
index 04cb410..7bcc94f 100644
--- a/arch/powerpc/boot/dts/xpedite5301.dts
+++ b/arch/powerpc/boot/dts/xpedite5301.dts
@@ -231,7 +231,7 @@
 			};
 
 			rtc@68 {
-				compatible = "stm,m41t00",
+				compatible = "st,m41t00",
 				             "dallas,ds1338";
 				reg = <0x68>;
 			};
diff --git a/arch/powerpc/boot/dts/xpedite5330.dts b/arch/powerpc/boot/dts/xpedite5330.dts
index 73f8620..86df8bc 100644
--- a/arch/powerpc/boot/dts/xpedite5330.dts
+++ b/arch/powerpc/boot/dts/xpedite5330.dts
@@ -267,7 +267,7 @@
 			};
 
 			rtc@68 {
-				compatible = "stm,m41t00",
+				compatible = "st,m41t00",
 				             "dallas,ds1338";
 				reg = <0x68>;
 			};
diff --git a/arch/powerpc/boot/dts/xpedite5370.dts b/arch/powerpc/boot/dts/xpedite5370.dts
index cd0ea2b..b8ade09 100644
--- a/arch/powerpc/boot/dts/xpedite5370.dts
+++ b/arch/powerpc/boot/dts/xpedite5370.dts
@@ -229,7 +229,7 @@
 			};
 
 			rtc@68 {
-				compatible = "stm,m41t00",
+				compatible = "st,m41t00",
 				             "dallas,ds1338";
 				reg = <0x68>;
 			};
-- 
2.8.3
