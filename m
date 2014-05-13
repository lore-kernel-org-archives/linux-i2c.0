From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH V2] i2c: remove unnecessary OOM messages
Date: Tue, 13 May 2014 10:51:58 +0900
Message-ID: <000d01cf6e4d$ece8ca50$c6ba5ef0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Guenter Roeck' <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, 'Jean Delvare' <jdelvare-l3A5Bk7waGM@public.gmane.org>, =?iso-8859-1?Q?'Uwe_Kleine-K=F6nig'?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, 'Felipe Balbi' <balbi-l0cyMroinI0@public.gmane.org>, 'Laurent Pinchart' <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, 'Linus Walleij' <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message. For example,
k.alloc and v.alloc failures use dump_stack().

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Acked-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Reviewed-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
Changes since v1:
- squashed all patches into a single patch
- added reviewed-by and acked-by

 drivers/i2c/busses/i2c-bcm2835.c    |    4 +---
 drivers/i2c/busses/i2c-diolan-u2c.c |    1 -
 drivers/i2c/busses/i2c-efm32.c      |    4 +---
 drivers/i2c/busses/i2c-eg20t.c      |    4 +---
 drivers/i2c/busses/i2c-exynos5.c    |    4 +---
 drivers/i2c/busses/i2c-imx.c        |    4 +---
 drivers/i2c/busses/i2c-omap.c       |    4 +---
 drivers/i2c/busses/i2c-rcar.c       |    4 +---
 drivers/i2c/busses/i2c-s3c2410.c    |    8 ++------
 drivers/i2c/busses/i2c-sh_mobile.c  |    4 +---
 drivers/i2c/busses/i2c-simtec.c     |    4 +---
 drivers/i2c/busses/i2c-sirf.c       |    1 -
 drivers/i2c/busses/i2c-stu300.c     |    4 +---
 drivers/i2c/busses/i2c-tegra.c      |    4 +---
 drivers/i2c/busses/i2c-wmt.c        |    4 +---
 drivers/i2c/busses/scx200_acb.c     |    4 +---
 16 files changed, 15 insertions(+), 47 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-=
bcm2835.c
index c607195..214ff97 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -225,10 +225,8 @@ static int bcm2835_i2c_probe(struct platform_devic=
e *pdev)
 	struct i2c_adapter *adap;
=20
 	i2c_dev =3D devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL);
-	if (!i2c_dev) {
-		dev_err(&pdev->dev, "Cannot allocate i2c_dev\n");
+	if (!i2c_dev)
 		return -ENOMEM;
-	}
 	platform_set_drvdata(pdev, i2c_dev);
 	i2c_dev->dev =3D &pdev->dev;
 	init_completion(&i2c_dev->completion);
