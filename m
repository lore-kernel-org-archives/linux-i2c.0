From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/3] Blackfin I2C/TWI Driver: make sure we don't end up
	with a CLKDIV=0
Date: Wed, 27 May 2009 09:05:42 +0200
Message-ID: <20090527070542.GA3085@pengutronix.de>
References: <1243405210-26227-1-git-send-email-vapier@gentoo.org> <1243405210-26227-2-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1243405210-26227-2-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2009 at 02:20:08AM -0400, Mike Frysinger wrote:
> From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>=20
> Make sure we don't end up with an invalid CLKDIV=3D0 in case someone
> specifies 20kHz SCL or less (5 * 1024 / 20 =3D 0x100).
>=20
> Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig        |    2 +-
>  drivers/i2c/busses/i2c-bfin-twi.c |   11 ++++++++---
>  2 files changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index f1c6ca7..c8460fa 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -298,7 +298,7 @@ config I2C_BLACKFIN_TWI
>  config I2C_BLACKFIN_TWI_CLK_KHZ
>  	int "Blackfin TWI I2C clock (kHz)"
>  	depends on I2C_BLACKFIN_TWI
> -	range 10 400
> +	range 21 400
>  	default 50
>  	help
>  	  The unit of the TWI clock is kHz.
> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-b=
fin-twi.c
> index fc548b3..3ab1f66 100644
> --- a/drivers/i2c/busses/i2c-bfin-twi.c
> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
> @@ -614,6 +614,7 @@ static int i2c_bfin_twi_probe(struct platform_device =
*pdev)
>  	struct i2c_adapter *p_adap;
>  	struct resource *res;
>  	int rc;
> +	unsigned int clkhilow;
> =20
>  	iface =3D kzalloc(sizeof(struct bfin_twi_iface), GFP_KERNEL);
>  	if (!iface) {
> @@ -675,10 +676,14 @@ static int i2c_bfin_twi_probe(struct platform_devic=
e *pdev)
>  	/* Set TWI internal clock as 10MHz */
>  	write_CONTROL(iface, ((get_sclk() / 1024 / 1024 + 5) / 10) & 0x7F);
> =20
> +	/*
> +	 * We will not end up with a CLKDIV=3D0 cause no one will specifies

specify

> +	 * 20kHz SCL or less in Kconfig now. (5 * 1024 / 20 =3D 0x100)
> +	 */
> +	clkhilow =3D 5 * 1024 / CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ;
> +
>  	/* Set Twi interface clock as specified */
> -	write_CLKDIV(iface, ((5*1024 / CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ)
> -			<< 8) | ((5*1024 / CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ)
> -			& 0xFF));
> +	write_CLKDIV(iface, (clkhilow << 8) | clkhilow);
> =20
>  	/* Enable TWI */
>  	write_CONTROL(iface, read_CONTROL(iface) | TWI_ENA);
> --=20
> 1.6.3.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoc5kYACgkQD27XaX1/VRtM9wCfeRJbp+N31tB+KgfMM4f42Oxv
j+IAoI3Fimbu3wLLE3KU+UlBEz8cB+lf
=kN1j
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
