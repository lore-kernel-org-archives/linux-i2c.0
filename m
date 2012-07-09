From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: stu300: use devm allocation
Date: Mon, 9 Jul 2012 14:20:56 +0200
Message-ID: <20120709122056.GI1296@pengutronix.de>
References: <1339522417-606-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7SrMUQONj8Rl9QNG"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1339522417-606-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--7SrMUQONj8Rl9QNG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2012 at 07:33:37PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>=20
> Allocate memory for device state using devm_kzalloc() to
> simplify accounting.
>=20
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Please use devm_* for resource allocation, too, then...

> ---
>  drivers/i2c/busses/i2c-stu300.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu=
300.c
> index 79b7851..e5c10c5 100644
> --- a/drivers/i2c/busses/i2c-stu300.c
> +++ b/drivers/i2c/busses/i2c-stu300.c
> @@ -873,7 +873,7 @@ stu300_probe(struct platform_device *pdev)
>  	int ret =3D 0;
>  	char clk_name[] =3D "I2C0";
> =20
> -	dev =3D kzalloc(sizeof(struct stu300_dev), GFP_KERNEL);
> +	dev =3D devm_kzalloc(&pdev->dev, sizeof(struct stu300_dev), GFP_KERNEL);
>  	if (!dev) {
>  		dev_err(&pdev->dev, "could not allocate device struct\n");
>  		ret =3D -ENOMEM;
> @@ -971,7 +971,6 @@ stu300_probe(struct platform_device *pdev)
>   err_no_resource:
>  	clk_put(dev->clk);
>   err_no_clk:
> -	kfree(dev);
>   err_no_devmem:
>  	dev_err(&pdev->dev, "failed to add " NAME " adapter: %d\n",
>  		pdev->id);
> @@ -1020,7 +1019,6 @@ stu300_remove(struct platform_device *pdev)
>  	clk_unprepare(dev->clk);
>  	clk_put(dev->clk);
>  	platform_set_drvdata(pdev, NULL);
> -	kfree(dev);
>  	return 0;
>  }
> =20
> --=20
> 1.7.9.2
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7SrMUQONj8Rl9QNG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/6zKgACgkQD27XaX1/VRuoYACfUAGYTGpmoiQ29VttuNpgQfT9
U84AoL7UiUvL2UeDMlHYJXtmx7pmLkm9
=AmFt
-----END PGP SIGNATURE-----

--7SrMUQONj8Rl9QNG--
