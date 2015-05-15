From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] i2c: designware: separate ops for system_sleep_pm and runtime_pm
Date: Fri, 15 May 2015 20:31:39 +0800
Message-ID: <1431693099-2292-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Commit 1fc2fe204cb9 ("i2c: designware: Add runtime PM hooks") adds
runtime pm support using the same ops for system sleep and runtime pm.
When suspend to ram, the i2c host may have been runtime suspended, thus
i2c_dw_disable() hangs.

This patch fixes this issue by separating ops for system sleep pm and
runtime pm, and in the system suspend/resume path, runtime pm apis are
used to ensure the device is at correct state.

Signed-off-by: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 48 ++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 0a80e4a..d306397 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -298,14 +298,16 @@ static const struct of_device_id dw_i2c_of_match[] = {
 MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
 #endif
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int dw_i2c_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
+	pm_runtime_get_sync(dev);
 	i2c_dw_disable(i_dev);
-	clk_disable_unprepare(i_dev->clk);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 
 	return 0;
 }
@@ -315,6 +317,32 @@ static int dw_i2c_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
 
+	pm_runtime_get_sync(dev);
+	i2c_dw_init(i_dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PM
+static int dw_i2c_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
+
+	i2c_dw_disable(i_dev);
+	clk_disable_unprepare(i_dev->clk);
+
+	return 0;
+}
+
+static int dw_i2c_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
+
 	clk_prepare_enable(i_dev->clk);
 
 	if (!i_dev->pm_runtime_disabled)
@@ -324,8 +352,18 @@ static int dw_i2c_resume(struct device *dev)
 }
 #endif
 
-static UNIVERSAL_DEV_PM_OPS(dw_i2c_dev_pm_ops, dw_i2c_suspend,
-			    dw_i2c_resume, NULL);
+#ifdef CONFIG_PM
+static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_suspend, dw_i2c_resume)
+	SET_RUNTIME_PM_OPS(dw_i2c_runtime_suspend,
+		dw_i2c_runtime_resume, NULL)
+};
+
+#define DW_I2C_DEV_PM_OPS (&dw_i2c_dev_pm_ops)
+
+#else
+#define DW_I2C_DEV_PM_OPS NULL
+#endif
 
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:i2c_designware");
@@ -337,7 +375,7 @@ static struct platform_driver dw_i2c_driver = {
 		.name	= "i2c_designware",
 		.of_match_table = of_match_ptr(dw_i2c_of_match),
 		.acpi_match_table = ACPI_PTR(dw_i2c_acpi_match),
-		.pm	= &dw_i2c_dev_pm_ops,
+		.pm	= DW_I2C_DEV_PM_OPS,
 	},
 };
 
-- 
2.1.4
