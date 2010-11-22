From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCHv2,resend] i2c: add generic I2C multiplexer using gpio
 api
Date: Mon, 22 Nov 2010 17:50:48 +0100
Message-ID: <20101122175048.235062c1@endymion.delvare>
References: <1288797243-8074-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1288797243-8074-1-git-send-email-jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ml.lawnick-Mmb7MZpHnFY@public.gmane.org, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

Sorry and the late answer.

On Wed,  3 Nov 2010 16:14:03 +0100, Peter Korsgaard wrote:
> From: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
> 
> Add an i2c mux driver providing virtual i2c busses using a hardware MUX
> sitting on a master bus and controlled through gpio pins.
> 
> E.G. something like:
> 
>   ----------              ----------  Virtual bus 1   - - - - -
>  |          | SCL/SDA    |          |-------------- |           |
>  |          |------------|          |
>  |          |            |          | Virtual bus 2 |           |
>  |  Linux   | GPIO 1..N  |   MUX    |---------------   Devices
>  |          |------------|          |               |           |
>  |          |            |          | Virtual bus M
>  |          |            |          |---------------|           |
>   ----------              ----------                  - - - - -
> 
> SCL/SDA of the master I2C bus is multiplexed to virtual bus 1..M
> according to the settings of the GPIO pins 1..N.
> 
> Signed-off-by: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
> ---
> Changes since v1:
>  - Use i2c-mux infrastructure
>  - Move to drivers/i2c/muxes

Thanks for doing this.

Overall the driver design looks good and your code looks pretty clean
too. Review:

> 
>  Documentation/i2c/busses/i2c-gpiomux |   65 +++++++++++++
>  MAINTAINERS                          |    7 ++
>  drivers/i2c/muxes/Kconfig            |   12 +++
>  drivers/i2c/muxes/Makefile           |    1 +
>  drivers/i2c/muxes/i2c-gpiomux.c      |  172 ++++++++++++++++++++++++++++++++++
>  include/linux/i2c-gpiomux.h          |   35 +++++++
>  6 files changed, 292 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/i2c/busses/i2c-gpiomux
>  create mode 100644 drivers/i2c/muxes/i2c-gpiomux.c
>  create mode 100644 include/linux/i2c-gpiomux.h
> 
> diff --git a/Documentation/i2c/busses/i2c-gpiomux b/Documentation/i2c/busses/i2c-gpiomux
> new file mode 100644
> index 0000000..b0a7746
> --- /dev/null
> +++ b/Documentation/i2c/busses/i2c-gpiomux
> @@ -0,0 +1,65 @@
> +Kernel driver i2c-gpiomux
> +
> +Author: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
> +
> +Description
> +-----------
> +
> +i2c-gpiomux is an i2c bus driver providing virtual I2C busses from a

It is an i2c mux driver now.

> +master I2C bus and a hardware MUX controlled through GPIO pins.
> +
> +E.G.:
> +
> +  ----------              ----------  Virtual bus 1   - - - - -
> + |          | SCL/SDA    |          |-------------- |           |
> + |          |------------|          |
> + |          |            |          | Virtual bus 2 |           |
> + |  Linux   | GPIO 1..N  |   MUX    |---------------   Devices
> + |          |------------|          |               |           |
> + |          |            |          | Virtual bus M
> + |          |            |          |---------------|           |
> +  ----------              ----------                  - - - - -
> +
> +SCL/SDA of the master I2C bus is multiplexed to virtual bus 1..M
> +according to the settings of the GPIO pins 1..N.
> +
> +Usage
> +-----
> +
> +i2c-gpiomux uses the platform bus, so you need to provide a struct
> +platform_device with the platform_data pointing to a struct
> +gpiomux_i2c_platform_data with the I2C adapter number of the master

The structure should be named i2c_gpiomux_platform_data, so that the
prefix matches the driver name (but see below).

> +bus, the number of virtual busses to create and the GPIO pins used
> +to control it. See include/linux/i2c-gpiomux.h for details.
> +
> +E.G. something like this for a MUX providing 4 virtual busses
> +controlled through 3 GPIO pins:
> +
> +#include <linux/i2c-gpiomux.h>
> +#include <linux/platform_device.h>
> +
> +static unsigned myboard_gpiomux_pins[] = {
> +	AT91_PIN_PC26, AT91_PIN_PC25, AT91_PIN_PC24
> +};
> +
> +static unsigned myboard_gpiomux_values[] = {
> +	0, 1, 2, 3
> +};
> +
> +static struct gpiomux_i2c_platform_data myboard_i2cmux_data = {
> +	.parent		= 1,
> +	.base_nr	= 2,

There might be no need to specify the numbers of the child I2C segments.
Your driver should handle the case where base_nr isn't set, and not ask
for specific i2c_adpater numbers then.

> +	.busses		= ARRAY_SIZE(myboard_gpiomux_values),
> +	.gpios		= ARRAY_SIZE(myboard_gpiomux_pins),
> +	.gpio		= myboard_gpiomux_pins,
> +	.values		= myboard_gpiomux_values,

I find your naming convention (or lack thereof) confusing. What about:

	.values		= myboard_gpiomux_values,
	.n_values	= ARRAY_SIZE(myboard_gpiomux_values),
	.pins		= myboard_gpiomux_pins,
	.n_pins		= ARRAY_SIZE(myboard_gpiomux_pins),

This would be more consistent and obvious.

> +	.idle		= 4,

This should be optional. Not all hardware setup can actually disable
all children.

> +};
> +
> +static struct platform_device myboard_i2cmux = {
> +	.name		= "i2c-gpiomux",
> +	.id		= 0,
> +	.dev		= {
> +		.platform_data	= &myboard_i2cmux_data,
> +	},
> +};

