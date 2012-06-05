From: "Jayachandran C" <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Subject: [PATCH 1/4] i2c: i2c-ocores - DT bindings and minor fixes.
Date: Tue, 5 Jun 2012 21:11:05 +0530
Message-ID: <1338910868-12318-2-git-send-email-jayachandranc@netlogicmicro.com>
References: <1338910868-12318-1-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1338910868-12318-1-git-send-email-jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org, Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Cleanups to i2c-cores, no change in logic, changes are:
* Move i2c-ocores device tree documentation from source file to
  Documentation/devicetree/bindings/i2c/i2c-ocores.txt.
* Add \n to dev_warn and dev_err messages where missing
* Minor updates to the text and formatting fixes.

Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
---
 .../devicetree/bindings/i2c/i2c-ocores.txt         |   27 ++++++++++++
 drivers/i2c/busses/i2c-ocores.c                    |   45 +++-----------------
 2 files changed, 34 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-ocores.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
new file mode 100644
index 0000000..bfec894
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
@@ -0,0 +1,27 @@
+Device tree configuration for i2c-ocores
+
+Required properties:
+- compatible      : "opencores,i2c-ocores"
+- reg             : bus address start and address range size of device
+- interrupts      : interrupt number
+- regstep         : size of device registers in bytes
+- clock-frequency : frequency of bus clock in Hz
+- #address-cells  : should be <1>
+- #size-cells     : should be <0>
+
+Example:
+
+	i2c0: ocores@a0000000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "opencores,i2c-ocores";
+		reg = <0xa0000000 0x8>;
+		interrupts = <10>;
+		regstep = <1>;
+		clock-frequency = <20000000>;
+
+		dummy@60 {
+			compatible = "dummy";
+			reg = <0x60>;
+		};
+	};
diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 75194c5..e8159db 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -10,40 +10,9 @@
  */
 
 /*
- * Device tree configuration:
- *
- * Required properties:
- * - compatible      : "opencores,i2c-ocores"
- * - reg             : bus address start and address range size of device
- * - interrupts      : interrupt number
- * - regstep         : size of device registers in bytes
- * - clock-frequency : frequency of bus clock in Hz
- * 
- * Example:
- *
- *  i2c0: ocores@a0000000 {
- *              compatible = "opencores,i2c-ocores";
- *              reg = <0xa0000000 0x8>;
- *              interrupts = <10>;
- *
- *              regstep = <1>;
- *              clock-frequency = <20000000>;
- *
- * -- Devices connected on this I2C bus get
- * -- defined here; address- and size-cells
- * -- apply to these child devices
- *
- *              #address-cells = <1>;
- *              #size-cells = <0>;
- *
- *              dummy@60 {
- *                     compatible = "dummy";
- *                     reg = <60>;
- *              };
- *  };
- *
+ * This driver can be used from the device tree, see
+ *     Documentation/devicetree/bindings/i2c/ocore-i2c.txt
  */
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -247,14 +216,14 @@ static struct i2c_adapter ocores_adapter = {
 };
 
 #ifdef CONFIG_OF
-static int ocores_i2c_of_probe(struct platform_device* pdev,
-				struct ocores_i2c* i2c)
+static int ocores_i2c_of_probe(struct platform_device *pdev,
+				struct ocores_i2c *i2c)
 {
 	const __be32* val;
 
 	val = of_get_property(pdev->dev.of_node, "regstep", NULL);
 	if (!val) {
-		dev_err(&pdev->dev, "Missing required parameter 'regstep'");
+		dev_err(&pdev->dev, "Missing required parameter 'regstep'\n");
 		return -ENODEV;
 	}
 	i2c->regstep = be32_to_cpup(val);
@@ -262,7 +231,7 @@ static int ocores_i2c_of_probe(struct platform_device* pdev,
 	val = of_get_property(pdev->dev.of_node, "clock-frequency", NULL);
 	if (!val) {
 		dev_err(&pdev->dev,
-			"Missing required parameter 'clock-frequency'");
+			"Missing required parameter 'clock-frequency'\n");
 		return -ENODEV;
 	}
 	i2c->clock_khz = be32_to_cpup(val) / 1000;
@@ -351,7 +320,7 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit ocores_i2c_remove(struct platform_device* pdev)
+static int __devexit ocores_i2c_remove(struct platform_device *pdev)
 {
 	struct ocores_i2c *i2c = platform_get_drvdata(pdev);
 
-- 
1.7.9.5
