From: Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH] arm64: dts: actions: s700: Add I2C controller nodes
Date: Tue, 13 Nov 2018 14:32:35 +0100
Message-ID: <20181113133235.37754-1-pn@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: afaerber@suse.de, manivannan.sadhasivam@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Parthiban Nallathambi <pn@denx.de>
List-Id: linux-i2c@vger.kernel.org

Add I2C controller nodes for Actions Semiconductor S700 SoC.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 192c7b39c8c1..573c844d7afe 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -174,6 +174,46 @@
 			#clock-cells = <1>;
 		};
 
+		i2c0: i2c@e0170000 {
+			compatible = "actions,s900-i2c";
+			reg = <0 0xe0170000 0 0x1000>;
+			clocks = <&cmu CLK_I2C0>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@e0174000 {
+			compatible = "actions,s900-i2c";
+			reg = <0 0xe0174000 0 0x1000>;
+			clocks = <&cmu CLK_I2C1>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@e0178000 {
+			compatible = "actions,s900-i2c";
+			reg = <0 0xe0178000 0 0x1000>;
+			clocks = <&cmu CLK_I2C2>;
+			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@e017c000 {
+			compatible = "actions,s900-i2c";
+			reg = <0 0xe017c000 0 0x1000>;
+			clocks = <&cmu CLK_I2C3>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		sps: power-controller@e01b0100 {
 			compatible = "actions,s700-sps";
 			reg = <0x0 0xe01b0100 0x0 0x100>;
-- 
2.17.2
