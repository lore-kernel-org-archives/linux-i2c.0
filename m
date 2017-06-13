From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 3/4] i2c: pca-platform: use device managed allocations
Date: Tue, 13 Jun 2017 13:56:40 +1200
Message-ID: <20170613015641.29373-4-chris.packham@alliedtelesis.co.nz>
References: <20170613015641.29373-1-chris.packham@alliedtelesis.co.nz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170613015641.29373-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>
List-Id: linux-i2c@vger.kernel.org

Switch to using the devm_ APIs and remove the now unnecessary error
handling and most of the device removal code.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/i2c/busses/i2c-pca-platform.c | 61 +++++++----------------------------
 1 file changed, 11 insertions(+), 50 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index 79d737eb2770..ee217ef5d879 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -143,35 +143,23 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 	int ret = 0;
 	int irq;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
 	/* If irq is 0, we do polling. */
 	if (irq < 0)
 		irq = 0;
 
-	if (res == NULL) {
-		ret = -ENODEV;
-		goto e_print;
-	}
+	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
+	if (!i2c)
+		return -ENOMEM;
 
-	if (!request_mem_region(res->start, resource_size(res), res->name)) {
-		ret = -ENOMEM;
-		goto e_print;
-	}
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	i2c->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(i2c->reg_base))
+		return PTR_ERR(i2c->reg_base);
 
-	i2c = kzalloc(sizeof(struct i2c_pca_pf_data), GFP_KERNEL);
-	if (!i2c) {
-		ret = -ENOMEM;
-		goto e_alloc;
-	}
 
 	init_waitqueue_head(&i2c->wait);
 
-	i2c->reg_base = ioremap(res->start, resource_size(res));
-	if (!i2c->reg_base) {
-		ret = -ENOMEM;
-		goto e_remap;
-	}
 	i2c->io_base = res->start;
 	i2c->io_size = resource_size(res);
 	i2c->irq = irq;
@@ -220,7 +208,7 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 	}
 
 	if (gpio_is_valid(i2c->gpio)) {
-		ret = gpio_request(i2c->gpio, i2c->adap.name);
+		ret = devm_gpio_request(&pdev->dev, i2c->gpio, i2c->adap.name);
 		if (ret == 0) {
 			gpio_direction_output(i2c->gpio, 1);
 			i2c->algo_data.reset_chip = i2c_pca_pf_resetchip;
@@ -232,15 +220,14 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 	}
 
 	if (irq) {
-		ret = request_irq(irq, i2c_pca_pf_handler,
+		ret = devm_request_irq(&pdev->dev, irq, i2c_pca_pf_handler,
 			IRQF_TRIGGER_FALLING, pdev->name, i2c);
 		if (ret)
-			goto e_reqirq;
+			return ret;
 	}
 
 	if (i2c_pca_add_numbered_bus(&i2c->adap) < 0) {
-		ret = -ENODEV;
-		goto e_adapt;
+		return -ENODEV;
 	}
 
 	platform_set_drvdata(pdev, i2c);
@@ -248,22 +235,6 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 	printk(KERN_INFO "%s registered.\n", i2c->adap.name);
 
 	return 0;
-
-e_adapt:
-	if (irq)
-		free_irq(irq, i2c);
-e_reqirq:
-	if (gpio_is_valid(i2c->gpio))
-		gpio_free(i2c->gpio);
-
-	iounmap(i2c->reg_base);
-e_remap:
-	kfree(i2c);
-e_alloc:
-	release_mem_region(res->start, resource_size(res));
-e_print:
-	printk(KERN_ERR "Registering PCA9564/PCA9665 FAILED! (%d)\n", ret);
-	return ret;
 }
 
 static int i2c_pca_pf_remove(struct platform_device *pdev)
@@ -272,16 +243,6 @@ static int i2c_pca_pf_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&i2c->adap);
 
-	if (i2c->irq)
-		free_irq(i2c->irq, i2c);
-
-	if (gpio_is_valid(i2c->gpio))
-		gpio_free(i2c->gpio);
-
-	iounmap(i2c->reg_base);
-	release_mem_region(i2c->io_base, i2c->io_size);
-	kfree(i2c);
-
 	return 0;
 }
 
-- 
2.13.0
