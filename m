From: Milton Miller <miltonm-ogEGBHC/i9Y@public.gmane.org>
Subject: Re: [3/3,v2] i2c-gpio: add devicetree support
Date: Mon, 31 Jan 2011 15:14:26 -0600
Message-ID: <of-i2c-doc@mdm.bga.com>
References: <1296487551-30938-3-git-send-email-thomas@wytron.com.tw>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1296487551-30938-3-git-send-email-thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>, Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 31 Jan 2011 about 15:25:51 -0000, Thomas Chou wrote:

> This patch is based on an earlier patch from Albert Herranz,
> http://git.infradead.org/users/herraa1/gc-linux-2.6.git/commit/
> 9854eb78607c641ab5ae85bcbe3c9d14ac113733
> 
> The dts binding is modified as Grant suggested. The of probing
> is merged inline instead of a separate file. It uses the newer
> of gpio probe.

> diff --git a/Documentation/devicetree/bindings/i2c/i2c-gpio.txt b/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
> new file mode 100644
> index 0000000..541fb10
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
> @@ -0,0 +1,40 @@
> +GPIO-based I2C
> +
> +Required properties:
> +- compatible : should be "i2c-gpio".
> +- gpios : should specify GPIOs used for SDA and SCL lines, in that order.
> +Optional properties:
> +- sda-is-open-drain : present if SDA gpio is open-drain.
> +- scl-is-open-drain : present if SCL gpio is open-drain.
> +- scl-is-output-only : present if the output driver for SCL cannot be
> +	turned off. this will prevent clock stretching from working.
> +- udelay : signal toggle delay. SCL frequency is (500 / udelay) kHz
> +- timeout : clock stretching timeout in milliseconds.


This description needs a lot more text, specifically what happens
when these optional parameters are not present.

Why are the sda / sdl properties required, why can't the gpio description
describe them?   Should't they be part of the flags on the gpio?

And come to think about it, udelay is not a good property name.  The
fact linux uses it for a name of a function that causes a microsecond
delay not withstanding.


>  
> +/* Check if devicetree nodes exist and build platform data */
> +static struct i2c_gpio_platform_data *i2c_gpio_of_probe(
> +	struct platform_device *pdev)
> +{
> +	struct i2c_gpio_platform_data *pdata = NULL;
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	if (np && of_gpio_count(np) >= 2) {
> +		const __be32 *prop;
> +		int sda_pin, scl_pin;
> +
> +		sda_pin = of_get_gpio_flags(np, 0, NULL);
> +		scl_pin = of_get_gpio_flags(np, 1, NULL);
> +		if (sda_pin < 0 || scl_pin < 0) {
> +			pr_err("%s: invalid GPIO pins, sda=%d/scl=%d\n",
> +			       np->full_name, sda_pin, scl_pin);
> +			goto err_gpio_pin;
> +		}
> +		pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
> +		if (!pdata)
> +			goto err_alloc_pdata;
> +		pdata->sda_pin = sda_pin;
> +		pdata->scl_pin = scl_pin;
> +		prop = of_get_property(np, "sda-is-open-drain", NULL);
> +		if (prop)
> +			pdata->sda_is_open_drain = 1;
> +		prop = of_get_property(np, "scl-is-open-drain", NULL);
> +		if (prop)
> +			pdata->scl_is_open_drain = 1;
> +		prop = of_get_property(np, "scl-is-output-only", NULL);
> +		if (prop)
> +			pdata->scl_is_output_only = 1;
> +		prop = of_get_property(np, "udelay", NULL);
> +		if (prop)
> +			pdata->udelay = be32_to_cpup(prop);
> +		prop = of_get_property(np, "timeout", NULL);
> +		if (prop) {
> +			pdata->timeout =
> +				msecs_to_jiffies(be32_to_cpup(prop));
> +		}
> +	}
> +
> +err_gpio_pin:
> +err_alloc_pdata:
> +	return pdata;
> +}

This looks nicer but  we don't really need two labels for the same point.
Also, it seems the whole function could be shifted left one tab by
returning early if the gpio count doesn't exist.


> +
>  static int __devinit i2c_gpio_probe(struct platform_device *pdev)
>  {
>  	struct i2c_gpio_platform_data *pdata;
> @@ -87,6 +136,8 @@ static int __devinit i2c_gpio_probe(struct platform_device *pdev)
>  
>  	pdata = pdev->dev.platform_data;
>  	if (!pdata)
> +		pdata = i2c_gpio_of_probe(pdev);
> +	if (!pdata)
>  		return -ENXIO;
>  
>  	ret = -ENOMEM;
> @@ -143,6 +194,7 @@ static int __devinit i2c_gpio_probe(struct platform_device *pdev)
>  	adap->algo_data = bit_data;
>  	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
>  	adap->dev.parent = &pdev->dev;
> +	adap->dev.of_node = pdev->dev.of_node;
>  
>  	/*
>  	 * If "dev->id" is negative we consider it as zero.
> @@ -161,6 +213,9 @@ static int __devinit i2c_gpio_probe(struct platform_device *pdev)
>  		 pdata->scl_is_output_only
>  		 ? ", no clock stretching" : "");
>  
> +	/* Now register all the child nodes */
> +	of_i2c_register_devices(adap);
> +
>  	return 0;
>  
>  err_add_bus:
> @@ -172,6 +227,8 @@ err_request_sda:
>  err_alloc_bit_data:
>  	kfree(adap);
>  err_alloc_adap:
> +	if (!pdev->dev.platform_data)
> +		kfree(pdata);

This looks better with the code move to the function above, but
I don't like the condition on this free here ...

>  	return ret;
>  }
>  
> @@ -179,23 +236,33 @@ static int __devexit i2c_gpio_remove(struct platform_device *pdev)
>  {
>  	struct i2c_gpio_platform_data *pdata;
>  	struct i2c_adapter *adap;
> +	struct i2c_algo_bit_data *bit_data;
>  
>  	adap = platform_get_drvdata(pdev);
> -	pdata = pdev->dev.platform_data;
> +	bit_data = adap->algo_data;
> +	pdata = bit_data->data;
>  
>  	i2c_del_adapter(adap);
>  	gpio_free(pdata->scl_pin);
>  	gpio_free(pdata->sda_pin);
>  	kfree(adap->algo_data);
>  	kfree(adap);
> +	if (!pdev->dev.platform_data)
> +		kfree(pdata);

and especially here ... it seems unrelated.

Looking at devices/base/platform.c, how about just allocating the
initial platform data struct on the stack in i2c_gpio_of_probe
and then calling platform_device_add_data?  That way the pdev
is responsible for freeing the data.

>  
>  	return 0;
>  }
>  
> +static const struct of_device_id i2c_gpio_match[] = {
> +	{ .compatible = "i2c-gpio", },
> +	{},
> +};
> +
>  static struct platform_driver i2c_gpio_driver = {
>  	.driver		= {
>  		.name	= "i2c-gpio",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = i2c_gpio_match,
>  	},
>  	.probe		= i2c_gpio_probe,
>  	.remove		= __devexit_p(i2c_gpio_remove),

milton
