From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] driver/i2c/mux: Add register based mux i2c-mux-reg
Date: Wed, 17 Jun 2015 17:03:24 +0200
Message-ID: <55818C3C.8000704@nokia.com>
References: <1434475692-4611-1-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434475692-4611-1-git-send-email-yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi!

On 16/06/15 19:28, ext York Sun wrote:
> Based on i2c-mux-gpio driver, similarly the register based mux
> switch from one bus to another by setting a single register.
> The register can be on PCIe bus, local bus, or any memory-mapped
> address.
> 
> Signed-off-by: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> CC: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> CC: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
> ---
>  .../devicetree/bindings/i2c/i2c-mux-reg.txt        |   69 ++++++
>  drivers/i2c/muxes/Kconfig                          |   11 +
>  drivers/i2c/muxes/Makefile                         |    1 +
>  drivers/i2c/muxes/i2c-mux-reg.c                    |  239 ++++++++++++++++++++
>  drivers/i2c/muxes/i2c-mux-reg.h                    |   38 ++++
>  5 files changed, 358 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-reg.txt
>  create mode 100644 drivers/i2c/muxes/i2c-mux-reg.c
>  create mode 100644 drivers/i2c/muxes/i2c-mux-reg.h
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-reg.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-reg.txt
> new file mode 100644
> index 0000000..ad7cc4f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-reg.txt
> @@ -0,0 +1,69 @@
> +Register-based I2C Bus Mux
> +
> +This binding describes an I2C bus multiplexer that uses a single regsiter
                                                                    ^^^^^^^^

