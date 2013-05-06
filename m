From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 03/13] i2c: i2c-mxs: Let device core handle pinctrl
Date: Mon, 6 May 2013 15:05:51 -0300
Message-ID: <1367863561-11534-3-git-send-email-fabio.estevam@freescale.com>
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
 drivers/i2c/busses/i2c-mxs.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 120f246..7f3dced 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -24,7 +24,6 @@
 #include <linux/platform_device.h>
 #include <linux/jiffies.h>
 #include <linux/io.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/stmp_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -604,16 +603,11 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct mxs_i2c_dev *i2c;
 	struct i2c_adapter *adap;
-	struct pinctrl *pinctrl;
 	struct resource *res;
 	resource_size_t res_size;
 	int err, irq, dmairq;
 	dma_cap_mask_t mask;
 
-	pinctrl = devm_pinctrl_get_select_default(dev);
-	if (IS_ERR(pinctrl))
-		return PTR_ERR(pinctrl);
-
 	i2c = devm_kzalloc(dev, sizeof(struct mxs_i2c_dev), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
-- 
1.7.9.5
