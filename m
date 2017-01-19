From: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Subject: [PATCH v10 3/5] ARM: dts: stm32: Add I2C1 support for STM32F429 SoC
Date: Thu, 19 Jan 2017 14:25:14 +0100
Message-ID: <1484832316-5594-4-git-send-email-cedric.madianga@gmail.com>
References: <1484832316-5594-1-git-send-email-cedric.madianga@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484832316-5594-1-git-send-email-cedric.madianga@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linus.walleij@linaro.org, patrice.chotard@st.com, linux@armlinux.org.uk, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de
Cc: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
List-Id: linux-i2c@vger.kernel.org

This patch adds I2C1 support for STM32F429 SoC

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index e4dae0e..5b063e9 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -48,6 +48,7 @@
 #include "skeleton.dtsi"
 #include "armv7-m.dtsi"
 #include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
+#include <dt-bindings/mfd/stm32f4-rcc.h>
 
 / {
 	clocks {
@@ -153,6 +154,18 @@
 			status = "disabled";
 		};
 
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
+
 		usart7: serial@40007800 {
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40007800 0x400>;
@@ -355,6 +368,16 @@
 					slew-rate = <2>;
 				};
 			};
+
+			i2c1_pins_b: i2c1@0 {
+				pins {
+					pinmux = <STM32F429_PB9_FUNC_I2C1_SDA>,
+						 <STM32F429_PB6_FUNC_I2C1_SCL>;
+					bias-disable;
+					drive-open-drain;
+					slew-rate = <3>;
+				};
+			};
 		};
 
 		rcc: rcc@40023810 {
-- 
1.9.1
