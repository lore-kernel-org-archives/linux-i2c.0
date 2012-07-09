From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2] i2c: stu300: use devm managed resources
Date: Mon,  9 Jul 2012 22:11:06 +0200
Message-ID: <1341864666-29441-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Allocate memory for device state using devm_kzalloc(), get the
clock using devm_clk_get(), get the IRQ using devm_request_irq(),
request and remap memory using devm_request_and_ioremap().
All to simplify accounting and letting the kernel do the
garbage-collection.

Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
ChangeLog v1->v2:
- Use more devm* stuff, at Wolfram's request.
- Note: based on a clean v3.5-rc6, may need some patch -p1 < patch
  to apply on the i2c tree, if you want me to rebase it, just tell
  me where to find the baseline.
---
 drivers/i2c/busses/i2c-stu300.c |   75 +++++++++-----------------------------
 1 files changed, 18 insertions(+), 57 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index 4d44af1..dc4c518 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 ST-Ericsson AB
+ * Copyright (C) 2007-2012 ST-Ericsson AB
  * License terms: GNU General Public License (GPL) version 2
  * ST DDC I2C master mode driver, used in e.g. U300 series platforms.
  * Author: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
@@ -873,64 +873,46 @@ stu300_probe(struct platform_device *pdev)
 	int ret = 0;
 	char clk_name[] = "I2C0";
 
-	dev = kzalloc(sizeof(struct stu300_dev), GFP_KERNEL);
+	dev = devm_kzalloc(&pdev->dev, sizeof(struct stu300_dev), GFP_KERNEL);
 	if (!dev) {
 		dev_err(&pdev->dev, "could not allocate device struct\n");
-		ret = -ENOMEM;
-		goto err_no_devmem;
+		return -ENOMEM;
 	}
 
 	bus_nr = pdev->id;
 	clk_name[3] += (char)bus_nr;
-	dev->clk = clk_get(&pdev->dev, clk_name);
+	dev->clk = devm_clk_get(&pdev->dev, clk_name);
 	if (IS_ERR(dev->clk)) {
-		ret = PTR_ERR(dev->clk);
 		dev_err(&pdev->dev, "could not retrieve i2c bus clock\n");
-		goto err_no_clk;
+		return PTR_ERR(dev->clk);
 	}
 
 	dev->pdev = pdev;
-	platform_set_drvdata(pdev, dev);
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		ret = -ENOENT;
-		goto err_no_resource;
-	}
+	if (!res)
+		return -ENOENT;
 
 	dev->phybase = res->start;
 	dev->physize = resource_size(res);
-
-	if (request_mem_region(dev->phybase, dev->physize,
-			       NAME " I/O Area") == NULL) {
-		ret = -EBUSY;
-		goto err_no_ioregion;
-	}
-
-	dev->virtbase = ioremap(dev->phybase, dev->physize);
+	dev->virtbase = devm_request_and_ioremap(&pdev->dev, res);
 	dev_dbg(&pdev->dev, "initialize bus device I2C%d on virtual "
 		"base %p\n", bus_nr, dev->virtbase);
-	if (!dev->virtbase) {
-		ret = -ENOMEM;
-		goto err_no_ioremap;
-	}
+	if (!dev->virtbase)
+		return -ENOMEM;
 
 	dev->irq = platform_get_irq(pdev, 0);
-	if (request_irq(dev->irq, stu300_irh, 0,
-			NAME, dev)) {
-		ret = -EIO;
-		goto err_no_irq;
-	}
+	ret = devm_request_irq(&pdev->dev, dev->irq, stu300_irh, 0, NAME, dev);
+	if (ret < 0)
+		return ret;
 
 	dev->speed = scl_frequency;
 
 	clk_enable(dev->clk);
 	ret = stu300_init_hw(dev);
 	clk_disable(dev->clk);
-
 	if (ret != 0) {
 		dev_err(&dev->pdev->dev, "error initializing hardware.\n");
-		goto err_init_hw;
+		return -EIO;
 	}
 
 	/* IRQ event handling initialization */
@@ -952,29 +934,13 @@ stu300_probe(struct platform_device *pdev)
 	/* i2c device drivers may be active on return from add_adapter() */
 	ret = i2c_add_numbered_adapter(adap);
 	if (ret) {
-		dev_err(&dev->pdev->dev, "failure adding ST Micro DDC "
+		dev_err(&pdev->dev, "failure adding ST Micro DDC "
 		       "I2C adapter\n");
-		goto err_add_adapter;
+		return ret;
 	}
-	return 0;
 
- err_add_adapter:
- err_init_hw:
-	free_irq(dev->irq, dev);
- err_no_irq:
-	iounmap(dev->virtbase);
- err_no_ioremap:
-	release_mem_region(dev->phybase, dev->physize);
- err_no_ioregion:
-	platform_set_drvdata(pdev, NULL);
- err_no_resource:
-	clk_put(dev->clk);
- err_no_clk:
-	kfree(dev);
- err_no_devmem:
-	dev_err(&pdev->dev, "failed to add " NAME " adapter: %d\n",
-		pdev->id);
-	return ret;
+	platform_set_drvdata(pdev, dev);
+	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1013,12 +979,7 @@ stu300_remove(struct platform_device *pdev)
 	i2c_del_adapter(&dev->adapter);
 	/* Turn off everything */
 	stu300_wr8(0x00, dev->virtbase + I2C_CR);
-	free_irq(dev->irq, dev);
-	iounmap(dev->virtbase);
-	release_mem_region(dev->phybase, dev->physize);
-	clk_put(dev->clk);
 	platform_set_drvdata(pdev, NULL);
-	kfree(dev);
 	return 0;
 }
 
-- 
1.7.7.6
