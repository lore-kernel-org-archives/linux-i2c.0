From: Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
Subject: [PATCH] dt-bindings: i2c: cadence: Migrate i2c-cadence documentation to YAML
Date: Wed,  1 Apr 2020 22:42:22 +0900
Message-ID: <20200401134222.60317-1-iwamatsu@nigauri.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The document was migrated to YAML format and renamed cdns,i2c-r1p10.yaml

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
---
 .../bindings/i2c/cdns,i2c-r1p10.yaml          | 58 +++++++++++++++++++
 .../devicetree/bindings/i2c/i2c-cadence.txt   | 28 ---------
 MAINTAINERS                                   |  2 +-
 3 files changed, 59 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-cadence.txt

diff --git a/Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml b/Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
new file mode 100644
index 0000000000000..dc0952f3780fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/i2c/cdns,i2c-r1p10.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Cadence I2C controller Device Tree Bindings
+
+maintainers:
+  - Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - cdns,i2c-r1p10 # cadence i2c controller version 1.0
+      - cdns,i2c-r1p14 # cadence i2c controller version 1.4
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-frequency:
+    minimum: 1
+    maximum: 400000
+    description: |
+      Desired operating frequency, in Hz, of the bus.
+
+  clock-name:
+    const: pclk
+    description: |
+      Input clock name.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    i2c@e0004000 {
+        compatible = "cdns,i2c-r1p10";
+        clocks = <&clkc 38>;
+        interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+        reg = <0xe0004000 0x1000>;
+        clock-frequency = <400000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/i2c/i2c-cadence.txt b/Documentation/devicetree/bindings/i2c/i2c-cadence.txt
deleted file mode 100644
index ebaa90c58c8e7..0000000000000
--- a/Documentation/devicetree/bindings/i2c/i2c-cadence.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Binding for the Cadence I2C controller
-
-Required properties:
-  - reg: Physical base address and size of the controller's register area.
-  - compatible: Should contain one of:
-		* "cdns,i2c-r1p10"
-		Note:	Use this when cadence i2c controller version 1.0 is used.
-		* "cdns,i2c-r1p14"
-		Note:	Use this when cadence i2c controller version 1.4 is used.
-  - clocks: Input clock specifier. Refer to common clock bindings.
-  - interrupts: Interrupt specifier. Refer to interrupt bindings.
-  - #address-cells: Should be 1.
-  - #size-cells: Should be 0.
-
-Optional properties:
-  - clock-frequency: Desired operating frequency, in Hz, of the bus.
-  - clock-names: Input clock name, should be 'pclk'.
-
-Example:
-	i2c@e0004000 {
-		compatible = "cdns,i2c-r1p10";
-		clocks = <&clkc 38>;
-		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-		reg = <0xe0004000 0x1000>;
-		clock-frequency = <400000>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 38fe2f3f7b6f2..1fb95a12eda48 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2672,7 +2672,7 @@ F:	drivers/cpuidle/cpuidle-zynq.c
 F:	drivers/block/xsysace.c
 N:	zynq
 N:	xilinx
-F:	Documentation/devicetree/bindings/i2c/i2c-cadence.txt
+F:	Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
 F:	Documentation/devicetree/bindings/i2c/i2c-xiic.txt
 F:	drivers/clocksource/timer-cadence-ttc.c
 F:	drivers/i2c/busses/i2c-cadence.c
-- 
2.26.0
