From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: [PATCH v2 1/4] i2c: imx: Fix reinit_completion() use
Date: Mon,  9 Jul 2018 11:43:01 +0200
Message-ID: <20180709094304.8814-2-esben.haabendal@gmail.com>
References: <20180709094304.8814-1-esben.haabendal@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709094304.8814-1-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Yuan Yao <yao.yuan@freescale.com>, Esben Haabendal <eha@deif.com>, Phil Reid <preid@electromag.com.au>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Peter Rosin <peda@axentia.se>, Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

Make sure to call reinit_completion() before dma is started to avoid race
condition where reinit_completion() is called after complete() and before
wait_for_completion_timeout().

Signed-off-by: Esben Haabendal <eha@deif.com>
Fixes: ce1a78840ff7 ("i2c: imx: add DMA support for freescale i2c driver")
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/i2c/busses/i2c-imx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 0207e194f84b..39cfd98c7b23 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -368,6 +368,7 @@ static int i2c_imx_dma_xfer(struct imx_i2c_struct *i2c_imx,
 		goto err_desc;
 	}
 
+	reinit_completion(&dma->cmd_complete);
 	txdesc->callback = i2c_imx_dma_callback;
 	txdesc->callback_param = i2c_imx;
 	if (dma_submit_error(dmaengine_submit(txdesc))) {
@@ -622,7 +623,6 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 	 * The first byte must be transmitted by the CPU.
 	 */
 	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
-	reinit_completion(&i2c_imx->dma->cmd_complete);
 	time_left = wait_for_completion_timeout(
 				&i2c_imx->dma->cmd_complete,
 				msecs_to_jiffies(DMA_TIMEOUT));
@@ -681,7 +681,6 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 	if (result)
 		return result;
 
-	reinit_completion(&i2c_imx->dma->cmd_complete);
 	time_left = wait_for_completion_timeout(
 				&i2c_imx->dma->cmd_complete,
 				msecs_to_jiffies(DMA_TIMEOUT));
-- 
2.18.0
