From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-ocores: Adapt for device tree
Date: Wed, 24 Nov 2010 15:58:43 +0100
Message-ID: <20101124145843.GD6812@pengutronix.de>
References: <1290607789-8996-1-git-send-email-jonas@southpole.se>
 <1290607789-8996-2-git-send-email-jonas@southpole.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1290607789-8996-2-git-send-email-jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

quick review (hopefully not too quick)...

On Wed, Nov 24, 2010 at 03:09:48PM +0100, Jonas Bonn wrote:
> This patch adapts the i2c-ocores driver for being defined and configured =
via
> a device tree description.
>=20
> The device tree bits need to be protected by CONFIG_OF guards as this is
> still an optional feature.
>=20
> Signed-off-by: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-ocores.c |   63 +++++++++++++++++++++++++++++++++=
+-----
>  1 files changed, 55 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-oco=
res.c
> index 0070371..86a536c 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -210,6 +210,31 @@ static struct i2c_adapter ocores_adapter =3D {
>  	.algo		=3D &ocores_algorithm,
>  };
> =20
> +#ifdef CONFIG_OF
> +static int ocores_i2c_of_probe(struct platform_device* pdev,
> +				struct ocores_i2c* i2c)
> +{
> +	int* val;
> +
> +	val =3D (int*) of_get_property(pdev->dev.of_node, "regstep", NULL);
> +	if (!val) {
> +		dev_err(&pdev->dev, "Missing required paramter 'regstep'");
> +		return -ENODEV;
> +	}

New properties need to be documented (e.g. like here=B9). What is regstep?

=B9 http://lists.ozlabs.org/pipermail/devicetree-discuss/2010-November/0035=
69.html

> +
> +	i2c->regstep =3D *val;
> +	val =3D (int*) of_get_property(pdev->dev.of_node, "clock_khz", NULL);
> +	if (!val) {
> +		dev_err(&pdev->dev, "Missing required paramter 'clock_khz'");
> +		return -ENODEV;
> +	}

Other i2c-drivers use "clock-frequency", you should as well.

> +	i2c->clock_khz =3D *val;
> +
> +	return 0;
> +}
> +#else
> +#define ocores_i2c_of_probe(pdev,i2c) -ENODEV
> +#endif
> =20
>  static int __devinit ocores_i2c_probe(struct platform_device *pdev)
>  {
> @@ -227,10 +252,6 @@ static int __devinit ocores_i2c_probe(struct platfor=
m_device *pdev)
>  	if (!res2)
>  		return -ENODEV;
> =20
> -	pdata =3D (struct ocores_i2c_platform_data*) pdev->dev.platform_data;
> -	if (!pdata)
> -		return -ENODEV;
> -
>  	i2c =3D kzalloc(sizeof(*i2c), GFP_KERNEL);
>  	if (!i2c)
>  		return -ENOMEM;
> @@ -249,8 +270,16 @@ static int __devinit ocores_i2c_probe(struct platfor=
m_device *pdev)
>  		goto map_failed;
>  	}
> =20
> -	i2c->regstep =3D pdata->regstep;
> -	i2c->clock_khz =3D pdata->clock_khz;
> +	pdata =3D (struct ocores_i2c_platform_data*) pdev->dev.platform_data;

The cast can be dropped.

> +	if (pdata) {
> +		i2c->regstep =3D pdata->regstep;
> +		i2c->clock_khz =3D pdata->clock_khz;
> +	} else {
> +		ret =3D ocores_i2c_of_probe(pdev, i2c);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ocores_init(i2c);
> =20
>  	init_waitqueue_head(&i2c->wait);
> @@ -265,6 +294,9 @@ static int __devinit ocores_i2c_probe(struct platform=
_device *pdev)
>  	i2c->adap =3D ocores_adapter;
>  	i2c_set_adapdata(&i2c->adap, i2c);
>  	i2c->adap.dev.parent =3D &pdev->dev;
> +#ifdef CONFIG_OF
> +	i2c->adap.dev.of_node =3D pdev->dev.of_node;
> +#endif

No need for the ifdef here.

> =20
>  	/* add i2c adapter to i2c tree */
>  	ret =3D i2c_add_adapter(&i2c->adap);
> @@ -274,8 +306,10 @@ static int __devinit ocores_i2c_probe(struct platfor=
m_device *pdev)
>  	}
> =20
>  	/* add in known devices to the bus */
> -	for (i =3D 0; i < pdata->num_devices; i++)
> -		i2c_new_device(&i2c->adap, pdata->devices + i);
> +	if (pdata) {
> +		for (i =3D 0; i < pdata->num_devices; i++)
> +			i2c_new_device(&i2c->adap, pdata->devices + i);
> +	}
> =20
>  	return 0;
> =20
> @@ -344,6 +378,16 @@ static int ocores_i2c_resume(struct platform_device =
*pdev)
>  #define ocores_i2c_resume	NULL
>  #endif
> =20
> +#ifdef CONFIG_OF
> +static struct of_device_id ocores_i2c_match[] =3D {
> +        {
> +                .compatible =3D "opencores,i2c-ocores",
> +        },
> +        {},
> +};
> +MODULE_DEVICE_TABLE(of, ocores_i2c_match);
> +#endif

ditto

> +
>  /* work with hotplug and coldplug */
>  MODULE_ALIAS("platform:ocores-i2c");
> =20
> @@ -355,6 +399,9 @@ static struct platform_driver ocores_i2c_driver =3D {
>  	.driver  =3D {
>  		.owner =3D THIS_MODULE,
>  		.name =3D "ocores-i2c",
> +#ifdef CONFIG_OF
> +                .of_match_table =3D ocores_i2c_match,
> +#endif

ditto

>  	},
>  };
> =20
> --=20
> 1.7.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkztKCMACgkQD27XaX1/VRu3pACgoWzCsQdi0t2pisN/W3xKUp7x
vpgAoLGUsMLy+KK8FnEqo2lwFI+JqNgZ
=HqK8
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--
