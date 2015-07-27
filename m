From: Fugang Duan <b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] i2c: imx: change dev_info to dev_dbg to reduce dummy log
Date: Mon, 27 Jul 2015 16:26:55 +0800
Message-ID: <1437985615-30791-1-git-send-email-b38611@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

For most of imx platforms, there have no DMA support for I2C bus.
So, by default, there is only cpu mode.

The current driver to check whether there have DMA channel config in
dts file to judge whether it support DMA mode or not, if doesn't config
it print out "can't use DMA" for each bus during probe.

kernel boot up log:
i2c i2c-0: IMX I2C adapter registered
i2c i2c-0: can't use DMA
i2c i2c-1: IMX I2C adapter registered
i2c i2c-1: can't use DMA
i2c i2c-2: IMX I2C adapter registered
i2c i2c-2: can't use DMA
i2c i2c-3: IMX I2C adapter registered
i2c i2c-3: can't use DMA

It is very ugly and confused. So change the dev_info() to deb_dbg() to
avoid print dummy and redundant log.

Signed-off-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 785aa67..28fba91 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -339,7 +339,7 @@ fail_tx:
 	dma_release_channel(dma->chan_tx);
 fail_al:
 	devm_kfree(dev, dma);
-	dev_info(dev, "can't use DMA\n");
+	dev_dbg(dev, "can't use DMA\n");
 }
 
 static void i2c_imx_dma_callback(void *arg)
-- 
1.9.1
