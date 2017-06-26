From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 4/5] i2c: pca-platform: use device managed allocations
Date: Mon, 26 Jun 2017 12:44:33 +1200
Message-ID: <20170626004434.2757-5-chris.packham@alliedtelesis.co.nz>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:34787 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbdFZAor (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 25 Jun 2017 20:44:47 -0400
In-Reply-To: <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>

Switch to using the devm_ APIs and remove the now unnecessary error
handling and most of the device removal code.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/i2c/busses/i2c-pca-platform.c | 53 +++++++----------------------------
 1 file changed, 10 insertions(+), 43 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index a6df6b8d2289..7db481cbf402 100644
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
@@ -236,15 +224,14 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
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
@@ -252,19 +239,6 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 	printk(KERN_INFO "%s registered.\n", i2c->adap.name);
 
 	return 0;
-
-e_adapt:
-	if (irq)
-		free_irq(irq, i2c);
-e_reqirq:
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
@@ -273,13 +247,6 @@ static int i2c_pca_pf_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&i2c->adap);
 
-	if (i2c->irq)
-		free_irq(i2c->irq, i2c);
-
-	iounmap(i2c->reg_base);
-	release_mem_region(i2c->io_base, i2c->io_size);
-	kfree(i2c);
-
 	return 0;
 }
 
-- 
2.13.0