diff --git a/drivers/i2c/busses/i2c-diolan-u2c.c b/drivers/i2c/busses/i=
2c-diolan-u2c.c
index 721f7eb..b19a310 100644
--- a/drivers/i2c/busses/i2c-diolan-u2c.c
+++ b/drivers/i2c/busses/i2c-diolan-u2c.c
@@ -455,7 +455,6 @@ static int diolan_u2c_probe(struct usb_interface *i=
nterface,
 	/* allocate memory for our device state and initialize it */
 	dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (dev =3D=3D NULL) {
-		dev_err(&interface->dev, "no memory for device state\n");
 		ret =3D -ENOMEM;
 		goto error;
 	}
diff --git a/drivers/i2c/busses/i2c-efm32.c b/drivers/i2c/busses/i2c-ef=
m32.c
index 777ed40..f7eccd6 100644
--- a/drivers/i2c/busses/i2c-efm32.c
+++ b/drivers/i2c/busses/i2c-efm32.c
@@ -320,10 +320,8 @@ static int efm32_i2c_probe(struct platform_device =
*pdev)
 		return -EINVAL;
=20
 	ddata =3D devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
-	if (!ddata) {
-		dev_dbg(&pdev->dev, "failed to allocate private data\n");
+	if (!ddata)
 		return -ENOMEM;
-	}
 	platform_set_drvdata(pdev, ddata);
=20
 	init_completion(&ddata->done);
diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg=
20t.c
index ff775ac..a44ea13 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -751,10 +751,8 @@ static int pch_i2c_probe(struct pci_dev *pdev,
 	pch_pci_dbg(pdev, "Entered.\n");
=20
 	adap_info =3D kzalloc((sizeof(struct adapter_info)), GFP_KERNEL);
-	if (adap_info =3D=3D NULL) {
-		pch_pci_err(pdev, "Memory allocation FAILED\n");
+	if (adap_info =3D=3D NULL)
 		return -ENOMEM;
-	}
=20
 	ret =3D pci_enable_device(pdev);
 	if (ret) {
diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-=
exynos5.c
index 00af0a0..ce7c315 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -621,10 +621,8 @@ static int exynos5_i2c_probe(struct platform_devic=
e *pdev)
 	int ret;
=20
 	i2c =3D devm_kzalloc(&pdev->dev, sizeof(struct exynos5_i2c), GFP_KERN=
EL);
-	if (!i2c) {
-		dev_err(&pdev->dev, "no memory for state\n");
+	if (!i2c)
 		return -ENOMEM;
-	}
=20
 	if (of_property_read_u32(np, "clock-frequency", &op_clock)) {
 		i2c->speed_mode =3D HSI2C_FAST_SPD;
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.=
c
index db895fb..584e002 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -617,10 +617,8 @@ static int i2c_imx_probe(struct platform_device *p=
dev)
=20
 	i2c_imx =3D devm_kzalloc(&pdev->dev, sizeof(struct imx_i2c_struct),
 				GFP_KERNEL);
-	if (!i2c_imx) {
-		dev_err(&pdev->dev, "can't allocate interface\n");
+	if (!i2c_imx)
 		return -ENOMEM;
-	}
=20
 	if (of_id)
 		i2c_imx->hwdata =3D of_id->data;
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-oma=
p.c
index 85f8eac..b182793 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1114,10 +1114,8 @@ omap_i2c_probe(struct platform_device *pdev)
 	}
=20
 	dev =3D devm_kzalloc(&pdev->dev, sizeof(struct omap_i2c_dev), GFP_KER=
NEL);
-	if (!dev) {
-		dev_err(&pdev->dev, "Menory allocation failed\n");
+	if (!dev)
 		return -ENOMEM;
-	}
=20
 	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dev->base =3D devm_ioremap_resource(&pdev->dev, mem);
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rca=
r.c
index d4fa8eb..6a63bfd 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -654,10 +654,8 @@ static int rcar_i2c_probe(struct platform_device *=
pdev)
 	int ret;
=20
 	priv =3D devm_kzalloc(dev, sizeof(struct rcar_i2c_priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(dev, "no mem for private data\n");
+	if (!priv)
 		return -ENOMEM;
-	}
=20
 	priv->clk =3D devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk)) {
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-=
s3c2410.c
index ae44910..0bb14bd 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -1114,16 +1114,12 @@ static int s3c24xx_i2c_probe(struct platform_de=
vice *pdev)
 	}
=20
 	i2c =3D devm_kzalloc(&pdev->dev, sizeof(struct s3c24xx_i2c), GFP_KERN=
EL);
-	if (!i2c) {
-		dev_err(&pdev->dev, "no memory for state\n");
+	if (!i2c)
 		return -ENOMEM;
-	}
=20
 	i2c->pdata =3D devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!i2c->pdata) {
-		dev_err(&pdev->dev, "no memory for platform data\n");
+	if (!i2c->pdata)
 		return -ENOMEM;
-	}
=20
 	i2c->quirks =3D s3c24xx_get_device_quirks(pdev);
 	if (pdata)
diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2=
c-sh_mobile.c
index 1d79585..fbc13e9 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -665,10 +665,8 @@ static int sh_mobile_i2c_probe(struct platform_dev=
ice *dev)
 	int ret;
=20
 	pd =3D kzalloc(sizeof(struct sh_mobile_i2c_data), GFP_KERNEL);
-	if (pd =3D=3D NULL) {
-		dev_err(&dev->dev, "cannot allocate private data\n");
+	if (pd =3D=3D NULL)
 		return -ENOMEM;
-	}
=20
 	pd->clk =3D clk_get(&dev->dev, NULL);
 	if (IS_ERR(pd->clk)) {
diff --git a/drivers/i2c/busses/i2c-simtec.c b/drivers/i2c/busses/i2c-s=
imtec.c
index 294c80f..964e5c6 100644
--- a/drivers/i2c/busses/i2c-simtec.c
+++ b/drivers/i2c/busses/i2c-simtec.c
@@ -77,10 +77,8 @@ static int simtec_i2c_probe(struct platform_device *=
dev)
 	int ret;
=20
 	pd =3D kzalloc(sizeof(struct simtec_i2c_data), GFP_KERNEL);
-	if (pd =3D=3D NULL) {
-		dev_err(&dev->dev, "cannot allocate private data\n");
+	if (pd =3D=3D NULL)
 		return -ENOMEM;
-	}
=20
 	platform_set_drvdata(dev, pd);
=20
diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sir=
f.c
index 8e3be7e..a3216de 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -307,7 +307,6 @@ static int i2c_sirfsoc_probe(struct platform_device=
 *pdev)
=20
 	siic =3D devm_kzalloc(&pdev->dev, sizeof(*siic), GFP_KERNEL);
 	if (!siic) {
-		dev_err(&pdev->dev, "Can't allocate driver data\n");
 		err =3D -ENOMEM;
 		goto out;
 	}
diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-s=
tu300.c
index 29b1fb7..fefb1c1 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -868,10 +868,8 @@ static int stu300_probe(struct platform_device *pd=
ev)
 	int ret =3D 0;
=20
 	dev =3D devm_kzalloc(&pdev->dev, sizeof(struct stu300_dev), GFP_KERNE=
L);
-	if (!dev) {
-		dev_err(&pdev->dev, "could not allocate device struct\n");
+	if (!dev)
 		return -ENOMEM;
-	}
=20
 	bus_nr =3D pdev->id;
 	dev->clk =3D devm_clk_get(&pdev->dev, NULL);
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-te=
gra.c
index 00f04cb..f1bb2fc 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -732,10 +732,8 @@ static int tegra_i2c_probe(struct platform_device =
*pdev)
 	}
=20
 	i2c_dev =3D devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL);
