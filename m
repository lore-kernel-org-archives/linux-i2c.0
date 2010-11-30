From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCHv3] i2c: add generic I2C multiplexer using gpio api
Date: Tue, 30 Nov 2010 11:29:58 +0100
Message-ID: <20101130112958.30b72f39@endymion.delvare>
References: <1291050486-12000-1-git-send-email-peter.korsgaard@barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1291050486-12000-1-git-send-email-peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ml.lawnick-Mmb7MZpHnFY@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

Thanks for the updated patch.

On Mon, 29 Nov 2010 18:08:06 +0100, Peter Korsgaard wrote:
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

Again: these are not virtual buses. These are bus segments behind a
mux, and they are as real as the trunk segment in front of the mux.

Your code looks really good now, I have a few minor comments remaining
(see inline below) but overall we're good to go.

I'm eager to give it a try on my own PC system, where the SMBus is
multiplexed using ICH10 GPIO pins. Unfortunately I don't think there is
a driver for the Intel ICH GPIO pins, so I'll have to write one. And
then I'll have to write some glue code to instantiate the relevant
platform device on my system. I'll let you know when I get there.

> 
> Signed-off-by: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
> ---
> Changes since v2:
>  - Adjust according to Jean's comments, rename to gpio-i2cmux
> 
> Changes since v1:
>  - Use i2c-mux infrastructure
>  - Move to drivers/i2c/muxes
> 
>  Documentation/i2c/muxes/gpio-i2cmux |   65 +++++++++++++
>  MAINTAINERS                         |    7 ++
>  drivers/i2c/muxes/Kconfig           |   12 +++
>  drivers/i2c/muxes/Makefile          |    1 +
>  drivers/i2c/muxes/gpio-i2cmux.c     |  175 +++++++++++++++++++++++++++++++++++
>  include/linux/gpio-i2cmux.h         |   35 +++++++
>  6 files changed, 295 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/i2c/muxes/gpio-i2cmux
>  create mode 100644 drivers/i2c/muxes/gpio-i2cmux.c
>  create mode 100644 include/linux/gpio-i2cmux.h
> 
> diff --git a/Documentation/i2c/muxes/gpio-i2cmux b/Documentation/i2c/muxes/gpio-i2cmux
> new file mode 100644
> index 0000000..a1768d3
> --- /dev/null
> +++ b/Documentation/i2c/muxes/gpio-i2cmux
> @@ -0,0 +1,65 @@
> +Kernel driver gpio-i2cmux
> +
> +Author: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
> +
> +Description
> +-----------
> +
> +gpio-i2cmux is an i2c mux driver providing virtual I2C busses from a
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

As said above, I would like you to get rid of the "virtual" term in
this document, and talk in terms of I2C bus segments.

> +
> +Usage
> +-----
> +
> +gpio-i2cmux uses the platform bus, so you need to provide a struct
> +platform_device with the platform_data pointing to a struct
> +gpio_i2cmux_platform_data with the I2C adapter number of the master
> +bus, the number of virtual busses to create and the GPIO pins used
> +to control it. See include/linux/gpio-i2cmux.h for details.
> +
> +E.G. something like this for a MUX providing 4 virtual busses
> +controlled through 3 GPIO pins:
> +
> +#include <linux/gpio-i2cmux.h>
> +#include <linux/platform_device.h>
> +
> +static const unsigned myboard_gpiomux_gpios[] = {
> +	AT91_PIN_PC26, AT91_PIN_PC25, AT91_PIN_PC24
> +};
> +
> +static const unsigned myboard_gpiomux_values[] = {
> +	0, 1, 2, 3
> +};
> +
> +static struct gpio_i2cmux_platform_data myboard_i2cmux_data = {
> +	.parent		= 1,
> +	.base_nr	= 2, /* optional */
> +	.values		= myboard_gpiomux_values,
> +	.n_values	= ARRAY_SIZE(myboard_gpiomux_values),
> +	.gpio		= myboard_gpiomux_gpios,

.gpios

> +	.gpios		= ARRAY_SIZE(myboard_gpiomux_gpios),

.n_gpios

> +	.idle		= 4, /* optional */
> +};
> +
> +static struct platform_device myboard_i2cmux = {
> +	.name		= "gpio-i2cmux",
> +	.id		= 0,
> +	.dev		= {
> +		.platform_data	= &myboard_i2cmux_data,
> +	},
> +};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b3be8b3..8117a3f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2579,6 +2579,13 @@ S:	Supported
>  F:	drivers/i2c/busses/i2c-gpio.c
>  F:	include/linux/i2c-gpio.h
>  
> +GENERIC GPIO I2C MULTIPLEXER DRIVER
> +M:	Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
> +L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +S:	Supported
> +F:	drivers/i2c/muxes/gpio-i2cmux.c
> +F:	include/linux/gpio-i2mux.h

