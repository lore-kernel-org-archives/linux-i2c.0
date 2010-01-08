From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] i2c/imx: call ioremap only after request_mem_region
Date: Fri,  8 Jan 2010 17:23:17 +0100
Message-ID: <1262967797-2001-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753834Ab0AHQX1@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Richard Zhao <linuxzsc@gmail.com>, Darius Augulis <augulis.darius@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

accordingly adapt order of release_mem_region and release_mem_region on
remove.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Richard Zhao <linuxzsc@gmail.com>
Cc: Darius Augulis <augulis.darius@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-i2c@vger.kernel.org
---
 drivers/i2c/busses/i2c-imx.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.=
c
index e3654d6..8431500 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -496,22 +496,23 @@ static int __init i2c_imx_probe(struct platform_d=
evice *pdev)
 	}
=20
 	res_size =3D resource_size(res);
+
+	if (!request_mem_region(res->start, res_size, DRIVER_NAME)) {
+		ret =3D -EBUSY;
+		goto fail0;
+	}
+
 	base =3D ioremap(res->start, res_size);
 	if (!base) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		ret =3D -EIO;
-		goto fail0;
+		goto fail1;
 	}
=20
 	i2c_imx =3D kzalloc(sizeof(struct imx_i2c_struct), GFP_KERNEL);
 	if (!i2c_imx) {
 		dev_err(&pdev->dev, "can't allocate interface\n");
 		ret =3D -ENOMEM;
-		goto fail1;
-	}
-
-	if (!request_mem_region(res->start, res_size, DRIVER_NAME)) {
-		ret =3D -EBUSY;
 		goto fail2;
 	}
=20
@@ -582,11 +583,11 @@ fail5:
 fail4:
 	clk_put(i2c_imx->clk);
 fail3:
-	release_mem_region(i2c_imx->res->start, resource_size(res));
-fail2:
 	kfree(i2c_imx);
-fail1:
+fail2:
 	iounmap(base);
+fail1:
+	release_mem_region(res->start, resource_size(res));
 fail0:
 	if (pdata && pdata->exit)
 		pdata->exit(&pdev->dev);
@@ -618,8 +619,8 @@ static int __exit i2c_imx_remove(struct platform_de=
vice *pdev)
=20
 	clk_put(i2c_imx->clk);
=20
-	release_mem_region(i2c_imx->res->start, resource_size(i2c_imx->res));
 	iounmap(i2c_imx->base);
+	release_mem_region(i2c_imx->res->start, resource_size(i2c_imx->res));
 	kfree(i2c_imx);
 	return 0;
 }
--=20
1.6.5.2
