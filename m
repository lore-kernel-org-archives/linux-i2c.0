From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v2] i2c: imx: whitespace and checkpatch cleanup
Date: Thu, 22 Jan 2015 16:17:29 +0100
Message-ID: <1421939849-20964-1-git-send-email-p.zabel@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch fixes up some whitespace issues and addresses a few
checkpatch warnings.

Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Acked-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
Changes since v1:
 - Dropped the 80 char limit line breaks
---
 drivers/i2c/busses/i2c-imx.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 9b02d1d..60ecb3f 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -201,7 +201,7 @@ struct imx_i2c_struct {
 	void __iomem		*base;
 	wait_queue_head_t	queue;
 	unsigned long		i2csr;
-	unsigned int 		disable_delay;
+	unsigned int		disable_delay;
 	int			stopped;
 	unsigned int		ifdr; /* IMX_I2C_IFDR */
 	unsigned int		cur_clk;
@@ -479,8 +479,8 @@ static void i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx)
 	i2c_clk_rate = clk_get_rate(i2c_imx->clk);
 	if (i2c_imx->cur_clk == i2c_clk_rate)
 		return;
-	else
-		i2c_imx->cur_clk = i2c_clk_rate;
+
+	i2c_imx->cur_clk = i2c_clk_rate;
 
 	div = (i2c_clk_rate + i2c_imx->bitrate - 1) / i2c_imx->bitrate;
 	if (div < i2c_clk_div[0].div)
@@ -488,7 +488,8 @@ static void i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx)
 	else if (div > i2c_clk_div[i2c_imx->hwdata->ndivs - 1].div)
 		i = i2c_imx->hwdata->ndivs - 1;
 	else
-		for (i = 0; i2c_clk_div[i].div < div; i++);
+		for (i = 0; i2c_clk_div[i].div < div; i++)
+			;
 
 	/* Store divider value */
 	i2c_imx->ifdr = i2c_clk_div[i].val;
@@ -820,6 +821,7 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
 	/* read data */
 	for (i = 0; i < msgs->len; i++) {
 		u8 len = 0;
+
 		result = i2c_imx_trx_complete(i2c_imx);
 		if (result)
 			return result;
@@ -915,15 +917,16 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 		/* write/read data */
 #ifdef CONFIG_I2C_DEBUG_BUS
 		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
-		dev_dbg(&i2c_imx->adapter.dev, "<%s> CONTROL: IEN=%d, IIEN=%d, "
-			"MSTA=%d, MTX=%d, TXAK=%d, RSTA=%d\n", __func__,
+		dev_dbg(&i2c_imx->adapter.dev,
+			"<%s> CONTROL: IEN=%d, IIEN=%d, MSTA=%d, MTX=%d, TXAK=%d, RSTA=%d\n",
+			__func__,
 			(temp & I2CR_IEN ? 1 : 0), (temp & I2CR_IIEN ? 1 : 0),
 			(temp & I2CR_MSTA ? 1 : 0), (temp & I2CR_MTX ? 1 : 0),
 			(temp & I2CR_TXAK ? 1 : 0), (temp & I2CR_RSTA ? 1 : 0));
 		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
 		dev_dbg(&i2c_imx->adapter.dev,
-			"<%s> STATUS: ICF=%d, IAAS=%d, IBB=%d, "
-			"IAL=%d, SRW=%d, IIF=%d, RXAK=%d\n", __func__,
+			"<%s> STATUS: ICF=%d, IAAS=%d, IBB=%d, IAL=%d, SRW=%d, IIF=%d, RXAK=%d\n",
+			__func__,
 			(temp & I2SR_ICF ? 1 : 0), (temp & I2SR_IAAS ? 1 : 0),
 			(temp & I2SR_IBB ? 1 : 0), (temp & I2SR_IAL ? 1 : 0),
 			(temp & I2SR_SRW ? 1 : 0), (temp & I2SR_IIF ? 1 : 0),
@@ -1002,7 +1005,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	i2c_imx->adapter.owner		= THIS_MODULE;
 	i2c_imx->adapter.algo		= &i2c_imx_algo;
 	i2c_imx->adapter.dev.parent	= &pdev->dev;
-	i2c_imx->adapter.nr 		= pdev->id;
+	i2c_imx->adapter.nr		= pdev->id;
 	i2c_imx->adapter.dev.of_node	= pdev->dev.of_node;
 	i2c_imx->base			= base;
 
@@ -1061,7 +1064,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
 		i2c_imx->adapter.name);
 	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
 
-	/* Init DMA config if support*/
+	/* Init DMA config if supported */
 	i2c_imx_dma_request(i2c_imx, phy_addr);
 
 	return 0;   /* Return OK */
-- 
2.1.4
