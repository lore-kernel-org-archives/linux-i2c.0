From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 1/5] i2c: i2c-davinci: switch to use platform_get_irq
Date: Mon, 1 Dec 2014 17:34:03 +0200
Message-ID: <1417448047-15236-2-git-send-email-grygorii.strashko@ti.com>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417448047-15236-1-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Switch Davinci I2C driver to use platform_get_irq(), because
it is not recommened to use platform_get_resource(pdev, IORESOURCE_IRQ,=
 ..)
for requesting IRQ resources any more, as they can be not ready yet
in case of DT-boot.

CC: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
CC: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
CC: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-=
davinci.c
index 4d96147..25e8e25 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -640,13 +640,17 @@ static int davinci_i2c_probe(struct platform_devi=
ce *pdev)
 {
 	struct davinci_i2c_dev *dev;
 	struct i2c_adapter *adap;
-	struct resource *mem, *irq;
-	int r;
-
-	irq =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq) {
-		dev_err(&pdev->dev, "no irq resource?\n");
-		return -ENODEV;
+	struct resource *mem;
+	int r, irq;
+
+	irq =3D platform_get_irq(pdev, 0);
+	if (irq <=3D 0) {
+		if (!irq)
+			irq =3D -ENXIO;
+		if (irq !=3D -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"can't get irq resource ret=3D%d\n", irq);
+		return irq;
 	}
=20
 	dev =3D devm_kzalloc(&pdev->dev, sizeof(struct davinci_i2c_dev),
@@ -661,7 +665,7 @@ static int davinci_i2c_probe(struct platform_device=
 *pdev)
 	init_completion(&dev->xfr_complete);
 #endif
 	dev->dev =3D &pdev->dev;
-	dev->irq =3D irq->start;
+	dev->irq =3D irq;
 	dev->pdata =3D dev_get_platdata(&pdev->dev);
 	platform_set_drvdata(pdev, dev);
=20
--=20
1.9.1
