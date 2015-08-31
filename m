From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 5/6] i2c: designware: Rename platform driver probe and PM functions
Date: Mon, 31 Aug 2015 17:31:32 +0300
Message-ID: <1441031493-18938-6-git-send-email-jarkko.nikula@linux.intel.com>
References: <1441031493-18938-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441031493-18938-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Make it easier to distinguish between i2c-designware-platdrv and
i2c-designware-core functions and to be consistent with
i2c-designware-pcidrv.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 3dd2de31a2f8..17167cd4812d 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -133,7 +133,7 @@ static inline int dw_i2c_acpi_configure(struct platform_device *pdev)
 static inline void dw_i2c_acpi_unconfigure(struct platform_device *pdev) { }
 #endif
 
-static int dw_i2c_probe(struct platform_device *pdev)
+static int dw_i2c_plat_probe(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev;
 	struct i2c_adapter *adap;
@@ -271,7 +271,7 @@ static int dw_i2c_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int dw_i2c_remove(struct platform_device *pdev)
+static int dw_i2c_plat_remove(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
 
@@ -300,12 +300,12 @@ MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
 #endif
 
 #ifdef CONFIG_PM_SLEEP
-static int dw_i2c_prepare(struct device *dev)
+static int dw_i2c_plat_prepare(struct device *dev)
 {
 	return pm_runtime_suspended(dev);
 }
 
-static void dw_i2c_complete(struct device *dev)
+static void dw_i2c_plat_complete(struct device *dev)
 {
 	if (dev->power.direct_complete)
 		pm_request_resume(dev);
@@ -316,7 +316,7 @@ static void dw_i2c_complete(struct device *dev)
 #endif
 
 #ifdef CONFIG_PM
-static int dw_i2c_suspend(struct device *dev)
+static int dw_i2c_plat_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
@@ -327,7 +327,7 @@ static int dw_i2c_suspend(struct device *dev)
 	return 0;
 }
 
-static int dw_i2c_resume(struct device *dev)
+static int dw_i2c_plat_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
@@ -341,10 +341,10 @@ static int dw_i2c_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
-	.prepare = dw_i2c_prepare,
-	.complete = dw_i2c_complete,
-	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_suspend, dw_i2c_resume)
-	SET_RUNTIME_PM_OPS(dw_i2c_suspend, dw_i2c_resume, NULL)
+	.prepare = dw_i2c_plat_prepare,
+	.complete = dw_i2c_plat_complete,
+	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
+	SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume, NULL)
 };
 
 #define DW_I2C_DEV_PMOPS (&dw_i2c_dev_pm_ops)
@@ -356,8 +356,8 @@ static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
 MODULE_ALIAS("platform:i2c_designware");
 
 static struct platform_driver dw_i2c_driver = {
-	.probe = dw_i2c_probe,
-	.remove = dw_i2c_remove,
+	.probe = dw_i2c_plat_probe,
+	.remove = dw_i2c_plat_remove,
 	.driver		= {
 		.name	= "i2c_designware",
 		.of_match_table = of_match_ptr(dw_i2c_of_match),
-- 
2.5.0
