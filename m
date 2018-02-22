From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: i2c: add binding for Socionext SynQuacer
 I2C
Date: Thu, 22 Feb 2018 19:16:46 +0000
Message-ID: <20180222191647.4727-2-ard.biesheuvel@linaro.org>
References: <20180222191647.4727-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180222191647.4727-1-ard.biesheuvel@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
Cc: andy.shevchenko@gmail.com, jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-Id: linux-i2c@vger.kernel.org

Add a binding for the I2C controller that can be found in the Socionext
SynQuacer SoC. Note that this is the exact same IP as the Fujitsu F_I2C.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 Documentation/devicetree/bindings/i2c/i2c-synquacer.txt | 29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-synquacer.txt b/Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
new file mode 100644
index 000000000000..4d0bb6a71211
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
@@ -0,0 +1,29 @@
+Socionext SynQuacer I2C
+
+Required properties:
+- compatible      : Must be "socionext,synquacer-i2c"
+- reg             : Offset and length of the register set for the device
+- interrupts      : the interrupt specifier
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
2.11.0
