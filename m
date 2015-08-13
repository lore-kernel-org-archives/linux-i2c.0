From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [Patch v2] i2c: imx: implement bus recovery
Date: Thu, 13 Aug 2015 10:15:28 +0200
Message-ID: <20150813081528.GA9999@pengutronix.de>
References: <1437100605-28047-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437100605-28047-1-git-send-email-b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B20596-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Fri, Jul 17, 2015 at 10:36:45AM +0800, Gao Pan wrote:
> Implement bus recovery methods for i2c-imx so we can recover from
> situations where SCL/SDA are stuck low.
>=20
> Once i2c bus SCL/SDA are stuck low during transfer, config the i2c
> pinctrl to gpio mode by calling pinctrl sleep set function, and then
> use GPIO to emulate the i2c protocol to send nine dummy clock to reco=
ver
> i2c device. After recovery, set i2c pinctrl to default group setting.
>=20
> V2:
> As Uwe Kleine-K=F6nig's suggestion, the version do below changes:
>  -replace of_get_named_gpio() with devm_gpiod_get_optional()
>  -move gpio_direction_input() and gpio_direction_output() call to the
>   prepare callback
>  -use 0 and 1 as return value for the get_scl and get_sda callbacks

this section usally goes after the triple-dash below. Otherwise this is
included in the commit log which it shouldn't.

> diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.txt b/Docu=
mentation/devicetree/bindings/i2c/i2c-imx.txt
> index ce4311d..a9fe525 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> @@ -14,6 +14,8 @@ Optional properties:
>    The absence of the propoerty indicates the default frequency 100 k=
Hz.
>  - dmas: A list of two dma specifiers, one for each entry in dma-name=
s.
>  - dma-names: should contain "tx" and "rx".
> +- scl-gpio: specify the gpio related to SCL pin
> +- sda-gpio: specify the gpio related to SDA pin

In the meantime I learned that "...-gpios" is the recommended name for
such properties, even if conceptually there can only be a single gpio
here. (You might want to help to change that?!)

> @@ -436,7 +444,7 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct=
 *i2c_imx, int for_busy)
>  		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
>  			dev_dbg(&i2c_imx->adapter.dev,
>  				"<%s> I2C bus is busy\n", __func__);
> -			return -ETIMEDOUT;
> +			return i2c_recover_bus(&i2c_imx->adapter);
>  		}
>  		schedule();
>  	}
> @@ -450,7 +458,7 @@ static int i2c_imx_trx_complete(struct imx_i2c_st=
ruct *i2c_imx)
> =20
>  	if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
>  		dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout\n", __func__);
> -		return -ETIMEDOUT;
> +		return i2c_recover_bus(&i2c_imx->adapter);

I'm still not convinced that doing that here unconditionally is a good
idea. Wolfram will know for sure.

> +static void i2c_imx_prepare_recovery(struct i2c_adapter *adap)
> +{
> +	struct imx_i2c_struct *i2c_imx;
> +
> +	i2c_imx =3D container_of(adap, struct imx_i2c_struct, adapter);
> +	if (i2c_imx->pins.sda && i2c_imx->pins.scl) {
> +		pinctrl_pm_select_sleep_state(&adap->dev);

Your requirement that the sleep state should configure the pins as gpio
is strange. Maybe better introduce a dedicated state for recovery? At
least you should document this requirement.

> @@ -1004,12 +1073,13 @@ static int i2c_imx_probe(struct platform_devi=
ce *pdev)
> =20
>  	/* Setup i2c_imx driver structure */
>  	strlcpy(i2c_imx->adapter.name, pdev->name, sizeof(i2c_imx->adapter.=
name));
> -	i2c_imx->adapter.owner		=3D THIS_MODULE;
> -	i2c_imx->adapter.algo		=3D &i2c_imx_algo;
> -	i2c_imx->adapter.dev.parent	=3D &pdev->dev;
> -	i2c_imx->adapter.nr		=3D pdev->id;
> -	i2c_imx->adapter.dev.of_node	=3D pdev->dev.of_node;
> -	i2c_imx->base			=3D base;
> +	i2c_imx->adapter.owner =3D THIS_MODULE;
> +	i2c_imx->adapter.algo =3D &i2c_imx_algo;
> +	i2c_imx->adapter.dev.parent =3D &pdev->dev;
> +	i2c_imx->adapter.nr =3D pdev->id;
> +	i2c_imx->adapter.dev.of_node =3D pdev->dev.of_node;
> +	i2c_imx->adapter.bus_recovery_info =3D &i2c_imx_bus_recovery_info;

What happens if the device tree only specifies a gpio for sda but not
scl? The recovery stuff is still hooked up, right? What about only doin=
g
that if both properties are valid? This would also get rid of the tests
for validity in the recovery callbacks.

> @@ -1037,6 +1107,24 @@ static int i2c_imx_probe(struct platform_devic=
e *pdev)
>  	/* Set up adapter data */
>  	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
> =20
> +	/* Init recover pins */
> +	i2c_imx->pins.sda =3D
> +		devm_gpiod_get_optional(&pdev->dev, "sda-gpio", 0);
> +	i2c_imx->pins.scl =3D
> +		devm_gpiod_get_optional(&pdev->dev, "scl-gpio", 0);

0 is wrong here, better use GPIOD_ASIS. Is there a reason not to
configure the direction as input already here?

> +
> +	if (IS_ERR(i2c_imx->pins.sda)) {
> +		ret =3D PTR_ERR(i2c_imx->pins.sda);
> +		dev_err(&pdev->dev, "Failed to get sda gpio: %d\n", ret);
> +		i2c_imx->pins.sda =3D NULL;
> +	}

As you're using devm_gpiod_get_optional there is no justification to
ignore the error code.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
