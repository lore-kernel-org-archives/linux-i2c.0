From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH] i2c: Platform data is optional for i2c-imx
Date: Mon, 12 Jan 2009 14:45:21 +0000
Message-ID: <1231771521-3772-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <493CF201.8030406@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <493CF201.8030406-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The i.MX i2c driver insists on platform data but all the fields may be
omitted individually so remove the requirement for platform data.

Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---

This is an incremental patch against the (still out of tree) i.MX
driver.  Is there anything that can be done to help with getting that
mainlined?

 drivers/i2c/busses/i2c-imx.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 3296380..2028ab8 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -457,12 +457,8 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	}
 
 	pdata = pdev->dev.platform_data;
-	if (!pdata) {
-		dev_err(&pdev->dev, "I2C driver needs platform data\n");
-		return -ENODEV;
-	}
 
-	if (pdata->init) {
+	if (pdata && pdata->init) {
 		ret = pdata->init(&pdev->dev);
 		if (ret)
 			return ret;
@@ -516,7 +512,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
 
 	/* Set up clock divider */
-	if (pdata->bitrate)
+	if (pdata && pdata->bitrate)
 		i2c_imx_set_clk(i2c_imx, pdata->bitrate);
 	else
 		i2c_imx_set_clk(i2c_imx, IMX_I2C_BIT_RATE);
@@ -556,7 +552,7 @@ fail2:
 fail1:
 	iounmap(base);
 fail0:
-	if (pdata->exit)
+	if (pdata && pdata->exit)
 		pdata->exit(&pdev->dev);
 	return ret; /* Return error number */
 }
@@ -581,7 +577,7 @@ static int __exit i2c_imx_remove(struct platform_device *pdev)
 	writeb(0, i2c_imx->base + IMX_I2C_I2SR);
 
 	/* Shut down hardware */
-	if (pdata->exit)
+	if (pdata && pdata->exit)
 		pdata->exit(&pdev->dev);
 
 	/* Disable I2C clock */
-- 
1.5.6.5
