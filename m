From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v6 1/3] dt-bindings: i2c: add binding for Socionext SynQuacer
 I2C
Date: Sun, 25 Mar 2018 12:07:45 +0100
Message-ID: <20180325110747.8852-2-ard.biesheuvel@linaro.org>
References: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: wsa@the-dreams.de
Cc: andy.shevchenko@gmail.com, jassisinghbrar@gmail.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-Id: linux-i2c@vger.kernel.org

Add a binding for the I2C controller that can be found in the Socionext
SynQuacer SoC.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/i2c/i2c-synquacer.txt | 29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-synquacer.txt b/Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
new file mode 100644
index 000000000000..72f4a2f0fedc
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
@@ -0,0 +1,29 @@
+Socionext SynQuacer I2C
+
+Required properties:
+- compatible      : Must be "socionext,synquacer-i2c"
+- reg             : Offset and length of the register set for the device
+- interrupts      : A single interrupt specifier
+- #address-cells  : Must be <1>;
+- #size-cells     : Must be <0>;
+- clock-names     : Must contain "pclk".
+- clocks          : Must contain an entry for each name in clock-names.
+                    (See the common clock bindings.)
+
+Optional properties:
+- clock-frequency : Desired I2C bus clock frequency in Hz. As only Normal and
+                    Fast modes are supported, possible values are 100000 and
+                    400000.
+
+Example :
+
+    i2c@51210000 {
+        compatible = "socionext,synquacer-i2c";
+        reg = <0x51210000 0x1000>;
+        interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clock-names = "pclk";
+        clocks = <&clk_i2c>;
+        clock-frequency = <400000>;
+    };
-- 
2.15.1
