From: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Subject: [PATCH v7 4/4] arm64: dts: sdm845: Add support for an instance of I2C controller
Date: Tue, 12 Jun 2018 11:09:08 -0600
Message-ID: <1528823348-30532-5-git-send-email-kramasub@codeaurora.org>
References: <1528823348-30532-1-git-send-email-kramasub@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528823348-30532-1-git-send-email-kramasub@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org
Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, evgreen@chromium.org, acourbot@chromium.org, swboyd@chromium.org, dianders@chromium.org
List-Id: linux-i2c@vger.kernel.org

Add one instance of GENI based I2C master controller to enable testing
I2C driver using EEPROM slave.

Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 19 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 28 ++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 17b2fb0..dbe3a36 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -29,9 +29,28 @@
 		serial@a84000 {
 			status = "okay";
 		};
+
+		i2c@a88000 {
+			clock-frequency = <400000>;
+			status = "okay";
+		};
 	};
 
 	pinctrl@3400000 {
+		qup-i2c10-default {
+			pinconf {
+				pins = "gpio55", "gpio56";
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+
+		qup-i2c10-sleep {
+			pinconf {
+				pins = "gpio55", "gpio56";
+			};
+		};
+
 		qup-uart2-default {
 			pinconf_tx {
 				pins = "gpio4";
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 71801b9..d367020 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -196,6 +196,20 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
+			qup_i2c10_default: qup-i2c10-default {
+				pinmux {
+					function = "qup10";
+					pins = "gpio55", "gpio56";
+				};
+			};
+
+			qup_i2c10_sleep: qup-i2c10-sleep {
+				pinmux {
+					function = "gpio";
+					pins = "gpio55", "gpio56";
+				};
+			};
+
 			qup_uart2_default: qup-uart2-default {
 				pinmux {
 					function = "qup9";
@@ -310,6 +324,20 @@
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
+
+			i2c10: i2c@a88000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0xa88000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				pinctrl-names = "default", "sleep";
+				pinctrl-0 = <&qup_i2c10_default>;
+				pinctrl-1 = <&qup_i2c10_sleep>;
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
