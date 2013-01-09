From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] i2c: s3c2410: Use devm_clk_get() and devm_request_irq()
Date: Wed, 09 Jan 2013 09:08:05 +0900
Message-ID: <002701cdedfd$65c63610$3152a230$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Ben Dooks' <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The devm_ functions allocate memory that is released when a driver
detaches. This patch uses devm_clk_get() and devm_request_irq()
for these functions. These make the code smaller and a bit simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-s3c2410.c |   24 +++++++-----------------
 1 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index a290d08..f174932 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -999,10 +999,8 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 	}
 
 	i2c->pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!i2c->pdata) {
-		ret = -ENOMEM;
-		goto err_noclk;
-	}
+	if (!i2c->pdata)
+		return -ENOMEM;
 
 	i2c->quirks = s3c24xx_get_device_quirks(pdev);
 	if (pdata)
@@ -1022,11 +1020,10 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 	/* find the clock and enable it */
 
 	i2c->dev = &pdev->dev;
-	i2c->clk = clk_get(&pdev->dev, "i2c");
+	i2c->clk = devm_clk_get(&pdev->dev, "i2c");
 	if (IS_ERR(i2c->clk)) {
 		dev_err(&pdev->dev, "cannot get clock\n");
-		ret = -ENOENT;
-		goto err_noclk;
+		return -ENOENT;
 	}
 
 	dev_dbg(&pdev->dev, "clock source %p\n", i2c->clk);
@@ -1085,8 +1082,8 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	ret = request_irq(i2c->irq, s3c24xx_i2c_irq, 0,
-			  dev_name(&pdev->dev), i2c);
+	ret = devm_request_irq(&pdev->dev, i2c->irq, s3c24xx_i2c_irq, 0,
+				dev_name(&pdev->dev), i2c);
 
 	if (ret != 0) {
 		dev_err(&pdev->dev, "cannot claim IRQ %d\n", i2c->irq);
@@ -1096,7 +1093,7 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 	ret = s3c24xx_i2c_register_cpufreq(i2c);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register cpufreq notifier\n");
-		goto err_irq;
+		goto err_clk;
 	}
 
 	/* Note, previous versions of the driver used i2c_add_adapter()
@@ -1127,14 +1124,9 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
  err_cpufreq:
 	s3c24xx_i2c_deregister_cpufreq(i2c);
 
- err_irq:
-	free_irq(i2c->irq, i2c);
-
  err_clk:
 	clk_disable_unprepare(i2c->clk);
-	clk_put(i2c->clk);
 
- err_noclk:
 	return ret;
 }
 
@@ -1153,10 +1145,8 @@ static int s3c24xx_i2c_remove(struct platform_device *pdev)
 	s3c24xx_i2c_deregister_cpufreq(i2c);
 
 	i2c_del_adapter(&i2c->adap);
-	free_irq(i2c->irq, i2c);
 
 	clk_disable_unprepare(i2c->clk);
-	clk_put(i2c->clk);
 
 	if (pdev->dev.of_node && IS_ERR(i2c->pctrl))
 		s3c24xx_i2c_dt_gpio_free(i2c);
-- 
1.7.2.5