All these structures can presumably be marked const.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0094224..ffe181a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2567,6 +2567,13 @@ S:	Supported
>  F:	drivers/i2c/busses/i2c-gpio.c
>  F:	include/linux/i2c-gpio.h
>  
> +GENERIC GPIO I2C MULTIPLEXER DRIVER
> +M:	Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
> +L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +S:	Supported
> +F:	drivers/i2c/muxes/i2c-gpiomux.c
> +F:	include/linux/i2c-gpiomux.h
> +
>  GENERIC HDLC (WAN) DRIVERS
>  M:	Krzysztof Halasa <khc-9GfyWEdoJtJmR6Xm/wNWPw@public.gmane.org>
>  W:	http://www.kernel.org/pub/linux/utils/net/hdlc/
> diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
> index 4d91d80..0345e37 100644
> --- a/drivers/i2c/muxes/Kconfig
> +++ b/drivers/i2c/muxes/Kconfig
> @@ -25,4 +25,16 @@ config I2C_MUX_PCA954x
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called pca954x.
>  
> + config I2C_GPIOMUX
> +	tristate "GPIO-based I2C multiplexer"
> +	depends on GENERIC_GPIO
> +	help
> +	  If you say yes to this option, support will be included for a
> +	  GPIO based I2C multiplexer. This driver provides virtual I2C
> +	  busses from a master bus through a MUX controlled through

There is nothing virtual about these bus segments. They are very real.

> +	  the generic GPIO interface.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-gpiomux.
> +
>  endmenu
> diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
> index d743806..5143bc0 100644
> --- a/drivers/i2c/muxes/Makefile
> +++ b/drivers/i2c/muxes/Makefile
> @@ -3,5 +3,6 @@
>  
>  obj-$(CONFIG_I2C_MUX_PCA9541)	+= pca9541.o
>  obj-$(CONFIG_I2C_MUX_PCA954x)	+= pca954x.o
> +obj-$(CONFIG_I2C_GPIOMUX)	+= i2c-gpiomux.o

It should be obvious from the above that your config option should be
named CONFIG_I2C_MUX_GPIO.

Not sure about the driver name. i2c-gpiomux makes it look like an i2c core or
i2c bus driver, which it is not. Maybe gpio-i2cmux would be better? I
see we already have drivers named gpio-fan for fans controlled over
GPIOs, as well as gpio_mouse and gpio_keys.

>  
>  ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
> diff --git a/drivers/i2c/muxes/i2c-gpiomux.c b/drivers/i2c/muxes/i2c-gpiomux.c
> new file mode 100644
> index 0000000..6e19ef4
> --- /dev/null
> +++ b/drivers/i2c/muxes/i2c-gpiomux.c
> @@ -0,0 +1,172 @@
> +/*
> + * I2C multiplexer using GPIO API
> + *
> + * Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/i2c-mux.h>
> +#include <linux/i2c-gpiomux.h>
> +#include <linux/platform_device.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/gpio.h>
> +
> +struct gpiomux_i2c {
> +	struct i2c_adapter *parent;
> +	struct i2c_adapter **adap; /* child busses */
> +	struct gpiomux_i2c_platform_data data;
> +};
> +
> +static void gpiomux_set(struct gpiomux_i2c *i2c, unsigned val)

i2c could be a const pointer.

