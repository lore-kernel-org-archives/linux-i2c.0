From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 13/13] i2c: xiic: Use devm_*() functions
Date: Tue, 17 Dec 2013 16:02:43 +0900
Message-ID: <003101cefaf5$fb67f9f0$f237edd0$%han@samsung.com>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <001601cefaf3$940d0040$bc2700c0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "'Steven A. Falco'" <sfalco-7/gz0mrWfc7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use devm_*() functions to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-xiic.c |   59 +++++++++++------------------------------
 1 file changed, 16 insertions(+), 43 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index fc2716a..ea83dfc 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -696,31 +696,26 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	u8 i;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		goto resource_missing;
+	if (!res) {
+		dev_err(&pdev->dev, "Memory resource is missing\n");
+		return -EINVAL;
+	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		goto resource_missing;
+	if (irq < 0) {
+		dev_err(&pdev->dev, "IRQ resource is missing\n");
+		return irq;
+	}
 
 	pdata = dev_get_platdata(&pdev->dev);
 
-	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
+	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
 
-	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
-		dev_err(&pdev->dev, "Memory region busy\n");
-		ret = -EBUSY;
-		goto request_mem_failed;
-	}
-
-	i2c->base = ioremap(res->start, resource_size(res));
-	if (!i2c->base) {
-		dev_err(&pdev->dev, "Unable to map registers\n");
-		ret = -EIO;
-		goto map_failed;
-	}
+	i2c->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(i2c->base))
+		return PTR_ERR(i2c->base);
 
 	/* hook up driver to tree */
 	platform_set_drvdata(pdev, i2c);
@@ -733,17 +728,17 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 
 	spin_lock_init(&i2c->lock);
 	init_waitqueue_head(&i2c->wait);
-	ret = request_irq(irq, xiic_isr, 0, pdev->name, i2c);
+	ret = devm_request_irq(&pdev->dev, irq, xiic_isr, 0, pdev->name, i2c);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot claim IRQ\n");
-		goto request_irq_failed;
+		goto failed;
 	}
 
 	/* add i2c adapter to i2c tree */
 	ret = i2c_add_adapter(&i2c->adap);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to add adapter\n");
-		goto add_adapter_failed;
+		goto failed;
 	}
 
 	if (pdata) {
@@ -754,42 +749,20 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 
 	return 0;
 
-add_adapter_failed:
-	free_irq(irq, i2c);
-request_irq_failed:
+failed:
 	xiic_deinit(i2c);
-	iounmap(i2c->base);
-map_failed:
-	release_mem_region(res->start, resource_size(res));
-request_mem_failed:
-	kfree(i2c);
-
 	return ret;
-resource_missing:
-	dev_err(&pdev->dev, "IRQ or Memory resource is missing\n");
-	return -ENOENT;
 }
 
 static int xiic_i2c_remove(struct platform_device *pdev)
 {
 	struct xiic_i2c *i2c = platform_get_drvdata(pdev);
-	struct resource *res;
 
 	/* remove adapter & data */
 	i2c_del_adapter(&i2c->adap);
 
 	xiic_deinit(i2c);
 
-	free_irq(platform_get_irq(pdev, 0), i2c);
-
-	iounmap(i2c->base);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res)
-		release_mem_region(res->start, resource_size(res));
-
-	kfree(i2c);
-
 	return 0;
 }
 
-- 
1.7.10.4
