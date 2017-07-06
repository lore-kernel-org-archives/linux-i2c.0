From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v3 4/5] ARM: dts: stm32: Add I2C1 support for STM32F746 SoC
Date: Thu, 6 Jul 2017 17:53:05 +0200
Message-ID: <1499356386-28779-5-git-send-email-pierre-yves.mordret@st.com>
References: <1499356386-28779-1-git-send-email-pierre-yves.mordret@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499356386-28779-1-git-send-email-pierre-yves.mordret@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Russell King <linux@armlinux.org.uk>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: pierre-yves.mordret@st.com
List-Id: linux-i2c@vger.kernel.org

This patch adds I2C1 support for STM32F746 SoC.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
 Version history:
    v3:
        * None
    v2:
        * Update I2C SoC device tree with latest Linux version
---
---
 arch/arm/boot/dts/stm32f746.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index c2765ce..b00b96b 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -326,6 +326,16 @@
 					bias-disable;
 				};
 			};
+
+			i2c1_pins_b: i2c1@0 {
+				pins {
+					pinmux = <STM32F746_PB9_FUNC_I2C1_SDA>,
+						 <STM32F746_PB8_FUNC_I2C1_SCL>;
+					bias-disable;
+					drive-open-drain;
+					slew-rate = <0>;
+				};
+			};
 		};
 
 		crc: crc@40023000 {
@@ -344,6 +354,18 @@
 			assigned-clocks = <&rcc 1 CLK_HSE_RTC>;
 			assigned-clock-rates = <1000000>;
 		};
+
+		i2c1: i2c@40005400 {
+			compatible = "st,stm32f7-i2c";
+			reg = <0x40005400 0x400>;
+			interrupts = <31>,
+				     <32>;
+			resets = <&rcc STM32F7_APB1_RESET(I2C1)>;
+			clocks = <&rcc 1 CLK_I2C1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.7.4
