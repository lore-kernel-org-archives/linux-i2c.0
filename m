From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 3/3] ARM: dts: fix STMicroelectronics compatible strings
Date: Sun, 26 Jun 2016 02:34:06 -0700
Message-ID: <20160626093406.26785-3-stefan@agner.ch>
References: <20160626093406.26785-1-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160626093406.26785-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, mark.rutland@arm.com, arnd@arndb.de, shawnguo@kernel.org, mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org
Cc: scottwood@freescale.com, dinguyen@opensource.altera.com, robh+dt@kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-i2c@vger.kernel.org

Replace the non-standard vendor prefix stm with st for
STMicroelectronics. The drivers do not specify the vendor prefixes
since the I2C Core strips them away from the DT provided compatible
string. Therefore, changing existing device trees does not have any
impact on device detection.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx28-m28.dtsi                | 2 +-
 arch/arm/boot/dts/imx51-ts4800.dts              | 2 +-
 arch/arm/boot/dts/imx53-m53.dtsi                | 2 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts         | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-m28.dtsi b/arch/arm/boot/dts/imx28-m28.dtsi
index 6cebaa6..214bb15 100644
--- a/arch/arm/boot/dts/imx28-m28.dtsi
+++ b/arch/arm/boot/dts/imx28-m28.dtsi
@@ -37,7 +37,7 @@
 				status = "okay";
 
 				rtc: rtc@68 {
-					compatible = "stm,m41t62";
+					compatible = "st,m41t62";
 					reg = <0x68>;
 				};
 			};
diff --git a/arch/arm/boot/dts/imx51-ts4800.dts b/arch/arm/boot/dts/imx51-ts4800.dts
index 984c71b..ca1cc5e 100644
--- a/arch/arm/boot/dts/imx51-ts4800.dts
+++ b/arch/arm/boot/dts/imx51-ts4800.dts
@@ -102,7 +102,7 @@
 	status = "okay";
 
 	rtc: m41t00@68 {
-		compatible = "stm,m41t00";
+		compatible = "st,m41t00";
 		reg = <0x68>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx53-m53.dtsi b/arch/arm/boot/dts/imx53-m53.dtsi
index 87a7fc7..d259f57 100644
--- a/arch/arm/boot/dts/imx53-m53.dtsi
+++ b/arch/arm/boot/dts/imx53-m53.dtsi
@@ -84,7 +84,7 @@
 	};
 
 	rtc: rtc@68 {
-		compatible = "stm,m41t62";
+		compatible = "st,m41t62";
 		reg = <0x68>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index 364578d..9059073 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -282,7 +282,7 @@
 	};
 
 	rtc: m41t62@68 {
-		compatible = "stm,m41t62";
+		compatible = "st,m41t62";
 		reg = <0x68>;
 	};
 };
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
index e1a61f2..d798537 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
@@ -52,7 +52,7 @@
 	status = "okay";
 
 	rtc: rtc@68 {
-		compatible = "stm,m41t82";
+		compatible = "st,m41t82";
 		reg = <0x68>;
 	};
 };
-- 
2.8.3