> +to route the I2C signals.
> +
> +Required properties:
> +- compatible: i2c-mux-reg
> +- i2c-parent: The phandle of the I2C bus that this multiplexer's master-side
> +  port is connected to.
> +* Standard I2C mux properties. See mux.txt in this directory.
> +* I2C child bus nodes. See mux.txt in this directory.
> +
> +Optional properties:
> +- reg: this pair of <offset size> specifies the register to control the mux.
> +  The <offset size> depends on its parent node. It can be any memory-mapped
> +  address. If omitted, the resource of this device will be used.
> +- idle-state: value to set the muxer to when idle. When no value is
> +  given, it defaults to the last value used.
> +
> +For each i2c child node, an I2C child bus will be created. They will
> +be numbered based on their order in the device tree.
> +
> +Whenever an access is made to a device on a child bus, the value set
> +in the revelant node's reg property will be output to the register.
> +
> +If an idle state is defined, using the idle-state (optional) property,
> +whenever an access is not being made to a device on a child bus, the
> +register will be set according to the idle value.
> +
> +If an idle state is not defined, the most recently used value will be
> +left programmed into the register.
> +
> +Example of a mux on PCIe card, the host is a powerpc SoC (big endian):
> +
> +	i2c-mux {
> +		/* the <offset size> depends on the address translation
> +		 * of the parent device. If omitted, device resource
> +		 * will be used instead.
> +		 */
> +		reg = <0x6028 0x4>;
> +		compatible = "i2c-mux-reg";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c-parent = <&i2c1>;
> +		i2c@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			si5338: clock-generator@70 {
> +				compatible = "silabs,si5338";
> +				reg = <0x70>;
> +				/* other stuff */
> +			};
> +		};
> +
> +		i2c@1 {
> +			/* data is in little endian on pcie bus */
> +			reg = <0x01000000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			si5338: clock-generator@70 {
> +				compatible = "silabs,si5338";
> +				reg = <0x70>;
> +				/* other stuff */
> +			};
> +		};
> +	};
> diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
> index f6d313e..77c1257 100644
> --- a/drivers/i2c/muxes/Kconfig
> +++ b/drivers/i2c/muxes/Kconfig
> @@ -29,6 +29,17 @@ config I2C_MUX_GPIO
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-mux-gpio.
>  
> +config I2C_MUX_REG
> +	tristate "Register-based I2C multiplexer"
> +	help
> +	  If you say yes to this option, support will be included for a
> +	  register based I2C multiplexer. This driver provides access to
> +	  I2C busses connected through a MUX, which is controlled
> +	  by a sinple register.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-mux-reg.
> +
>  config I2C_MUX_PCA9541
>  	tristate "NXP PCA9541 I2C Master Selector"
>  	help
> diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
> index 465778b..bc517bb 100644
> --- a/drivers/i2c/muxes/Makefile
> +++ b/drivers/i2c/muxes/Makefile
> @@ -4,6 +4,7 @@
>  obj-$(CONFIG_I2C_ARB_GPIO_CHALLENGE)	+= i2c-arb-gpio-challenge.o
>  
>  obj-$(CONFIG_I2C_MUX_GPIO)	+= i2c-mux-gpio.o
> +obj-$(CONFIG_I2C_MUX_REG)	+= i2c-mux-reg.o
>  obj-$(CONFIG_I2C_MUX_PCA9541)	+= i2c-mux-pca9541.o
>  obj-$(CONFIG_I2C_MUX_PCA954x)	+= i2c-mux-pca954x.o
>  obj-$(CONFIG_I2C_MUX_PINCTRL)	+= i2c-mux-pinctrl.o
> diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
> new file mode 100644
> index 0000000..03ce858
> --- /dev/null
> +++ b/drivers/i2c/muxes/i2c-mux-reg.c
> @@ -0,0 +1,239 @@
> +/*
> + * I2C multiplexer using a single register
> + *
> + * Copyright 2015 Freescale Semiconductor
> + * York Sun  <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/i2c-mux.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include "i2c-mux-reg.h"
> +
> +struct regmux {
> +	struct i2c_adapter *parent;
> +	struct i2c_adapter **adap; /* child busses */
> +	struct i2c_mux_reg_platform_data data;
> +};
> +
> +static int i2c_mux_reg_set(const struct regmux *mux, unsigned int chan)
> +{
> +	if (!mux->data.reg || chan < 0 || chan > mux->data.n_values)
> +		return -EINVAL;
> +
> +	*mux->data.reg = mux->data.values[chan];

Oh, I believe, this will not work. This will not work for PCI, because it's
a "posted" bus, it will not work on certain high-performance SoC like Octeon,
where writes to the memory are buffered... Finally your I2C transfer can
be performed before this write will be completed (if at all), because there
is no synchronization here. You probably want to use some iowrite*(), but
maybe also accomplish it with readback. There are ARM architectures where
writes to memory mapped HW modules are only ordered inside one module, but
not ordered between the modules, etc... Without volatile a good compiler
will optimize this statement away completely as it produces no "side effect".

> +
> +	return 0;
> +}
> +
> +static int i2c_mux_reg_select(struct i2c_adapter *adap, void *data,
> +			      unsigned int chan)
> +{
> +	struct regmux *mux = data;
> +
> +	return i2c_mux_reg_set(mux, chan);
> +}
> +
> +static int i2c_mux_reg_deselect(struct i2c_adapter *adap, void *data,
> +				unsigned int chan)
> +{
> +	struct regmux *mux = data;
> +
> +	return i2c_mux_reg_set(mux, mux->data.idle);
> +}
> +
> +#ifdef CONFIG_OF
> +static int i2c_mux_reg_probe_dt(struct regmux *mux,
> +					struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *adapter_np, *child;
> +	struct i2c_adapter *adapter;
> +	struct resource res;
> +	unsigned *values;
> +	int i = 0;
> +
> +	if (!np)
> +		return -ENODEV;
> +
> +	adapter_np = of_parse_phandle(np, "i2c-parent", 0);
> +	if (!adapter_np) {
> +		dev_err(&pdev->dev, "Cannot parse i2c-parent\n");
> +		return -ENODEV;
> +	}
> +	adapter = of_find_i2c_adapter_by_node(adapter_np);
> +	if (!adapter) {
> +		dev_err(&pdev->dev, "Cannot find parent bus\n");
> +		return -EPROBE_DEFER;
> +	}
> +	mux->parent = adapter;
> +	mux->data.parent = i2c_adapter_id(adapter);
> +	put_device(&adapter->dev);
> +
> +	mux->data.n_values = of_get_child_count(np);
> +
> +	values = devm_kzalloc(&pdev->dev,
> +			      sizeof(*mux->data.values) * mux->data.n_values,
> +			      GFP_KERNEL);
> +	if (!values) {
> +		dev_err(&pdev->dev, "Cannot allocate values array");
> +		return -ENOMEM;
> +	}
> +
> +	for_each_child_of_node(np, child) {
> +		of_property_read_u32(child, "reg", values + i);
> +		i++;
> +	}
> +	mux->data.values = values;
> +
> +	if (of_property_read_u32(np, "idle-state", &mux->data.idle))
> +		mux->data.idle = I2C_MUX_REG_NO_IDLE;
> +
> +	/* map address from "reg" if exists */
> +	if (!of_address_to_resource(np, 0, &res)) {
> +		mux->data.reg = devm_ioremap_resource(&pdev->dev, &res);
> +		if (IS_ERR(mux->data.reg))
> +			return PTR_ERR(mux->data.reg);
> +	}
> +
> +	return 0;
> +}
> +#else
> +static int i2c_mux_reg_probe_dt(struct gpiomux *mux,
> +					struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +#endif
> +
> +static int i2c_mux_reg_probe(struct platform_device *pdev)
> +{
> +	struct regmux *mux;
> +	struct i2c_adapter *parent;
> +	struct resource *res;
> +	int (*deselect)(struct i2c_adapter *, void *, u32);
> +	unsigned int initial_state, class;
> +	int i, ret, nr;
> +
> +	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
> +	if (!mux)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, mux);
> +
> +	if (dev_get_platdata(&pdev->dev)) {
> +		memcpy(&mux->data, dev_get_platdata(&pdev->dev),
> +			sizeof(mux->data));
> +
> +		parent = i2c_get_adapter(mux->data.parent);
> +		if (!parent) {
> +			dev_err(&pdev->dev, "Parent adapter (%d) not found\n",
> +				mux->data.parent);
> +			return -EPROBE_DEFER;
> +		}
> +		mux->parent = parent;
> +		i2c_put_adapter(parent);

You should only give up this reference in remove() function of your driver.

> +	} else {
> +		ret = i2c_mux_reg_probe_dt(mux, pdev);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "Cannot locate device tree");
> +			return ret;
> +		}
> +	}
> +
> +	if (!mux->data.reg) {
> +		dev_info(&pdev->dev,
> +			"Register not set, using platform resource\n");
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		mux->data.reg = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(mux->data.reg))
> +			return PTR_ERR(mux->data.reg);
> +	}
> +
> +	mux->adap = devm_kzalloc(&pdev->dev,
> +				 sizeof(*mux->adap) * mux->data.n_values,
> +				 GFP_KERNEL);
> +	if (!mux->adap) {
> +		dev_err(&pdev->dev, "Cannot allocate i2c_adapter structure");
> +		return -ENOMEM;
> +	}
> +
> +	if (mux->data.idle != I2C_MUX_REG_NO_IDLE) {
> +		initial_state = mux->data.idle;
> +		deselect = i2c_mux_reg_deselect;
> +	} else {
> +		initial_state = mux->data.values[0];
> +		deselect = NULL;
> +	}
> +
> +	for (i = 0; i < mux->data.n_values; i++) {
> +		nr = mux->data.base_nr ? (mux->data.base_nr + i) : 0;
> +		class = mux->data.classes ? mux->data.classes[i] : 0;
> +
> +		mux->adap[i] = i2c_add_mux_adapter(mux->parent, &pdev->dev, mux,
> +						   nr, mux->data.values[i],
> +						   class, i2c_mux_reg_select,
> +						   deselect);
> +		if (!mux->adap[i]) {
> +			ret = -ENODEV;
> +			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
> +			goto add_adapter_failed;
> +		}
> +	}
> +
> +	dev_info(&pdev->dev, "%d port mux on %s adapter\n",
> +		 mux->data.n_values, mux->parent->name);

