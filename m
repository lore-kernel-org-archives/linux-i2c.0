From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 1/3] i2c: imx: use clk notifier for rate changes
Date: Fri, 17 Nov 2017 19:05:37 +0100
Message-ID: <20171117180539.4984-2-l.stach@pengutronix.de>
References: <20171117180539.4984-1-l.stach@pengutronix.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49519 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753820AbdKQSFl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 17 Nov 2017 13:05:41 -0500
In-Reply-To: <20171117180539.4984-1-l.stach@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, kernel@pengutronix.de, patchwork-lst@pengutronix.de, Lukas Rusak <lorusak@gmail.com>, Chris Healy <cphealy@gmail.com>

Instead of repeatedly calling clk_get_rate for each transfer, register
a clock notifier to update the cached divider value each time the clock
rate actually changes.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/i2c/busses/i2c-imx.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 54a47b40546f..800c1f390308 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -467,15 +467,14 @@ static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx)
 	return 0;
 }
 
-static void i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx)
+static void i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
+			    unsigned int i2c_clk_rate)
 {
 	struct imx_i2c_clk_pair *i2c_clk_div = i2c_imx->hwdata->clk_div;
-	unsigned int i2c_clk_rate;
 	unsigned int div;
 	int i;
 
 	/* Divider value calculation */
-	i2c_clk_rate = clk_get_rate(i2c_imx->clk);
 	if (i2c_imx->cur_clk == i2c_clk_rate)
 		return;
 
@@ -510,6 +509,24 @@ static void i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx)
 #endif
 }
 
+static int i2c_imx_clk_notifier_call(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	struct clk_notifier_data *ndata = data;
+	struct imx_i2c_struct *i2c_imx = container_of(&ndata->clk,
+						      struct imx_i2c_struct,
+						      clk);
+
+	if (action & POST_RATE_CHANGE)
+		i2c_imx_set_clk(i2c_imx, ndata->new_rate);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block i2c_imx_clk_notifier = {
+	.notifier_call = i2c_imx_clk_notifier_call,
+};
+
 static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
 {
 	unsigned int temp = 0;
@@ -517,8 +534,6 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
 
-	i2c_imx_set_clk(i2c_imx);
-
 	imx_i2c_write_reg(i2c_imx->ifdr, i2c_imx, IMX_I2C_IFDR);
 	/* Enable I2C controller */
 	imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx, IMX_I2C_I2SR);
@@ -1131,6 +1146,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
 				   "clock-frequency", &i2c_imx->bitrate);
 	if (ret < 0 && pdata && pdata->bitrate)
 		i2c_imx->bitrate = pdata->bitrate;
+	clk_notifier_register(i2c_imx->clk, &i2c_imx_clk_notifier);
+	i2c_imx_set_clk(i2c_imx, clk_get_rate(i2c_imx->clk));
 
 	/* Set up chip registers to defaults */
 	imx_i2c_write_reg(i2c_imx->hwdata->i2cr_ien_opcode ^ I2CR_IEN,
@@ -1141,12 +1158,12 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	ret = i2c_imx_init_recovery_info(i2c_imx, pdev);
 	/* Give it another chance if pinctrl used is not ready yet */
 	if (ret == -EPROBE_DEFER)
-		goto rpm_disable;
+		goto clk_notifier_unregister;
 
 	/* Add I2C adapter */
 	ret = i2c_add_numbered_adapter(&i2c_imx->adapter);
 	if (ret < 0)
-		goto rpm_disable;
+		goto clk_notifier_unregister;
 
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
@@ -1162,6 +1179,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
 
 	return 0;   /* Return OK */
 
+clk_notifier_unregister:
+	clk_notifier_unregister(i2c_imx->clk, &i2c_imx_clk_notifier);
 rpm_disable:
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -1195,6 +1214,7 @@ static int i2c_imx_remove(struct platform_device *pdev)
 	imx_i2c_write_reg(0, i2c_imx, IMX_I2C_I2CR);
 	imx_i2c_write_reg(0, i2c_imx, IMX_I2C_I2SR);
 
+	clk_notifier_unregister(i2c_imx->clk, &i2c_imx_clk_notifier);
 	clk_disable_unprepare(i2c_imx->clk);
 
 	pm_runtime_put_noidle(&pdev->dev);
-- 
2.11.0
