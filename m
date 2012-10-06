From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c: nomadik: adopt pinctrl support
Date: Sat, 6 Oct 2012 15:30:06 +0200
Message-ID: <20121006133006.GA25123@pengutronix.de>
References: <1348837151-20820-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1348837151-20820-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anmar Oueja <anmar.oueja-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Patrice Chotard <patrice.chotard-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> +	ret =3D clk_prepare(dev->clk);
> +	if (ret) {
> +		dev_err(&adev->dev, "can't prepare clock\n");
> +		goto err_prep_clk;
> +	}
> +
>  	adap =3D &dev->adap;
>  	adap->dev.parent =3D &adev->dev;
>  	adap->owner	=3D THIS_MODULE;
> @@ -994,6 +1092,8 @@ static int nmk_i2c_probe(struct amba_device *adev, c=
onst struct amba_id *id)
>  	return 0;
> =20
>   err_add_adap:
> +	clk_unprepare(dev->clk);
> + err_prep_clk:

This is unrelated, right? And it is also unneeded because of Ulf
Hansson's patch?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlBwMl4ACgkQD27XaX1/VRvlNwCdHf/QvjZ1CRqXIB29LhzK+wt2
ENUAoKbrf0t9wys7cMW4ChlV6k52y0d5
=lANg
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
