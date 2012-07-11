From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: [PATCH 4/7] i2c-pnx: Use struct dev_pm_ops for power management
Date: Wed, 11 Jul 2012 21:25:17 +0200
Message-ID: <201207112125.18040.rjw@sisk.pl>
References: <201207112121.11046.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201207112121.11046.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>

Make the PNX I2C controller driver define its PM callbacks through
a struct dev_pm_ops object rather than by using legacy PM hooks
in struct platform_driver.

Signed-off-by: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>
---
 drivers/i2c/busses/i2c-pnx.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

Index: linux/drivers/i2c/busses/i2c-pnx.c
===================================================================
--- linux.orig/drivers/i2c/busses/i2c-pnx.c
+++ linux/drivers/i2c/busses/i2c-pnx.c
@@ -587,25 +587,27 @@ static struct i2c_algorithm pnx_algorith
 };
 
 #ifdef CONFIG_PM
-static int i2c_pnx_controller_suspend(struct platform_device *pdev,
-				      pm_message_t state)
+static int i2c_pnx_controller_suspend(struct device *dev)
 {
-	struct i2c_pnx_algo_data *alg_data = platform_get_drvdata(pdev);
+	struct i2c_pnx_algo_data *alg_data = dev_get_drvdata(dev);
 
 	clk_disable(alg_data->clk);
 
 	return 0;
 }
 
-static int i2c_pnx_controller_resume(struct platform_device *pdev)
+static int i2c_pnx_controller_resume(struct device *dev)
 {
-	struct i2c_pnx_algo_data *alg_data = platform_get_drvdata(pdev);
+	struct i2c_pnx_algo_data *alg_data = dev_get_drvdata(dev);
 
 	return clk_enable(alg_data->clk);
 }
+
+static SIMPLE_DEV_PM_OPS(i2c_pnx_pm,
+			 i2c_pnx_controller_suspend, i2c_pnx_controller_resume);
+#define PNX_I2C_PM	(&i2c_pnx_pm)
 #else
-#define i2c_pnx_controller_suspend	NULL
-#define i2c_pnx_controller_resume	NULL
+#define PNX_I2C_PM	NULL
 #endif
 
 static int __devinit i2c_pnx_probe(struct platform_device *pdev)
@@ -783,11 +785,10 @@ static struct platform_driver i2c_pnx_dr
 		.name = "pnx-i2c",
 		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(i2c_pnx_of_match),
+		.pm = PNX_I2C_PM,
 	},
 	.probe = i2c_pnx_probe,
 	.remove = __devexit_p(i2c_pnx_remove),
-	.suspend = i2c_pnx_controller_suspend,
-	.resume = i2c_pnx_controller_resume,
 };
 
 static int __init i2c_adap_pnx_init(void)
