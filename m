From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-gpio: Add support for deferred probing
Date: Fri, 31 Aug 2012 14:38:34 +0200
Message-ID: <20120831143834.57e57774@endymion.delvare>
References: <20120719131924.7672f99e@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120719131924.7672f99e-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 19 Jul 2012 13:19:24 +0200, Jean Delvare wrote:
> GPIOs may not be available immediately when i2c-gpio looks for them.
> Implement support for deferred probing so that probing can be
> attempted again later when GPIO pins are finally available.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> A little more changes were needed than I initially thought, because we
> want to check the pins before we allocate memory. Otherwise we would
> have a possibly large number of memory allocation and freeing cycles
> until GPIO pins are finally available.
> 
> Note: I wrote this patch for someone else, I can't test it, so I would
> appreciate if someone could at least test and confirm that I did not
> break anything in the standard (non-deferred) case. Thanks!

Anyone, please? Anyone using i2c-gpio, please test this patch and
report how it goes. Thanks.

>  drivers/i2c/busses/i2c-gpio.c |   76 +++++++++++++++++++++++++++--------------
>  1 file changed, 51 insertions(+), 25 deletions(-)
> 
> --- linux-3.5-rc5.orig/drivers/i2c/busses/i2c-gpio.c	2012-06-05 16:22:59.000000000 +0200
> +++ linux-3.5-rc5/drivers/i2c/busses/i2c-gpio.c	2012-07-07 10:53:40.911407245 +0200
> @@ -85,23 +85,30 @@ static int i2c_gpio_getscl(void *data)
>  	return gpio_get_value(pdata->scl_pin);
>  }
>  
> -static int __devinit of_i2c_gpio_probe(struct device_node *np,
> -			     struct i2c_gpio_platform_data *pdata)
> +static int __devinit of_i2c_gpio_get_pins(struct device_node *np,
> +					  unsigned int *sda_pin,
> +					  unsigned int *scl_pin)
>  {
> -	u32 reg;
> -
>  	if (of_gpio_count(np) < 2)
>  		return -ENODEV;
>  
> -	pdata->sda_pin = of_get_gpio(np, 0);
> -	pdata->scl_pin = of_get_gpio(np, 1);
> +	*sda_pin = of_get_gpio(np, 0);
> +	*scl_pin = of_get_gpio(np, 1);
>  
> -	if (!gpio_is_valid(pdata->sda_pin) || !gpio_is_valid(pdata->scl_pin)) {
> +	if (!gpio_is_valid(*sda_pin) || !gpio_is_valid(*scl_pin)) {
>  		pr_err("%s: invalid GPIO pins, sda=%d/scl=%d\n",
> -		       np->full_name, pdata->sda_pin, pdata->scl_pin);
> +		       np->full_name, *sda_pin, *scl_pin);
>  		return -ENODEV;
>  	}
>  
> +	return 0;
> +}
> +
> +static void __devinit of_i2c_gpio_get_props(struct device_node *np,
> +					struct i2c_gpio_platform_data *pdata)
> +{
> +	u32 reg;
> +
>  	of_property_read_u32(np, "i2c-gpio,delay-us", &pdata->udelay);
>  
>  	if (!of_property_read_u32(np, "i2c-gpio,timeout-ms", &reg))
> @@ -113,8 +120,6 @@ static int __devinit of_i2c_gpio_probe(s
>  		of_property_read_bool(np, "i2c-gpio,scl-open-drain");
>  	pdata->scl_is_output_only =
>  		of_property_read_bool(np, "i2c-gpio,scl-output-only");
> -
> -	return 0;
>  }
>  
>  static int __devinit i2c_gpio_probe(struct platform_device *pdev)
> @@ -123,31 +128,52 @@ static int __devinit i2c_gpio_probe(stru
>  	struct i2c_gpio_platform_data *pdata;
>  	struct i2c_algo_bit_data *bit_data;
>  	struct i2c_adapter *adap;
> +	unsigned int sda_pin, scl_pin;
>  	int ret;
>  
> -	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> -		return -ENOMEM;
> -	adap = &priv->adap;
> -	bit_data = &priv->bit_data;
> -	pdata = &priv->pdata;
> -
> +	/* First get the GPIO pins; if it fails, we'll defer the probe. */
>  	if (pdev->dev.of_node) {
> -		ret = of_i2c_gpio_probe(pdev->dev.of_node, pdata);
> +		ret = of_i2c_gpio_get_pins(pdev->dev.of_node,
> +					   &sda_pin, &scl_pin);
>  		if (ret)
>  			return ret;
>  	} else {
>  		if (!pdev->dev.platform_data)
>  			return -ENXIO;
> -		memcpy(pdata, pdev->dev.platform_data, sizeof(*pdata));
> +		pdata = pdev->dev.platform_data;
> +		sda_pin = pdata->sda_pin;
> +		scl_pin = pdata->scl_pin;
>  	}
>  
> -	ret = gpio_request(pdata->sda_pin, "sda");
> -	if (ret)
> +	ret = gpio_request(sda_pin, "sda");
> +	if (ret) {
> +		if (ret == -EINVAL)
> +			ret = -EPROBE_DEFER;	/* Try again later */
>  		goto err_request_sda;
> -	ret = gpio_request(pdata->scl_pin, "scl");
> -	if (ret)
> +	}
> +	ret = gpio_request(scl_pin, "scl");
> +	if (ret) {
> +		if (ret == -EINVAL)
> +			ret = -EPROBE_DEFER;	/* Try again later */
>  		goto err_request_scl;
> +	}
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		ret = -ENOMEM;
> +		goto err_add_bus;
> +	}
> +	adap = &priv->adap;
> +	bit_data = &priv->bit_data;
> +	pdata = &priv->pdata;
> +
> +	if (pdev->dev.of_node) {
> +		pdata->sda_pin = sda_pin;
> +		pdata->scl_pin = scl_pin;
> +		of_i2c_gpio_get_props(pdev->dev.of_node, pdata);
> +	} else {
> +		memcpy(pdata, pdev->dev.platform_data, sizeof(*pdata));
> +	}
>  
>  	if (pdata->sda_is_open_drain) {
>  		gpio_direction_output(pdata->sda_pin, 1);
> @@ -207,9 +233,9 @@ static int __devinit i2c_gpio_probe(stru
>  	return 0;
>  
>  err_add_bus:
> -	gpio_free(pdata->scl_pin);
> +	gpio_free(scl_pin);
>  err_request_scl:
> -	gpio_free(pdata->sda_pin);
> +	gpio_free(sda_pin);
>  err_request_sda:
>  	return ret;
>  }
> 
> 


-- 
Jean Delvare
