From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH V2 1/3] i2c/algo-pca: rework waiting for a free bus
Date: Fri, 27 Feb 2009 09:44:12 +0100
Message-ID: <20090227084412.GA3481@pengutronix.de>
References: <1235492536-31695-1-git-send-email-w.sang@pengutronix.de> <1235492536-31695-2-git-send-email-w.sang@pengutronix.de> <20090226181447.35775a21@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090226181447.35775a21-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Waiting for a free bus now accepts the timeout value in jiffies and does
proper checking using time_before.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---

changes since V1:

* fix user sh7785lcr
* break >80 chars

 arch/sh/boards/board-sh7785lcr.c |    2 +-
 drivers/i2c/algos/i2c-algo-pca.c |   19 +++++++++++--------
 drivers/i2c/busses/i2c-pca-isa.c |    2 +-
 include/linux/i2c-pca-platform.h |    2 +-
 4 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/sh/boards/board-sh7785lcr.c b/arch/sh/boards/board-sh7785=
lcr.c
index 38a6496..6258c79 100644
--- a/arch/sh/boards/board-sh7785lcr.c
+++ b/arch/sh/boards/board-sh7785lcr.c
@@ -229,7 +229,7 @@ static struct resource i2c_resources[] =3D {
 static struct i2c_pca9564_pf_platform_data i2c_platform_data =3D {
 	.gpio			=3D 0,
 	.i2c_clock_speed	=3D I2C_PCA_CON_330kHz,
-	.timeout		=3D 100,
+	.timeout		=3D HZ,
 };
=20
 static struct platform_device i2c_device =3D {
diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-=
pca.c
index a8e51bd..9e134fa 100644
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
@@ -186,14 +187,16 @@ static int pca_xfer(struct i2c_adapter *i2c_adap,
 	int numbytes =3D 0;
 	int state;
 	int ret;
-	int timeout =3D i2c_adap->timeout;
+	unsigned long timeout =3D jiffies + i2c_adap->timeout;
=20
-	while ((state =3D pca_status(adap)) !=3D 0xf8 && timeout--) {
-		msleep(10);
-	}
-	if (state !=3D 0xf8) {
-		dev_dbg(&i2c_adap->dev, "bus is not idle. status is %#04x\n", state);
-		return -EAGAIN;
+	while (pca_status(adap) !=3D 0xf8) {
+		if (time_before(jiffies, timeout)) {
+			msleep(10);
+		} else {
+			dev_dbg(&i2c_adap->dev, "bus is not idle. status is "
+				"%#04x\n", state);
+			return -EAGAIN;
+		}
 	}
=20
 	DEB1("{{{ XFER %d messages\n", num);
diff --git a/drivers/i2c/busses/i2c-pca-isa.c b/drivers/i2c/busses/i2c-pca-=
isa.c
index 8835de2..84d035c 100644
--- a/drivers/i2c/busses/i2c-pca-isa.c
+++ b/drivers/i2c/busses/i2c-pca-isa.c
@@ -103,7 +103,7 @@ static struct i2c_adapter pca_isa_ops =3D {
 	.owner          =3D THIS_MODULE,
 	.algo_data	=3D &pca_isa_data,
 	.name		=3D "PCA9564/PCA9665 ISA Adapter",
-	.timeout	=3D 100,
+	.timeout	=3D HZ,
 };
=20
 static int __devinit pca_isa_match(struct device *dev, unsigned int id)
diff --git a/include/linux/i2c-pca-platform.h b/include/linux/i2c-pca-platf=
orm.h
index 3d19187..aba3375 100644
--- a/include/linux/i2c-pca-platform.h
+++ b/include/linux/i2c-pca-platform.h
@@ -6,7 +6,7 @@ struct i2c_pca9564_pf_platform_data {
 				 * not supplied (negative value), but it
 				 * cannot exit some error conditions then */
 	int i2c_clock_speed;	/* values are defined in linux/i2c-algo-pca.h */
-	int timeout;		/* timeout =3D this value * 10us */
+	int timeout;		/* timeout in jiffies */
 };
=20
 #endif /* I2C_PCA9564_PLATFORM_H */

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmnp9wACgkQD27XaX1/VRsTWACeM0PBAnq78GdTub2N2RIihQR7
NuQAn2BgCL9J0amTAL7aVnkPGOAejiTJ
=lOZ+
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