Typo: gpio-i2cmux.h. And you're missing:

F:	Documentation/i2c/muxes/gpio-i2cmux

> +
>  GENERIC HDLC (WAN) DRIVERS
>  M:	Krzysztof Halasa <khc-9GfyWEdoJtJmR6Xm/wNWPw@public.gmane.org>
>  W:	http://www.kernel.org/pub/linux/utils/net/hdlc/
> diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
> index 4d91d80..394a8b1 100644
> --- a/drivers/i2c/muxes/Kconfig
> +++ b/drivers/i2c/muxes/Kconfig
> @@ -25,4 +25,16 @@ config I2C_MUX_PCA954x
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called pca954x.
>  
> + config I2C_MUX_GPIO
> +	tristate "GPIO-based I2C multiplexer"
> +	depends on GENERIC_GPIO
> +	help
> +	  If you say yes to this option, support will be included for a
> +	  GPIO based I2C multiplexer. This driver provides access to
> +	  I2C busses connected through a MUX, which is controlled
> +	  through GPIO pins.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called gpio-i2cmux.
> +

Alphabetic order -> goes at the beginning of the list.

>  endmenu
> diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
> index d743806..b9a56d9 100644
> --- a/drivers/i2c/muxes/Makefile
> +++ b/drivers/i2c/muxes/Makefile
> @@ -3,5 +3,6 @@
>  
>  obj-$(CONFIG_I2C_MUX_PCA9541)	+= pca9541.o
>  obj-$(CONFIG_I2C_MUX_PCA954x)	+= pca954x.o
> +obj-$(CONFIG_I2C_MUX_GPIO)	+= gpio-i2cmux.o

Alphabetic order -> goes at the beginning of the list.

