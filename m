From: Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH 3/3] arm64: dts: fsl: ls1046a: Add mul-value property of the i2c controller nodes
Date: Tue, 30 Apr 2019 12:32:42 +0800
Message-ID: <20190430043242.29687-3-chuanhua.han@nxp.com>
References: <20190430043242.29687-1-chuanhua.han@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190430043242.29687-1-chuanhua.han@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, leoyang.li@nxp.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com, festevam@gmail.com, wsa+renesas@sang-engineering.com, u.kleine-koenig@pengutronix.de, eha@deif.com, linux@rempel-privat.de, sumit.batra@nxp.com, l.stach@pengutronix.de, peda@axentia.se, Chuanhua Han <chuanhua.han@nxp.com>
List-Id: linux-i2c@vger.kernel.org

According to LS1046A Reference Manual, for the i2c controller, you have
up to three MUL options available for all divider values. Therefore, we
need to determine which MUL to use in the device tree for driver use.

The "mul-value" property provides which mul is used in our driver.

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index b0ef08b090dd..373310e4c0ea 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -385,6 +385,7 @@
 			dmas = <&edma0 1 39>,
 			       <&edma0 1 38>;
 			dma-names = "tx", "rx";
+			mul-value = <4>;
 			status = "disabled";
 		};
 
@@ -395,6 +396,7 @@
 			reg = <0x0 0x2190000 0x0 0x10000>;
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
+			mul-value = <4>;
 			status = "disabled";
 		};
 
@@ -405,6 +407,7 @@
 			reg = <0x0 0x21a0000 0x0 0x10000>;
 			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
+			mul-value = <4>;
 			status = "disabled";
 		};
 
@@ -415,6 +418,7 @@
 			reg = <0x0 0x21b0000 0x0 0x10000>;
 			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 1>;
+			mul-value = <4>;
 			status = "disabled";
 		};
 
-- 
2.17.1
