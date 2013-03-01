From: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-gpio: Add support for deferred probing
Date: Fri, 01 Mar 2013 11:58:29 +0800
Message-ID: <51302765.8030202@atmel.com>
References: <20130228120140.127ebb91@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130228120140.127ebb91-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On 2/28/2013 19:01, Jean Delvare wrote:
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
> I wrote this quite some time ago already, but I do not have any system
> to test it. I would appreciate if one or more users of the i2c-gpio
> driver could give it a try and confirm it works as intended, or at
> least doesn't introduce any regression. Thanks.
>
>   drivers/i2c/busses/i2c-gpio.c |   75 ++++++++++++++++++++++++++++--------------
>   1 file changed, 50 insertions(+), 25 deletions(-)

Test on at91sam9g20ek_2mmc board, booting with non-dt kernel and 
dt-kernel base on Linux-3.8. Both are OK.

Tested-by: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Best Regards,
Bo Shen

> --- linux-3.8-rc2.orig/drivers/i2c/busses/i2c-gpio.c	2013-01-09 22:26:30.031060312 +0100
> +++ linux-3.8-rc2/drivers/i2c/busses/i2c-gpio.c	2013-01-09 22:32:59.950308645 +0100
> @@ -85,23 +85,29 @@ static int i2c_gpio_getscl(void *data)
>   	return gpio_get_value(pdata->scl_pin);
>   }
>
> -static int of_i2c_gpio_probe(struct device_node *np,
> -			     struct i2c_gpio_platform_data *pdata)
> +static int of_i2c_gpio_get_pins(struct device_node *np,
> +				unsigned int *sda_pin, unsigned int *scl_pin)
>   {
> -	u32 reg;
> -
>   	if (of_gpio_count(np) < 2)
>   		return -ENODEV;
>
> -	pdata->sda_pin = of_get_gpio(np, 0);
> -	pdata->scl_pin = of_get_gpio(np, 1);
> +	*sda_pin = of_get_gpio(np, 0);
> +	*scl_pin = of_get_gpio(np, 1);
>
> -	if (!gpio_is_valid(pdata->sda_pin) || !gpio_is_valid(pdata->scl_pin)) {
> +	if (!gpio_is_valid(*sda_pin) || !gpio_is_valid(*scl_pin)) {
>   		pr_err("%s: invalid GPIO pins, sda=%d/scl=%d\n",
> -		       np->full_name, pdata->sda_pin, pdata->scl_pin);
> +		       np->full_name, *sda_pin, *scl_pin);
>   		return -ENODEV;
>   	}
>
> +	return 0;
> +}
> +
> +static void of_i2c_gpio_get_props(struct device_node *np,
> +				  struct i2c_gpio_platform_data *pdata)
> +{
> +	u32 reg;
> +
>   	of_property_read_u32(np, "i2c-gpio,delay-us", &pdata->udelay);
>
>   	if (!of_property_read_u32(np, "i2c-gpio,timeout-ms", &reg))
> @@ -113,8 +119,6 @@ static int of_i2c_gpio_probe(struct devi
>   		of_property_read_bool(np, "i2c-gpio,scl-open-drain");
>   	pdata->scl_is_output_only =
>   		of_property_read_bool(np, "i2c-gpio,scl-output-only");
> -
> -	return 0;
>   }
>
>   static int i2c_gpio_probe(struct platform_device *pdev)
> @@ -123,31 +127,52 @@ static int i2c_gpio_probe(struct platfor
>   	struct i2c_gpio_platform_data *pdata;
>   	struct i2c_algo_bit_data *bit_data;
>   	struct i2c_adapter *adap;
> +	unsigned int sda_pin, scl_pin;
>   	int ret;
>
> -	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> -		return -ENOMEM;
> -	adap = &priv->adap;
> -	bit_data = &priv->bit_data;
> -	pdata = &priv->pdata;
> -
> +	/* First get the GPIO pins; if it fails, we'll defer the probe. */
>   	if (pdev->dev.of_node) {
> -		ret = of_i2c_gpio_probe(pdev->dev.of_node, pdata);
> +		ret = of_i2c_gpio_get_pins(pdev->dev.of_node,
> +					   &sda_pin, &scl_pin);
>   		if (ret)
>   			return ret;
>   	} else {
>   		if (!pdev->dev.platform_data)
>   			return -ENXIO;
> -		memcpy(pdata, pdev->dev.platform_data, sizeof(*pdata));
> +		pdata = pdev->dev.platform_data;
> +		sda_pin = pdata->sda_pin;
> +		scl_pin = pdata->scl_pin;
>   	}
>
> -	ret = gpio_request(pdata->sda_pin, "sda");
> -	if (ret)
> +	ret = gpio_request(sda_pin, "sda");
> +	if (ret) {
> +		if (ret == -EINVAL)
> +			ret = -EPROBE_DEFER;	/* Try again later */
>   		goto err_request_sda;
> -	ret = gpio_request(pdata->scl_pin, "scl");
> -	if (ret)
> +	}
> +	ret = gpio_request(scl_pin, "scl");
> +	if (ret) {
> +		if (ret == -EINVAL)
> +			ret = -EPROBE_DEFER;	/* Try again later */
>   		goto err_request_scl;
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
>   	if (pdata->sda_is_open_drain) {
>   		gpio_direction_output(pdata->sda_pin, 1);
> @@ -211,9 +236,9 @@ static int i2c_gpio_probe(struct platfor
>   	return 0;
>
>   err_add_bus:
> -	gpio_free(pdata->scl_pin);
> +	gpio_free(scl_pin);
>   err_request_scl:
> -	gpio_free(pdata->sda_pin);
> +	gpio_free(sda_pin);
>   err_request_sda:
>   	return ret;
>   }
>
>
