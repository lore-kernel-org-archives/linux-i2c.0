From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] i2c: i2c-imx: Adapt the clock name to the new clock framework
Date: Fri, 6 Jul 2012 15:31:32 -0300
Message-ID: <1341599492-18212-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

With the new i.mx clock framework the i2c clock is registered as:

clk_register_clkdev(clk[i2c1_ipg_gate], NULL, "imx-i2c.0")

So we do not need to pass "i2c_clk" string and can use NULL instead.

Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 370031a..a8709b1 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -528,7 +528,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	}
 
 	/* Get I2C clock */
-	i2c_imx->clk = clk_get(&pdev->dev, "i2c_clk");
+	i2c_imx->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(i2c_imx->clk)) {
 		ret = PTR_ERR(i2c_imx->clk);
 		dev_err(&pdev->dev, "can't get I2C clock\n");
-- 
1.7.1
