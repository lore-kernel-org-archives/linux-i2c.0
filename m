From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: getting rid of subsys_initcall usage? (was: Re: [PATCH RESEND] i2c:
 designware: use module_platform_driver)
Date: Wed, 28 Aug 2013 11:57:07 +0200
Message-ID: <20130828095706.GH4086@katana>
References: <1376987548-12366-1-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhtSGe8h3+lMyY1M"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1376987548-12366-1-git-send-email-zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--zhtSGe8h3+lMyY1M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2013 at 04:32:28PM +0800, Zhangfei Gao wrote:
> Instead of use platform_driver_probe, use module_platform_driver
> To support deferred probing
> Also subsys_initcall may too early to auto set pinctl
>=20
> Signed-off-by: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Acked-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>

This patch is tougher than it looks. You need it, because
subsys_initcall may be too early for pinctrl. Other people might be
depending on subsys_initcall to get I2C active before they want to
activate, say, PMICs. So, I fear regressions, since deferred probing
might not be available in the needed places to avoid these regressions.
I am all ears for a nice transition away from subsys_initcall, anyone?

> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c |   14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/bu=
sses/i2c-designware-platdrv.c
> index 4c5fada..36ceebc 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -236,6 +236,7 @@ static SIMPLE_DEV_PM_OPS(dw_i2c_dev_pm_ops, dw_i2c_su=
spend, dw_i2c_resume);
>  MODULE_ALIAS("platform:i2c_designware");
> =20
>  static struct platform_driver dw_i2c_driver =3D {
> +	.probe		=3D dw_i2c_probe,
>  	.remove		=3D dw_i2c_remove,
>  	.driver		=3D {
>  		.name	=3D "i2c_designware",
> @@ -245,18 +246,7 @@ static struct platform_driver dw_i2c_driver =3D {
>  		.pm	=3D &dw_i2c_dev_pm_ops,
>  	},
>  };
> -
> -static int __init dw_i2c_init_driver(void)
> -{
> -	return platform_driver_probe(&dw_i2c_driver, dw_i2c_probe);
> -}
> -subsys_initcall(dw_i2c_init_driver);
> -
> -static void __exit dw_i2c_exit_driver(void)
> -{
> -	platform_driver_unregister(&dw_i2c_driver);
> -}
> -module_exit(dw_i2c_exit_driver);
> +module_platform_driver(dw_i2c_driver);
> =20
>  MODULE_AUTHOR("Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>");
>  MODULE_DESCRIPTION("Synopsys DesignWare I2C bus adapter");
> --=20
> 1.7.9.5
>=20

--zhtSGe8h3+lMyY1M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSHclyAAoJEBQN5MwUoCm214AP/2cRjAti8+6guNiQ6bKhtSNt
8iSXUtgoRYjsjwny7QOtSV1PdRj1Oxu7D7B6GWYtA4PDlWJ8srZ+mOdOwaIt0a/2
OQutLc1AcXKlofK4qWwlV9IpDJ9IjL04wmLxQH9nL4CzQ9LploVLOxmytbBHZD9v
zLynT7cJYIhs8luvRCULuZ6ggxewte7LzxRUKg6BDARMmehikBQhsPmiRKhy4QIK
UQGZtt3uCFOdVQmrUw9oi6/Qjt6o14xq+lx32VW/Y4e6VHlYJSgoXPDQEqoBsfkR
RLmDYa9vPbRkdvj0Kmfel0loDeO/K+J5WFOP0LNDsPxssso7I3CI3RDgNANOsWw7
4ccnhD480NTK7sZ/CuEhH8+yOTHqL4Sz9M/1xPzRo/9kbNM/RMYzN0vzmkoX6LIy
5aEWC1d90xAORACyvLw6PyV8op91UNxQk/KwGdjg3+ZsEyxu+gHNrN0PBxy6di44
l10fW6j9nRWnSmRFe0a1MSIa1ZfTIxZxd2Nr77ZAhwNivnw/9BlEwxUO8erT86sy
0EqsOBS90Dud9SxqWnOD4+x7fc/lEQn/PCnro18gF2QB9QUtS62Jg1g5Gc8ZAgT3
QaWqw43oNh3SPVEjcs+6O0Cl5eT3cb+KTpoSO48QXWFKiYG+ag/BrUZtzMTYF1qe
jERG7ffC1jlFs4C05Qaf
=8lDH
-----END PGP SIGNATURE-----

--zhtSGe8h3+lMyY1M--
