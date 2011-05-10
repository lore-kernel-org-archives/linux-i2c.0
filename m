From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c: Adding the i2c-bit-platform bus
Date: Tue, 10 May 2011 23:35:56 +0100
Message-ID: <20110510223556.GD634@freya.fluff.org>
References: <BANLkTi=JtYdJr+0Dv32r-sCTgE-Eom2CJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BANLkTi=JtYdJr+0Dv32r-sCTgE-Eom2CJQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?iso-8859-1?Q?H=E5vard?= Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, May 07, 2011 at 02:53:05PM +0300, Eran Duchan wrote:
> Hi guys,
> 
> Following the discussion on the matter of i2c-gpio performance, I'm
> submitting this very simple patch which adds i2c-bit-platform. Using
> this driver, a platform can register callbacks called by i2c-bit-algo
> so that it can modify GPIO pins directly or do pretty much anything
> else. Besides style, I see 2 points for discussion:
> 
> 1) Should the i2c-bit-platform call setscl/setsda passing state to 1
> (so that SDA/SCL are explicitly pulled high) on probe or should this
> be implemented in the platforms which mandate this? In the patch I
> left it up to the platform.

I'd check it isn't done by the algobit driver already.
 
> 2) Which platform_data structure is passed to the driver? There are
> three options:
> 2.a) Currently in the patch - just expect a i2c_algo_bit_data
> structure. No new structures introduced, but this does expose some
> underlying bit-algo detail to the platform and does not elegantly
> support passing any future i2c-bit-platform specific fields, should
> they be required.
> 2.b) Declare a new platform structure which has a i2c_algo_bit_data
> member (for supporting future i2c-bit-platform fields). Solves the
> future field issue but still exposes so bit-algo stuff to the platform
> 2.c) Declare a new platform structure with members similar to
> i2c_algo_bit_data, but only those who should be exposed to the
> platform. The only downside to this is that any future change to
> i2c_algo_bit_data may require change to this new platform structure.
> 
> Tested on an MPC875 running @ 50MHz to achieve near perfect 100kHz I2C.

I'd probably go for the 'c' option and copy them across on probe so
that if the driver gets changed the whole system doesn't have to get
re-compiled.
 
> Eran
> 
> Signed-off-by: Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig            |   10 +++
>  drivers/i2c/busses/Makefile           |    1 +
>  drivers/i2c/busses/i2c-bit-platform.c |  105 +++++++++++++++++++++++++++++++++
>  3 files changed, 116 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-bit-platform.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 3a6321c..f6c6b8c 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -365,6 +365,16 @@ config I2C_GPIO
>  	  This is a very simple bitbanging I2C driver utilizing the
>  	  arch-neutral GPIO API to control the SCL and SDA lines.
> 
> +config I2C_BIT_PLATFORM
> +	tristate "I2c-bit-algo as platform device"
> +	select I2C_ALGOBIT
> +	help
> +	  An I2C bus adapter which delegates the bit-algo callback registration
> +	  to the platform. Useful in cases where existing adapters such as
> +	  i2c-gpio are too slow. Keep in mind that no resource locking of any kind
> +	  is performed by the adapter or algo, so any such contention must be
> +	  handled by the platform.
> +
>  config I2C_HIGHLANDER
>  	tristate "Highlander FPGA SMBus interface"
>  	depends on SH_HIGHLANDER
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 84cb16a..65bced4 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_I2C_CPM)		+= i2c-cpm.o
>  obj-$(CONFIG_I2C_DAVINCI)	+= i2c-davinci.o
>  obj-$(CONFIG_I2C_DESIGNWARE)	+= i2c-designware.o
>  obj-$(CONFIG_I2C_GPIO)		+= i2c-gpio.o
> +obj-$(CONFIG_I2C_BIT_PLATFORM)	+= i2c-bit-platform.o
>  obj-$(CONFIG_I2C_HIGHLANDER)	+= i2c-highlander.o
>  obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
>  obj-$(CONFIG_I2C_IMX)		+= i2c-imx.o
> diff --git a/drivers/i2c/busses/i2c-bit-platform.c
> b/drivers/i2c/busses/i2c-bit-platform.c
> new file mode 100644
> index 0000000..cb98006
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-bit-platform.c
> @@ -0,0 +1,105 @@
> +/*
> +    i2c-bit-algo as platform device
> +    Delegates the bit-algo callback registration to the platform
> +
> +    Copyright (C) 2011 Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> +
> +    This program is free software; you can redistribute it and/or modify
> +    it under the terms of the GNU General Public License as published by
> +    the Free Software Foundation; either version 2 of the License, or
> +    (at your option) any later version.
> +*/
> +
> +#include <linux/i2c.h>
> +#include <linux/i2c-algo-bit.h>
> +#include <linux/slab.h>
> +
> +static int __devinit i2c_bit_platform_probe(struct platform_device *pdev)
> +{
> +	struct i2c_algo_bit_data *bit_data;
> +	struct i2c_adapter *adap;
> +	int ret;
> +
> +	if (pdev->dev.platform_data == NULL)
> +		ret = -ENXIO;

minor point, this will probably not get shown by the bus layer.
Not sure what's best here, some people don't like -ENOENT here.

> +	bit_data = pdev->dev.platform_data;
> +
> +	ret = -ENOMEM;
> +	adap = kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
> +	if (adap == NULL)
> +		goto err_alloc_adap;
> +
> +	adap->owner = THIS_MODULE;
> +	adap->algo_data = bit_data;
> +	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
> +	adap->dev.parent = &pdev->dev;
> +
> +	snprintf(adap->name, sizeof(adap->name), "i2c-bit-platform%d",
> +			 pdev->id);
> +	adap->name[sizeof(adap->name) - 1] = '\0';
> +
> +	/*
> +	 * If "dev->id" is negative we consider it as zero.
> +	 * The reason to do so is to avoid sysfs names that only make
> +	 * sense when there are multiple adapters.
> +	 */
> +	adap->nr = (pdev->id != -1) ? pdev->id : 0;
> +	ret = i2c_bit_add_numbered_bus(adap);
> +	if (ret)
> +		goto err_add_bus;
> +
> +	platform_set_drvdata(pdev, adap);
> +
> +	return 0;
> +
> +err_add_bus:
> +err_alloc_adap:
> +
> +	kfree(adap);
> +
> +	return ret;
> +}
> +
> +static int __devexit i2c_bit_platform_remove(struct platform_device *pdev)
> +{
> +	struct i2c_adapter *adap;
> +
> +	adap = platform_get_drvdata(pdev);
> +
> +	i2c_del_adapter(adap);
> +	kfree(adap);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver i2c_bit_platform_driver = {
> +	.driver		= {
> +		.name	= "i2c-bit-platform",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= i2c_bit_platform_probe,
> +	.remove		= __devexit_p(i2c_bit_platform_remove),
> +};
> +
> +static int __init i2c_bit_platform_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&i2c_bit_platform_driver);
> +	if (ret)
> +		printk(KERN_ERR "i2c-bit-platform: probe failed: %d\n", ret);
> +
> +	return ret;
> +}
> +subsys_initcall(i2c_bit_platform_init);
> +
> +static void __exit i2c_bit_platform_exit(void)
> +{
> +	platform_driver_unregister(&i2c_bit_platform_driver);
> +}
> +module_exit(i2c_bit_platform_exit);
> +
> +MODULE_AUTHOR("Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
> +MODULE_DESCRIPTION("Thin platform adapter for i2c-bit-algo");
> +MODULE_LICENSE("GPL");
> -- 
> 1.7.0.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
