From: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Subject: [PATCH 1/4] i2c: pca-platform: add devicetree awareness
Date: Tue, 13 Jun 2017 13:56:38 +1200
Message-ID: <20170613015641.29373-2-chris.packham@alliedtelesis.co.nz>
References: <20170613015641.29373-1-chris.packham@alliedtelesis.co.nz>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170613015641.29373-1-chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Allow devices that use this driver to be registered via a
devicetree.

Signed-off-by: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
---
 .../devicetree/bindings/i2c/i2c-pca-platform.txt    | 18 ++++++++++++++++++
 drivers/i2c/busses/i2c-pca-platform.c               | 21 +++++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-pca-platform.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-pca-platform.txt b/Documentation/devicetree/bindings/i2c/i2c-pca-platform.txt
new file mode 100644
index 000000000000..47410bda3f37
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-pca-platform.txt
@@ -0,0 +1,18 @@
+* NXP PCA PCA9564/PCA9665 I2C controller
+
+The PCA9564/PCA9665 serves as an interface between most standard
+parallel-bus microcontrollers/microprocessors and the serial I2C-bus
+and allows the parallel bus system to communicate bi-directionally
+with the I2C-bus.
+
+Required properties :
+
+ - reg : Offset and length of the register set for the device
+ - compatible : one of "nxp,pca9564" or "nxp,pca9665"
+
+Optional properties
+ - interrupts : the interrupt number
+ - interrupt-parent : the phandle for the interrupt controller.
+   If an interrupt is not specified polling will be used.
+ - gpios : gpio phandle to control device reset.
+ - clock-frequency : I2C bus frequency.
\ No newline at end of file
diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index 3bd2e7d06e4b..ca63fee400cb 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -23,6 +23,9 @@
 #include <linux/i2c-pca-platform.h>
 #include <linux/gpio.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
 
 #include <asm/irq.h>
 
@@ -136,12 +139,15 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct i2c_pca9564_pf_platform_data *platform_data =
 				dev_get_platdata(&pdev->dev);
+	struct device_node *np = pdev->dev.of_node;
 	int ret = 0;
 	int irq;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
 	/* If irq is 0, we do polling. */
+	if (irq < 0)
+		irq = 0;
 
 	if (res == NULL) {
 		ret = -ENODEV;
@@ -182,6 +188,11 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 		i2c->adap.timeout = platform_data->timeout;
 		i2c->algo_data.i2c_clock = platform_data->i2c_clock_speed;
 		i2c->gpio = platform_data->gpio;
+	} else if (np) {
+		i2c->adap.timeout = HZ;
+		i2c->gpio = of_get_gpio(np, 0);
+		of_property_read_u32_index(np, "clock-frequency", 0,
+					   &i2c->algo_data.i2c_clock);
 	} else {
 		i2c->adap.timeout = HZ;
 		i2c->algo_data.i2c_clock = 59000;
@@ -275,11 +286,21 @@ static int i2c_pca_pf_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id i2c_pca_of_match_table[] = {
+	{ .compatible = "nxp,pca9564" },
+	{ .compatible = "nxp,pca9665" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, i2c_pca_of_match_table);
+#endif
+
 static struct platform_driver i2c_pca_pf_driver = {
 	.probe = i2c_pca_pf_probe,
 	.remove = i2c_pca_pf_remove,
 	.driver = {
 		.name = "i2c-pca-platform",
+		.of_match_table = of_match_ptr(i2c_pca_of_match_table),
 	},
 };
 
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
