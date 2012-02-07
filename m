From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 3/3] watchdog: Add Congatec CGEB watchdog driver
Date: Tue, 7 Feb 2012 16:08:56 +0100
Message-ID: <20120207150856.GI2539@pengutronix.de>
References: <1328102793-4313-1-git-send-email-s.hauer@pengutronix.de>
 <1328102793-4313-4-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vs0rQTeTompTJjtd"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1328102793-4313-4-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--vs0rQTeTompTJjtd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sascha,

> +struct cgeb_watchdog_stage {
> +	unsigned long timeout;
> +	unsigned long event;
> +};
> +
> +struct cgeb_watchdog_config {
> +	unsigned long size;
> +	unsigned long timeout; /* not used in staged mode */
> +	unsigned long delay;
> +	unsigned long mode;
> +	/* optional parameters for staged watchdog */
> +	unsigned long op_mode;
> +	unsigned long stage_count;
> +	struct cgeb_watchdog_stage stages[CGOS_WDOG_EVENT_MAX_STAGES];
> +};
> +

There is some unused stuff in here.

> +struct cgeb_watchdog_priv {
> +	struct cgeb_board_data	*board;
> +	struct watchdog_device	wdd;
> +	unsigned int		timeout_s;

Is wdd->timeout not sufficent?

> +	int unit;
> +};
> +
> +static int cgeb_watchdog_set_timeout(struct watchdog_device *wdd,
> +		unsigned int timeout_s)
> +{
> +	struct cgeb_watchdog_priv *priv =3D watchdog_get_drvdata(wdd);
> +
> +	if (!timeout_s)
> +		return -EINVAL;

Is this possible? You have min_timeout =3D 1.

> +static int __devinit cgeb_watchdog_probe(struct platform_device *pdev)
> +{
> +	struct cgeb_watchdog_priv *priv;
> +	struct cgeb_pdata *pdata =3D pdev->dev.platform_data;
> +	int ret;
> +
> +	dev_info(&pdev->dev, "registering\n");

"registered" on success would be more useful?

> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->wdd.ops =3D &cgeb_watchdog_ops;
> +	priv->wdd.info =3D &cgeb_wdd_info;
> +	priv->wdd.min_timeout =3D 1;
> +	priv->wdd.max_timeout =3D 3600;
> +	priv->board =3D pdata->board;
> +	priv->unit =3D pdata->unit;
> +
> +	watchdog_set_drvdata(&priv->wdd, priv);
> +	platform_set_drvdata(pdev, priv);
> +
> +	ret =3D watchdog_register_device(&priv->wdd);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

return watchdog_register_device();

> +}
> +
> +static int __devexit cgeb_watchdog_remove(struct platform_device *pdev)
> +{
> +	struct cgeb_watchdog_priv *priv =3D platform_get_drvdata(pdev);
> +
> +	watchdog_unregister_device(&priv->wdd);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver cgeb_watchdog_driver =3D {
> +	.probe		=3D cgeb_watchdog_probe,
> +	.remove		=3D __exit_p(cgeb_watchdog_remove),

__devexit_p

> +	.driver	=3D {
> +		.name	=3D "cgeb-watchdog",
> +		.owner	=3D THIS_MODULE,
> +	},
> +};
> +
> +static int __init cgeb_watchdog_driver_init(void)
> +{
> +	return platform_driver_register(&cgeb_watchdog_driver);
> +}
> +
> +static void __exit cgeb_watchdog_driver_exit(void)
> +{
> +	platform_driver_unregister(&cgeb_watchdog_driver);
> +}
> +
> +module_init(cgeb_watchdog_driver_init);
> +module_exit(cgeb_watchdog_driver_exit);

module_platform_driver()

> +
> +MODULE_AUTHOR("Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
> +MODULE_DESCRIPTION("cgeb watchdog driver");
> +MODULE_LICENSE("GPL");

GPL v2 according to header

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--vs0rQTeTompTJjtd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk8xPogACgkQD27XaX1/VRsXQQCdF4OJxzpAYjWiHv3RcocNX7JT
rsMAoKeAUDGaUTyqbj7D9WlbxFs46y69
=1vAS
-----END PGP SIGNATURE-----

--vs0rQTeTompTJjtd--