> +{
> +	int i;
> +
> +	for (i = 0;  i < i2c->data.gpios; i++)

Double space after the first ";".

> +		gpio_set_value(i2c->data.gpio[i], val & (1<<i));

Although checkpatch.pl surprisingly doesn't complain, the usual style
is to have spaces around "<<".

> +}
> +
> +static int gpiomux_select(struct i2c_adapter *adap, void *data, u32 chan)
> +{
> +	struct gpiomux_i2c *i2c = data;
> +
> +	gpiomux_set(i2c, i2c->data.values[chan]);
> +
> +	return 0;
> +}
> +
> +static int gpiomux_deselect(struct i2c_adapter *adap, void *data, u32 chan)
> +{
> +	struct gpiomux_i2c *i2c = data;
> +
> +	gpiomux_set(i2c, i2c->data.idle);
> +
> +	return 0;
> +}
> +
> +static int __devinit gpiomux_probe(struct platform_device *pdev)
> +{
> +	struct gpiomux_i2c *i2c;
> +	struct gpiomux_i2c_platform_data *pdata;
> +	struct i2c_adapter *parent;
> +	int i, ret;
> +
> +	pdata = pdev->dev.platform_data;
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "Missing platform data\n");
> +		return -ENODEV;
> +	}
> +
> +	parent = i2c_get_adapter(pdata->parent);
> +	if (!parent) {
> +		dev_err(&pdev->dev, "Parent adapter (%d) not found\n",
> +			pdata->parent);
> +		return -ENODEV;
> +	}
> +
> +	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
> +	if (!i2c) {
> +		ret = -ENOMEM;
> +		goto alloc_failed;
> +	}
> +
> +	i2c->parent = parent;
> +	i2c->data = *pdata;
> +	i2c->adap = kzalloc(sizeof(struct i2c_adapter *) * pdata->busses,
> +			    GFP_KERNEL);
> +	if (!i2c->adap) {
> +		ret = -ENOMEM;
> +		goto alloc_failed2;
> +	}
> +
> +	for (i = 0; i < pdata->gpios; i++) {
> +		ret = gpio_request(pdata->gpio[i], "i2c-gpiomux");
> +		if (ret)
> +			goto err_request_gpio;
> +		gpio_direction_output(pdata->gpio[i], pdata->idle & (1<<i));
> +	}
> +
> +	for (i = 0; i < pdata->busses; i++) {
> +		i2c->adap[i] =
> +			i2c_add_mux_adapter(parent, i2c, pdata->base_nr + i, i,
> +					    gpiomux_select, gpiomux_deselect);
> +		if (!i2c->adap[i]) {
> +			ret = -ENODEV;
> +			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
> +			goto add_adapter_failed;
> +		}
> +	}
> +
> +	dev_info(&pdev->dev, "%d port mux on %s adapter\n",
> +		 pdata->busses, parent->name);
> +
> +	platform_set_drvdata(pdev, i2c);
> +
> +	return 0;
> +
> +add_adapter_failed:
> +	for (; i > 0; i--)
> +		i2c_del_mux_adapter(i2c->adap[i - 1]);
> +	i = pdata->gpios;
> +err_request_gpio:
> +	for (; i > 0; i--)
> +		gpio_free(pdata->gpio[i - 1]);
> +	kfree(i2c->adap);
> +alloc_failed2:
> +	kfree(i2c);
> +alloc_failed:
> +	i2c_put_adapter(parent);
> +
> +	return ret;
> +}
> +
> +static int __devexit gpiomux_remove(struct platform_device *pdev)
> +{
> +	struct gpiomux_i2c *i2c = platform_get_drvdata(pdev);
> +	int i;
> +
> +	for (i = 0; i < i2c->data.busses; i++)
> +		i2c_del_mux_adapter(i2c->adap[i]);
> +
> +	for (i = 0; i < i2c->data.gpios; i++)
> +		gpio_free(i2c->data.gpio[i]);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	i2c_put_adapter(i2c->parent);
> +	kfree(i2c->adap);
> +	kfree(i2c);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver gpiomux_driver = {
> +	.probe  = gpiomux_probe,
> +	.remove = __devexit_p(gpiomux_remove),
> +	.driver = {

Please use tabs to align on "=".

> +		.owner = THIS_MODULE,
> +		.name = "i2c-gpiomux",

And please do the same here, for consistency.

> +	},
> +};
> +
> +static int __init gpiomux_init(void)
> +{
> +	return platform_driver_register(&gpiomux_driver);
> +}
> +
> +static void __exit gpiomux_exit(void)
> +{
> +	platform_driver_unregister(&gpiomux_driver);
> +}
> +
> +module_init(gpiomux_init);
> +module_exit(gpiomux_exit);
> +
> +MODULE_DESCRIPTION("GPIO-based I2C multiplexer driver");
> +MODULE_AUTHOR("Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:i2c-gpiomux");
> diff --git a/include/linux/i2c-gpiomux.h b/include/linux/i2c-gpiomux.h
> new file mode 100644
> index 0000000..2388ff2
> --- /dev/null
> +++ b/include/linux/i2c-gpiomux.h
> @@ -0,0 +1,35 @@
> +/*
> + * i2c-gpiomux interface to platform code
> + *
> + * Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _LINUX_I2C_GPIOMUX_H
> +#define _LINUX_I2C_GPIOMUX_H
> +
> +/**
> + * struct gpiomux_i2c_platform_data - Platform-dependent data for i2c-gpiomux
> + * @parent: Parent I2C bus adapter number
> + * @base_nr: Base bus number value to number adapters from
> + * @busses: Number of multiplexer positions (busses to instantiate)
> + * @gpios: Number of gpios used to control MUX
> + * @gpio: Array of @gpios gpio numbers used to control MUX
> + * @values: Array of @bussed bitmasks of gpio settings (low/high) for each
> + *	position
> + * @idle: Bitmask to write to MUX when idle
> + */
> +struct gpiomux_i2c_platform_data {
> +	int parent;
> +	int base_nr;
> +	int busses;
> +	int gpios;
> +	unsigned *gpio;
> +	unsigned *values;
> +	unsigned idle;
> +};
> +
> +#endif /* _LINUX_I2C_GPIOMUX_H */


-- 
Jean Delvare
