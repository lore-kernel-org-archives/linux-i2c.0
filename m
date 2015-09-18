From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [Patch V5] i2c: imx: implement bus recovery
Date: Fri, 18 Sep 2015 09:54:57 +0200
Message-ID: <20150918075457.GT5327@pengutronix.de>
References: <1441968155-10918-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441968155-10918-1-git-send-email-b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B20596-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Fri, Sep 11, 2015 at 06:42:34PM +0800, Gao Pan wrote:
> V5:
>  -introduce a dedicated gpio state for bus recovery.
>  -assign adapter.bus_recovery_info after the two gpios were aquired s=
uccessfully.

You also do this if the gpios were not acquired successfully.

> +	if (IS_ERR(i2c_imx->pinctrl_pins_default))
> +		dev_warn(&pdev->dev, "could not get default state\n");
> +	else {
> +		i2c_imx->pinctrl_pins_gpio =3D pinctrl_lookup_state(i2c_imx->pinct=
rl,
> +						I2C_PINCTRL_STATE_GPIO);
> +		if (IS_ERR(i2c_imx->pinctrl_pins_gpio))
> +			dev_warn(&pdev->dev, "could not get gpio state\n");

IMHO pinctrl_lookup_state returning an error is enough to not try a
recovery.

> +	}
> +
>  	/* Request IRQ */
>  	ret =3D devm_request_irq(&pdev->dev, irq, i2c_imx_isr, 0,
>  				pdev->name, i2c_imx);
> @@ -1057,6 +1146,24 @@ static int i2c_imx_probe(struct platform_devic=
e *pdev)
>  	if (ret < 0)
>  		goto rpm_disable;
> =20
> +	/* Init recover pins */
> +	i2c_imx->pins.sda =3D
> +		devm_gpiod_get_optional(&pdev->dev, "sda-gpios", GPIOD_IN);
> +	i2c_imx->pins.scl =3D
> +		devm_gpiod_get_optional(&pdev->dev, "scl-gpios", GPIOD_IN);
> +
> +	if (IS_ERR(i2c_imx->pins.sda)) {
> +		ret =3D PTR_ERR(i2c_imx->pins.sda);
> +		goto clk_disable;
> +	}
> +
> +	if (IS_ERR(i2c_imx->pins.scl)) {
> +		ret =3D PTR_ERR(i2c_imx->pins.scl);
> +		goto clk_disable;
> +	}
> +

if (i2c_imx->pins.sda && i2c_imx->pins.scl)

> +	i2c_imx->adapter.bus_recovery_info =3D &i2c_imx_bus_recovery_info;
> +
>  	/* Set up clock divider */
>  	i2c_imx->bitrate =3D IMX_I2C_BIT_RATE;
>  	ret =3D of_property_read_u32(pdev->dev.of_node,

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
