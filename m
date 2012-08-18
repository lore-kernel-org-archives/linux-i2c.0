From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: tegra: Fix ifdefs for suspend mode
Date: Sat, 18 Aug 2012 09:07:32 +0200
Message-ID: <20120818070732.GA24639@pengutronix.de>
References: <1343655187-18282-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1343655187-18282-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2012 at 07:03:07PM +0530, Laxman Dewangan wrote:
> CONFIG_PM covers runtime only PM.

I am a bit confused by this description. CONFIG_PM_RUNTIME covers
runtime PM, no?

>=20
> Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> This patch will remove the compilation warning if CONFIG_PM_SLEEP
> is not enabled.

Maybe it would help to see the warning?

>=20
>  drivers/i2c/busses/i2c-tegra.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegr=
a.c
> index 66eb53f..9a08c57 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -712,7 +712,7 @@ static int __devexit tegra_i2c_remove(struct platform=
_device *pdev)
>  	return 0;
>  }
> =20
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  static int tegra_i2c_suspend(struct device *dev)
>  {
>  	struct tegra_i2c_dev *i2c_dev =3D dev_get_drvdata(dev);
> --=20
> 1.7.1.1
>=20

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlAvPzQACgkQD27XaX1/VRu2zQCeJ6W1ndhyQmQGfiWc0cleh/37
b6sAoKcmqUnYeXQNdEd2j1ivUkcP4NHI
=uVkj
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
