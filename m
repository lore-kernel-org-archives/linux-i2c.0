From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c-imx: Disable the clock on probe failure
Date: Sat,  4 Oct 2014 09:17:27 -0300
Message-ID: <1412425047-9323-1-git-send-email-festevam@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

In the case of errors during probe, we should disable i2c_imx->clk.

Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index ceff87c..c48e46a 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -710,7 +710,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
 				pdev->name, i2c_imx);
 	if (ret) {
 		dev_err(&pdev->dev, "can't claim irq %d\n", irq);
-		return ret;
+		goto clk_disable;
 	}
 
 	/* Init queue */
@@ -735,7 +735,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	ret = i2c_add_numbered_adapter(&i2c_imx->adapter);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "registration failed\n");
-		return ret;
+		goto clk_disable;
 	}
 
 	/* Set up platform driver data */
@@ -749,6 +749,10 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
 
 	return 0;   /* Return OK */
+
+clk_disable:
+	clk_disable_unprepare(i2c_imx->clk);
+	return ret;
 }
 
 static int i2c_imx_remove(struct platform_device *pdev)
-- 
1.9.1
