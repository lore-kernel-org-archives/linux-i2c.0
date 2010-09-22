From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] fix i2c_pca_pf_waitforcompletion() return value
Date: Wed, 22 Sep 2010 11:04:41 +0200
Message-ID: <20100922090441.GB2693@pengutronix.de>
References: <4C9725F8.1080200@visionsystems.de>
 <20100921054150.GA29281@pengutronix.de>
 <4C98BA51.3000209@visionsystems.de>
 <4C99C479.7040902@visionsystems.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4C99C479.7040902-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegor_sub1-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Yegor,

looks good in general. Just a few whitespace issues. When you fixed them
you can send a proper patch with the renamed patch description and my

Reviewed-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>


On Wed, Sep 22, 2010 at 10:55:21AM +0200, Yegor Yefremov wrote:
> Index: b/drivers/i2c/busses/i2c-pca-platform.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/i2c/busses/i2c-pca-platform.c	2010-09-22 09:31:12.000000000=
 +0200
> +++ b/drivers/i2c/busses/i2c-pca-platform.c	2010-09-22 10:47:13.000000000=
 +0200
> @@ -80,8 +80,8 @@
>  static int i2c_pca_pf_waitforcompletion(void *pd)
>  {
>  	struct i2c_pca_pf_data *i2c =3D pd;
> -	long ret =3D ~0;
>  	unsigned long timeout;
> +	long ret;
> =20
>  	if (i2c->irq) {
>  		ret =3D wait_event_timeout(i2c->wait,
> @@ -90,10 +90,13 @@
>  	} else {
>  		/* Do polling */
>  		timeout =3D jiffies + i2c->adap.timeout;
> -		while (((i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
> -				& I2C_PCA_CON_SI) =3D=3D 0)
> -				&& (ret =3D time_before(jiffies, timeout)))
> +		do {
> +			ret =3D time_before(jiffies, timeout);
> +			if (i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
> +					& I2C_PCA_CON_SI)

Add one or two tabs to the above line. I missed that, too. It looks
strange if this line is on the same indentation level as the 'break'
below.

> +				break;
>  			udelay(100);
> +		} while (ret);
>  	}
> =20
>  	return ret > 0;
> Index: b/drivers/i2c/busses/i2c-pca-isa.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/i2c/busses/i2c-pca-isa.c	2010-08-27 01:47:12.000000000 +0200
> +++ b/drivers/i2c/busses/i2c-pca-isa.c	2010-09-22 10:47:10.000000000 +0200
> @@ -71,8 +71,8 @@
> =20
>  static int pca_isa_waitforcompletion(void *pd)
>  {
> -	long ret =3D ~0;
>  	unsigned long timeout;
> +	long ret;
> =20
>  	if (irq > -1) {
>  		ret =3D wait_event_timeout(pca_wait,
> @@ -81,11 +81,15 @@
>  	} else {
>  		/* Do polling */
>  		timeout =3D jiffies + pca_isa_ops.timeout;
> -		while (((pca_isa_readbyte(pd, I2C_PCA_CON)
> -				& I2C_PCA_CON_SI) =3D=3D 0)
> -				&& (ret =3D time_before(jiffies, timeout)))
> +		do {
> +			ret =3D time_before(jiffies, timeout);
> +			if (pca_isa_readbyte(pd, I2C_PCA_CON)
> +				& I2C_PCA_CON_SI)

ditto.

> +				break;
>  			udelay(100);
> +		}while(ret);

Missing space.

>  	}
> +
>  	return ret > 0;
>  }
> =20
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyZxqkACgkQD27XaX1/VRuaugCbB8VGrWgb9z76n1TFnCcggIUR
dJUAoJBiGgNtWxNHG1w2M9E0j/4Hk7/v
=7fvj
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
