From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-pxa: prepare clock before use
Date: Sat, 15 Jun 2013 16:23:27 +0200
Message-ID: <20130615142327.GC2923@katana>
References: <20130613192457.51006FAACE@dev.laptop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130613192457.51006FAACE-2+9YHz4BXxlLDiiyqF6/jw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2013 at 03:24:57PM -0400, Daniel Drake wrote:
> On OLPC XO-1.75 (MMP2), a WARN_ON() was occurring during boot
> since the clock being enabled by i2c-pxa had not been prepared.
>=20
> Use clk_prepare_enable() to ensure that the prepare operation
> has taken place.
>=20
> Signed-off-by: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>

The other half of the pair is missing.

> ---
>  drivers/i2c/busses/i2c-pxa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index ea6d45d..ef307ea 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1160,7 +1160,7 @@ static int i2c_pxa_probe(struct platform_device *de=
v)
>  		i2c->adap.class =3D plat->class;
>  	}
> =20
> -	clk_enable(i2c->clk);
> +	clk_prepare_enable(i2c->clk);
> =20
>  	if (i2c->use_pio) {
>  		i2c->adap.algo =3D &i2c_pxa_pio_algorithm;
> --=20
> 1.8.1.4
>=20

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRvHjfAAoJEBQN5MwUoCm2rPgP/ibnRgLa+sPqFyXFNJpPHOcu
ZYcMf5HRRJ5aDMsAWln0tZODLNJwMxVLltz/cuoOl34Ae7xkWX5iVWT6/RPWFyLg
9nFO1thwjuWpPR8gD3oxfW0ZGhR977r6cH3kIsIRfY6Nd6cpIBhvcEi9jyz0IPJN
YbrUM1YJy+/Mw7fMIeCgKHh9H6HzWYeGmZJpHXihhO1Fxe3ZEH9hTg2Kaxof88Xv
gYPz7kRK9vQ8mz70+l3ZPyvkJqQkBaFun3EdB0jmH/AdjD+L1nFS2r6BBPqV9pKW
oVIHy3ba82k4f37KBgr/qymDdI6Fw7Hb4Q8eQvm1ZXvug9NmzEXmwXDWsu7b6d2v
esmwX2i9J4O6S/Dccs2mWiiUiMpPyhkzRs4zytOq2qcMr5OPCXVWT6cH0Rinijor
dlCk2BDr0ynyU1VkMhxIG8ZTtAnT7q0iWZthg2nEOYAitylDkFZUeqvWyqswScOE
0Xy62xgVUtOdmDeNBvUBbYVhWr2JwX4v2Yi+zyroTYsPNjGfFKoCS1vZL22Sexdm
FnYCiC4fQ1fWIEWry/ZWETeb+W5nW7/Jm8qWadbzGM9bM+SnRomxHrAs5TCM6s+j
7RKUDQADN7ILopGi9+RhQ2QDT+2PK1i8ngTTece+6WKtIMSok/RKIieoYMJAhTsy
uei1W1qiAQYxX0+1ah+k
=uBZ3
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
