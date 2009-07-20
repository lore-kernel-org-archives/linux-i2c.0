From: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH] i2c-au1550: dev_pm_ops conversion.
Date: Mon, 20 Jul 2009 20:47:41 +0200
Message-ID: <1248115661-20189-1-git-send-email-manuel.lauss@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Run-tested on Au1200.

 drivers/i2c/busses/i2c-au1550.c |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index 532828b..6565012 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -440,40 +440,37 @@ i2c_au1550_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int
-i2c_au1550_suspend(struct platform_device *pdev, pm_message_t state)
+static int i2c_au1550_suspend(struct device *dev)
 {
-	struct i2c_au1550_data *priv = platform_get_drvdata(pdev);
+	struct i2c_au1550_data *priv = dev_get_drvdata(dev);
 
 	i2c_au1550_disable(priv);
 
 	return 0;
 }
 
-static int
-i2c_au1550_resume(struct platform_device *pdev)
+static int i2c_au1550_resume(struct device *dev)
 {
-	struct i2c_au1550_data *priv = platform_get_drvdata(pdev);
+	struct i2c_au1550_data *priv = dev_get_drvdata(dev);
 
 	i2c_au1550_setup(priv);
 
 	return 0;
 }
-#else
-#define i2c_au1550_suspend	NULL
-#define i2c_au1550_resume	NULL
-#endif
+
+static struct dev_pm_ops au1xpsc_smbus_pmops = {
+	.resume		= i2c_au1550_resume,
+	.suspend	= i2c_au1550_suspend,
+};
 
 static struct platform_driver au1xpsc_smbus_driver = {
 	.driver = {
 		.name	= "au1xpsc_smbus",
 		.owner	= THIS_MODULE,
+		.pm	= &au1xpsc_smbus_pmops,
 	},
 	.probe		= i2c_au1550_probe,
 	.remove		= __devexit_p(i2c_au1550_remove),
-	.suspend	= i2c_au1550_suspend,
-	.resume		= i2c_au1550_resume,
 };
 
 static int __init
-- 
1.6.3.3
