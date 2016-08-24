From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/2] i2c: sh_mobile: use proper device with dma_mapping_error
Date: Wed, 24 Aug 2016 11:19:28 +0200
Message-ID: <20160824091929.2082-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

We must use the same device we used for mapping.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 6fb3e264599229..05b1eeab9cf5f6 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -610,7 +610,7 @@ static void sh_mobile_i2c_xfer_dma(struct sh_mobile_i2c_data *pd)
 		return;
 
 	dma_addr = dma_map_single(chan->device->dev, pd->msg->buf, pd->msg->len, dir);
-	if (dma_mapping_error(pd->dev, dma_addr)) {
+	if (dma_mapping_error(chan->device->dev, dma_addr)) {
 		dev_dbg(pd->dev, "dma map failed, using PIO\n");
 		return;
 	}
-- 
2.9.3
