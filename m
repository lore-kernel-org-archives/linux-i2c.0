From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 03/13] i2c: highlander: Use devm_*() functions
Date: Tue, 17 Dec 2013 15:50:33 +0900
Message-ID: <002701cefaf4$489c4c50$d9d4e4f0$%han@samsung.com>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <001601cefaf3$940d0040$bc2700c0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use devm_*() functions to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-highlander.c |   38 ++++++++++-------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/drivers/i2c/busses/i2c-highlander.c b/drivers/i2c/busses/i2c-highlander.c
index 436b0f2..405dc4a 100644
--- a/drivers/i2c/busses/i2c-highlander.c
+++ b/drivers/i2c/busses/i2c-highlander.c
@@ -369,15 +369,15 @@ static int highlander_i2c_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	dev = kzalloc(sizeof(struct highlander_i2c_dev), GFP_KERNEL);
+	dev = devm_kzalloc(&pdev->dev, sizeof(struct highlander_i2c_dev),
+			   GFP_KERNEL);
 	if (unlikely(!dev))
 		return -ENOMEM;
 
-	dev->base = ioremap_nocache(res->start, resource_size(res));
-	if (unlikely(!dev->base)) {
-		ret = -ENXIO;
-		goto err;
-	}
+	dev->base = devm_ioremap_nocache(&pdev->dev, res->start,
+					 resource_size(res));
+	if (unlikely(!dev->base))
+		return -ENXIO;
 
 	dev->dev = &pdev->dev;
 	platform_set_drvdata(pdev, dev);
@@ -387,10 +387,10 @@ static int highlander_i2c_probe(struct platform_device *pdev)
 		dev->irq = 0;
 
 	if (dev->irq) {
-		ret = request_irq(dev->irq, highlander_i2c_irq, 0,
-				  pdev->name, dev);
+		ret = devm_request_irq(&pdev->dev, dev->irq, highlander_i2c_irq,
+				       0, pdev->name, dev);
 		if (unlikely(ret))
-			goto err_unmap;
+			return ret;
 
 		highlander_i2c_irq_enable(dev);
 	} else {
@@ -417,26 +417,16 @@ static int highlander_i2c_probe(struct platform_device *pdev)
 	ret = highlander_i2c_reset(dev);
 	if (unlikely(ret)) {
 		dev_err(&pdev->dev, "controller didn't come up\n");
-		goto err_free_irq;
+		return ret;
 	}
 
 	ret = i2c_add_numbered_adapter(adap);
 	if (unlikely(ret)) {
 		dev_err(&pdev->dev, "failure adding adapter\n");
-		goto err_free_irq;
+		return ret;
 	}
 
 	return 0;
-
-err_free_irq:
-	if (dev->irq)
-		free_irq(dev->irq, dev);
-err_unmap:
-	iounmap(dev->base);
-err:
-	kfree(dev);
-
-	return ret;
 }
 
 static int highlander_i2c_remove(struct platform_device *pdev)
@@ -445,12 +435,6 @@ static int highlander_i2c_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&dev->adapter);
 
-	if (dev->irq)
-		free_irq(dev->irq, dev);
-
-	iounmap(dev->base);
-	kfree(dev);
-
 	return 0;
 }
 
-- 
1.7.10.4
