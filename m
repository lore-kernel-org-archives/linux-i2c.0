From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Subject: [PATCH] dt-bindings: convert i2c-cros-ec-tunnel.txt to yaml
Date: Mon, 27 Jan 2020 17:12:13 +0100
Message-ID: <20200127161213.13339-1-dafna.hirschfeld@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, bleung@chromium.org, enric.balletbo@collabora.com, groeck@chromium.org, dafna.hirschfeld@collabora.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, helen.koike@collabora.com, ezequiel@collabora.com, kernel@collabora.com, dafna3@gmail.com
List-Id: linux-i2c@vger.kernel.org

Convert the binding file i2c-cros-ec-tunnel.txt to yaml format.

This was tested and verified on ARM and ARM64 with:

make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml
make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 .../bindings/i2c/i2c-cros-ec-tunnel.txt       | 39 ------------
 .../bindings/i2c/i2c-cros-ec-tunnel.yaml      | 61 +++++++++++++++++++
 2 files changed, 61 insertions(+), 39 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt b/Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
deleted file mode 100644
index 898f030eba62..000000000000
--- a/Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-I2C bus that tunnels through the ChromeOS EC (cros-ec)
-======================================================
-On some ChromeOS board designs we've got a connection to the EC (embedded
-controller) but no direct connection to some devices on the other side of
-the EC (like a battery and PMIC).  To get access to those devices we need
-to tunnel our i2c commands through the EC.
-
-The node for this device should be under a cros-ec node like google,cros-ec-spi
-or google,cros-ec-i2c.
-
-
-Required properties:
-- compatible: google,cros-ec-i2c-tunnel
-- google,remote-bus: The EC bus we'd like to talk to.
-
-Optional child nodes:
-- One node per I2C device connected to the tunnelled I2C bus.
-
-
-Example:
-	cros-ec@0 {
-		compatible = "google,cros-ec-spi";
-
-		...
-
-		i2c-tunnel {
-			compatible = "google,cros-ec-i2c-tunnel";
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			google,remote-bus = <0>;
-
-			battery: sbs-battery@b {
-				compatible = "sbs,sbs-battery";
-				reg = <0xb>;
-				sbs,poll-retry-count = <1>;
-			};
-		};
-	}
diff --git a/Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml b/Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml
new file mode 100644
index 000000000000..c1383e607f47
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/i2c-cros-ec-tunnel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: I2C bus that tunnels through the ChromeOS EC (cros-ec)
+
+maintainers:
+  - Benson Leung <bleung@chromium.org>
+  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
+  - Guenter Roeck <groeck@chromium.org>
+
+description: |
+  On some ChromeOS board designs we've got a connection to the EC (embedded
+  controller) but no direct connection to some devices on the other side of
+  the EC (like a battery and PMIC). To get access to those devices we need
+  to tunnel our i2c commands through the EC.
+  The node for this device should be under a cros-ec node like google,cros-ec-spi
+  or google,cros-ec-i2c.
+
+properties:
+  compatible:
+    const:
+      google,cros-ec-i2c-tunnel
+
+  google,remote-bus:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: The EC bus we'd like to talk to.
+
+  "#address-cells": true
+  "#size-cells": true
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+    description: One node per I2C device connected to the tunnelled I2C bus.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - google,remote-bus
+
+examples:
+  - |
+    cros-ec@0 {
+        compatible = "google,cros-ec-spi";
+        i2c-tunnel {
+            compatible = "google,cros-ec-i2c-tunnel";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            google,remote-bus = <0>;
+
+            battery: sbs-battery@b {
+                compatible = "sbs,sbs-battery";
+                reg = <0xb>;
+                sbs,poll-retry-count = <1>;
+            };
+        };
+    };
-- 
2.17.1
