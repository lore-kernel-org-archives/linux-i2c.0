From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] dt-bindings: i2c: meson: convert to yaml
Date: Mon, 21 Oct 2019 16:00:53 +0200
Message-ID: <20191021140053.9525-1-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Beniamino Galvani <b.galvani@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Now that we have the DT validation in place, let's convert the device tree
bindings for the Amlogic I2C Controller over to YAML schemas.

Cc: Beniamino Galvani <b.galvani@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/i2c/amlogic,meson6-i2c.yaml      | 53 +++++++++++++++++++
 .../devicetree/bindings/i2c/i2c-meson.txt     | 30 -----------
 2 files changed, 53 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/amlogic,meson6-i2c.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-meson.txt

diff --git a/Documentation/devicetree/bindings/i2c/amlogic,meson6-i2c.yaml b/Documentation/devicetree/bindings/i2c/amlogic,meson6-i2c.yaml
new file mode 100644
index 000000000000..49cad273c8e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/amlogic,meson6-i2c.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 BayLibre, SAS
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/i2c/amlogic,meson6-i2c.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic Meson I2C Controller
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+  - Beniamino Galvani <b.galvani@gmail.com>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - amlogic,meson6-i2c # Meson6, Meson8 and compatible SoCs
+      - amlogic,meson-gxbb-i2c # GXBB and compatible SoCs
+      - amlogic,meson-axg-i2c # AXG and compatible SoCs
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+examples:
+  - |
+    i2c@c8100500 {
+        compatible = "amlogic,meson6-i2c";
+        reg = <0xc8100500 0x20>;
+        interrupts = <92>;
+        clocks = <&clk81>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        eeprom@52 {
+            compatible = "atmel,24c32";
+            reg = <0x52>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/i2c/i2c-meson.txt b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
deleted file mode 100644
index 13d410de077c..000000000000
--- a/Documentation/devicetree/bindings/i2c/i2c-meson.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Amlogic Meson I2C controller
-
-Required properties:
- - compatible: must be:
-	"amlogic,meson6-i2c" for Meson8 and compatible SoCs
-	"amlogic,meson-gxbb-i2c" for GXBB and compatible SoCs
-	"amlogic,meson-axg-i2c"for AXG and compatible SoCs
-
- - reg: physical address and length of the device registers
- - interrupts: a single interrupt specifier
- - clocks: clock for the device
- - #address-cells: should be <1>
- - #size-cells: should be <0>
-
-For details regarding the following core I2C bindings see also i2c.txt.
-
-Optional properties:
-- clock-frequency: the desired I2C bus clock frequency in Hz; in
-  absence of this property the default value is used (100 kHz).
-
-Examples:
-
-	i2c@c8100500 {
-		compatible = "amlogic,meson6-i2c";
-		reg = <0xc8100500 0x20>;
-		interrupts = <0 92 1>;
-		clocks = <&clk81>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-- 
2.22.0
