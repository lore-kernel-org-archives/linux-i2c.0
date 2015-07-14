From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [PATCH-v4 06/11] i2c:pxa: Use devm_ variants in probe function
Date: Tue, 14 Jul 2015 13:06:45 +0530
Message-ID: <1436859410-28878-7-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436859410-28878-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436859410-28878-1-git-send-email-vaibhav.hiremath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: wsa@the-dreams.de, robh+dt@kernel.org, robert.jarzmik@free.fr, yizhang@marvell.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
List-Id: linux-i2c@vger.kernel.org

This patch cleans up i2c_pxa_probe() function,

 - Use devm_ variants wherever
   This will clean both probe exit and i2c_pxa_remove() functions

 - Check platform resource before parsing any other data from DT/platform

 - Use dev_err on failure from i2c_add_numbered_adapter()

 - Use pr_info instead of printk for KERN_INFO

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/i2c/busses/i2c-pxa.c | 81 ++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 51 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index beeed7c..66cf437 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1158,10 +1158,23 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	struct resource *res = NULL;
 	int ret, irq;
 
-	i2c = kzalloc(sizeof(struct pxa_i2c), GFP_KERNEL);
-	if (!i2c) {
-		ret = -ENOMEM;
-		goto emalloc;
+	i2c = devm_kzalloc(&dev->dev, sizeof(struct pxa_i2c), GFP_KERNEL);
+	if (!i2c)
+		return -ENOMEM;
+
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+
+	i2c->reg_base = devm_ioremap_resource(&dev->dev, res);
+	if (IS_ERR(i2c->reg_base)) {
+		dev_err(&dev->dev, "failed to map resource: %ld\n",
+			PTR_ERR(i2c->reg_base));
+		return PTR_ERR(i2c->reg_base);
+	}
+
+	irq = platform_get_irq(dev, 0);
+	if (irq < 0) {
+		dev_err(&dev->dev, "no irq resource: %d\n", irq);
+		return irq;
 	}
 
 	/* Default adapter num to device id; i2c_pxa_probe_dt can override. */
@@ -1171,19 +1184,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	if (ret > 0)
 		ret = i2c_pxa_probe_pdata(dev, i2c, &i2c_type);
 	if (ret < 0)
-		goto eclk;
-
-	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	irq = platform_get_irq(dev, 0);
-	if (res == NULL || irq < 0) {
-		ret = -ENODEV;
-		goto eclk;
-	}
-
-	if (!request_mem_region(res->start, resource_size(res), res->name)) {
-		ret = -ENOMEM;
-		goto eclk;
-	}
+		return ret;
 
 	i2c->adap.owner   = THIS_MODULE;
 	i2c->adap.retries = 5;
@@ -1193,16 +1194,10 @@ static int i2c_pxa_probe(struct platform_device *dev)
 
 	strlcpy(i2c->adap.name, "pxa_i2c-i2c", sizeof(i2c->adap.name));
 
-	i2c->clk = clk_get(&dev->dev, NULL);
+	i2c->clk = devm_clk_get(&dev->dev, NULL);
 	if (IS_ERR(i2c->clk)) {
-		ret = PTR_ERR(i2c->clk);
-		goto eclk;
-	}
-
-	i2c->reg_base = ioremap(res->start, resource_size(res));
-	if (!i2c->reg_base) {
-		ret = -EIO;
-		goto eremap;
+		dev_err(&dev->dev, "failed to get the clk: %ld\n", PTR_ERR(i2c->clk));
+		return PTR_ERR(i2c->clk);
 	}
 
 	i2c->reg_ibmr = i2c->reg_base + pxa_reg_layout[i2c_type].ibmr;
@@ -1244,11 +1239,13 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		i2c->adap.algo = &i2c_pxa_pio_algorithm;
 	} else {
 		i2c->adap.algo = &i2c_pxa_algorithm;
-		ret = request_irq(irq, i2c_pxa_handler,
+		ret = devm_request_irq(&dev->dev, irq, i2c_pxa_handler,
 				IRQF_SHARED | IRQF_NO_SUSPEND,
 				dev_name(&dev->dev), i2c);
-		if (ret)
+		if (ret) {
+			dev_err(&dev->dev, "failed to request irq: %d\n", ret);
 			goto ereqirq;
+		}
 	}
 
 	i2c_pxa_reset(i2c);
@@ -1261,33 +1258,22 @@ static int i2c_pxa_probe(struct platform_device *dev)
 
 	ret = i2c_add_numbered_adapter(&i2c->adap);
 	if (ret < 0) {
-		printk(KERN_INFO "I2C: Failed to add bus\n");
-		goto eadapt;
+		dev_err(&dev->dev, "failed to add bus: %d\n", ret);
+		goto ereqirq;
 	}
 
 	platform_set_drvdata(dev, i2c);
 
 #ifdef CONFIG_I2C_PXA_SLAVE
-	printk(KERN_INFO "I2C: %s: PXA I2C adapter, slave address %d\n",
-	       dev_name(&i2c->adap.dev), i2c->slave_addr);
+	dev_info(&i2c->adap.dev, " PXA I2C adapter, slave address %d\n",
+		i2c->slave_addr);
 #else
-	printk(KERN_INFO "I2C: %s: PXA I2C adapter\n",
-	       dev_name(&i2c->adap.dev));
+	dev_info(&i2c->adap.dev, " PXA I2C adapter\n");
 #endif
 	return 0;
 
-eadapt:
-	if (!i2c->use_pio)
-		free_irq(irq, i2c);
 ereqirq:
 	clk_disable_unprepare(i2c->clk);
-	iounmap(i2c->reg_base);
-eremap:
-	clk_put(i2c->clk);
-eclk:
-	kfree(i2c);
-emalloc:
-	release_mem_region(res->start, resource_size(res));
 	return ret;
 }
 
@@ -1296,15 +1282,8 @@ static int i2c_pxa_remove(struct platform_device *dev)
 	struct pxa_i2c *i2c = platform_get_drvdata(dev);
 
 	i2c_del_adapter(&i2c->adap);
-	if (!i2c->use_pio)
-		free_irq(i2c->irq, i2c);
 
 	clk_disable_unprepare(i2c->clk);
-	clk_put(i2c->clk);
-
-	iounmap(i2c->reg_base);
-	release_mem_region(i2c->iobase, i2c->iosize);
-	kfree(i2c);
 
 	return 0;
 }
-- 
1.9.1
