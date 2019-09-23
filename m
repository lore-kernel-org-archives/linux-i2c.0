From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] dt-bindings: at24: convert the binding document to yaml
Date: Mon, 23 Sep 2019 19:52:11 +0200
Message-ID: <20190923175211.2060-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Convert the binding document for at24 EEPROMs from txt to yaml. The
compatible property uses a regex pattern to address all the possible
combinations of "vendor,model" strings.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../devicetree/bindings/eeprom/at24.txt       |  90 +--------------
 .../devicetree/bindings/eeprom/at24.yaml      | 107 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 109 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/eeprom/at24.yaml

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index 22aead844d0f..c94acbb8cb0c 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -1,89 +1 @@
-EEPROMs (I2C)
-
-Required properties:
-
-  - compatible: Must be a "<manufacturer>,<model>" pair. The following <model>
-                values are supported (assuming "atmel" as manufacturer):
-
-                "atmel,24c00",
-                "atmel,24c01",
-                "atmel,24cs01",
-                "atmel,24c02",
-                "atmel,24cs02",
-                "atmel,24mac402",
-                "atmel,24mac602",
-                "atmel,spd",
-                "atmel,24c04",
-                "atmel,24cs04",
-                "atmel,24c08",
-                "atmel,24cs08",
-                "atmel,24c16",
-                "atmel,24cs16",
-                "atmel,24c32",
-                "atmel,24cs32",
-                "atmel,24c64",
-                "atmel,24cs64",
-                "atmel,24c128",
-                "atmel,24c256",
-                "atmel,24c512",
-                "atmel,24c1024",
-                "atmel,24c2048",
-
-                If <manufacturer> is not "atmel", then a fallback must be used
-                with the same <model> and "atmel" as manufacturer.
-
-                Example:
-                        compatible = "microchip,24c128", "atmel,24c128";
-
-                Supported manufacturers are:
-
-                "catalyst",
-                "microchip",
-                "nxp",
-                "ramtron",
-                "renesas",
-                "rohm",
-                "st",
-
-                Some vendors use different model names for chips which are just
-                variants of the above. Known such exceptions are listed below:
-
-                "nxp,se97b" - the fallback is "atmel,24c02",
-                "renesas,r1ex24002" - the fallback is "atmel,24c02"
-                "renesas,r1ex24016" - the fallback is "atmel,24c16"
-                "renesas,r1ex24128" - the fallback is "atmel,24c128"
-                "rohm,br24t01" - the fallback is "atmel,24c01"
-
-  - reg: The I2C address of the EEPROM.
-
-Optional properties:
-
-  - pagesize: The length of the pagesize for writing. Please consult the
-              manual of your device, that value varies a lot. A wrong value
-              may result in data loss! If not specified, a safety value of
-              '1' is used which will be very slow.
-
-  - read-only: This parameterless property disables writes to the eeprom.
-
-  - size: Total eeprom size in bytes.
-
-  - no-read-rollover: This parameterless property indicates that the
-                      multi-address eeprom does not automatically roll over
-                      reads to the next slave address. Please consult the
-                      manual of your device.
-
-  - wp-gpios: GPIO to which the write-protect pin of the chip is connected.
-
-  - address-width: number of address bits (one of 8, 16).
-
-  - num-addresses: total number of i2c slave addresses this device takes
-
-Example:
-
-eeprom@52 {
-	compatible = "atmel,24c32";
-	reg = <0x52>;
-	pagesize = <32>;
-	wp-gpios = <&gpio1 3 0>;
-	num-addresses = <8>;
-};
+This file has been moved to at24.yaml.
diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
new file mode 100644
index 000000000000..28c8b068c8a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2019 BayLibre SAS
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/eeprom/at24.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: I2C EEPROMs compatible with Atmel's AT24
+
+maintainers:
+  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
+
+properties:
+  compatible:
+    additionalItems: true
+    maxItems: 2
+    pattern: "^(atmel|catalyst|microchip|nxp|ramtron|renesas|rohm|st),24(c|cs|mac)[0-9]+$"
+    oneOf:
+      - const: nxp,se97b
+      - const: renesas,r1ex24002
+      - const: renesas,r1ex24016
+      - const: renesas,r1ex24128
+      - const: rohm,br24t01
+    contains:
+      enum:
+        - atmel,24c00
+        - atmel,24c01
+        - atmel,24cs01
+        - atmel,24c02
+        - atmel,24cs02
+        - atmel,24mac402
+        - atmel,24mac602
+        - atmel,spd
+        - atmel,24c04
+        - atmel,24cs04
+        - atmel,24c08
+        - atmel,24cs08
+        - atmel,24c16
+        - atmel,24cs16
+        - atmel,24c32
+        - atmel,24cs32
+        - atmel,24c64
+        - atmel,24cs64
+        - atmel,24c128
+        - atmel,24c256
+        - atmel,24c512
+        - atmel,24c1024
+        - atmel,24c2048
+
+  reg:
+    description:
+      The I2C slave address of the EEPROM.
+    maxItems: 1
+
+  pagesize:
+    description:
+      The length of the pagesize for writing. Please consult the
+      manual of your device, that value varies a lot. A wrong value
+      may result in data loss! If not specified, a safety value of
+      '1' is used which will be very slow.
+    type: integer
+
+  read-only:
+    description:
+      This parameterless property disables writes to the eeprom.
+    type: boolean
+
+  size:
+    description:
+      Total eeprom size in bytes.
+    type: integer
+
+  no-read-rollover:
+    description:
+      This parameterless property indicates that the multi-address
+      eeprom does not automatically roll over reads to the next slave
+      address. Please consult the manual of your device.
+    type: boolean
+
+  wp-gpios:
+    description:
+      GPIO to which the write-protect pin of the chip is connected.
+    maxItems: 1
+
+  address-width:
+    description:
+      Number of address bits (one of 8, 16).
+    type: integer
+
+  num-addresses:
+    description:
+      Total number of i2c slave addresses this device takes.
+    type: integer
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    eeprom@52 {
+        compatible = "microchip,24c32", "atmel,24c32";
+        reg = <0x52>;
+        pagesize = <32>;
+        wp-gpios = <&gpio1 3 0>;
+        num-addresses = <8>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a400af0501c9..3c7ced686966 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2698,7 +2698,7 @@ M:	Bartosz Golaszewski <bgolaszewski@baylibre.com>
 L:	linux-i2c@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
 S:	Maintained
-F:	Documentation/devicetree/bindings/eeprom/at24.txt
+F:	Documentation/devicetree/bindings/eeprom/at24.yaml
 F:	drivers/misc/eeprom/at24.c
 
 ATA OVER ETHERNET (AOE) DRIVER
-- 
2.23.0
