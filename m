From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] fix i2c_pca_pf_waitforcompletion() return value
Date: Tue, 21 Sep 2010 23:04:48 +0200
Message-ID: <20100921210448.GA14796@pengutronix.de>
References: <4C9877C3.30106@visionsystems.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4C9877C3.30106-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegor_sub1-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Yegor,

On Tue, Sep 21, 2010 at 11:15:47AM +0200, Yegor Yefremov wrote:
> ret is still -1, if during the polling read_byte() returns at once
> with I2C_PCA_CON_SI set. So ret > 0 would lead=20
> i2c_pca_pf_waitforcompletion() to return 0, in spite of
> the proper behavior.=20
>=20
> Solution: get rid of ret and make immediate return where possible.
>=20
> Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>=20
> Index: b/drivers/i2c/busses/i2c-pca-platform.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/i2c/busses/i2c-pca-platform.c	2010-09-21 10:53:46.000000000=
 +0200
> +++ b/drivers/i2c/busses/i2c-pca-platform.c	2010-09-21 10:59:18.000000000=
 +0200
> @@ -80,23 +80,26 @@
>  static int i2c_pca_pf_waitforcompletion(void *pd)
>  {
>  	struct i2c_pca_pf_data *i2c =3D pd;
> -	long ret =3D ~0;
>  	unsigned long timeout;
> =20
>  	if (i2c->irq) {
> -		ret =3D wait_event_timeout(i2c->wait,
> +		return wait_event_timeout(i2c->wait,
>  			i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
>  			& I2C_PCA_CON_SI, i2c->adap.timeout);
>  	} else {
>  		/* Do polling */
>  		timeout =3D jiffies + i2c->adap.timeout;
> -		while (((i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
> -				& I2C_PCA_CON_SI) =3D=3D 0)
> -				&& (ret =3D time_before(jiffies, timeout)))
> -			udelay(100);
> +		while (!(i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
> +				& I2C_PCA_CON_SI))
> +		{
> +			if(time_before(jiffies, timeout))
> +				udelay(100);
> +			else
> +				return 0;
> +		}
>  	}
> =20
> -	return ret > 0;
> +	return ~0;
>  }
> =20
>  static void i2c_pca_pf_dummyreset(void *pd)

Hmm, I think I'd prefer a centralized exit point. What about this? I think =
it
might be easier to read. Only compile tested, though. The final patch needs=
 to
be applied to the isa version, too. BTW, good debugging there, fixing this =
old
issue you reported. Thanks a lot!

Regards,

   Wolfram

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c=
-pca-platform.c
index ef5c784..a13aecb 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -80,8 +80,8 @@ static void i2c_pca_pf_writebyte32(void *pd, int reg, int=
 val)
 static int i2c_pca_pf_waitforcompletion(void *pd)
 {
 	struct i2c_pca_pf_data *i2c =3D pd;
-	long ret =3D ~0;
 	unsigned long timeout;
+	long ret;
=20
 	if (i2c->irq) {
 		ret =3D wait_event_timeout(i2c->wait,
@@ -90,10 +90,13 @@ static int i2c_pca_pf_waitforcompletion(void *pd)
 	} else {
 		/* Do polling */
 		timeout =3D jiffies + i2c->adap.timeout;
-		while (((i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
-				& I2C_PCA_CON_SI) =3D=3D 0)
-				&& (ret =3D time_before(jiffies, timeout)))
+		do {
+			ret =3D time_before(jiffies, timeout);
+			if (i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
+				& I2C_PCA_CON_SI)
+				break;
 			udelay(100);
+		} while (ret);
 	}
=20
 	return ret > 0;


--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkyZHfAACgkQD27XaX1/VRsbRACffV4r7Xvvse0kjw6yQ+TKcwyz
sOAAniytNRrn8sfKx+PosTz5xUwm3k4M
=TUWn
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
