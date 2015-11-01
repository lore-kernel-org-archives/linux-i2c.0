From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] i2c: imx: Improve message log when DMA is not used
Date: Sun,  1 Nov 2015 14:22:51 -0200
Message-ID: <1446394972-19463-1-git-send-email-festevam@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34671 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbbKAQXI (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 1 Nov 2015 11:23:08 -0500
Received: by qgem9 with SMTP id m9so99274442qge.1
        for <linux-i2c@vger.kernel.org>; Sun, 01 Nov 2015 08:23:07 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

When DMA cannot be used, it is better to state that the I2C controller
will operate in PIO mode.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 785aa67..1e522c3 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -339,7 +339,7 @@ fail_tx:
 	dma_release_channel(dma->chan_tx);
 fail_al:
 	devm_kfree(dev, dma);
-	dev_info(dev, "can't use DMA\n");
+	dev_info(dev, "can't use DMA, using PIO instead.\n");
 }
 
 static void i2c_imx_dma_callback(void *arg)
-- 
1.9.1
