From: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Subject: [PATCH v5 3/5] ARM: dts: Add I2C1 support for STM32F429 SoC
Date: Thu,  8 Dec 2016 09:26:01 +0100
Message-ID: <1481185563-8735-4-git-send-email-cedric.madianga@gmail.com>
References: <1481185563-8735-1-git-send-email-cedric.madianga@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481185563-8735-1-git-send-email-cedric.madianga@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linus.walleij@linaro.org, patrice.chotard@st.com, linux@armlinux.org.uk, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 7de52ee..cbdece7 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -48,6 +48,7 @@
 #include "skeleton.dtsi"
 #include "armv7-m.dtsi"
 #include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
+#include <dt-bindings/mfd/stm32f4-rcc.h>
 
 / {
 	clocks {
@@ -337,6 +338,16 @@
 					slew-rate = <2>;
 				};
 			};
+
+			i2c1_pins_b: i2c1@0 {
+				pins1 {
+					pinmux = <STM32F429_PB9_FUNC_I2C1_SDA>;
+					drive-open-drain;
+				};
+				pins2 {
+					pinmux = <STM32F429_PB6_FUNC_I2C1_SCL>;
+				};
+			};
 		};
 
 		rcc: rcc@40023810 {
@@ -409,6 +420,18 @@
 			interrupts = <80>;
 			clocks = <&rcc 0 38>;
 		};
+
+		i2c1: i2c@40005400 {
+			compatible = "st,stm32f4-i2c";
+			reg = <0x40005400 0x400>;
+			interrupts = <31>,
+				     <32>;
+			resets = <&rcc STM32F4_APB1_RESET(I2C1)>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(I2C1)>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.9.1