>  
>  ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
> diff --git a/drivers/i2c/muxes/gpio-i2cmux.c b/drivers/i2c/muxes/gpio-i2cmux.c
> new file mode 100644
> index 0000000..3487aca
> --- /dev/null
> +++ b/drivers/i2c/muxes/gpio-i2cmux.c
> @@ -0,0 +1,175 @@
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
> +#include <linux/gpio-i2cmux.h>
> +#include <linux/platform_device.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/gpio.h>
> +
> +struct gpiomux {
> +	struct i2c_adapter *parent;
> +	struct i2c_adapter **adap; /* child busses */
> +	struct gpio_i2cmux_platform_data data;
> +};
> +
> +static void gpiomux_set(const struct gpiomux *mux, unsigned val)
> +{
> +	int i;
> +
> +	for (i = 0; i < mux->data.n_gpios; i++)
> +		gpio_set_value(mux->data.gpios[i], val & (1 << i));
> +}
> +
> +static int gpiomux_select(struct i2c_adapter *adap, void *data, u32 chan)
> +{
> +	struct gpiomux *mux = data;
> +
> +	gpiomux_set(mux, mux->data.values[chan]);
> +
> +	return 0;
> +}
> +
> +static int gpiomux_deselect(struct i2c_adapter *adap, void *data, u32 chan)
> +{
> +	struct gpiomux *mux = data;
> +
> +	gpiomux_set(mux, mux->data.idle);
> +
> +	return 0;
> +}
> +
> +static int __devinit gpiomux_probe(struct platform_device *pdev)
> +{
> +	struct gpiomux *mux;
> +	struct gpio_i2cmux_platform_data *pdata;
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
> +	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
> +	if (!mux) {
> +		ret = -ENOMEM;
> +		goto alloc_failed;
> +	}
> +
> +	mux->parent = parent;
> +	mux->data = *pdata;
> +	mux->adap = kzalloc(sizeof(struct i2c_adapter *) * pdata->n_values,
> +			    GFP_KERNEL);
> +	if (!mux->adap) {
> +		ret = -ENOMEM;
> +		goto alloc_failed2;
> +	}
> +
> +	for (i = 0; i < pdata->n_gpios; i++) {
> +		ret = gpio_request(pdata->gpios[i], "gpio-i2cmux");
> +		if (ret)
> +			goto err_request_gpio;
> +		gpio_direction_output(pdata->gpios[i], pdata->idle & (1 << i));
> +	}
> +
> +	for (i = 0; i < pdata->n_values; i++) {
> +		u32 nr = pdata->base_nr ? (pdata->base_nr + i) : 0;
> +		bool has_idle = (pdata->idle != (unsigned)-1);

has_idle doesn't depend on i, so it would be more efficiently set
outside the loop. You could even store a function pointer instead of a
boolean value, to be even more efficient.

BTW, would it make sense to

#define GPIO_I2CMUX_NO_IDLE	((unsigned)-1)

to avoid arbitrary cast and constant in the code?

> +
> +		mux->adap[i] =
> +			i2c_add_mux_adapter(parent, mux, nr, i, gpiomux_select,
> +					    has_idle ? gpiomux_deselect : NULL);
> +		if (!mux->adap[i]) {
> +			ret = -ENODEV;
> +			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
> +			goto add_adapter_failed;
> +		}
> +	}
> +
> +	dev_info(&pdev->dev, "%d port mux on %s adapter\n",
> +		 pdata->n_values, parent->name);
> +
> +	platform_set_drvdata(pdev, mux);
> +
> +	return 0;
> +
> +add_adapter_failed:
> +	for (; i > 0; i--)
> +		i2c_del_mux_adapter(mux->adap[i - 1]);
> +	i = pdata->n_gpios;
> +err_request_gpio:
> +	for (; i > 0; i--)
> +		gpio_free(pdata->gpios[i - 1]);
> +	kfree(mux->adap);
> +alloc_failed2:
> +	kfree(mux);
> +alloc_failed:
> +	i2c_put_adapter(parent);
> +
> +	return ret;
> +}
> +
> +static int __devexit gpiomux_remove(struct platform_device *pdev)
> +{
> +	struct gpiomux *mux = platform_get_drvdata(pdev);
> +	int i;
> +
> +	for (i = 0; i < mux->data.n_values; i++)
> +		i2c_del_mux_adapter(mux->adap[i]);
> +
> +	for (i = 0; i < mux->data.n_gpios; i++)
> +		gpio_free(mux->data.gpios[i]);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	i2c_put_adapter(mux->parent);
> +	kfree(mux->adap);
> +	kfree(mux);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver gpiomux_driver = {
> +	.probe	= gpiomux_probe,
> +	.remove	= __devexit_p(gpiomux_remove),
> +	.driver	= {
> +		.owner	= THIS_MODULE,
> +		.name	= "gpio-i2cmux",
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
> +MODULE_ALIAS("platform:gpio-i2cmux");
> diff --git a/include/linux/gpio-i2cmux.h b/include/linux/gpio-i2cmux.h
> new file mode 100644
> index 0000000..5ac3438
> --- /dev/null
> +++ b/include/linux/gpio-i2cmux.h
> @@ -0,0 +1,35 @@
> +/*
> + * gpio-i2cmux interface to platform code
> + *
> + * Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _LINUX_GPIO_I2CMUX_H
> +#define _LINUX_GPIO_I2CMUX_H
> +
> +/**
> + * struct gpio_i2cmux_platform_data - Platform-dependent data for gpio-i2cmux
> + * @parent: Parent I2C bus adapter number
> + * @base_nr: Base I2C bus number to number adapters from or zero for dynamic
> + * @values: Array of bitmasks of GPIO settings (low/high) for each
> + *	position
> + * @n_values: Number of multiplexer positions (busses to instantiate)
> + * @gpios: Array of GPIO numbers used to control MUX
> + * @n_gpios: Number of GPIOs used to control MUX
> + * @idle: Bitmask to write to MUX when idle or -1 if not used
> + */
> +struct gpio_i2cmux_platform_data {
> +	int parent;
> +	int base_nr;
> +	const unsigned *values;
> +	int n_values;
> +	const unsigned *gpios;
> +	int n_gpios;
> +	unsigned idle;
> +};
> +
> +#endif /* _LINUX_GPIO_I2CMUX_H */


-- 
Jean Delvare
