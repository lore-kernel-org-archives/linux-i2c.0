From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c: s3c2410: Add fix for i2c suspend/resume
Date: Mon, 19 Nov 2012 10:23:16 +0100
Message-ID: <20121119092316.GD7775@pengutronix.de>
References: <1353315626-31194-1-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1353315626-31194-1-git-send-email-a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 19, 2012 at 02:30:26PM +0530, Abhilash Kesavan wrote:
> The I2C driver makes a gpio_request during initialization. This request
> happens again on resume and fails due to the earlier successful request.
> Re-factor the code to only initialize the gpios during probe.
>=20
> Errors on resume without this:
> [   16.020000] s3c-i2c s3c2440-i2c.0: gpio [42] request failed
> [   16.020000] s3c-i2c s3c2440-i2c.1: gpio [44] request failed
> [   16.020000] s3c-i2c s3c2440-i2c.2: gpio [6] request failed
>=20
> Signed-off-by: Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
> Changes from v1:
> Refactor code to initialize gpios only during probe
>=20
>  drivers/i2c/busses/i2c-s3c2410.c |   26 +++++++++++++++++++-------
>  1 files changed, 19 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3=
c2410.c
> index 081e261..0ca321b 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -856,6 +856,7 @@ static int s3c24xx_i2c_parse_dt_gpio(struct s3c24xx_i=
2c *i2c)
>  			dev_err(i2c->dev, "invalid gpio[%d]: %d\n", idx, gpio);
>  			goto free_gpio;
>  		}
> +		i2c->gpios[idx] =3D gpio;

Without this line, gpios won't be freed at all, right? This should be a
separate patch then, since it fixes a seperate issue.

> =20
>  		ret =3D gpio_request(gpio, "i2c-bus");
>  		if (ret) {
> @@ -892,6 +893,18 @@ static void s3c24xx_i2c_dt_gpio_free(struct s3c24xx_=
i2c *i2c)
>  }
>  #endif
> =20
> +static int s3c24xx_i2c_cfg_gpio(struct s3c24xx_i2c *i2c)
> +{
> +	struct s3c2410_platform_i2c *pdata =3D i2c->pdata;
> +
> +	if (pdata->cfg_gpio)
> +		pdata->cfg_gpio(to_platform_device(i2c->dev));
> +	else if (IS_ERR(i2c->pctrl) && s3c24xx_i2c_parse_dt_gpio(i2c))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  /* s3c24xx_i2c_init
>   *
>   * initialise the controller, set the IO lines and frequency
> @@ -907,13 +920,6 @@ static int s3c24xx_i2c_init(struct s3c24xx_i2c *i2c)
> =20
>  	pdata =3D i2c->pdata;
> =20
> -	/* inititalise the gpio */
> -
> -	if (pdata->cfg_gpio)
> -		pdata->cfg_gpio(to_platform_device(i2c->dev));
> -	else if (IS_ERR(i2c->pctrl) && s3c24xx_i2c_parse_dt_gpio(i2c))
> -		return -EINVAL;
> -
>  	/* write slave address */
> =20
>  	writeb(pdata->slave_addr, i2c->regs + S3C2410_IICADD);
> @@ -1054,6 +1060,12 @@ static int s3c24xx_i2c_probe(struct platform_devic=
e *pdev)
> =20
>  	i2c->pctrl =3D devm_pinctrl_get_select_default(i2c->dev);
> =20
> +	/* inititalise the i2c gpio lines */
> +
> +	ret =3D s3c24xx_i2c_cfg_gpio(i2c);
> +	if (ret !=3D 0)
> +		goto err_clk;
> +

I don't think the seperate function is needed here, just copy the code bloc=
k?

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCp+oQACgkQD27XaX1/VRsS1gCdFk/I0KWxC0wzS2j0AVvD6kkB
C/EAoLmM6VYqiH+ctwAcgmP8KJn72qes
=z0WJ
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--
