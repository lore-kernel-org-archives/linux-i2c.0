From: Biwen Li <biwen.li@nxp.com>
Subject: [v6,3/3] arm64: dts: fsl-ls208xa-rdb: fix an errata E-00013
Date: Fri, 29 Nov 2019 17:22:22 +0800
Message-ID: <20191129092222.2706-3-biwen.li@nxp.com>
References: <20191129092222.2706-1-biwen.li@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191129092222.2706-1-biwen.li@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peda@axentia.se, leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Biwen Li <biwen.li@nxp.com>
List-Id: linux-i2c@vger.kernel.org

Specify a channel zero in idle state to
avoid enterring tri-stated state for PCA9547.
About E-00013:
	- Description: I2C1 and I2C3 buses
	  are missing pull-up.
	- Impact: When the PCA954x device is tri-stated, the I2C bus
	  will float. This makes the I2C bus and its associated
	  downstream devices inaccessible.
	- Hardware fix: Populate resistors R189 and R190 for I2C1
	  and resistors R228 and R229 for I2C3.
	- Software fix: Remove the tri-state option from the PCA954x
	  driver(PCA954x always on enable status, specify a
	  channel zero in dts to fix the errata E-00013).

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v6:
	- none

Change in v5:
	- specify a channel zero when pca9547 in idle state.

 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
index 6fd7f63085c9..412f1bc0db5f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
@@ -49,6 +49,7 @@
 		reg = <0x75>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		idle-state = <0>;
 		i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.17.1
