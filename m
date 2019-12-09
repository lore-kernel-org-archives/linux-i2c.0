From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 05/10] dt-bindings: sound: Add documentation
	for AD242x codecs
Date: Mon,  9 Dec 2019 19:35:06 +0100
Message-ID: <20191209183511.3576038-7-daniel@zonque.org>
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

This device must be placed as a sub-device of an AD242x MFD node.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 .../bindings/sound/adi,ad242x-codec.yaml      | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,ad242x-codec.yaml

diff --git a/Documentation/devicetree/bindings/sound/adi,ad242x-codec.yaml b/Documentation/devicetree/bindings/sound/adi,ad242x-codec.yaml
new file mode 100644
index 000000000000..2cfb6f9fc548
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,ad242x-codec.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/sound/adi,ad242x-codec.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Analog Devices AD242x clock provider
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
+      - adi,ad2428w-codec
+
+  '#sound-dai-cells':
+    const: 1
+
+  adi,pdm-highpass-filter:
+    type: boolean
+    description: |
+      Enables highpass filtering for data received through the PDM ports
+
+required:
+  - compatible
+  - '#sound-dai-cells'
\ No newline at end of file
-- 
2.23.0