-	if (!i2c_dev) {
-		dev_err(&pdev->dev, "Could not allocate struct tegra_i2c_dev");
+	if (!i2c_dev)
 		return -ENOMEM;
-	}
=20
 	i2c_dev->base =3D base;
 	i2c_dev->div_clk =3D div_clk;
diff --git a/drivers/i2c/busses/i2c-wmt.c b/drivers/i2c/busses/i2c-wmt.=
c
index 2c8a3e4..889a212 100644
--- a/drivers/i2c/busses/i2c-wmt.c
+++ b/drivers/i2c/busses/i2c-wmt.c
@@ -379,10 +379,8 @@ static int wmt_i2c_probe(struct platform_device *p=
dev)
 	u32 clk_rate;
=20
 	i2c_dev =3D devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL);
-	if (!i2c_dev) {
-		dev_err(&pdev->dev, "device memory allocation failed\n");
+	if (!i2c_dev)
 		return -ENOMEM;
-	}
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	i2c_dev->base =3D devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx20=
0_acb.c
index cb66f95..ff3f574 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -431,10 +431,8 @@ static struct scx200_acb_iface *scx200_create_ifac=
e(const char *text,
 	struct i2c_adapter *adapter;
=20
 	iface =3D kzalloc(sizeof(*iface), GFP_KERNEL);
-	if (!iface) {
-		pr_err("can't allocate memory\n");
+	if (!iface)
 		return NULL;
-	}
=20
 	adapter =3D &iface->adapter;
 	i2c_set_adapdata(adapter, iface);
--=20
1.7.10.4
