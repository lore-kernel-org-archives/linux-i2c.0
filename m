From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c: imx: use of_alias_get_id to order i2c devices
Date: Tue,  9 Apr 2013 19:09:39 +0200
Message-ID: <1365527379-17786-1-git-send-email-p.zabel@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This allows to order i2c character devices as they are numbered
in the reference manual, instead of ordering them by register
base address.

Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 82f20c6..e5a3f08 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -488,6 +488,7 @@ static struct i2c_algorithm i2c_imx_algo = {
 
 static int __init i2c_imx_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id = of_match_device(i2c_imx_dt_ids,
 							   &pdev->dev);
 	struct imx_i2c_struct *i2c_imx;
@@ -531,7 +532,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	i2c_imx->adapter.owner		= THIS_MODULE;
 	i2c_imx->adapter.algo		= &i2c_imx_algo;
 	i2c_imx->adapter.dev.parent	= &pdev->dev;
-	i2c_imx->adapter.nr 		= pdev->id;
+	i2c_imx->adapter.nr		= (pdev->id < 0) ? of_alias_get_id(np, "i2c") : pdev->id;
 	i2c_imx->adapter.dev.of_node	= pdev->dev.of_node;
 	i2c_imx->base			= base;
 
-- 
1.8.2.rc2
