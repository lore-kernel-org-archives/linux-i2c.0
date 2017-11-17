From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 3/3] i2c: imx: use runtime PM provided by core
Date: Fri, 17 Nov 2017 19:05:39 +0100
Message-ID: <20171117180539.4984-4-l.stach@pengutronix.de>
References: <20171117180539.4984-1-l.stach@pengutronix.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59443 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161213AbdKQSFl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 17 Nov 2017 13:05:41 -0500
In-Reply-To: <20171117180539.4984-1-l.stach@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, kernel@pengutronix.de, patchwork-lst@pengutronix.de, Lukas Rusak <lorusak@gmail.com>, Chris Healy <cphealy@gmail.com>

Simplifies the driver and fixes a deadlock, which has been observed
in the wild, due to the i2c bus lock and the clk framework clk_prepare
lock being taken in different order by multiple i2c devices.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/i2c/busses/i2c-imx.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 800c1f390308..95da40e74847 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -904,10 +904,6 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
 
-	result = pm_runtime_get_sync(i2c_imx->adapter.dev.parent);
-	if (result < 0)
-		goto out;
-
 	/* Start I2C transfer */
 	result = i2c_imx_start(i2c_imx);
 	if (result) {
@@ -971,10 +967,6 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 	/* Stop I2C transfer */
 	i2c_imx_stop(i2c_imx);
 
-	pm_runtime_mark_last_busy(i2c_imx->adapter.dev.parent);
-	pm_runtime_put_autosuspend(i2c_imx->adapter.dev.parent);
-
-out:
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> exit with: %s: %d\n", __func__,
 		(result < 0) ? "error" : "success msg",
 			(result < 0) ? result : num);
@@ -1099,6 +1091,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	i2c_imx->adapter.dev.parent	= &pdev->dev;
 	i2c_imx->adapter.nr		= pdev->id;
 	i2c_imx->adapter.dev.of_node	= pdev->dev.of_node;
+	i2c_imx->adapter.auto_rpm	= true;
 	i2c_imx->base			= base;
 
 	/* Get I2C clock */
-- 
2.11.0
