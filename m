From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v4 1/2] i2c: imx: notify about real errors on dma
 i2c_imx_dma_request
Date: Mon,  7 Jan 2019 09:47:37 +0100
Message-ID: <20190107084738.4130-2-o.rempel@pengutronix.de>
References: <20190107084738.4130-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190107084738.4130-1-o.rempel@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, linux-i2c@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org, NXP Linux Team <linux-imx@nxp.com>
List-Id: linux-i2c@vger.kernel.org

Current implementation will print "can't use DMA, using PIO instead",
which is confusing and mostly interpreted as error. At least on i.MX5x,
DMA event for I2C is muxed with SDHC. So it is project specific
configuration. On other hand, real error have debug level.

With this patch real error should be printed and configuration specific
state will become silent.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/i2c/busses/i2c-imx.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index fa9ad53845d9..e28ef494dac8 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -285,9 +285,11 @@ static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
 	if (!dma)
 		return;
 
-	dma->chan_tx = dma_request_slave_channel(dev, "tx");
-	if (!dma->chan_tx) {
-		dev_dbg(dev, "can't request DMA tx channel\n");
+	dma->chan_tx = dma_request_chan(dev, "tx");
+	if (IS_ERR(dma->chan_tx)) {
+		ret = PTR_ERR(dma->chan_rx);
+		if (ret != -ENODEV && ret != -EPROBE_DEFER)
+			dev_err(dev, "can't request DMA tx channel (%d)\n", ret);
 		goto fail_al;
 	}
 
@@ -298,13 +300,15 @@ static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
 	dma_sconfig.direction = DMA_MEM_TO_DEV;
 	ret = dmaengine_slave_config(dma->chan_tx, &dma_sconfig);
 	if (ret < 0) {
-		dev_dbg(dev, "can't configure tx channel\n");
+		dev_err(dev, "can't configure tx channel (%d)\n", ret);
 		goto fail_tx;
 	}
 
-	dma->chan_rx = dma_request_slave_channel(dev, "rx");
-	if (!dma->chan_rx) {
-		dev_dbg(dev, "can't request DMA rx channel\n");
+	dma->chan_rx = dma_request_chan(dev, "rx");
+	if (IS_ERR(dma->chan_rx)) {
+		ret = PTR_ERR(dma->chan_rx);
+		if (ret != -ENODEV && ret != -EPROBE_DEFER)
+			dev_err(dev, "can't request DMA rx channel (%d)\n", ret);
 		goto fail_tx;
 	}
 
@@ -315,7 +319,7 @@ static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
 	dma_sconfig.direction = DMA_DEV_TO_MEM;
 	ret = dmaengine_slave_config(dma->chan_rx, &dma_sconfig);
 	if (ret < 0) {
-		dev_dbg(dev, "can't configure rx channel\n");
+		dev_err(dev, "can't configure rx channel (%d)\n", ret);
 		goto fail_rx;
 	}
 
@@ -332,7 +336,6 @@ static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
 	dma_release_channel(dma->chan_tx);
 fail_al:
 	devm_kfree(dev, dma);
-	dev_info(dev, "can't use DMA, using PIO instead.\n");
 }
 
 static void i2c_imx_dma_callback(void *arg)
-- 
2.19.1
