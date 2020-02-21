From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/2] dt-bindings: i2c: Convert UniPhier FI2C controller to
 json-schema
Date: Fri, 21 Feb 2020 11:55:34 +0900
Message-ID: <20200221025535.30311-2-yamada.masahiro@socionext.com>
References: <20200221025535.30311-1-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200221025535.30311-1-yamada.masahiro@socionext.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-i2c@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Convert the UniPhier FIFO-builtin I2C (a.k.a. FIFO) controller binding
to DT schema format.

There are two types of I2C controllers used on the UniPhier platform.
This is the new one with FIFO support, which is used on the Pro4 SoC
or newer.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../bindings/i2c/i2c-uniphier-f.txt           | 25 ----------
 .../bindings/i2c/socionext,uniphier-fi2c.yaml | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-uniphier-f.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/socionext,uniphier-fi2c.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-uniphier-f.txt b/Documentation/devicetree/bindings/i2c/i2c-uniphier-f.txt
deleted file mode 100644
index 27fc6f8c798b..000000000000
--- a/Documentation/devicetree/bindings/i2c/i2c-uniphier-f.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-UniPhier I2C controller (FIFO-builtin)
-
-Required properties:
-- compatible: should be "socionext,uniphier-fi2c".
-- #address-cells: should be 1.
-- #size-cells: should be 0.
-- reg: offset and length of the register set for the device.
-- interrupts: a single interrupt specifier.
-- clocks: phandle to the input clock.
-
-Optional properties:
-- clock-frequency: desired I2C bus frequency in Hz.  The maximum supported
-  value is 400000.  Defaults to 100000 if not specified.
-
-Examples:
-
-	i2c0: i2c@58780000 {
-		compatible = "socionext,uniphier-fi2c";
-		reg = <0x58780000 0x80>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interrupts = <0 41 4>;
-		clocks = <&i2c_clk>;
-		clock-frequency = <100000>;
-	};
diff --git a/Documentation/devicetree/bindings/i2c/socionext,uniphier-fi2c.yaml b/Documentation/devicetree/bindings/i2c/socionext,uniphier-fi2c.yaml
new file mode 100644
index 000000000000..15abc022968e
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/socionext,uniphier-fi2c.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/socionext,uniphier-fi2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UniPhier I2C controller (FIFO-builtin)
+
+maintainers:
+  - Masahiro Yamada <yamada.masahiro@socionext.com>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    const: socionext,uniphier-fi2c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-frequency:
+    minimum: 100000
+    maximum: 400000
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - interrupts
+  - clocks
+
+examples:
+  - |
+    i2c0: i2c@58780000 {
+        compatible = "socionext,uniphier-fi2c";
+        reg = <0x58780000 0x80>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        interrupts = <0 41 4>;
+        clocks = <&i2c_clk>;
+        clock-frequency = <100000>;
+    };
-- 
2.17.1
