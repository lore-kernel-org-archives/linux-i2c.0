From: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 06/11] i2c: pxa: Keep i2c clock enabled when system suspends/resumes.
Date: Thu,  8 Nov 2012 22:17:59 +0800
Message-ID: <1352384284-15660-6-git-send-email-liangs@marvell.com>
References: <1352384284-15660-1-git-send-email-liangs@marvell.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352384284-15660-1-git-send-email-liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Chao Xie <cxie4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiaofan Tian <tianxf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Xiaofan Tian <tianxf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

If a PMIC interrupt occurs after i2c clock disables, since PMIC
interrupt handler uses i2c bus, phone hang or key value missing might
happen. So i2c clock should keep enabled when system suspends/resumes.

Change-Id: I983c5d3fe2dc18149d5d836d986e65e356913b47
Signed-off-by: Jett.Zhou <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index cab0792..ad6e69b 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1295,45 +1295,12 @@ static int __exit i2c_pxa_remove(struct platform_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int i2c_pxa_suspend_noirq(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct pxa_i2c *i2c = platform_get_drvdata(pdev);
-
-	clk_disable(i2c->clk);
-
-	return 0;
-}
-
-static int i2c_pxa_resume_noirq(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct pxa_i2c *i2c = platform_get_drvdata(pdev);
-
-	clk_enable(i2c->clk);
-	i2c_pxa_reset(i2c);
-
-	return 0;
-}
-
-static const struct dev_pm_ops i2c_pxa_dev_pm_ops = {
-	.suspend_noirq = i2c_pxa_suspend_noirq,
-	.resume_noirq = i2c_pxa_resume_noirq,
-};
-
-#define I2C_PXA_DEV_PM_OPS (&i2c_pxa_dev_pm_ops)
-#else
-#define I2C_PXA_DEV_PM_OPS NULL
-#endif
-
 static struct platform_driver i2c_pxa_driver = {
 	.probe		= i2c_pxa_probe,
 	.remove		= __exit_p(i2c_pxa_remove),
 	.driver		= {
 		.name	= "pxa2xx-i2c",
 		.owner	= THIS_MODULE,
-		.pm	= I2C_PXA_DEV_PM_OPS,
 		.of_match_table = i2c_pxa_dt_ids,
 	},
 	.id_table	= i2c_pxa_id_table,
-- 
1.7.5.4
