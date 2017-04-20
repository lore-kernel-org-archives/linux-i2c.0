From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] i2c: rcar: clarify PM handling with more comments
Date: Thu, 20 Apr 2017 12:04:33 +0200
Message-ID: <20170420100433.7010-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48147 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031105AbdDTKEo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 20 Apr 2017 06:04:44 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

PM handling is correct but might be a bit subtle. Add some comments for
clarification.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 66b84bf51bbfd0..214bf2835d1f95 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -753,6 +753,7 @@ static int rcar_reg_slave(struct i2c_client *slave)
 	if (slave->flags & I2C_CLIENT_TEN)
 		return -EAFNOSUPPORT;
 
+	/* Keep device active for slave address detection logic */
 	pm_runtime_get_sync(rcar_i2c_priv_to_dev(priv));
 
 	priv->slave = slave;
@@ -856,13 +857,14 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	priv->dma_direction = DMA_NONE;
 	priv->dma_rx = priv->dma_tx = ERR_PTR(-EPROBE_DEFER);
 
+	/* Activate device for clock calculation */
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 	ret = rcar_i2c_clock_calculate(priv, &i2c_t);
 	if (ret < 0)
 		goto out_pm_put;
 
-	/* Don't suspend when multi-master to keep arbitration working */
+	/* Stay always active when multi-master to keep arbitration working */
 	if (of_property_read_bool(dev->of_node, "multi-master"))
 		priv->flags |= ID_P_PM_BLOCKED;
 	else
-- 
2.11.0
