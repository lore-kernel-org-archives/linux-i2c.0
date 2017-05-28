From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] i2c: rcar: use correct length when unmapping DMA
Date: Sun, 28 May 2017 09:52:17 +0200
Message-ID: <20170528075217.1214-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

Because we need to transfer some bytes with PIO, the msg length is not
the length of the DMA buffer. Use the correct value which we used when
doing the mapping.

Fixes: 73e8b0528346e8 ("i2c: rcar: add DMA support")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 214bf2835d1f95..8be3e6cb8fe686 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -319,7 +319,7 @@ static void rcar_i2c_dma_unmap(struct rcar_i2c_priv *priv)
 	rcar_i2c_write(priv, ICFBSCR, TCYC06);
 
 	dma_unmap_single(chan->device->dev, sg_dma_address(&priv->sg),
-			 priv->msg->len, priv->dma_direction);
+			 sg_dma_len(&priv->sg), priv->dma_direction);
 
 	priv->dma_direction = DMA_NONE;
 }
-- 
2.11.0
