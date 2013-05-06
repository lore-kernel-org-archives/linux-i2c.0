From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 02/13] i2c: i2c-imx: Let device core handle pinctrl
Date: Mon, 6 May 2013 15:05:50 -0300
Message-ID: <1367863561-11534-2-git-send-email-fabio.estevam@freescale.com>
References: <1367863561-11534-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1367863561-11534-1-git-send-email-fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
we can rely on device core for handling pinctrl.

So remove devm_pinctrl_get_select_default() from the driver. 

Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 82f20c6..8c7526c 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -51,7 +51,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_i2c.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/platform_data/i2c-imx.h>
 
 /** Defines ********************************************************************
@@ -493,7 +492,6 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	struct imx_i2c_struct *i2c_imx;
 	struct resource *res;
 	struct imxi2c_platform_data *pdata = pdev->dev.platform_data;
-	struct pinctrl *pinctrl;
 	void __iomem *base;
 	int irq, ret;
 	u32 bitrate;
@@ -535,12 +533,6 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	i2c_imx->adapter.dev.of_node	= pdev->dev.of_node;
 	i2c_imx->base			= base;
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl)) {
-		dev_err(&pdev->dev, "can't get/select pinctrl\n");
-		return PTR_ERR(pinctrl);
-	}
-
 	/* Get I2C clock */
 	i2c_imx->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(i2c_imx->clk)) {
-- 
1.7.9.5
