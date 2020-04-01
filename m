From: Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
Subject: [PATCH] dt-bindings: i2c: xiic: Migrate i2c-xiic documentation to YAML
Date: Wed,  1 Apr 2020 22:47:09 +0900
Message-ID: <20200401134709.60421-1-iwamatsu@nigauri.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The document was migrated to YAML format and renamed xlnx,xps-iic-2.00.a.yaml

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
---
 .../devicetree/bindings/i2c/i2c-xiic.txt      | 25 ----------
 .../bindings/i2c/xlnx,xps-iic-2.00.a.yaml     | 49 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 50 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-xiic.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-xiic.txt b/Documentation/devicetree/bindings/i2c/i2c-xiic.txt
deleted file mode 100644
index caf42e9894625..0000000000000
--- a/Documentation/devicetree/bindings/i2c/i2c-xiic.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Xilinx IIC controller:
-
-Required properties:
-- compatible : Must be "xlnx,xps-iic-2.00.a"
-- reg : IIC register location and length
-- interrupts : IIC controller unterrupt
-- #address-cells = <1>
-- #size-cells = <0>
-- clocks: Input clock specifier. Refer to common clock bindings.
-
-Optional properties:
-- Child nodes conforming to i2c bus binding
-- clock-names: Input clock name, should be 'pclk'.
-
-Example:
-
-	axi_iic_0: i2c@40800000 {
-		compatible = "xlnx,xps-iic-2.00.a";
-		clocks = <&clkc 15>;
-		interrupts = < 1 2 >;
-		reg = < 0x40800000 0x10000 >;
-
-		#size-cells = <0>;
-		#address-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml b/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
new file mode 100644
index 0000000000000..67c1c84ba3dc2
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/i2c/xlnx,xps-iic-2.00.a.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: ilinx IIC controller Device Tree Bindings
+
+maintainers:
+  - info-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    const: xlnx,xps-iic-2.00.a
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
+  clock-name:
+    const: pclk
+    description: |
+      Input clock name.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+examples:
+  - |
+    axi_iic_0: i2c@40800000 {
+      compatible = "xlnx,xps-iic-2.00.a";
+      clocks = <&clkc 15>;
+      interrupts = < 1 2 >;
+      reg = < 0x40800000 0x10000 >;
+
+      #size-cells = <0>;
+      #address-cells = <1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 1fb95a12eda48..ffaf0053aba86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2673,7 +2673,7 @@ F:	drivers/block/xsysace.c
 N:	zynq
 N:	xilinx
 F:	Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
-F:	Documentation/devicetree/bindings/i2c/i2c-xiic.txt
+F:	Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
 F:	drivers/clocksource/timer-cadence-ttc.c
 F:	drivers/i2c/busses/i2c-cadence.c
 F:	drivers/mmc/host/sdhci-of-arasan.c
-- 
2.26.0
