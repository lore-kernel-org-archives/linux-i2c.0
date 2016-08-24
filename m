From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/2] i2c: rcar: use proper device with dma_mapping_error
Date: Wed, 24 Aug 2016 11:19:29 +0200
Message-ID: <20160824091929.2082-2-wsa+renesas@sang-engineering.com>
References: <20160824091929.2082-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160824091929.2082-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

We must use the same device we used for mapping.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 52407f3c9e1cce..9bd849dacee872 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -378,7 +378,7 @@ static void rcar_i2c_dma(struct rcar_i2c_priv *priv)
 	}
 
 	dma_addr = dma_map_single(chan->device->dev, buf, len, dir);
-	if (dma_mapping_error(dev, dma_addr)) {
+	if (dma_mapping_error(chan->device->dev, dma_addr)) {
 		dev_dbg(dev, "dma map failed, using PIO\n");
 		return;
 	}
-- 
2.9.3
