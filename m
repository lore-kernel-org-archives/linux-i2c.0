From: Pierre-Yves MORDRET <pierre-yves.mordret-qxv4g6HH51o@public.gmane.org>
Subject: [RESEND PATCH v3 4/5] ARM: dts: stm32: Add I2C1 support for STM32F746 SoC
Date: Fri, 1 Sep 2017 09:34:14 +0200
Message-ID: <1504251255-20469-5-git-send-email-pierre-yves.mordret@st.com>
References: <1504251255-20469-1-git-send-email-pierre-yves.mordret@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1504251255-20469-1-git-send-email-pierre-yves.mordret-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Pierre-Yves MORDRET <pierre-yves.mordret-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch adds I2C1 support for STM32F746 SoC.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret-qxv4g6HH51o@public.gmane.org>
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
index 4506eb9..ddd8f2c 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -361,6 +361,16 @@
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
@@ -380,6 +390,18 @@
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
