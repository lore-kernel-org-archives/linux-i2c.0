From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 2/5] i2c: pca-platform: add devicetree awareness
Date: Tue, 20 Jun 2017 13:18:34 +1200
Message-ID: <20170620011837.14010-3-chris.packham@alliedtelesis.co.nz>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:48571 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752813AbdFTBSr (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 19 Jun 2017 21:18:47 -0400
In-Reply-To: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>

Allow devices that use this driver to be registered via a
devicetree.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v2:
- Set i2c->adap.dev.of_node so that child nodes are automatically probed
- Split dt-binding to separate patch, use "reset-gpios" instead of "gpios".

 drivers/i2c/busses/i2c-pca-platform.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index 3bd2e7d06e4b..87ca2f02f607 100644
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
@@ -177,11 +183,17 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 		 (unsigned long) res->start);
 	i2c->adap.algo_data = &i2c->algo_data;
 	i2c->adap.dev.parent = &pdev->dev;
+	i2c->adap.dev.of_node = np;
 
 	if (platform_data) {
 		i2c->adap.timeout = platform_data->timeout;
 		i2c->algo_data.i2c_clock = platform_data->i2c_clock_speed;
 		i2c->gpio = platform_data->gpio;
+	} else if (np) {
+		i2c->adap.timeout = HZ;
+		i2c->gpio = of_get_named_gpio(np, "reset-gpios", 0);
+		of_property_read_u32_index(np, "clock-frequency", 0,
+					   &i2c->algo_data.i2c_clock);
 	} else {
 		i2c->adap.timeout = HZ;
 		i2c->algo_data.i2c_clock = 59000;
@@ -275,11 +287,21 @@ static int i2c_pca_pf_remove(struct platform_device *pdev)
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
