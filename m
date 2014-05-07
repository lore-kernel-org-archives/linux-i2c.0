From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 08/16] i2c: rcar: remove unnecessary OOM messages
Date: Wed, 07 May 2014 13:26:03 +0900
Message-ID: <018c01cf69ac$7511b5a0$5f3520e0$%han@samsung.com>
References: <018301cf69aa$cb7987d0$626c9770$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <018301cf69aa$cb7987d0$626c9770$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Ben Dooks' <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, 'Guennadi Liakhovetski' <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-rcar.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index d4fa8eb..6a63bfd 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -654,10 +654,8 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(struct rcar_i2c_priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(dev, "no mem for private data\n");
+	if (!priv)
 		return -ENOMEM;
-	}
 
 	priv->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk)) {
-- 
1.7.10.4
