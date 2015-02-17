From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c: pca954x: improve usage of gpiod API
Date: Tue, 17 Feb 2015 10:12:08 +0100
Message-ID: <1424164328-28534-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
which appeared in v3.17-rc1, the gpiod_get* functions take an additiona=
l
parameter that allows to specify direction and initial value for
outputs.

Also there is an *_optional variant that serves well here.  The sematic=
s
is slightly changed here by using it. Now if a reset gpio is specified
and getting hold on it fails, pca954x_probe fails, too.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2=
c-mux-pca954x.c
index ec11b404b433..0042cf3d77db 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -201,9 +201,9 @@ static int pca954x_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, data);
=20
 	/* Get the mux out of reset if a reset GPIO is specified. */
-	gpio =3D devm_gpiod_get(&client->dev, "reset");
-	if (!IS_ERR(gpio))
-		gpiod_direction_output(gpio, 0);
+	gpio =3D devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_LOW=
);
+	if (IS_ERR(gpio))
+		return PTR_ERR(gpio);
=20
 	/* Write the mux register at addr to verify
 	 * that the mux is in fact present. This also
--=20
2.1.4
