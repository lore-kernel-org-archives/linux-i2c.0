From: Gao Pan <pandy.gao@nxp.com>
Subject: [Patch V5 1/2] i2c: imx: add devicetree binding for lpi2c
Date: Thu, 17 Nov 2016 16:17:06 +0800
Message-ID: <1479370627-26691-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0071.outbound.protection.outlook.com ([104.47.2.71]:55155
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1945968AbcKQKwP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 17 Nov 2016 05:52:15 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, u.kleine-koenig@pengutronix.de, cmo@melexis.com, robh@kernel.org, vz@mleia.com
Cc: linux-i2c@vger.kernel.org, pandy.gao@nxp.com, frank.li@nxp.com, fugang.duan@nxp.com

Add a binding document for lpi2c driver

Signed-off-by: Gao Pan <pandy.gao@nxp.com>
---
 .../devicetree/bindings/i2c/i2c-imx-lpi2c.txt        | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt b/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt
new file mode 100644
index 0000000..70c054a
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt
@@ -0,0 +1,20 @@
+* Freescale Low Power Inter IC (LPI2C) for i.MX
+
+Required properties:
+- compatible :
+  - "fsl,imx7ulp-lpi2c" for LPI2C compatible with the one integrated on i.MX7ULP soc
+  - "fsl,imx8dv-lpi2c" for LPI2C compatible with the one integrated on i.MX8DV soc
+- reg : address and length of the lpi2c master registers
+- interrupt-parent : core interrupt controller
+- interrupts : lpi2c interrupt
+- clocks : lpi2c clock specifier
+
+Examples:
+
+lpi2c7: lpi2c7@40A50000 {
+	compatible = "fsl,imx8dv-lpi2c";
+	reg = <0x40A50000 0x10000>;
+	interrupt-parent = <&intc>;
+	interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clks IMX7ULP_CLK_LPI2C7>;
+};
-- 
1.9.1
