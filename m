From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 3/4] i2c: designware: Add runtime PM hooks
Date: Thu, 15 May 2014 17:37:23 +0300
Message-ID: <1400164644-3222-4-git-send-email-mika.westerberg@linux.intel.com>
References: <1400164644-3222-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1400164644-3222-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Yao Jin <yao.jin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aubrey Li <aubrey.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

It is possible that after entering runtime PM suspend the controller
context is lost due the fact that its power is removed. This happens for
example on Asus T100, an Intel Baytrail based tablet/laptop.

In order to get the controller back to functional state, we need to
implement runtime PM hooks which will re-initialize the hardware during
runtime PM resume. We can re-use the existing system suspend hooks as the
steps to resume/suspend the controller are the same.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index f72102f389c5..402ec3970fed 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -247,7 +247,7 @@ static const struct of_device_id dw_i2c_of_match[] = {
 MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
 #endif
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM
 static int dw_i2c_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -269,13 +269,11 @@ static int dw_i2c_resume(struct device *dev)
 
 	return 0;
 }
-
-static SIMPLE_DEV_PM_OPS(dw_i2c_dev_pm_ops, dw_i2c_suspend, dw_i2c_resume);
-#define DW_I2C_DEV_PM_OPS	(&dw_i2c_dev_pm_ops)
-#else
-#define DW_I2C_DEV_PM_OPS	NULL
 #endif
 
+static UNIVERSAL_DEV_PM_OPS(dw_i2c_dev_pm_ops, dw_i2c_suspend,
+			    dw_i2c_resume, NULL);
+
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:i2c_designware");
 
@@ -287,7 +285,7 @@ static struct platform_driver dw_i2c_driver = {
 		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(dw_i2c_of_match),
 		.acpi_match_table = ACPI_PTR(dw_i2c_acpi_match),
-		.pm	= DW_I2C_DEV_PM_OPS,
+		.pm	= &dw_i2c_dev_pm_ops,
 	},
 };
 
-- 
2.0.0.rc2
