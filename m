From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCHv2 3/3] Add platform driver on top of the new
 pca-algorithm
Date: Tue, 12 Feb 2008 22:53:06 +0100
Message-ID: <20080212225306.4cf2bd74@hyperion.delvare>
References: <20080206202056.364404622@pengutronix.de>
	<20080206203037.228001815@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080206203037.228001815-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Wed, 06 Feb 2008 21:20:59 +0100, Wolfram Sang wrote:
> Tested on a blackfin.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> ---
>  drivers/i2c/busses/Kconfig            |   11 +
>  drivers/i2c/busses/Makefile           |    1 
>  drivers/i2c/busses/i2c-pca-platform.c |  278 ++++++++++++++++++++++++++++++++++
>  include/linux/i2c-pca-platform.h      |   12 +
>  4 files changed, 302 insertions(+)
> 
> Index: linux-playground/drivers/i2c/busses/i2c-pca-platform.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-playground/drivers/i2c/busses/i2c-pca-platform.c	2008-02-06 20:15:54.000000000 +0100
> @@ -0,0 +1,278 @@
> +/*
> + *  i2c_pca_platform.c
> + *
> + *  Platform driver for the PCA9564 I2C controller.
> + *
> + *  Copyright (C) 2008 Pengutronix
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/i2c-algo-pca.h>
> +#include <linux/i2c-pca-platform.h>
> +
> +#include <asm/irq.h>
> +#include <asm/io.h>
> +
> +#ifdef GENERIC_GPIO
> +#include <asm/gpio.h>
> +#endif
> +
> +#define res_len(r)		((r)->end - (r)->start + 1)
> +
> +struct i2c_pca_pf_data {
> +	void __iomem			*reg_base;
> +	int				irq;	/* if 0, use polling */
> +	wait_queue_head_t		wait;
> +	struct i2c_adapter		adap;
> +	struct i2c_algo_pca_data	algo_data;
> +	unsigned long			io_base;
> +	unsigned long			io_size;
> +};
> +
> +/* Read/Write functions for different register alignments */
> +
> +static int i2c_pca_pf_readbyte8(void *pd, int reg)
> +{
> +	struct i2c_pca_pf_data *i2c = pd;
> +	return ioread8(i2c->reg_base + reg);
> +}
> +
> +static int i2c_pca_pf_readbyte16(void *pd, int reg)
> +{
> +	struct i2c_pca_pf_data *i2c = pd;
> +	return ioread8(i2c->reg_base + reg * 2);

Shouldn't this be ioread16?

> +}
> +
> +static int i2c_pca_pf_readbyte32(void *pd, int reg)
> +{
> +	struct i2c_pca_pf_data *i2c = pd;
> +	return ioread8(i2c->reg_base + reg * 4);
> +}

And ioread32?

