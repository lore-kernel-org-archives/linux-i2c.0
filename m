From: Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH 2/2] arm64: dts: fsl: ls1046a: Add the guts node in dts
Date: Tue, 30 Apr 2019 12:47:19 +0800
Message-ID: <20190430044719.30720-2-chuanhua.han@nxp.com>
References: <20190430044719.30720-1-chuanhua.han@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190430044719.30720-1-chuanhua.han@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: shawnguo@kernel.org, s.hauer@pengutronix.de, leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, festevam@gmail.com, linux-imx@nxp.com, wsa+renesas@sang-engineering.com, u.kleine-koenig@pengutronix.de, eha@deif.com, linux@rempel-privat.de, l.stach@pengutronix.de, peda@axentia.se, sumit.batra@nxp.com, Chuanhua Han <chuanhua.han@nxp.com>
List-Id: linux-i2c@vger.kernel.org

For NXP ls1046a SoC, the i2c clock needs to be configured with the
appropriate bit of RCW, so we add the guts node (GUTS/DCFG global
utilities block) for the driver to read.

Signed-off-by: Sumit Batra <sumit.batra@nxp.com>
Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 373310e4c0ea..f88599df18bb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -205,6 +205,11 @@
 			status = "disabled";
 		};
 
+		guts: global-utilities@1ee0000 {
+			compatible = "fsl,qoriq-device-config";
+			reg = <0x0 0x1ee0000 0x0 0x1000>;
+		};
+
 		qspi: spi@1550000 {
 			compatible = "fsl,ls1021a-qspi";
 			#address-cells = <1>;
-- 
2.17.1
