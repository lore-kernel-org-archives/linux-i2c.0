From: Baolin Wang <baolin.wang@spreadtrum.com>
Subject: [PATCH 1/2] dt-bindings: i2c: Add Spreadtrum I2C controller documentation
Date: Thu, 15 Jun 2017 19:30:07 +0800
Message-ID: <7bc5c69030b6e491cfb2519eb1b21c1b0adc70c3.1497525667.git.baolin.wang@spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:16772 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1752137AbdFOLdl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 15 Jun 2017 07:33:41 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, mark.rutland@arm.com, robh+dt@kernel.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, baolin.wang@linaro.org, baolin.wang@spreadtrum.com

This patch adds the binding documentation for Spreadtrum I2C
controller device.

Signed-off-by: Baolin Wang <baolin.wang@spreadtrum.com>
---
 Documentation/devicetree/bindings/i2c/i2c-sprd.txt |   31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sprd.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-sprd.txt b/Documentation/devicetree/bindings/i2c/i2c-sprd.txt
new file mode 100644
index 0000000..f285e5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-sprd.txt
@@ -0,0 +1,31 @@
+I2C for Spreadtrum platforms
+
+Required properties:
+- compatible: Should be "sprd,r8p0-i2c".
+- reg: Specify the physical base address of the controller and length
+  of memory mapped region.
+- interrupts: Should contain I2C interrupt.
+- clock-names: Should contain following entries:
+  "i2c" for I2C clock,
+  "source" for I2C source (parent) clock,
+  "enable" for I2C module enable clock.
+- clocks: Should contain a clock specifier for each entry in clock-names.
+- clock-frequency: Constains desired I2C bus clock frequency in Hz.
+- #address-cells: Should be 1 to describe address cells for I2C device address.
+- #size-cells: Should be 0 means no size cell for I2C device address.
+
+Optional properties:
+- Child nodes conforming to I2C bus binding
+
+Examples:
+i2c0: i2c@70500000 {
+	compatible = "sprd,r8p0-i2c";
+	reg = <0 0x70500000 0 0x1000>;
+	interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+	clock-names = "i2c", "source", "enable";
+	clocks = <&clk_i2c3>, <&ext_26m>, <&clk_ap_apb_gates 11>;
+	clock-frequency = <400000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+};
+
-- 
1.7.9.5
