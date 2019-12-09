From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 03/10] dt-bindings: gpio: Add documentation for
	AD242x GPIO controllers
Date: Mon,  9 Dec 2019 19:35:04 +0100
Message-ID: <20191209183511.3576038-5-daniel@zonque.org>
References: <20191209183511.3576038-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20191209183511.3576038-1-daniel@zonque.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc: lars@metafoo.de, sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org, broonie@kernel.org, pascal.huerst@gmail.com, lee.jones@linaro.org, Daniel Mack <daniel@zonque.org>
List-Id: linux-i2c@vger.kernel.org

This device must be place as a sub-device of an AD242x MFD node.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 .../bindings/gpio/adi,ad242x-gpio.yaml        | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/adi,ad242x-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/adi,ad242x-gpio.yaml b/Documentation/devicetree/bindings/gpio/adi,ad242x-gpio.yaml
new file mode 100644
index 000000000000..0a5a339fc84e
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/adi,ad242x-gpio.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/gpio/adi,ad242x-gpio.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Analog Devices AD242x GPIO controller
+
+maintainers:
+  - Daniel Mack <daniel@zonque.org>
+
+description: |
+  This module is part of the AD242x MFD device. For more details and an example
+  refer to Documentation/devicetree/bindings/mfd/ad242x.yaml.
+
+properties:
+  compatible:
+    enum:
+      - adi,ad2428w-gpio
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+
+  gpio-over-distance:
+    type: object
+    description: |
+      Sub-node to configure pins as 'GPIO over distance'.
+      Pins in this mode are not accessible as regular GPIOs; instead, their
+      state is transparantly mirrored between one or multiple nodes.
+
+      Each child node of the 'gpio-over-distance' node describes one pin
+      that is to be configured in 'over distance' mode
+
+    properties:
+      pin:
+        type: object
+        properties:
+          reg:
+            maxItems: 1
+
+          adi,virtual-port-mask:
+            $ref: '/schemas/types.yaml#/definitions/uint32'
+            description: |
+              The virtual port mask to assign this GPIO to.
+              Multiple GPIOs can use the same virtual port to link them
+              together. Refer to the datasheet for the details.
+
+          adi,gpio-output:
+            type: boolean
+            description: Configures this GPIO as output. Defaults to input mode.
+
+          adi,gpio-inverted:
+            type: boolean
+            description: Inverts the GPIO value
+
+        required:
+          - reg
+          - adi,virtual-port-mask
+
+required:
+  - compatible
+  - '#gpio-cells'
+  - gpio-controller
-- 
2.23.0
