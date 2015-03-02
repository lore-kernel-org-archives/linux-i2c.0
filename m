From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH 1/2] dt-bindings: i2c: Add dt binding documentation for ingenic jz4780 SoC
Date: Mon, 2 Mar 2015 12:46:28 +0000
Message-ID: <1425300389-13193-2-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1425300389-13193-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425300389-13193-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Zubair.Kakakhel@imgtec.com
List-Id: linux-i2c@vger.kernel.org

Adds DT documentation for the the i2c controller for the JZ4780 SoC

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
---
 .../devicetree/bindings/i2c/i2c-jz4780.txt         | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-jz4780.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-jz4780.txt b/Documentation/devicetree/bindings/i2c/i2c-jz4780.txt
new file mode 100644
index 0000000..8ba2266
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-jz4780.txt
@@ -0,0 +1,38 @@
+* Ingenic JZ4780 I2C Bus controller
+
+Required properties:
+- compatible: should be "ingenic,jz4780-i2c"
+- reg: Should contain the address & size of the I2C controller registers.
+- interrupts: Should specify the interrupt provided by parent.
+- clocks: Should contain a single clock specifier for the JZ4780 I2C clock.
+- clock-frequency: desired I2C bus clock frequency in Hz.
+
+Recommended properties:
+- pinctrl-names: should be "default";
+- pinctrl-0: phandle to pinctrl function
+
+Optional properties:
+- interrupt-parent: Should be the phandle of the interrupt controller that
+  delivers interrupts to the I2C block.
+
+Example SoC file
+
+/ {
+	i2c4: i2c4@0x10054000 {
+		compatible = "ingenic,jz4780-i2c";
+		reg = <0x10054000 0x1000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <56>;
+
+		clocks = <&cgu JZ4780_CLK_SMB4>;
+	};
+};
+
+Example board file
+
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_i2c4_data>;
+}
-- 
1.9.1
