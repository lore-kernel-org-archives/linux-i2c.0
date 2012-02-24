From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 1/2] i2c/busses: Add PM support
Date: Fri, 24 Feb 2012 17:01:15 +0530
Message-ID: <0ca1d8990c23a45193a32d0e7e889620b995af59.1330082915.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: armando.visconti-qxv4g6HH51o@public.gmane.org, shiraz.hashim-qxv4g6HH51o@public.gmane.org, vipin.kumar-qxv4g6HH51o@public.gmane.org, rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org, deepak.sikri-qxv4g6HH51o@public.gmane.org, vipulkumar.samar-qxv4g6HH51o@public.gmane.org, amit.virdi-qxv4g6HH51o@public.gmane.org, viresh.kumar-qxv4g6HH51o@public.gmane.org, pratyush.anand-qxv4g6HH51o@public.gmane.org, bhupesh.sharma-qxv4g6HH51o@public.gmane.org, viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhavna.yadav-qxv4g6HH51o@public.gmane.org, vincenzo.frascino-qxv4g6HH51o@public.gmane.org, mirko.gardi-qxv4g6HH51o@public.gmane.org, salvatore.dedominicis-qxv4g6HH51o@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Deepak Sikri <deepak.sikri-qxv4g6HH51o@public.gmane.org>

This patch adds in support for standby/S2R/hybernate for i2c-designware driver.

Signed-off-by: Deepak Sikri <deepak.sikri-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 5244c47..c5ac2dc 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -36,6 +36,7 @@
 #include <linux/interrupt.h>
 #include <linux/of_i2c.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include "i2c-designware-core.h"
@@ -198,6 +199,31 @@ static const struct of_device_id dw_i2c_of_match[] = {
 MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
 #endif
 
+#ifdef CONFIG_PM
+static int dw_i2c_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
+
+	clk_disable(i_dev->clk);
+
+	return 0;
+}
+
+static int dw_i2c_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
+
+	clk_enable(i_dev->clk);
+	i2c_dw_init(i_dev);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(dw_i2c_dev_pm_ops, dw_i2c_suspend, dw_i2c_resume);
+
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:i2c_designware");
 
@@ -207,6 +233,7 @@ static struct platform_driver dw_i2c_driver = {
 		.name	= "i2c_designware",
 		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(dw_i2c_of_match),
+		.pm	= &dw_i2c_dev_pm_ops,
 	},
 };
 
-- 
1.7.8.110.g4cb5d
