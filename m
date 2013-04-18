From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 1/3] i2c: davinci: drop superfluous {get|put}_device
Date: Thu, 18 Apr 2013 19:13:36 +0200
Message-ID: <1366305218-22817-2-git-send-email-wsa@the-dreams.de>
References: <1366305218-22817-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1366305218-22817-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, manishv.b-l0cyMroinI0@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Driver core already takes care of refcounting, no need to do this on
driver level again.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c |   19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index c01edac..cf20e06 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -670,7 +670,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 #ifdef CONFIG_CPU_FREQ
 	init_completion(&dev->xfr_complete);
 #endif
-	dev->dev = get_device(&pdev->dev);
+	dev->dev = &pdev->dev;
 	dev->irq = irq->start;
 	dev->pdata = dev->dev->platform_data;
 	platform_set_drvdata(pdev, dev);
@@ -680,10 +680,9 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 
 		dev->pdata = devm_kzalloc(&pdev->dev,
 			sizeof(struct davinci_i2c_platform_data), GFP_KERNEL);
-		if (!dev->pdata) {
-			r = -ENOMEM;
-			goto err_free_mem;
-		}
+		if (!dev->pdata)
+			return -ENOMEM;
+
 		memcpy(dev->pdata, &davinci_i2c_platform_data_default,
 			sizeof(struct davinci_i2c_platform_data));
 		if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
@@ -694,10 +693,8 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	}
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(dev->clk)) {
-		r = -ENODEV;
-		goto err_free_mem;
-	}
+	if (IS_ERR(dev->clk))
+		return -ENODEV;
 	clk_prepare_enable(dev->clk);
 
 	dev->base = devm_ioremap_resource(&pdev->dev, mem);
@@ -744,9 +741,6 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 err_unuse_clocks:
 	clk_disable_unprepare(dev->clk);
 	dev->clk = NULL;
-err_free_mem:
-	put_device(&pdev->dev);
-
 	return r;
 }
 
@@ -757,7 +751,6 @@ static int davinci_i2c_remove(struct platform_device *pdev)
 	i2c_davinci_cpufreq_deregister(dev);
 
 	i2c_del_adapter(&dev->adapter);
-	put_device(&pdev->dev);
 
 	clk_disable_unprepare(dev->clk);
 	dev->clk = NULL;
-- 
1.7.10.4
