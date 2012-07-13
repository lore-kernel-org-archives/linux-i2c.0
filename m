From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c: stu300: use devm managed resources
Date: Fri, 13 Jul 2012 11:26:57 +0200
Message-ID: <20120713092657.GJ32184@pengutronix.de>
References: <1341864666-29441-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bWEb1MG/o7IKOlQF"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1341864666-29441-1-git-send-email-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--bWEb1MG/o7IKOlQF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2012 at 10:11:06PM +0200, Linus Walleij wrote:
> Allocate memory for device state using devm_kzalloc(), get the
> clock using devm_clk_get(), get the IRQ using devm_request_irq(),
> request and remap memory using devm_request_and_ioremap().
> All to simplify accounting and letting the kernel do the
> garbage-collection.
>=20
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> ChangeLog v1->v2:
> - Use more devm* stuff, at Wolfram's request.
> - Note: based on a clean v3.5-rc6, may need some patch -p1 < patch
>   to apply on the i2c tree, if you want me to rebase it, just tell
>   me where to find the baseline.

Thanks, it is here:

git://git.pengutronix.de/git/wsa/linux.git i2c-embedded/for-next


> ---
>  drivers/i2c/busses/i2c-stu300.c |   75 +++++++++------------------------=
-----
>  1 files changed, 18 insertions(+), 57 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu=
300.c
> index 4d44af1..dc4c518 100644
> --- a/drivers/i2c/busses/i2c-stu300.c
> +++ b/drivers/i2c/busses/i2c-stu300.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2007-2009 ST-Ericsson AB
> + * Copyright (C) 2007-2012 ST-Ericsson AB
>   * License terms: GNU General Public License (GPL) version 2
>   * ST DDC I2C master mode driver, used in e.g. U300 series platforms.
>   * Author: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> @@ -873,64 +873,46 @@ stu300_probe(struct platform_device *pdev)
>  	int ret =3D 0;
>  	char clk_name[] =3D "I2C0";
> =20
> -	dev =3D kzalloc(sizeof(struct stu300_dev), GFP_KERNEL);
> +	dev =3D devm_kzalloc(&pdev->dev, sizeof(struct stu300_dev), GFP_KERNEL);
>  	if (!dev) {
>  		dev_err(&pdev->dev, "could not allocate device struct\n");
> -		ret =3D -ENOMEM;
> -		goto err_no_devmem;
> +		return -ENOMEM;
>  	}
> =20
>  	bus_nr =3D pdev->id;
>  	clk_name[3] +=3D (char)bus_nr;
> -	dev->clk =3D clk_get(&pdev->dev, clk_name);
> +	dev->clk =3D devm_clk_get(&pdev->dev, clk_name);
>  	if (IS_ERR(dev->clk)) {
> -		ret =3D PTR_ERR(dev->clk);
>  		dev_err(&pdev->dev, "could not retrieve i2c bus clock\n");
> -		goto err_no_clk;
> +		return PTR_ERR(dev->clk);
>  	}
> =20
>  	dev->pdev =3D pdev;
> -	platform_set_drvdata(pdev, dev);
> -
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		ret =3D -ENOENT;
> -		goto err_no_resource;
> -	}
> +	if (!res)
> +		return -ENOENT;
> =20
>  	dev->phybase =3D res->start;
>  	dev->physize =3D resource_size(res);

I'd think you can skip those, too?

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--bWEb1MG/o7IKOlQF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk//6eEACgkQD27XaX1/VRtPrACaApQdUBUqvuE6NQtSyY4eX63h
hWkAoJlyLjpcCfKgY2Kg7h6l7OYXZuy7
=9wlr
-----END PGP SIGNATURE-----

--bWEb1MG/o7IKOlQF--
