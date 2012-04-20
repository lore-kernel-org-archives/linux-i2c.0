From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c: imx: don't use strcpy but strlcpy
Date: Fri, 20 Apr 2012 22:47:25 +0200
Message-ID: <1334954845-13267-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Signed-off-by: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index dfb84b7..cdcf313 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -510,7 +510,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	}
 
 	/* Setup i2c_imx driver structure */
-	strcpy(i2c_imx->adapter.name, pdev->name);
+	strlcpy(i2c_imx->adapter.name, pdev->name, sizeof(i2c_imx->adapter.name));
 	i2c_imx->adapter.owner		= THIS_MODULE;
 	i2c_imx->adapter.algo		= &i2c_imx_algo;
 	i2c_imx->adapter.dev.parent	= &pdev->dev;
-- 
1.7.10
