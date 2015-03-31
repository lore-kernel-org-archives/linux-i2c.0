From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V3 1/2] dt-bindings: i2c: Add dt binding documentation for ingenic jz4780 SoC
Date: Tue, 31 Mar 2015 14:03:55 +0100
Message-ID: <1427807036-45366-2-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1427807036-45366-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427807036-45366-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Zubair.Kakakhel@imgtec.com
List-Id: linux-i2c@vger.kernel.org

Adds DT documentation for the the i2c controller for the JZ4780 SoC

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
V2 -> V3
Rebase to v4.0-rc6

V1 -> V2
Reworded example node. Was separated between board/soc.
No need for that as such.
Rebase to v4.0-rc3
---
 .../devicetree/bindings/i2c/i2c-jz4780.txt         | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-jz4780.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-jz4780.txt b/Documentation/devicetree/bindings/i2c/i2c-jz4780.txt
new file mode 100644
index 0000000..231e4cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-jz4780.txt
@@ -0,0 +1,35 @@
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
+Example
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
+		clock-frequency = <100000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pins_i2c4_data>;
+
+	};
+};
+
-- 
1.9.1
