From: Fugang Duan <fugang.duan@nxp.com>
Subject: [PATCH 1/1] i2c: imx-lpi2c: add runtime pm support
Date: Tue, 2 Jan 2018 17:11:52 +0800
Message-ID: <1514884312-8535-1-git-send-email-fugang.duan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn3nam01on0068.outbound.protection.outlook.com ([104.47.33.68]:47968
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751216AbeABJPk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 2 Jan 2018 04:15:40 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, u.kleine-koenig@pengutronix.de, bhumirks@gmail.com, vz@mleia.com, fugang.duan@nxp.com

Add runtime pm support to dynamically manage the clock to avoid enable/disable
clock in frequently that can improve the i2c bus transfer performance.

And use pm_runtime_force_suspend/resume() instead of lpi2c_imx_suspend/resume().

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 68 ++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index e86801a..e6da2c7 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -30,6 +30,7 @@
 #include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 
@@ -90,6 +91,8 @@
 #define FAST_PLUS_MAX_BITRATE	3400000
 #define HIGHSPEED_MAX_BITRATE	5000000
 
+#define I2C_PM_TIMEOUT		10 /* ms */
+
 enum lpi2c_imx_mode {
 	STANDARD,	/* 100+Kbps */
 	FAST,		/* 400+Kbps */
@@ -274,8 +277,8 @@ static int lpi2c_imx_master_enable(struct lpi2c_imx_struct *lpi2c_imx)
 	unsigned int temp;
 	int ret;
 
-	ret = clk_enable(lpi2c_imx->clk);
-	if (ret)
+	ret = pm_runtime_get_sync(lpi2c_imx->adapter.dev.parent);
+	if (ret < 0)
 		return ret;
 
 	temp = MCR_RST;
@@ -284,7 +287,7 @@ static int lpi2c_imx_master_enable(struct lpi2c_imx_struct *lpi2c_imx)
 
 	ret = lpi2c_imx_config(lpi2c_imx);
 	if (ret)
-		goto clk_disable;
+		goto rpm_put;
 
 	temp = readl(lpi2c_imx->base + LPI2C_MCR);
 	temp |= MCR_MEN;
@@ -292,8 +295,9 @@ static int lpi2c_imx_master_enable(struct lpi2c_imx_struct *lpi2c_imx)
 
 	return 0;
 
-clk_disable:
-	clk_disable(lpi2c_imx->clk);
+rpm_put:
+	pm_runtime_mark_last_busy(lpi2c_imx->adapter.dev.parent);
+	pm_runtime_put_autosuspend(lpi2c_imx->adapter.dev.parent);
 
 	return ret;
 }
@@ -306,7 +310,8 @@ static int lpi2c_imx_master_disable(struct lpi2c_imx_struct *lpi2c_imx)
 	temp &= ~MCR_MEN;
 	writel(temp, lpi2c_imx->base + LPI2C_MCR);
 
-	clk_disable(lpi2c_imx->clk);
+	pm_runtime_mark_last_busy(lpi2c_imx->adapter.dev.parent);
+	pm_runtime_put_autosuspend(lpi2c_imx->adapter.dev.parent);
 
 	return 0;
 }
@@ -606,22 +611,31 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev, I2C_PM_TIMEOUT);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	temp = readl(lpi2c_imx->base + LPI2C_PARAM);
 	lpi2c_imx->txfifosize = 1 << (temp & 0x0f);
 	lpi2c_imx->rxfifosize = 1 << ((temp >> 8) & 0x0f);
 
-	clk_disable(lpi2c_imx->clk);
-
 	ret = i2c_add_adapter(&lpi2c_imx->adapter);
 	if (ret)
-		goto clk_unprepare;
+		goto rpm_disable;
+
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
 
 	dev_info(&lpi2c_imx->adapter.dev, "LPI2C adapter registered\n");
 
 	return 0;
 
-clk_unprepare:
-	clk_unprepare(lpi2c_imx->clk);
+rpm_disable:
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
 	return ret;
 }
@@ -632,28 +646,48 @@ static int lpi2c_imx_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&lpi2c_imx->adapter);
 
-	clk_unprepare(lpi2c_imx->clk);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
 	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int lpi2c_imx_suspend(struct device *dev)
+static int lpi2c_runtime_suspend(struct device *dev)
 {
+	struct lpi2c_imx_struct *lpi2c_imx = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(lpi2c_imx->clk);
 	pinctrl_pm_select_sleep_state(dev);
 
 	return 0;
 }
 
-static int lpi2c_imx_resume(struct device *dev)
+static int lpi2c_runtime_resume(struct device *dev)
 {
+	struct lpi2c_imx_struct *lpi2c_imx = dev_get_drvdata(dev);
+	int ret;
+
 	pinctrl_pm_select_default_state(dev);
+	ret = clk_prepare_enable(lpi2c_imx->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable I2C clock, ret=%d\n", ret);
+		return ret;
+	}
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(imx_lpi2c_pm, lpi2c_imx_suspend, lpi2c_imx_resume);
+static const struct dev_pm_ops lpi2c_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				      pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(lpi2c_runtime_suspend,
+			   lpi2c_runtime_resume, NULL)
+};
+#define IMX_LPI2C_PM      (&lpi2c_pm_ops)
+#else
+#define IMX_LPI2C_PM      NULL
+#endif
 
 static struct platform_driver lpi2c_imx_driver = {
 	.probe = lpi2c_imx_probe,
@@ -661,7 +695,7 @@ static int lpi2c_imx_resume(struct device *dev)
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = lpi2c_imx_of_match,
-		.pm = &imx_lpi2c_pm,
+		.pm = IMX_LPI2C_PM,
 	},
 };
 
-- 
1.9.1
