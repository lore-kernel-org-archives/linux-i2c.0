From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH V2 2/7] i2c: designware: add CONFIG_PM_SLEEP to suspend/resume
 functions
Date: Mon, 15 Jul 2013 11:28:59 +0900
Message-ID: <005601ce8103$10333740$3099a5c0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: 'Wolfram Sang' <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
build warning when CONFIG_PM_SLEEP is not selected. This is because
sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
the CONFIG_PM_SLEEP is enabled.

drivers/i2c/busses/i2c-designware-platdrv.c:211:12: warning: 'dw_i2c_suspend' defined but not used [-Wunused-function]
drivers/i2c/busses/i2c-designware-platdrv.c:221:12: warning: 'dw_i2c_resume' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 4c5fada..64ffb90 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -207,7 +207,7 @@ static const struct of_device_id dw_i2c_of_match[] = {
 MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
 #endif
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int dw_i2c_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -228,9 +228,12 @@ static int dw_i2c_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(dw_i2c_dev_pm_ops, dw_i2c_suspend, dw_i2c_resume);
+#define DW_I2C_DEV_PM_OPS	(&dw_i2c_dev_pm_ops)
+#else
+#define DW_I2C_DEV_PM_OPS	NULL
+#endif
 
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:i2c_designware");
@@ -242,7 +245,7 @@ static struct platform_driver dw_i2c_driver = {
 		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(dw_i2c_of_match),
 		.acpi_match_table = ACPI_PTR(dw_i2c_acpi_match),
-		.pm	= &dw_i2c_dev_pm_ops,
+		.pm	= DW_I2C_DEV_PM_OPS,
 	},
 };
 
-- 
1.7.10.4
