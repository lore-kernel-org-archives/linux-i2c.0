From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/7] i2c-ocores: Use struct dev_pm_ops for power management
Date: Wed, 11 Jul 2012 21:24:15 +0200
Message-ID: <201207112124.15712.rjw@sisk.pl>
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

Make the OpenCores I2C controller driver define its PM callbacks
through a struct dev_pm_ops object rather than by using legacy PM
hooks in struct platform_driver.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/i2c/busses/i2c-ocores.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

Index: linux/drivers/i2c/busses/i2c-ocores.c
===================================================================
--- linux.orig/drivers/i2c/busses/i2c-ocores.c
+++ linux/drivers/i2c/busses/i2c-ocores.c
@@ -367,9 +367,9 @@ static int __devexit ocores_i2c_remove(s
 }
 
 #ifdef CONFIG_PM
-static int ocores_i2c_suspend(struct platform_device *pdev, pm_message_t state)
+static int ocores_i2c_suspend(struct device *dev)
 {
-	struct ocores_i2c *i2c = platform_get_drvdata(pdev);
+	struct ocores_i2c *i2c = dev_get_drvdata(dev);
 	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
 
 	/* make sure the device is disabled */
@@ -378,17 +378,19 @@ static int ocores_i2c_suspend(struct pla
 	return 0;
 }
 
-static int ocores_i2c_resume(struct platform_device *pdev)
+static int ocores_i2c_resume(struct device *dev)
 {
-	struct ocores_i2c *i2c = platform_get_drvdata(pdev);
+	struct ocores_i2c *i2c = dev_get_drvdata(dev);
 
 	ocores_init(i2c);
 
 	return 0;
 }
+
+static SIMPLE_DEV_PM_OPS(ocores_i2c_pm, ocores_i2c_suspend, ocores_i2c_resume);
+#define OCORES_I2C_PM	(&ocores_i2c_pm)
 #else
-#define ocores_i2c_suspend	NULL
-#define ocores_i2c_resume	NULL
+#define OCORES_I2C_PM	NULL
 #endif
 
 static struct of_device_id ocores_i2c_match[] = {
@@ -400,12 +402,11 @@ MODULE_DEVICE_TABLE(of, ocores_i2c_match
 static struct platform_driver ocores_i2c_driver = {
 	.probe   = ocores_i2c_probe,
 	.remove  = __devexit_p(ocores_i2c_remove),
-	.suspend = ocores_i2c_suspend,
-	.resume  = ocores_i2c_resume,
 	.driver  = {
 		.owner = THIS_MODULE,
 		.name = "ocores-i2c",
 		.of_match_table = ocores_i2c_match,
+		.pm = OCORES_I2C_PM,
 	},
 };
 
