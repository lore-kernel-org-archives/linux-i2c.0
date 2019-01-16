From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 1/2] i2c: imx: fix dma_request_chan error handling
Date: Wed, 16 Jan 2019 13:28:54 +0200
Message-ID: <20190116112855.13824-1-laurentiu.tudor@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-imx@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, wsa@the-dreams.de
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabio.estevam@nxp.com, leoyang.li@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
List-Id: linux-i2c@vger.kernel.org

Use the correct error pointer when extracting the error code.

Fixes: ea1e5f176e97 ("i2c: imx: notify about real errors on dma i2c_imx_dma_request")
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 09b124547669..42fed40198a0 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -287,7 +287,7 @@ static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
 
 	dma->chan_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(dma->chan_tx)) {
-		ret = PTR_ERR(dma->chan_rx);
+		ret = PTR_ERR(dma->chan_tx);
 		if (ret != -ENODEV && ret != -EPROBE_DEFER)
 			dev_err(dev, "can't request DMA tx channel (%d)\n", ret);
 		goto fail_al;
-- 
2.17.1
