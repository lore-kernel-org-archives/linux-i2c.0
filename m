From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c: add driver for Freescale i.MX28
Date: Thu, 27 Jan 2011 01:02:17 +0000
Message-ID: <4D40C419.8080508@fluff.org>
References: <1295866245-30203-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1295866245-30203-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 24/01/11 10:50, Wolfram Sang wrote:
> Currently only supporting the PIOQUEUE-mode, because DMA-support for
> this platform is not yet available. When it becomes available and
> support has been added to this driver, it will also be suitable for
> i.MX23 and STMP3xxx.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig   |   10 +
>  drivers/i2c/busses/Makefile  |    1 +
>  drivers/i2c/busses/i2c-mxs.c |  383 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 394 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-mxs.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 3a6321c..25e2dc7 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -452,6 +452,16 @@ config I2C_MV64XXX
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-mv64xxx.
>  
> +config I2C_MXS
> +	tristate "Freescale i.MX28 I2C interface"
> +	depends on SOC_IMX28
> +	help
> +	  Say Y here if you want to use the I2C bus controller on
> +	  the Freescale i.MX28 processors.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-mxs.
> +
>  config I2C_NOMADIK
>  	tristate "ST-Ericsson Nomadik/Ux500 I2C Controller"
>  	depends on PLAT_NOMADIK
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 84cb16a..f415132 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
>  obj-$(CONFIG_I2C_IXP2000)	+= i2c-ixp2000.o
>  obj-$(CONFIG_I2C_MPC)		+= i2c-mpc.o
>  obj-$(CONFIG_I2C_MV64XXX)	+= i2c-mv64xxx.o
> +obj-$(CONFIG_I2C_MXS)		+= i2c-mxs.o
>  obj-$(CONFIG_I2C_NOMADIK)	+= i2c-nomadik.o
>  obj-$(CONFIG_I2C_NUC900)	+= i2c-nuc900.o
>  obj-$(CONFIG_I2C_OCORES)	+= i2c-ocores.o
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> new file mode 100644
> index 0000000..b80233b
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -0,0 +1,383 @@
> +/*
> + * Freescale MXS I2C bus driver
> + *
> + * Copyright (C) 2011 Wolfram Sang, Pengutronix e.K.
> + *
> + * based on a (broken) driver which was:
> + *
> + * Copyright (C) 2009-2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * TODO: add dma-support if platform-support for it is available
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/completion.h>
> +#include <linux/platform_device.h>
> +#include <linux/jiffies.h>
> +#include <linux/io.h>
> +
> +#include <mach/common.h>

do we actually use anything from the above?

> +struct mxs_i2c_dev {
> +	struct device *dev;
> +	void __iomem *regs;
> +	struct completion cmd_complete;
> +	u32 cmd_err;
> +	struct i2c_adapter adapter;
> +};

kerneldoc the above would be helpful.

> +
> +static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
> +{
> +	mxs_reset_block(i2c->regs);
> +	__raw_writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
> +}

readl/writel are the usual way to use ioremaped() memory. If there's an
exception here, please document why.


> +static void mxs_i2c_pioq_setup_write(struct mxs_i2c_dev *i2c,
> +				    u8 addr, u8 *buf, int len, int flags)
> +{
> +	u32 data;
> +	int i, shifts_left;
> +
> +	data = MXS_CMD_I2C_WRITE | MXS_I2C_CTRL0_XFER_COUNT(len + 1) | flags;
> +	__raw_writel(data, i2c->regs + MXS_I2C_QUEUECMD);
> +
> +	/* Start with address, then append buffer */
> +	data = ((addr << 1) | I2C_SMBUS_WRITE) << 24;
> +
> +	for (i = 0; i < len; i++) {
> +		data >>= 8;
> +		data |= buf[i] << 24;
> +		if ((i & 3) == 2)
> +			__raw_writel(data, i2c->regs + MXS_I2C_DATA);
> +	}
> +
> +	shifts_left = 24 - (i & 3) * 8;
> +	if (shifts_left)
> +		__raw_writel(data >> shifts_left, i2c->regs + MXS_I2C_DATA);
> +}

I'm going to have a think about the above, since it looks rather
hard to understand. Any chance of re-writing this?

> +static int mxs_i2c_wait_for_data(struct mxs_i2c_dev *i2c)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
> +
> +	while (__raw_readl(i2c->regs + MXS_I2C_QUEUESTAT)
> +			& MXS_I2C_QUEUESTAT_RD_QUEUE_EMPTY) {
> +			if (time_after(jiffies, timeout))
> +				return -ETIMEDOUT;
> +			cond_resched();
> +	}
> +
> +	return 0;
> +}

surely there's a relevant wait_event here?


> +static int __devinit mxs_i2c_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mxs_i2c_dev *i2c;
> +	struct i2c_adapter *adap;
> +	struct resource *res;
> +	resource_size_t res_size;
> +	int err, irq;
> +
> +	i2c = devm_kzalloc(dev, sizeof(struct mxs_i2c_dev), GFP_KERNEL);
> +	if (!i2c)
> +		return -ENOMEM;

Possibly be worth printing an error.

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;

-ENODEV gets ignored by the platform bus probe.

> +
> +	res_size = resource_size(res);
> +	if (!devm_request_mem_region(dev, res->start, res_size, res->name))
> +		return -EBUSY;
> +
> +	i2c->regs = devm_ioremap_nocache(dev, res->start, res_size);
> +	if (!i2c->regs)
> +		return -EBUSY;

Maybe there should be a devm request to do all of the above in one go.

> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	err = devm_request_irq(dev, irq, mxs_i2c_isr, 0, dev_name(dev), i2c);
> +	if (err)
> +		return err;
> +
> +	i2c->dev = dev;
> +	platform_set_drvdata(pdev, i2c);
> +
> +	/* Do reset to enforce correct startup after pinmuxing */
> +	mxs_i2c_reset(i2c);
> +	__raw_writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
> +			i2c->regs + MXS_I2C_QUEUECTRL_SET);
> +
> +	adap = &i2c->adapter;
> +	strncpy(adap->name, "MXS I2C adapter", sizeof(adap->name));

isn't there a version of this call that ensures proper termination
of the string if it is too long?


> +static struct platform_driver mxs_i2c_driver = {
> +	.driver = {
> +		   .name = "mxs-i2c",
> +		   .owner = THIS_MODULE,
> +		   },
> +	.remove = __devexit_p(mxs_i2c_remove),
> +};
> +
> +static int __init mxs_i2c_init(void)
> +{
> +	return platform_driver_probe(&mxs_i2c_driver, mxs_i2c_probe);
> +}
> +subsys_initcall(mxs_i2c_init);

no assumption of hot plug platform devices?
