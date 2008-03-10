From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] Replace dev_warn with printk in pca-algo
Date: Mon, 10 Mar 2008 14:29:09 +0100
Message-ID: <20080310132909.GA13941@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4186754103154602494=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: I2C Mailing List <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--===============4186754103154602494==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

this patch needs to be applied on top of my patch
'i2c-pca-algo_extensions.diff'.

Bye,

   Wolfram

=3D=3D=3D

Subject: Replace dev_warn with printk in pca-algo
=46rom: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Replace dev_warn as it would be executed before the device is registered.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-pca.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-playground/drivers/i2c/algos/i2c-algo-pca.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-playground.orig/drivers/i2c/algos/i2c-algo-pca.c	2008-03-10 14:10=
:59.000000000 +0100
+++ linux-playground/drivers/i2c/algos/i2c-algo-pca.c	2008-03-10 14:15:36.0=
00000000 +0100
@@ -337,7 +337,9 @@
 	struct i2c_algo_pca_data *pca_data =3D adap->algo_data;
=20
 	if (pca_data->i2c_clock > 7) {
-		dev_warn(&adap->dev, "Invalid I2C clock speed selected. Trying default.\=
n");
+		printk(KERN_WARNING "%s: Invalid I2C clock speed selected. Trying defaul=
t.\n",
+			adap->name);
 		pca_data->i2c_clock =3D I2C_PCA_CON_59kHz;
 	}
=20

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH1TelD27XaX1/VRsRAunCAKDJTV0SqCkfWI1PpYEu+QOeyyFvRwCglPA+
qU7+4xTlwQZ1g1KyIwDERD8=
=GYT6
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--


--===============4186754103154602494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============4186754103154602494==--
