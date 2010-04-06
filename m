From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: [PATCH 4/6] i2c: davinci: Add suspend/resume support
Date: Tue,  6 Apr 2010 10:42:16 -0700
Message-ID: <1270575738-22388-5-git-send-email-khilman@deeprootsystems.com>
References: <1270575738-22388-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1270575738-22388-1-git-send-email-khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>, "Srinivasan, Nageswari" <nageswari-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>

Add suspend and resume callbacks to DaVinci I2C driver.
This has been tested on DA850/OMAP-L138 EVM.

Signed-off-by: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
Acked-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 9239d2b..dfec296 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -645,6 +645,41 @@ static int davinci_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int davinci_i2c_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct davinci_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
+
+	/* put I2C into reset */
+	davinci_i2c_reset_ctrl(i2c_dev, 0);
+	clk_disable(i2c_dev->clk);
+
+	return 0;
+}
+
+static int davinci_i2c_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct davinci_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
+
+	clk_enable(i2c_dev->clk);
+	/* take I2C out of reset */
+	davinci_i2c_reset_ctrl(i2c_dev, 1);
+
+	return 0;
+}
+
+static const struct dev_pm_ops davinci_i2c_pm = {
+	.suspend        = davinci_i2c_suspend,
+	.resume         = davinci_i2c_resume,
+};
+
+#define davinci_i2c_pm_ops (&davinci_i2c_pm)
+#else
+#define davinci_i2c_pm_ops NULL
+#endif
+
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:i2c_davinci");
 
@@ -654,6 +689,7 @@ static struct platform_driver davinci_i2c_driver = {
 	.driver		= {
 		.name	= "i2c_davinci",
 		.owner	= THIS_MODULE,
+		.pm	= davinci_i2c_pm_ops,
 	},
 };
 
-- 
1.7.0.2
