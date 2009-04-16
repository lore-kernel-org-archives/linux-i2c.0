From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] assign a default class to MPC adapter
Date: Thu, 16 Apr 2009 11:20:12 +0200
Message-ID: <20090416092012.GB3052@pengutronix.de>
References: <49E6F4F9.3060705@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <49E6F4F9.3060705-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Delvare, Jean " <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2009 at 11:06:01AM +0200, Michael Lawnick wrote:
> For MPC adapter there is no class assigned as it is done in other
> adapters. This way no new-style client will ever be instantiated. There
> should be at least a default class assignment.

Please have a loot at 618b26d52843c0f85b8eb143cf2695d7f6fd072d
Therefore, NACK.

>=20
> Signed-off-by: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-mpc.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -310,6 +310,7 @@ static const struct i2c_algorithm mpc_algo =3D {
>  static struct i2c_adapter mpc_ops =3D {
>  	.owner =3D THIS_MODULE,
>  	.name =3D "MPC adapter",
> +	.class =3D I2C_CLASS_HWMON,
>  	.algo =3D &mpc_algo,
>  	.timeout =3D 1,
>  };
>=20
> --=20
> Michael Lawnick
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknm+EwACgkQD27XaX1/VRsj5wCeI22r2AKKIu13ROsTHlO23Hcv
UOEAn19Mo6PEDnUYgUtUJAVci96UbFCr
=Z/R+
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
