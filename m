From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 3/5] i2c: pca-platform: add devicetree awareness
Date: Mon, 26 Jun 2017 12:44:32 +1200
Message-ID: <20170626004434.2757-4-chris.packham@alliedtelesis.co.nz>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>
List-Id: linux-i2c@vger.kernel.org

Allow devices that use this driver to be registered via a
devicetree.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v2:
- Set i2c->adap.dev.of_node so that child nodes are automatically probed
- Split dt-binding to separate patch, use "reset-gpios" instead of "gpios".
Changes in v3:
- None

 drivers/i2c/busses/i2c-pca-platform.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index 9f995b8ed587..a6df6b8d2289 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -24,6 +24,8 @@
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/irq.h>
 
@@ -137,12 +139,15 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
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
@@ -178,6 +183,7 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 		 (unsigned long) res->start);
 	i2c->adap.algo_data = &i2c->algo_data;
 	i2c->adap.dev.parent = &pdev->dev;
+	i2c->adap.dev.of_node = np;
 
 	if (platform_data) {
 		i2c->adap.timeout = platform_data->timeout;
@@ -196,6 +202,13 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 				i2c->gpio = NULL;
 			}
 		}
+	} else if (np) {
+		i2c->adap.timeout = HZ;
+		i2c->gpio = devm_gpiod_get_optional(&pdev->dev, "reset-gpios", GPIOD_OUT_LOW);
+		if (IS_ERR(i2c->gpio))
+			return PTR_ERR(i2c->gpio);
+		of_property_read_u32_index(np, "clock-frequency", 0,
+					   &i2c->algo_data.i2c_clock);
 	} else {
 		i2c->adap.timeout = HZ;
 		i2c->algo_data.i2c_clock = 59000;
@@ -270,11 +283,21 @@ static int i2c_pca_pf_remove(struct platform_device *pdev)
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
