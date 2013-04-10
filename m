From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 1/7] i2c-designware: move to managed functions (devm_*)
Date: Wed, 10 Apr 2013 13:36:36 +0300
Message-ID: <1365590202-1623-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

This makes the error handling much more simpler than open-coding everything
and in addition makes the probe function smaller and tidier.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
Changes to v1:
	- dropped redundant dev_err() after devm_ioremap_resource().

 drivers/i2c/busses/i2c-designware-platdrv.c |   73 +++++++--------------------
 1 file changed, 19 insertions(+), 54 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index e3085c4..94b3a4d 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -92,7 +92,7 @@ static int dw_i2c_probe(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev;
 	struct i2c_adapter *adap;
-	struct resource *mem, *ioarea;
+	struct resource *mem;
 	int irq, r;
 
 	/* NOTE: driver uses the static register mapping */
@@ -108,32 +108,25 @@ static int dw_i2c_probe(struct platform_device *pdev)
 		return irq; /* -ENXIO */
 	}
 
-	ioarea = request_mem_region(mem->start, resource_size(mem),
-			pdev->name);
-	if (!ioarea) {
-		dev_err(&pdev->dev, "I2C region already claimed\n");
-		return -EBUSY;
-	}
+	dev = devm_kzalloc(&pdev->dev, sizeof(struct dw_i2c_dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
 
-	dev = kzalloc(sizeof(struct dw_i2c_dev), GFP_KERNEL);
-	if (!dev) {
-		r = -ENOMEM;
-		goto err_release_region;
-	}
+	dev->base = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(dev->base))
+		return PTR_ERR(dev->base);
 
 	init_completion(&dev->cmd_complete);
 	mutex_init(&dev->lock);
-	dev->dev = get_device(&pdev->dev);
+	dev->dev = &pdev->dev;
 	dev->irq = irq;
 	platform_set_drvdata(pdev, dev);
 
-	dev->clk = clk_get(&pdev->dev, NULL);
+	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
 
-	if (IS_ERR(dev->clk)) {
-		r = -ENODEV;
-		goto err_free_mem;
-	}
+	if (IS_ERR(dev->clk))
+		return PTR_ERR(dev->clk);
 	clk_prepare_enable(dev->clk);
 
 	dev->functionality =
@@ -146,13 +139,6 @@ static int dw_i2c_probe(struct platform_device *pdev)
 	dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
 		DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
 
-	dev->base = ioremap(mem->start, resource_size(mem));
-	if (dev->base == NULL) {
-		dev_err(&pdev->dev, "failure mapping io resources\n");
-		r = -EBUSY;
-		goto err_unuse_clocks;
-	}
-
 	/* Try first if we can configure the device from ACPI */
 	r = dw_i2c_acpi_configure(pdev);
 	if (r) {
@@ -164,13 +150,14 @@ static int dw_i2c_probe(struct platform_device *pdev)
 	}
 	r = i2c_dw_init(dev);
 	if (r)
-		goto err_iounmap;
+		return r;
 
 	i2c_dw_disable_int(dev);
-	r = request_irq(dev->irq, i2c_dw_isr, IRQF_SHARED, pdev->name, dev);
+	r = devm_request_irq(&pdev->dev, dev->irq, i2c_dw_isr, IRQF_SHARED,
+			pdev->name, dev);
 	if (r) {
 		dev_err(&pdev->dev, "failure requesting irq %i\n", dev->irq);
-		goto err_iounmap;
+		return r;
 	}
 
 	adap = &dev->adapter;
@@ -186,57 +173,35 @@ static int dw_i2c_probe(struct platform_device *pdev)
 	r = i2c_add_numbered_adapter(adap);
 	if (r) {
 		dev_err(&pdev->dev, "failure adding adapter\n");
-		goto err_free_irq;
+		return r;
 	}
 	of_i2c_register_devices(adap);
 	acpi_i2c_register_devices(adap);
 
+	/* Increase reference counter */
+	get_device(&pdev->dev);
+
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_put(&pdev->dev);
 
 	return 0;
-
-err_free_irq:
-	free_irq(dev->irq, dev);
-err_iounmap:
-	iounmap(dev->base);
-err_unuse_clocks:
-	clk_disable_unprepare(dev->clk);
-	clk_put(dev->clk);
-	dev->clk = NULL;
-err_free_mem:
-	put_device(&pdev->dev);
-	kfree(dev);
-err_release_region:
-	release_mem_region(mem->start, resource_size(mem));
-
-	return r;
 }
 
 static int dw_i2c_remove(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
-	struct resource *mem;
 
 	pm_runtime_get_sync(&pdev->dev);
 
 	i2c_del_adapter(&dev->adapter);
 	put_device(&pdev->dev);
 
-	clk_disable_unprepare(dev->clk);
-	clk_put(dev->clk);
-	dev->clk = NULL;
-
 	i2c_dw_disable(dev);
-	free_irq(dev->irq, dev);
-	kfree(dev);
 
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mem->start, resource_size(mem));
 	return 0;
 }
 
-- 
1.7.10.4
