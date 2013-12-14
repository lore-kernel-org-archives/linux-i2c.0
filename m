From: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH -next] i2c: imx: add missing clk_disable_unprepare() on error path
Date: Sat, 14 Dec 2013 22:26:10 +0800
Message-ID: <CAPgLHd-zvCacvi5gN-PSqow5-NujhwtXa2RcnNQvorMmAEucrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnaud.patard-dQbF7i+pzddAfugRpC6u6w@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>

Add the missing clk_disable_unprepare() before return in
the error handling cases.

Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index d0cfbb4..e62f3be 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -328,8 +328,10 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
 	temp |= I2CR_MSTA;
 	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 	result = i2c_imx_bus_busy(i2c_imx, 1);
-	if (result)
+	if (result) {
+		clk_disable_unprepare(i2c_imx->clk);
 		return result;
+	}
 	i2c_imx->stopped = 0;
 
 	temp |= I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
@@ -654,7 +656,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
 				pdev->name, i2c_imx);
 	if (ret) {
 		dev_err(&pdev->dev, "can't claim irq %d\n", irq);
-		return ret;
+		goto err_out;
 	}
 
 	/* Init queue */
@@ -680,7 +682,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	ret = i2c_add_numbered_adapter(&i2c_imx->adapter);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "registration failed\n");
-		return ret;
+		goto err_out;
 	}
 
 	/* Set up platform driver data */
@@ -697,6 +699,9 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
 
 	return 0;   /* Return OK */
+err_out:
+	clk_disable_unprepare(i2c_imx->clk);
+	return ret;
 }
 
 static int i2c_imx_remove(struct platform_device *pdev)
