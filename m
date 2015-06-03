From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v4 5/6] i2c: at91: print hardware version
Date: Thu, 4 Jun 2015 00:19:22 +0900
Message-ID: <20150603151921.GA2873@katana>
References: <cover.1433321260.git.cyrille.pitchen@atmel.com>
 <03bf4d8906d12a87fee7238764074bc5687972be.1433321260.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <03bf4d8906d12a87fee7238764074bc5687972be.1433321260.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2015 at 11:04:26AM +0200, Cyrille Pitchen wrote:
> The probe() function now prints the hardware version of the I2C
> controller.
>=20
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Kernel has already very much printout, so I don't see the gain in adding
another one. At least, combine it with the other printout we have
already, but I wonder what new information will be in here? We should
know from the compatible binding which version we serve? Is it really
needed? Helpful for the user?

> ---
>  drivers/i2c/busses/i2c-at91.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 67b4f15..cbe6684 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -85,6 +85,8 @@
>  #define	AT91_TWI_ACR_DATAL(len)	((len) & 0xff)
>  #define	AT91_TWI_ACR_DIR	BIT(8)
> =20
> +#define	AT91_TWI_VER		0x00fc	/* Version Register */
> +
>  struct at91_twi_pdata {
>  	unsigned clk_max_div;
>  	unsigned clk_offset;
> @@ -872,6 +874,8 @@ static int at91_twi_probe(struct platform_device *pde=
v)
>  			return rc;
>  	}
> =20
> +	dev_info(dev->dev, "version: %#x\n", at91_twi_read(dev, AT91_TWI_VER));
> +
>  	rc =3D of_property_read_u32(dev->dev->of_node, "clock-frequency",
>  			&bus_clk_rate);
>  	if (rc)
> --=20
> 1.8.2.2
>=20

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbxr5AAoJEBQN5MwUoCm22jcP/0fgCYhcPxYtBTeCp6WNyNCx
vIkcAYktIdkpHPNWQI6BPMaeI0S0VVV+03NTQMcvILyLx5mnBSi3tqHolrovkoCd
CH9Ws6LzZdKpC78y8ghkoTB95l0pboqP2U+k3jetmD5YmGPx3CSIY5Wv7LfSYpQ2
6092mKb0zMXpLUR4ZQSCIcie+mZm2jBMf9nXFYu2mHdVGQRkiN8tOZ6S5MWhmckU
/9IjtZs24wnVIVB8KZ2x5DemI+18AzQnmRfgVnO0n1a/pRndYZrLcipkjMlntus6
0i/MIMOnrzv1ukFgCYoab7RYJ8dO1gqyKw3HROtp4d+J3FByokz6nXH/whV3h0zf
3GgzrEvhAOytvDFa/Kh1+r7yAOLIZTZObHhvVpWg5py7R6JYV4T31tGoe+jKLGTH
YD6aKxfcHhLXRrWpQBn5aEcGiZL38zYcrPBooAsDGy6ubSwS8zstAp0oGVPfhL0l
gV3CqOV6olc0zkCiBr1vpRKxp5Zo1zixCy14PNDm/QfO9Cho0Vlh+EmiuLkD6PRN
EJs5pjdKELn0ZKM99gbP0wD4iY06JBUZA2l3viLEWh29+VprvGD/LjfOLmJQoSOj
ZvhScyQOLLADljM/Y8146dZixIEaLNd+OiipmmB7257qkgsFBMj9k/xqfq5XmLkF
2tJcdgM/yvGV0m6H/alM
=Xtte
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
