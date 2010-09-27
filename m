From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] MIPS: I2C: Return -ETIMEDOUT in octeon_i2c_wait() on
 timeout
Date: Mon, 27 Sep 2010 13:02:48 +0200
Message-ID: <20100927110248.GF2664@pengutronix.de>
References: <1285584916-21317-1-git-send-email-walle@corscience.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pql/uPZNXIm1JCle"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1285584916-21317-1-git-send-email-walle-pDveNdigDaDu9UdzE1sIFA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bernhard Walle <walle-pDveNdigDaDu9UdzE1sIFA@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, rade.bozic.ext-OYasijW0DpE@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Pql/uPZNXIm1JCle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 27, 2010 at 12:55:16PM +0200, Bernhard Walle wrote:
> It doesn't make sense to set result to -ETIMEDOUT but return 0 (success)
> afterwards. Since there's code in octeon_i2c_start() to handle the
> error, it should be called.
>=20
> Signed-off-by: Bernhard Walle <walle-pDveNdigDaDu9UdzE1sIFA@public.gmane.org>

Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

but next time you should cc Ben Dooks to pick it up (i2c for embedded).

> ---
>  drivers/i2c/busses/i2c-octeon.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-oct=
eon.c
> index 0e9f85d..56dbe54 100644
> --- a/drivers/i2c/busses/i2c-octeon.c
> +++ b/drivers/i2c/busses/i2c-octeon.c
> @@ -218,7 +218,7 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
>  		return result;
>  	} else if (result =3D=3D 0) {
>  		dev_dbg(i2c->dev, "%s: timeout\n", __func__);
> -		result =3D -ETIMEDOUT;
> +		return -ETIMEDOUT;
>  	}
> =20
>  	return 0;
> --=20
> 1.7.0.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Pql/uPZNXIm1JCle
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkygedgACgkQD27XaX1/VRvwhQCfdKq1+ZaqD0cjLiSUVp/Ub3ze
nokAnRjOVSrndD/pL60bK0Lh430LDEHt
=oBIc
-----END PGP SIGNATURE-----

--Pql/uPZNXIm1JCle--
