From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH] i2c: img-scb: Add runtime PM
Date: Mon,  2 Oct 2017 10:49:01 +0100
Message-ID: <1506937741-32748-1-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr50045.outbound.protection.outlook.com ([40.107.5.45]:23712
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750878AbdJBJtZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 2 Oct 2017 05:49:25 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, Ed Blake <ed.blake@sondrel.com>

The i2c-img-scb driver already dynamically enables / disables clocks to
save power, but doesn't use the runtime PM framework. Convert the
driver to use runtime PM, so that dynamic clock management will be
disabled when runtime PM is disabled, and so that autosuspend can be
used to avoid unnecessarily disabling and re-enabling clocks repeatedly
during a sequence of transactions.

Signed-off-by: Ed Blake <ed.blake@sondrel.com>
---
 drivers/i2c/busses/i2c-img-scb.c | 94 ++++++++++++++++++++++++++++++++--------
 1 file changed, 76 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 84fb35f..4e58b3b 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -82,6 +82,7 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/timer.h>
 
@@ -280,6 +281,8 @@
 #define ISR_COMPLETE(err)	(ISR_COMPLETE_M | (ISR_STATUS_M & (err)))
 #define ISR_FATAL(err)		(ISR_COMPLETE(err) | ISR_FATAL_M)
 
+#define IMG_I2C_PM_TIMEOUT	1000 /* ms */
+
 enum img_i2c_mode {
 	MODE_INACTIVE,
 	MODE_RAW,
@@ -408,6 +411,9 @@ struct img_i2c {
 	unsigned int raw_timeout;
 };
 
+static int img_i2c_runtime_suspend(struct device *dev);
+static int img_i2c_runtime_resume(struct device *dev);
+
 static void img_i2c_writel(struct img_i2c *i2c, u32 offset, u32 value)
 {
 	writel(value, i2c->base + offset);
@@ -1054,8 +1060,8 @@ static int img_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			atomic = true;
 	}
 
-	ret = clk_prepare_enable(i2c->scb_clk);
-	if (ret)
+	ret = pm_runtime_get_sync(adap->dev.parent);
+	if (ret < 0)
 		return ret;
 
 	for (i = 0; i < num; i++) {
@@ -1131,7 +1137,8 @@ static int img_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			break;
 	}
 
-	clk_disable_unprepare(i2c->scb_clk);
+	pm_runtime_mark_last_busy(adap->dev.parent);
+	pm_runtime_put_autosuspend(adap->dev.parent);
 
 	return i2c->msg_status ? i2c->msg_status : num;
 }
@@ -1153,8 +1160,8 @@ static int img_i2c_init(struct img_i2c *i2c)
 	struct img_i2c_timings timing;
 	u32 rev;
 
-	ret = clk_prepare_enable(i2c->scb_clk);
-	if (ret)
+	ret = pm_runtime_get_sync(i2c->adap.dev.parent);
+	if (ret < 0)
 		return ret;
 
 	rev = img_i2c_readl(i2c, SCB_CORE_REV_REG);
@@ -1163,7 +1170,8 @@ static int img_i2c_init(struct img_i2c *i2c)
 			 "Unknown hardware revision (%d.%d.%d.%d)\n",
 			 (rev >> 24) & 0xff, (rev >> 16) & 0xff,
 			 (rev >> 8) & 0xff, rev & 0xff);
-		clk_disable_unprepare(i2c->scb_clk);
+		pm_runtime_mark_last_busy(i2c->adap.dev.parent);
+		pm_runtime_put_autosuspend(i2c->adap.dev.parent);
 		return -EINVAL;
 	}
 
@@ -1314,7 +1322,8 @@ static int img_i2c_init(struct img_i2c *i2c)
 	/* Perform a synchronous sequence to reset the bus */
 	ret = img_i2c_reset_bus(i2c);
 
-	clk_disable_unprepare(i2c->scb_clk);
+	pm_runtime_mark_last_busy(i2c->adap.dev.parent);
+	pm_runtime_put_autosuspend(i2c->adap.dev.parent);
 
 	return ret;
 }
@@ -1384,22 +1393,30 @@ static int img_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, i2c);
 
-	ret = clk_prepare_enable(i2c->sys_clk);
-	if (ret)
-		return ret;
+	pm_runtime_set_autosuspend_delay(&pdev->dev, IMG_I2C_PM_TIMEOUT);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	if (!pm_runtime_enabled(&pdev->dev)) {
+		ret = img_i2c_runtime_resume(&pdev->dev);
+		if (ret)
+			return ret;
+	}
 
 	ret = img_i2c_init(i2c);
 	if (ret)
-		goto disable_clk;
+		goto rpm_disable;
 
 	ret = i2c_add_numbered_adapter(&i2c->adap);
 	if (ret < 0)
-		goto disable_clk;
+		goto rpm_disable;
 
 	return 0;
 
-disable_clk:
-	clk_disable_unprepare(i2c->sys_clk);
+rpm_disable:
+	if (!pm_runtime_enabled(&pdev->dev))
+		img_i2c_runtime_suspend(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	return ret;
 }
 
@@ -1408,19 +1425,55 @@ static int img_i2c_remove(struct platform_device *dev)
 	struct img_i2c *i2c = platform_get_drvdata(dev);
 
 	i2c_del_adapter(&i2c->adap);
+	pm_runtime_disable(&dev->dev);
+	if (!pm_runtime_status_suspended(&dev->dev))
+		img_i2c_runtime_suspend(&dev->dev);
+
+	return 0;
+}
+
+static int img_i2c_runtime_suspend(struct device *dev)
+{
+	struct img_i2c *i2c = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(i2c->scb_clk);
 	clk_disable_unprepare(i2c->sys_clk);
 
 	return 0;
 }
 
+static int img_i2c_runtime_resume(struct device *dev)
+{
+	struct img_i2c *i2c = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(i2c->sys_clk);
+	if (ret) {
+		dev_err(dev, "Unable to enable sys clock\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(i2c->scb_clk);
+	if (ret) {
+		dev_err(dev, "Unable to enable scb clock\n");
+		clk_disable_unprepare(i2c->sys_clk);
+		return ret;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int img_i2c_suspend(struct device *dev)
 {
 	struct img_i2c *i2c = dev_get_drvdata(dev);
+	int ret;
 
-	img_i2c_switch_mode(i2c, MODE_SUSPEND);
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
 
-	clk_disable_unprepare(i2c->sys_clk);
+	img_i2c_switch_mode(i2c, MODE_SUSPEND);
 
 	return 0;
 }
@@ -1430,7 +1483,7 @@ static int img_i2c_resume(struct device *dev)
 	struct img_i2c *i2c = dev_get_drvdata(dev);
 	int ret;
 
-	ret = clk_prepare_enable(i2c->sys_clk);
+	ret = pm_runtime_force_resume(dev);
 	if (ret)
 		return ret;
 
@@ -1440,7 +1493,12 @@ static int img_i2c_resume(struct device *dev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
-static SIMPLE_DEV_PM_OPS(img_i2c_pm, img_i2c_suspend, img_i2c_resume);
+static const struct dev_pm_ops img_i2c_pm = {
+	SET_RUNTIME_PM_OPS(img_i2c_runtime_suspend,
+			   img_i2c_runtime_resume,
+			   NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(img_i2c_suspend, img_i2c_resume)
+};
 
 static const struct of_device_id img_scb_i2c_match[] = {
 	{ .compatible = "img,scb-i2c" },
-- 
1.9.1
