From: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH 4/4] i2c/au1550: dev_pm_ops conversion
Date: Thu, 14 Jul 2011 10:56:55 +0200
Message-ID: <1310633815-18817-5-git-send-email-manuel.lauss@googlemail.com>
References: <1310633815-18817-1-git-send-email-manuel.lauss@googlemail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1310633815-18817-1-git-send-email-manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

use newer dev_pm_ops for PM

Signed-off-by: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 drivers/i2c/busses/i2c-au1550.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index 36d1b29..90a79f4 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -387,39 +387,43 @@ static int __devexit i2c_au1550_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
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
+
+static const struct dev_pm_ops i2c_au1550_pmops = {
+	.suspend	= i2c_au1550_suspend,
+	.resume		= i2c_au1550_resume,
+};
+
+#define AU1XPSC_SMBUS_PMOPS (&i2c_au1550_pmops)
+
 #else
-#define i2c_au1550_suspend	NULL
-#define i2c_au1550_resume	NULL
+#define AU1XPSC_SMBUS_PMOPS NULL
 #endif
 
 static struct platform_driver au1xpsc_smbus_driver = {
 	.driver = {
 		.name	= "au1xpsc_smbus",
 		.owner	= THIS_MODULE,
+		.pm	= AU1XPSC_SMBUS_PMOPS,
 	},
 	.probe		= i2c_au1550_probe,
 	.remove		= __devexit_p(i2c_au1550_remove),
-	.suspend	= i2c_au1550_suspend,
-	.resume		= i2c_au1550_resume,
 };
 
 static int __init i2c_au1550_init(void)
-- 
1.7.6