> +
> +static void i2c_pca_pf_writebyte8(void *pd, int reg, int val)
> +{
> +	struct i2c_pca_pf_data *i2c = pd;
> +	iowrite8(val, i2c->reg_base + reg);
> +}
> +
> +static void i2c_pca_pf_writebyte16(void *pd, int reg, int val)
> +{
> +	struct i2c_pca_pf_data *i2c = pd;
> +	iowrite8(val, i2c->reg_base + reg * 2);
> +}
> +
> +static void i2c_pca_pf_writebyte32(void *pd, int reg, int val)
> +{
> +	struct i2c_pca_pf_data *i2c = pd;
> +	iowrite8(val, i2c->reg_base + reg * 4);
> +}
> +
> +
> +static int i2c_pca_pf_waitforcompletion(void *pd)
> +{
> +	struct i2c_pca_pf_data *i2c = pd;
> +	int ret = 0;
> +
> +	if (i2c->irq) {
> +		ret = wait_event_interruptible(i2c->wait,
> +			i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
> +			& I2C_PCA_CON_SI);
> +	} else {
> +		while ((i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
> +				& I2C_PCA_CON_SI) == 0)
> +			udelay(100);

No timeout?

> +	}
> +
> +	return ret;
> +}
> +
> +static void i2c_pca_pf_dummyreset(void *pd)
> +{
> +	struct i2c_pca_pf_data *i2c = pd;
> +	dev_warn(&i2c->adap.dev, "No reset-pin found. Chip may get stuck!\n");
> +}
> +
> +#ifdef GENERIC_GPIO
> +static void i2c_pca_pf_resetchip(void *pd)
> +{
> +	struct i2c_pca_pf_data *i2c = pd;
> +	struct i2c_pca9564_pf_platform_data *platform_data =
> +			i2c->adap.dev.parent->platform_data;
> +
> +	gpio_set_value(platform_data->gpio, 0);

The i2c_clock gets to be copied to the driver data structure, but for
the gpio you have to fetch it from the platform device data? Not very
consistent.

> +	ndelay(100);
> +	gpio_set_value(platform_data->gpio, 1);
> +}
> +#endif
> +
> +static irqreturn_t i2c_pca_pf_handler(int this_irq, void *dev_id)
> +{
> +	struct i2c_pca_pf_data *i2c = dev_id;
> +
> +	if ((i2c->algo_data.read_byte(i2c, I2C_PCA_CON) & I2C_PCA_CON_SI) == 0)
> +		return IRQ_NONE;
> +
> +	wake_up_interruptible(&i2c->wait);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +
> +static int i2c_pca_pf_probe(struct platform_device *pdev)
> +{
> +	struct i2c_pca_pf_data *i2c;
> +	struct resource *res;
> +	struct i2c_pca9564_pf_platform_data *platform_data =
> +				pdev->dev.platform_data;
> +	int ret;
> +	int irq;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	irq = platform_get_irq(pdev, 0);
> +	/* If irq is 0, we do polling. */
> +
> +	if (res == NULL)
> +		return -ENODEV;
> +
> +	if (!request_mem_region(res->start, res_len(res), res->name))
> +		return -ENOMEM;
> +
> +	i2c = kzalloc(sizeof(struct i2c_pca_pf_data), GFP_KERNEL);
> +	if (!i2c) {
> +		ret = -ENOMEM;
> +		goto e_alloc;
> +	}
> +
> +	init_waitqueue_head(&i2c->wait);
> +
> +	i2c->adap.nr = pdev->id >= 0 ? pdev->id : 0;
> +
> +	i2c->adap.owner   = THIS_MODULE;

No alignment in code please.

> +	snprintf(i2c->adap.name, sizeof(i2c->adap.name), "i2c-pca9564.%u",
> +		pdev->id);

That's a bit confusing given that the driver isn't named i2c-pca9564.
Other drivers usually include the address to distinguish between
multiple device for example (..., "PCA9564 adapter at %04lx",
res->start).

> +	i2c->adap.algo_data 	= &i2c->algo_data;
> +	i2c->adap.dev.parent 	= &pdev->dev;
> +	i2c->adap.timeout	= platform_data->timeout;
> +
> +	i2c->reg_base = ioremap(res->start, res_len(res));
> +	if (!i2c->reg_base) {
> +		ret = -EIO;
> +		goto e_remap;
> +	}
> +	i2c->io_base	= res->start;
> +	i2c->io_size	= res_len(res);
> +	i2c->irq	= irq;
> +
> +	i2c->algo_data.i2c_clock	= platform_data->i2c_clock_speed;
> +	i2c->algo_data.data		= i2c;
> +
> +	switch (res->flags & IORESOURCE_MEM_TYPE_MASK) {
> +	case IORESOURCE_MEM_32BIT:
> +		i2c->algo_data.write_byte	= i2c_pca_pf_writebyte32;
> +		i2c->algo_data.read_byte	= i2c_pca_pf_readbyte32;
> +		break;
> +	case IORESOURCE_MEM_16BIT:
> +		i2c->algo_data.write_byte	= i2c_pca_pf_writebyte16;
> +		i2c->algo_data.read_byte	= i2c_pca_pf_readbyte16;
> +		break;
> +	case IORESOURCE_MEM_8BIT:
> +	default:
> +		i2c->algo_data.write_byte	= i2c_pca_pf_writebyte8;
> +		i2c->algo_data.read_byte	= i2c_pca_pf_readbyte8;
> +		break;
> +	}
> +
> +	i2c->algo_data.wait_for_completion	= i2c_pca_pf_waitforcompletion;
> +
> +#ifdef GENERIC_GPIO
> +	/* Use NO_GPIO if this macro is in kernel somwhen? */

No "somwhen" in my dictionary.

> +	if (platform_data->gpio > -1)
> +		i2c->algo_data.reset_chip	= i2c_pca_pf_resetchip;
> +	else
> +		i2c->algo_data.reset_chip	= i2c_pca_pf_dummyreset;
> +#else
> +	i2c->algo_data.reset_chip	= i2c_pca_pf_dummyreset;
> +#endif
> +	if (irq) {
> +		ret = request_irq(irq, i2c_pca_pf_handler,
> +			IRQF_TRIGGER_FALLING, i2c->adap.name, i2c);
> +		if (ret)
> +			goto e_reqirq;
> +	}
> +
> +	if (i2c_pca_add_numbered_bus(&i2c->adap) < 0) {
> +		dev_err(&i2c->adap.dev, "Failed to add PCA9564\n");
> +		goto e_adapt;
> +	}
> +
> +	platform_set_drvdata(pdev, i2c);
> +
> +	dev_info(&i2c->adap.dev, "PCA9564 registered.\n");
> +	return 0;
> +
> +e_adapt:
> +	if (irq)
> +		free_irq(irq, i2c);
> +e_reqirq:
> +	iounmap(i2c->reg_base);
> +e_remap:
> +	kfree(i2c);
> +e_alloc:
> +	release_mem_region(res->start, res_len(res));
> +	return ret;
> +}
> +
> +static int i2c_pca_pf_remove(struct platform_device *pdev)

Missing __devexit.

> +{
> +	struct i2c_pca_pf_data *i2c = platform_get_drvdata(pdev);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	i2c_del_adapter(&i2c->adap);
> +
> +	if (i2c->irq)
> +		free_irq(i2c->irq, i2c);
> +
> +	iounmap(i2c->reg_base);
> +	release_mem_region(i2c->io_base, i2c->io_size);
> +	kfree(i2c);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver i2c_pca_pf_driver = {
> +	.probe		= i2c_pca_pf_probe,
> +	.remove		= __devexit_p(i2c_pca_pf_remove),
> +	.driver		= {
> +		.name	= "pca9564_platform",

Missing .owner = THIS_MODULE.

> +	},
> +};
> +
> +static int __init i2c_pca_pf_init(void)
> +{
> +	return platform_driver_register(&i2c_pca_pf_driver);
> +}
> +
> +static void __exit i2c_pca_pf_exit(void)
> +{
> +	platform_driver_unregister(&i2c_pca_pf_driver);
> +}
> +
> +MODULE_AUTHOR("Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
> +MODULE_DESCRIPTION("I2C-PCA9564 platform driver");
> +MODULE_LICENSE("GPL");
> +
> +module_init(i2c_pca_pf_init);
> +module_exit(i2c_pca_pf_exit);
> +
> Index: linux-playground/drivers/i2c/busses/Kconfig
> ===================================================================
> --- linux-playground.orig/drivers/i2c/busses/Kconfig	2008-02-06 20:15:36.000000000 +0100
> +++ linux-playground/drivers/i2c/busses/Kconfig	2008-02-06 20:15:54.000000000 +0100
> @@ -641,6 +641,17 @@
>  	  delays when I2C/SMBus chip drivers are loaded (e.g. at boot
>  	  time).  If unsure, say N.
>  
> +config I2C_PCA_PLATFORM
> +	tristate "PCA9564 as platform device"
> +	select I2C_ALGOPCA
> +	default n
> +	help
> +	  This driver supports a memory mapped Philips PCA 9564

For consistency, no space between "PCA" and "9564".

> +	  Parallel bus to I2C bus controller

Lowercase P, missing trailing dot.

> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-pca-platform.
> +
>  config I2C_MV64XXX
>  	tristate "Marvell mv64xxx I2C Controller"
>  	depends on (MV64X60 || ARCH_ORION) && EXPERIMENTAL
> Index: linux-playground/drivers/i2c/busses/Makefile
> ===================================================================
> --- linux-playground.orig/drivers/i2c/busses/Makefile	2008-02-06 20:15:36.000000000 +0100
> +++ linux-playground/drivers/i2c/busses/Makefile	2008-02-06 20:15:55.000000000 +0100
> @@ -30,6 +30,7 @@
>  obj-$(CONFIG_I2C_PARPORT_LIGHT)	+= i2c-parport-light.o
>  obj-$(CONFIG_I2C_PASEMI)	+= i2c-pasemi.o
>  obj-$(CONFIG_I2C_PCA_ISA)	+= i2c-pca-isa.o
> +obj-$(CONFIG_I2C_PCA_PLATFORM)	+= i2c-pca-platform.o
>  obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
>  obj-$(CONFIG_I2C_PMCMSP)	+= i2c-pmcmsp.o
>  obj-$(CONFIG_I2C_PNX)		+= i2c-pnx.o
> Index: linux-playground/include/linux/i2c-pca-platform.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-playground/include/linux/i2c-pca-platform.h	2008-02-06 20:15:55.000000000 +0100
> @@ -0,0 +1,12 @@
> +#ifndef I2C_PCA9564_PLATFORM_H
> +#define I2C_PCA9564_PLATFORM_H
> +
> +struct i2c_pca9564_pf_platform_data {

"pf" is redundant with "platform", isn't it?

> +	int gpio;		/* pin to reset chip. driver will work when
> +				 * not supplied (negative value), but it
> +				 * cannot exit some error conditions then */
> +	int i2c_clock_speed;	/* values are defined in linux/i2c-algo-pca.h */
> +	int timeout;		/* timeout = this value * 10us */

A rather curious time unit if you ask me.

> +};
> +
> +#endif /* I2C_PCA9564_PLATFORM_H */
> 


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
