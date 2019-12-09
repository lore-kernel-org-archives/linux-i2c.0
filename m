From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 04/10] dt-bindings: clock: Add documentation
	for AD242x clock providers
Date: Mon,  9 Dec 2019 19:35:05 +0100
Message-ID: <20191209183511.3576038-6-daniel@zonque.org>
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
 .../bindings/clock/adi,ad242x-clk.yaml        | 32 +++++++++++++++++++
 include/dt-bindings/clock/adi,ad242x.h        |  9 ++++++
 2 files changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/adi,ad242x-clk.yaml
 create mode 100644 include/dt-bindings/clock/adi,ad242x.h

diff --git a/Documentation/devicetree/bindings/clock/adi,ad242x-clk.yaml b/Documentation/devicetree/bindings/clock/adi,ad242x-clk.yaml
new file mode 100644
index 000000000000..f434b3e4928e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/adi,ad242x-clk.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/clock/adi,ad242x-clk.yaml#"
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
+      - adi,ad2428w-clk
+
+  '#clock-cells':
+    const: 1
+
+  clock-output-names:
+    minItems: 2
+    maxItems: 2
+    description: |
+      Array of two strings to use as names for the generated output clocks
+
+required:
+  - compatible
+  - '#clock-cells'
\ No newline at end of file
diff --git a/include/dt-bindings/clock/adi,ad242x.h b/include/dt-bindings/clock/adi,ad242x.h
new file mode 100644
index 000000000000..307a6cd1f5a6
--- /dev/null
+++ b/include/dt-bindings/clock/adi,ad242x.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __DT_BINDINGS_AD242X_CLK_H
+#define __DT_BINDINGS_AD242X_CLK_H
+
+#define MAX9485_CLKOUT1        0
+#define MAX9485_CLKOUT2        1
+
+#endif /* __DT_BINDINGS_AD242X_CLK_H */
-- 
2.23.0
