From: Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH v2 3/4] arm64: dts: actions: s700: Add I2C controller nodes
Date: Mon, 26 Nov 2018 19:58:20 +0100
Message-ID: <20181126185821.2480449-4-pn@denx.de>
References: <20181126185821.2480449-1-pn@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181126185821.2480449-1-pn@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: afaerber@suse.de, manivannan.sadhasivam@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux@cubietech.com, thomas.liau@actions-semi.com, Parthiban Nallathambi <pn@denx.de>
List-Id: linux-i2c@vger.kernel.org

Add I2C controller nodes for Actions Semiconductor S700 SoC.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 192c7b39c8c1..35fddba2af1c 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -174,6 +174,46 @@
 			#clock-cells = <1>;
 		};
 
+		i2c0: i2c@e0170000 {
+			compatible = "actions,s700-i2c";
+			reg = <0 0xe0170000 0 0x1000>;
+			clocks = <&cmu CLK_I2C0>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@e0174000 {
+			compatible = "actions,s700-i2c";
+			reg = <0 0xe0174000 0 0x1000>;
+			clocks = <&cmu CLK_I2C1>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@e0178000 {
+			compatible = "actions,s700-i2c";
+			reg = <0 0xe0178000 0 0x1000>;
+			clocks = <&cmu CLK_I2C2>;
+			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@e017c000 {
+			compatible = "actions,s700-i2c";
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