This could be dev_dbg() also, IMHO, as this information has very little value.

> +
> +	return 0;
> +
> +add_adapter_failed:
> +	for (; i > 0; i--)
> +		i2c_del_mux_adapter(mux->adap[i - 1]);
> +
> +	return ret;
> +}
> +
> +static int i2c_mux_reg_remove(struct platform_device *pdev)
> +{
> +	struct regmux *mux = platform_get_drvdata(pdev);
> +	int i;
> +
> +	for (i = 0; i < mux->data.n_values; i++)
> +		i2c_del_mux_adapter(mux->adap[i]);
> +
> +	i2c_put_adapter(mux->parent);
> +
> +	dev_info(&pdev->dev, "Removed\n");

I would say, only dev_dbg() is allowed here, otherwise it's a noise.

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id i2c_mux_reg_of_match[] = {
> +	{ .compatible = "i2c-mux-reg", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, i2c_mux_reg_of_match);
> +
> +static struct platform_driver i2c_mux_reg_driver = {
> +	.probe	= i2c_mux_reg_probe,
> +	.remove	= i2c_mux_reg_remove,
> +	.driver	= {
> +		.owner	= THIS_MODULE,
> +		.name	= "i2c-mux-reg",
> +	},
> +};
> +
> +module_platform_driver(i2c_mux_reg_driver);
> +
> +MODULE_DESCRIPTION("Register-based I2C multiplexer driver");
> +MODULE_AUTHOR("York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:i2c-mux-reg");
> diff --git a/drivers/i2c/muxes/i2c-mux-reg.h b/drivers/i2c/muxes/i2c-mux-reg.h
> new file mode 100644
> index 0000000..e213988
> --- /dev/null
> +++ b/drivers/i2c/muxes/i2c-mux-reg.h
> @@ -0,0 +1,38 @@
> +/*
> + * I2C multiplexer using a single register
> + *
> + * Copyright 2015 Freescale Semiconductor
> + * York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __LINUX_I2C_MUX_REG_H
> +#define __LINUX_I2C_MUX_REG_H
> +
> +/* MUX has no specific idel mode */
                          ^^^^

> +#define I2C_MUX_REG_NO_IDLE	((unsigned)-1)

What if the idle state is exactly "all ones"? Quite important corner case actually...

> +
> +/**
> + * struct i2c_mux_reg_platform_data - Platform-dependent data for i2c-mux-reg
> + * @parent: Parent I2C bus adapter number
> + * @base_nr: Base I2C bus number to number adapters from or zero for dynamic
> + * @values: Array of value for each channel
> + * @n_values: Number of multiplexer channels
> + * @classes: Optional I2C auto-detection classes
> + * @idle: Value to write to mux when idle
> + * @reg: Virtual address of the register to switch channel
> + */
> +struct i2c_mux_reg_platform_data {
> +	int parent;
> +	int base_nr;
> +	const unsigned int *values;
> +	int n_values;
> +	const unsigned int *classes;
> +	unsigned int idle;
> +	unsigned int *reg;

Yeah, this is really bad idea. You maybe want something like
__iomem "cookie" here instead of this bare pointer.

> +};
> +
> +#endif	/* __LINUX_I2C_MUX_REG_H */
> 

Other than the mentioned above, this is a useful code.

-- 
Best regards,
Alexander Sverdlin.
