From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/7] i2c-stu300: Use struct dev_pm_ops for power management
Date: Wed, 11 Jul 2012 21:26:36 +0200
Message-ID: <201207112126.36412.rjw@sisk.pl>
References: <201207112121.11046.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201207112121.11046.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linus Walleij <linus.walleij@stericsson.com>, linux-i2c@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>, Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Peter Korsgaard <jacmet@sunsite.dk>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Vitaly Wool <vitalywool@gmail.com>, Colin Cross <ccross@android.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: linux-i2c@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make the ST-Ericsson U300 I2C controller driver define its PM
callbacks through a struct dev_pm_ops object rather than by using
legacy PM hooks in struct platform_driver.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/i2c/busses/i2c-stu300.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

Index: linux/drivers/i2c/busses/i2c-stu300.c
===================================================================
--- linux.orig/drivers/i2c/busses/i2c-stu300.c
+++ linux/drivers/i2c/busses/i2c-stu300.c
@@ -978,31 +978,33 @@ stu300_probe(struct platform_device *pde
 }
 
 #ifdef CONFIG_PM
-static int stu300_suspend(struct platform_device *pdev, pm_message_t state)
+static int stu300_suspend(struct device *device)
 {
-	struct stu300_dev *dev = platform_get_drvdata(pdev);
+	struct stu300_dev *dev = dev_get_drvdata(device);
 
 	/* Turn off everything */
 	stu300_wr8(0x00, dev->virtbase + I2C_CR);
 	return 0;
 }
 
-static int stu300_resume(struct platform_device *pdev)
+static int stu300_resume(struct device *device)
 {
 	int ret = 0;
-	struct stu300_dev *dev = platform_get_drvdata(pdev);
+	struct stu300_dev *dev = dev_get_drvdata(device);
 
 	clk_enable(dev->clk);
 	ret = stu300_init_hw(dev);
 	clk_disable(dev->clk);
 
 	if (ret != 0)
-		dev_err(&pdev->dev, "error re-initializing hardware.\n");
+		dev_err(device, "error re-initializing hardware.\n");
 	return ret;
 }
+
+static SIMPLE_DEV_PM_OPS(stu300_pm, stu300_suspend, stu300_resume);
+#define STU300_I2C_PM	(&stu300_pm)
 #else
-#define stu300_suspend NULL
-#define stu300_resume NULL
+#define STU300_I2C_PM	NULL
 #endif
 
 static int __exit
@@ -1026,10 +1028,9 @@ static struct platform_driver stu300_i2c
 	.driver = {
 		.name	= NAME,
 		.owner	= THIS_MODULE,
+		.pm	= STU300_I2C_PM,
 	},
 	.remove		= __exit_p(stu300_remove),
-	.suspend        = stu300_suspend,
-	.resume         = stu300_resume,
 
 };
 
