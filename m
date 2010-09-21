From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] fix i2c_pca_pf_waitforcompletion() return value
Date: Tue, 21 Sep 2010 07:41:50 +0200
Message-ID: <20100921054150.GA29281@pengutronix.de>
References: <4C9725F8.1080200@visionsystems.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4C9725F8.1080200-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegor_sub1-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 20, 2010 at 11:14:32AM +0200, Yegor Yefremov wrote:
> ret is still -1, if during the polling read_byte() returns at once
> with I2C_PCA_CON_SI set. So ret > 0 would lead=20
> i2c_pca_pf_waitforcompletion() to return 0, in spite of
> the proper behavior. That's why only ret should be returned.
>=20
> Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

Thanks for reporting. In deed, this needs to be corrected. However, I think=
 we
should clean up the code some more and get rid of the initialization of ret
altogether (and hopefully make it more readable with this). Do you have time
for this, otherwise I'll have a look later.

Regards,

   Wolfram

>=20
> Index: b/drivers/i2c/busses/i2c-pca-platform.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/i2c/busses/i2c-pca-platform.c	2010-08-27 01:47:12.000000000=
 +0200
> +++ b/drivers/i2c/busses/i2c-pca-platform.c	2010-09-20 10:21:05.000000000=
 +0200
> @@ -96,7 +96,7 @@
>  			udelay(100);
>  	}
> =20
> -	return ret > 0;
> +	return ret;
>  }
> =20
>  static void i2c_pca_pf_dummyreset(void *pd)
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkyYRZ4ACgkQD27XaX1/VRtzoACfUJfLjiRws59CWhezqHKIM0YT
IHwAoIltlKW08lxujOhzOehFo7EFaj8j
=6Y+j
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
