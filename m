From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] i2c: pca-platform: Use platform_irq_get_optional
Date: Fri, 27 Mar 2020 11:44:22 +1300
Message-ID: <20200326224422.31063-1-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, allison@lohutok.net, info@metux.net, linus.walleij@linaro.org, tglx@linutronix.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>
List-Id: linux-i2c@vger.kernel.org

The interrupt is not required so use platform_irq_get_optional() to
avoid error messages like

  i2c-pca-platform 22080000.i2c: IRQ index 0 not found

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/i2c/busses/i2c-pca-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i=
2c-pca-platform.c
index a7a81846d5b1..635dd697ac0b 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -140,7 +140,7 @@ static int i2c_pca_pf_probe(struct platform_device *p=
dev)
 	int ret =3D 0;
 	int irq;
=20
-	irq =3D platform_get_irq(pdev, 0);
+	irq =3D platform_get_irq_optional(pdev, 0);
 	/* If irq is 0, we do polling. */
 	if (irq < 0)
 		irq =3D 0;
--=20
2.25.1
