From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 1/5] dt-bindings: add bindings for i2c-pca-platform
Date: Mon, 26 Jun 2017 12:44:30 +1200
Message-ID: <20170626004434.2757-2-chris.packham@alliedtelesis.co.nz>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:34768 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbdFZAop (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 25 Jun 2017 20:44:45 -0400
In-Reply-To: <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v2:
- Split dt-binding to separate patch, use "reset-gpios" instead of "gpios".
Changes in v3:
- State the gpio is active low
- Add example

 .../devicetree/bindings/i2c/i2c-pca-platform.txt   | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-pca-platform.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-pca-platform.txt b/Documentation/devicetree/bindings/i2c/i2c-pca-platform.txt
new file mode 100644
index 000000000000..f1f3876bb8e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-pca-platform.txt
@@ -0,0 +1,29 @@
+* NXP PCA PCA9564/PCA9665 I2C controller
+
+The PCA9564/PCA9665 serves as an interface between most standard
+parallel-bus microcontrollers/microprocessors and the serial I2C-bus
+and allows the parallel bus system to communicate bi-directionally
+with the I2C-bus.
+
+Required properties :
+
+ - reg : Offset and length of the register set for the device
+ - compatible : one of "nxp,pca9564" or "nxp,pca9665"
+
+Optional properties
+ - interrupts : the interrupt number
+ - interrupt-parent : the phandle for the interrupt controller.
+   If an interrupt is not specified polling will be used.
+ - reset-gpios : gpio specifier for gpio connected to RESET_N pin. As the line
+   is active low, it should be marked GPIO_ACTIVE_LOW.
+ - clock-frequency : I2C bus frequency.
+
+Example:
+	i2c0: i2c@80000 {
+		compatible = "nxp,pca9564";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x80000 0x4>;
+		reset-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
+		clock-frequency = <100000>;
+	};
-- 
2.13.0
