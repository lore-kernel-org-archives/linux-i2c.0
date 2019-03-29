From: laurentiu.tudor@nxp.com
Subject: [PATCH] i2c: imx: don't leak the i2c adapter on error
Date: Fri, 29 Mar 2019 14:48:17 +0200
Message-ID: <20190329124817.6717-1-laurentiu.tudor@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, wsa+renesas@sang-engineering.com
Cc: linux-imx@nxp.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, leoyang.li@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
List-Id: linux-i2c@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Make sure to free the i2c adapter on the error exit path.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/i2c/busses/i2c-imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 42fed40198a0..2dfd33f48cd8 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1169,11 +1169,13 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	/* Init DMA config if supported */
 	ret = i2c_imx_dma_request(i2c_imx, phy_addr);
 	if (ret < 0)
-		goto clk_notifier_unregister;
+		goto del_adapter;
 
 	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
 	return 0;   /* Return OK */
 
+del_adapter:
+	 i2c_del_adapter(&i2c_imx->adapter);
 clk_notifier_unregister:
 	clk_notifier_unregister(i2c_imx->clk, &i2c_imx->clk_change_nb);
 rpm_disable:
-- 
2.17.1
