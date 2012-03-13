From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/5 v3] i2c/gpio: add DT support
Date: Tue, 13 Mar 2012 08:37:48 +0100
Message-ID: <20120313073748.GA7746@pengutronix.de>
References: <1331196635-27203-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1331196635-27203-1-git-send-email-plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2012 at 09:50:31AM +0100, Jean-Christophe PLAGNIOL-VILLARD =
wrote:
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
> Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

Your patch description says "add DT support" but you are doing a bit more.
This should at least be described here.

> ---
> v3:
>=20
> 	update i2c binding (Rob comments)
>=20
> 	Jean can I have a ack to apply it?
>=20
> Best Regards,
> J.
>  .../devicetree/bindings/gpio/gpio_i2c.txt          |   32 +++++++
>  drivers/i2c/busses/i2c-gpio.c                      |   94 ++++++++++++++=
+----
>  2 files changed, 106 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio_i2c.txt
>=20
> diff --git a/Documentation/devicetree/bindings/gpio/gpio_i2c.txt b/Docume=
ntation/devicetree/bindings/gpio/gpio_i2c.txt
> new file mode 100644
> index 0000000..4f8ec94
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio_i2c.txt
> @@ -0,0 +1,32 @@
> +Device-Tree bindings for i2c gpio driver
> +
> +Required properties:
> +	- compatible =3D "i2c-gpio";

I assume people at "devicetree-discuss" have taken care of that, yet I wond=
er
that this breaks the "vendor,product" syntax I know of for compatible entri=
es.

