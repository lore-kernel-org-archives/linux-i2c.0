From: Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH] i2c: mediatek: modify threshold passed to i2c_get_dma_safe_msg_buf()
Date: Fri, 15 Feb 2019 17:02:02 +0800
Message-ID: <20190215090202.157100-1-hsinyi@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Jun Gao <jun.gao@mediatek.com>, Hsin-Yi Wang <hsinyi@chromium.org>, Ryder Lee <ryder.lee@mediatek.com>, linux-i2c@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

i2c_get_dma_safe_msg_buf() allocates space based on msg->len. If threshold is
0 and msg->len is also 0, function makes zero-length allocation, which returns
a special ZERO_SIZE_PTR instead of a NULL pointer, and this will cause later
code to fail. Modify the threshold to > 0 so the function returns NULL pointer.

Fixes: fc66b39fe36a ("i2c: mediatek: Use DMA safe buffers for i2c transactions")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/i2c/busses/i2c-mt65xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index a74ef76705e0..2bb4d20ead32 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -503,7 +503,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 		writel(I2C_DMA_INT_FLAG_NONE, i2c->pdmabase + OFFSET_INT_FLAG);
 		writel(I2C_DMA_CON_RX, i2c->pdmabase + OFFSET_CON);
 
-		dma_rd_buf = i2c_get_dma_safe_msg_buf(msgs, 0);
+		dma_rd_buf = i2c_get_dma_safe_msg_buf(msgs, 1);
 		if (!dma_rd_buf)
 			return -ENOMEM;
 
@@ -526,7 +526,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 		writel(I2C_DMA_INT_FLAG_NONE, i2c->pdmabase + OFFSET_INT_FLAG);
 		writel(I2C_DMA_CON_TX, i2c->pdmabase + OFFSET_CON);
 
-		dma_wr_buf = i2c_get_dma_safe_msg_buf(msgs, 0);
+		dma_wr_buf = i2c_get_dma_safe_msg_buf(msgs, 1);
 		if (!dma_wr_buf)
 			return -ENOMEM;
 
@@ -549,7 +549,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 		writel(I2C_DMA_CLR_FLAG, i2c->pdmabase + OFFSET_INT_FLAG);
 		writel(I2C_DMA_CLR_FLAG, i2c->pdmabase + OFFSET_CON);
 
-		dma_wr_buf = i2c_get_dma_safe_msg_buf(msgs, 0);
+		dma_wr_buf = i2c_get_dma_safe_msg_buf(msgs, 1);
 		if (!dma_wr_buf)
 			return -ENOMEM;
 
@@ -561,7 +561,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 			return -ENOMEM;
 		}
 
-		dma_rd_buf = i2c_get_dma_safe_msg_buf((msgs + 1), 0);
+		dma_rd_buf = i2c_get_dma_safe_msg_buf((msgs + 1), 1);
 		if (!dma_rd_buf) {
 			dma_unmap_single(i2c->dev, wpaddr,
 					 msgs->len, DMA_TO_DEVICE);
-- 
2.18.1
