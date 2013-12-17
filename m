From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 08/13] i2c: pxa: Use devm_*() functions
Date: Tue, 17 Dec 2013 15:57:32 +0900
Message-ID: <002c01cefaf5$4235b2b0$c6a11810$%han@samsung.com>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <001601cefaf3$940d0040$bc2700c0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Leilei Shang' <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, 'Haojian Zhuang' <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use devm_*() functions to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c |   66 ++++++++++++------------------------------
 1 file changed, 18 insertions(+), 48 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index bbe6dfb..be392b0 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1141,11 +1141,9 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	struct resource *res = NULL;
 	int ret, irq;
 
-	i2c = kzalloc(sizeof(struct pxa_i2c), GFP_KERNEL);
-	if (!i2c) {
-		ret = -ENOMEM;
-		goto emalloc;
-	}
+	i2c = devm_kzalloc(&dev->dev, sizeof(struct pxa_i2c), GFP_KERNEL);
+	if (!i2c)
+		return -ENOMEM;
 
 	/* Default adapter num to device id; i2c_pxa_probe_dt can override. */
 	i2c->adap.nr = dev->id;
@@ -1154,19 +1152,12 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	if (ret > 0)
 		ret = i2c_pxa_probe_pdata(dev, i2c, &i2c_type);
 	if (ret < 0)
-		goto eclk;
+		return ret;
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(dev, 0);
-	if (res == NULL || irq < 0) {
-		ret = -ENODEV;
-		goto eclk;
-	}
-
-	if (!request_mem_region(res->start, resource_size(res), res->name)) {
-		ret = -ENOMEM;
-		goto eclk;
-	}
+	if (res == NULL || irq < 0)
+		return -ENODEV;
 
 	i2c->adap.owner   = THIS_MODULE;
 	i2c->adap.retries = 5;
@@ -1176,17 +1167,14 @@ static int i2c_pxa_probe(struct platform_device *dev)
 
 	strlcpy(i2c->adap.name, "pxa_i2c-i2c", sizeof(i2c->adap.name));
 
-	i2c->clk = clk_get(&dev->dev, NULL);
-	if (IS_ERR(i2c->clk)) {
-		ret = PTR_ERR(i2c->clk);
-		goto eclk;
-	}
+	i2c->clk = devm_clk_get(&dev->dev, NULL);
+	if (IS_ERR(i2c->clk))
+		return PTR_ERR(i2c->clk);
+
+	i2c->reg_base = devm_ioremap_resource(&dev->dev, res);
+	if (IS_ERR(i2c->reg_base))
+		return PTR_ERR(i2c->reg_base);
 
-	i2c->reg_base = ioremap(res->start, resource_size(res));
-	if (!i2c->reg_base) {
-		ret = -EIO;
-		goto eremap;
-	}
 
 	i2c->reg_ibmr = i2c->reg_base + pxa_reg_layout[i2c_type].ibmr;
 	i2c->reg_idbr = i2c->reg_base + pxa_reg_layout[i2c_type].idbr;
@@ -1227,10 +1215,10 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		i2c->adap.algo = &i2c_pxa_pio_algorithm;
 	} else {
 		i2c->adap.algo = &i2c_pxa_algorithm;
-		ret = request_irq(irq, i2c_pxa_handler, IRQF_SHARED,
-				  dev_name(&dev->dev), i2c);
+		ret = devm_request_irq(&dev->dev, irq, i2c_pxa_handler,
+				       IRQF_SHARED, dev_name(&dev->dev), i2c);
 		if (ret)
-			goto ereqirq;
+			goto err;
 	}
 
 	i2c_pxa_reset(i2c);
@@ -1244,7 +1232,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	ret = i2c_add_numbered_adapter(&i2c->adap);
 	if (ret < 0) {
 		printk(KERN_INFO "I2C: Failed to add bus\n");
-		goto eadapt;
+		goto err;
 	}
 
 	platform_set_drvdata(dev, i2c);
@@ -1258,18 +1246,8 @@ static int i2c_pxa_probe(struct platform_device *dev)
 #endif
 	return 0;
 
-eadapt:
-	if (!i2c->use_pio)
-		free_irq(irq, i2c);
-ereqirq:
+err:
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
 
@@ -1278,15 +1256,7 @@ static int i2c_pxa_remove(struct platform_device *dev)
 	struct pxa_i2c *i2c = platform_get_drvdata(dev);
 
 	i2c_del_adapter(&i2c->adap);
-	if (!i2c->use_pio)
-		free_irq(i2c->irq, i2c);
-
 	clk_disable_unprepare(i2c->clk);
-	clk_put(i2c->clk);
-
-	iounmap(i2c->reg_base);
-	release_mem_region(i2c->iobase, i2c->iosize);
-	kfree(i2c);
 
 	return 0;
 }
-- 
1.7.10.4