> +	- gpios: sda and scl gpio
> +
> +
> +Optional properties:
> +	- i2c-gpio,sda-open-drain: sda as open drain
> +	- i2c-gpio,scl-open-drain: scl as open drain
> +	- i2c-gpio,scl-output-only: scl as output only
> +	- i2c-gpio,delay-us: delay between GPIO operations (may depend on each =
platform)
> +	- i2c-gpio,timeout-ms: timeout to get data
> +
> +Example nodes:
> +
> +i2c@0 {
> +	compatible =3D "i2c-gpio";
> +	gpios =3D <&pioA 23 0 /* sda */
> +		 &pioA 24 0 /* scl */
> +		>;
> +	i2c-gpio,sda-open-drain;
> +	i2c-gpio,scl-open-drain;
> +	i2c-gpio,delay-us =3D <2>;	/* ~100 kHz */
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +
> +	rv3029c2@56 {
> +		compatible =3D "rv3029c2";
> +		reg =3D <0x56>;
> +	};
> +};
> diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
> index a651779..98ae85b 100644
> --- a/drivers/i2c/busses/i2c-gpio.c
> +++ b/drivers/i2c/busses/i2c-gpio.c
> @@ -14,8 +14,15 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
> +#include <linux/gpio.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_i2c.h>
> =20
> -#include <asm/gpio.h>
> +struct i2c_gpio_private_data {
> +	struct i2c_adapter adap;
> +	struct i2c_algo_bit_data bit_data;
> +	struct i2c_gpio_platform_data pdata;
> +};
> =20
>  /* Toggle SDA by changing the direction of the pin */
>  static void i2c_gpio_setsda_dir(void *data, int state)
> @@ -78,24 +85,62 @@ static int i2c_gpio_getscl(void *data)
>  	return gpio_get_value(pdata->scl_pin);
>  }
> =20
> +static int __devinit of_i2c_gpio_probe(struct device_node *np,
> +			     struct i2c_gpio_platform_data *pdata)
> +{
> +	u32 reg;
> +
> +	if (of_gpio_count(np) < 2)
> +		return -ENODEV;
> +
> +	pdata->sda_pin =3D of_get_gpio(np, 0);
> +	pdata->scl_pin =3D of_get_gpio(np, 1);
> +
> +	if (pdata->sda_pin < 0 || pdata->scl_pin < 0) {

gpio_is_valid()?

> +		pr_err("%s: invalid GPIO pins, sda=3D%d/scl=3D%d\n",
> +		       np->full_name, pdata->sda_pin, pdata->scl_pin);
> +		return -ENODEV;
> +	}
> +
> +	of_property_read_u32(np, "i2c-gpio,delay-us", &pdata->udelay);
> +
> +	if (of_property_read_u32(np, "i2c-gpio,timeout-ms", &reg))
> +		pdata->timeout =3D msecs_to_jiffies(reg);
> +
> +	pdata->sda_is_open_drain =3D
> +		!!of_property_read_bool(np, "i2c-gpio,sda-open-drain");
> +	pdata->scl_is_open_drain =3D
> +		!!of_property_read_bool(np, "i2c-gpio,scl-open-drain");
> +	pdata->scl_is_output_only =3D
> +		!!of_property_read_bool(np, "i2c-gpio,scl-output-only");
> +
> +	return 0;
> +}
> +
>  static int __devinit i2c_gpio_probe(struct platform_device *pdev)
>  {
> +	struct i2c_gpio_private_data *priv;
>  	struct i2c_gpio_platform_data *pdata;
>  	struct i2c_algo_bit_data *bit_data;
>  	struct i2c_adapter *adap;
>  	int ret;
> =20
> -	pdata =3D pdev->dev.platform_data;
> -	if (!pdata)
> -		return -ENXIO;
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	adap =3D &priv->adap;
> +	bit_data =3D &priv->bit_data;
> +	pdata =3D &priv->pdata;
> =20
> -	ret =3D -ENOMEM;
> -	adap =3D kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
> -	if (!adap)
> -		goto err_alloc_adap;
> -	bit_data =3D kzalloc(sizeof(struct i2c_algo_bit_data), GFP_KERNEL);
> -	if (!bit_data)
> -		goto err_alloc_bit_data;
> +	if (pdev->dev.of_node) {
> +		ret =3D of_i2c_gpio_probe(pdev->dev.of_node, pdata);
> +		if (ret)
> +			return ret;
> +	} else {
> +		if (!pdev->dev.platform_data)
> +			return -ENXIO;
> +		memcpy(pdata, pdev->dev.platform_data, sizeof(*pdata));
> +	}
> =20
>  	ret =3D gpio_request(pdata->sda_pin, "sda");
>  	if (ret)
> @@ -143,6 +188,7 @@ static int __devinit i2c_gpio_probe(struct platform_d=
evice *pdev)
>  	adap->algo_data =3D bit_data;
>  	adap->class =3D I2C_CLASS_HWMON | I2C_CLASS_SPD;
>  	adap->dev.parent =3D &pdev->dev;
> +	adap->dev.of_node =3D pdev->dev.of_node;
> =20
>  	/*
>  	 * If "dev->id" is negative we consider it as zero.
> @@ -154,7 +200,9 @@ static int __devinit i2c_gpio_probe(struct platform_d=
evice *pdev)
>  	if (ret)
>  		goto err_add_bus;
> =20
> -	platform_set_drvdata(pdev, adap);
> +	of_i2c_register_devices(adap);
> +
> +	platform_set_drvdata(pdev, priv);
> =20
>  	dev_info(&pdev->dev, "using pins %u (SDA) and %u (SCL%s)\n",
>  		 pdata->sda_pin, pdata->scl_pin,
> @@ -168,34 +216,40 @@ err_add_bus:
>  err_request_scl:
>  	gpio_free(pdata->sda_pin);
>  err_request_sda:
> -	kfree(bit_data);
> -err_alloc_bit_data:
> -	kfree(adap);
> -err_alloc_adap:
>  	return ret;
>  }
> =20
>  static int __devexit i2c_gpio_remove(struct platform_device *pdev)
>  {
> +	struct i2c_gpio_private_data *priv;
>  	struct i2c_gpio_platform_data *pdata;
>  	struct i2c_adapter *adap;
> =20
> -	adap =3D platform_get_drvdata(pdev);
> -	pdata =3D pdev->dev.platform_data;
> +	priv =3D platform_get_drvdata(pdev);
> +	adap =3D &priv->adap;
> +	pdata =3D &priv->pdata;
> =20
>  	i2c_del_adapter(adap);
>  	gpio_free(pdata->scl_pin);
>  	gpio_free(pdata->sda_pin);
> -	kfree(adap->algo_data);
> -	kfree(adap);
> =20
>  	return 0;
>  }
> =20
> +#if defined(CONFIG_OF)
> +static const struct of_device_id i2c_gpio_dt_ids[] =3D {
> +	{ .compatible =3D "i2c-gpio", },
> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, i2c_gpio_dt_ids);
> +#endif
> +
>  static struct platform_driver i2c_gpio_driver =3D {
>  	.driver		=3D {
>  		.name	=3D "i2c-gpio",
>  		.owner	=3D THIS_MODULE,
> +		.of_match_table	=3D of_match_ptr(i2c_gpio_dt_ids),
>  	},
>  	.probe		=3D i2c_gpio_probe,
>  	.remove		=3D __devexit_p(i2c_gpio_remove),

Otherwise looks good in general. What was your test scenario?

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9e+UsACgkQD27XaX1/VRubigCfZ7pITYVuaAQL+Ix+7rA4hMsk
5JoAoLzXr9nD/H6smmSiR8yNFHusQ9CR
=NPMn
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
