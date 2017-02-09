From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH v6 1/3] dt: bindings: add documentation for zx2967 family i2c
 controller
Date: Thu,  9 Feb 2017 17:32:31 +0800
Message-ID: <1486632753-17363-1-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: shawnguo@kernel.org, andy.shevchenko@gmail.com, jun.nie@linaro.org, baoyou.xie@linaro.org, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, xie.baoyou@zte.com.cn, linux-kernel@vger.kernel.org, chen.chaokai@zte.com.cn, linux-i2c@vger.kernel.org, wang.qiang01@zte.com.cn, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

This patch adds dt-binding documentation for zx2967 family
i2c controller.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/i2c/i2c-zx2967.txt         | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-zx2967.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-zx2967.txt b/Documentation/devicetree/bindings/i2c/i2c-zx2967.txt
new file mode 100644
index 0000000..a528374
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-zx2967.txt
@@ -0,0 +1,24 @@
+ZTE zx2967 I2C controller
+
+Required properties:
+ - compatible: must be "zte,zx296718-i2c"
+ - reg: physical address and length of the device registers
+ - interrupts: a single interrupt specifier
+ - clocks: clock for the device
+ - #address-cells: should be <1>
+ - #size-cells: should be <0>
+ - clock-frequency: the desired I2C bus clock frequency.
+
+Examples:
+
+	i2c@112000 {
+		compatible = "zte,zx296718-i2c";
+		reg = <0x00112000 0x1000>;
+		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&osc24m>;
+		#address-cells = <1>
+		#size-cells = <0>;
+		clock-frequency = <1600000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c_global_pin>;
+	};
-- 
2.7.4
