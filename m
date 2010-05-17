From: =?ISO-8859-1?Q?Richard_R=F6jfors?=
	<richard.rojfors.lists-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Subject: Re: [PATCH] i2c-xii.c: Use OF instead of platform bus
Date: Mon, 17 May 2010 20:39:03 +0200
Message-ID: <4BF18D47.2030809@pelagicore.com>
References: <1274117574-1485-1-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1274117574-1485-1-git-send-email-ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 05/17/2010 07:32 PM, Ricardo Ribalda Delgado wrote:
> Xiic cores are seen on ppc and microblaze arches. Both arches are using device-trees
> instead of platform buses to descrive its peripherals.

We have the XIIC exposed as a platform device by a MFD driver on X86.

I think the patch must be more flexible to allow both platform an of devices.

--Richard

>
> This patch ports i2c-xiic.c from platform bus to OF.
>
> ---
>   drivers/i2c/busses/i2c-xiic.c |  121 ++++++++++++++++++++++-------------------
>   1 files changed, 64 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> index a9c419e..62f0ca5 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -2,6 +2,7 @@
>    * i2c-xiic.c
>    * Copyright (c) 2002-2007 Xilinx Inc.
>    * Copyright (c) 2009-2010 Intel Corporation
> + * Copyright (c) 2010 Qtechnology A/S
>    *
>    * This program is free software; you can redistribute it and/or modify
>    * it under the terms of the GNU General Public License version 2 as
> @@ -23,6 +24,8 @@
>    * Mocean Laboratories forked off the GNU/Linux platform work into a
>    * separate company called Pelagicore AB, which commited the code to the
>    * kernel.
> + *
> + * Ricardo Ribalda: Ported from platform device to device tree (OF)
>    */
>
>   /* Supports:
> @@ -33,13 +36,16 @@
>   #include<linux/init.h>
>   #include<linux/errno.h>
>   #include<linux/delay.h>
> -#include<linux/platform_device.h>
>   #include<linux/i2c.h>
>   #include<linux/interrupt.h>
>   #include<linux/wait.h>
>   #include<linux/i2c-xiic.h>
>   #include<linux/io.h>
> +#include<linux/of.h>
> +#include<linux/of_platform.h>
> +#include<linux/of_i2c.h>
>   #include<linux/slab.h>
> +#include<asm/of_device.h>
>
>   #define DRIVER_NAME "xiic-i2c"
>
> @@ -68,11 +74,14 @@ struct xiic_i2c {
>   	struct i2c_adapter	adap;
>   	struct i2c_msg		*tx_msg;
>   	spinlock_t		lock;
> -	unsigned int 		tx_pos;
> +	unsigned int		tx_pos;
>   	unsigned int		nmsgs;
>   	enum xilinx_i2c_state	state;
>   	struct i2c_msg		*rx_msg;
>   	int			rx_pos;
> +	int			irq;
> +	unsigned long		iomem;
> +	size_t			iolen;
>   };
>
>
> @@ -175,27 +184,27 @@ static void __xiic_start_xfer(struct xiic_i2c *i2c);
>
>   static inline void xiic_setreg8(struct xiic_i2c *i2c, int reg, u8 value)
>   {
> -	iowrite8(value, i2c->base + reg);
> +	out_be32(i2c->base + reg,value);
>   }
>
>   static inline u8 xiic_getreg8(struct xiic_i2c *i2c, int reg)
>   {
> -	return ioread8(i2c->base + reg);
> +	return in_be32(i2c->base + reg);
>   }
>
>   static inline void xiic_setreg16(struct xiic_i2c *i2c, int reg, u16 value)
>   {
> -	iowrite16(value, i2c->base + reg);
> +	out_be32(i2c->base + reg,value);
>   }
>
>   static inline void xiic_setreg32(struct xiic_i2c *i2c, int reg, int value)
>   {
> -	iowrite32(value, i2c->base + reg);
> +	out_be32(i2c->base + reg,value);
>   }
>
>   static inline int xiic_getreg32(struct xiic_i2c *i2c, int reg)
>   {
> -	return ioread32(i2c->base + reg);
> +	return in_be32(i2c->base + reg);
>   }
>
>   static inline void xiic_irq_dis(struct xiic_i2c *i2c, u32 mask)
> @@ -362,7 +371,7 @@ static void xiic_process(struct xiic_i2c *i2c)
>   		 * this is probably a TX error
>   		 */
>
> -		dev_dbg(i2c->adap.dev.parent, "%s error\n", __func__);
> +		dev_err(i2c->adap.dev.parent, "%s error\n", __func__);
>
>   		/* dynamic mode seem to suffer from problems if we just flushes
>   		 * fifos and the next message is a TX with len 0 (only addr)
> @@ -378,7 +387,7 @@ static void xiic_process(struct xiic_i2c *i2c)
>
>   		clr = XIIC_INTR_RX_FULL_MASK;
>   		if (!i2c->rx_msg) {
> -			dev_dbg(i2c->adap.dev.parent,
> +			dev_err(i2c->adap.dev.parent,
>   				"%s unexpexted RX IRQ\n", __func__);
>   			xiic_clear_rx_fifo(i2c);
>   			goto out;
> @@ -687,122 +696,120 @@ static struct i2c_adapter xiic_adapter = {
>   	.algo		=&xiic_algorithm,
>   };
>
> -
> -static int __devinit xiic_i2c_probe(struct platform_device *pdev)
> +static int __init
> +xiic_i2c_probe(struct of_device *op, const struct of_device_id *match)
>   {
> -	struct xiic_i2c *i2c;
> -	struct xiic_i2c_platform_data *pdata;
> -	struct resource *res;
> -	int ret, irq;
> -	u8 i;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		goto resource_missing;
> -
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq<  0)
> -		goto resource_missing;
>
> -	pdata = (struct xiic_i2c_platform_data *) pdev->dev.platform_data;
> -	if (!pdata)
> -		return -EINVAL;
> +	struct xiic_i2c *i2c;
> +	struct resource mem;
> +	int ret;
>
>   	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
>   	if (!i2c)
>   		return -ENOMEM;
>
> -	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
> -		dev_err(&pdev->dev, "Memory region busy\n");
> +	i2c->irq=irq_of_parse_and_map(op->node,0);
> +	if (!i2c->irq)
> +		goto resource_missing;
> +
> +	if (of_address_to_resource(op->node,0,&mem))
> +		goto resource_missing;
> +	i2c->iomem=mem.start;
> +	i2c->iolen=mem.end-mem.start+1;
> +
> +	if (!request_mem_region(i2c->iomem, i2c->iolen, DRIVER_NAME)) {
> +		dev_err(&op->dev, "Memory region busy\n");
>   		ret = -EBUSY;
>   		goto request_mem_failed;
>   	}
>
> -	i2c->base = ioremap(res->start, resource_size(res));
> +	i2c->base = ioremap(i2c->iomem, i2c->iolen);
>   	if (!i2c->base) {
> -		dev_err(&pdev->dev, "Unable to map registers\n");
> +		dev_err(&op->dev, "Unable to map registers\n");
>   		ret = -EIO;
>   		goto map_failed;
>   	}
>
>   	/* hook up driver to tree */
> -	platform_set_drvdata(pdev, i2c);
> +	dev_set_drvdata(&op->dev, i2c);
>   	i2c->adap = xiic_adapter;
>   	i2c_set_adapdata(&i2c->adap, i2c);
> -	i2c->adap.dev.parent =&pdev->dev;
> +	i2c->adap.dev.parent =&op->dev;
>
>   	xiic_reinit(i2c);
>
>   	spin_lock_init(&i2c->lock);
>   	init_waitqueue_head(&i2c->wait);
> -	ret = request_irq(irq, xiic_isr, 0, pdev->name, i2c);
> +	ret = request_irq(i2c->irq, xiic_isr, 0, DRIVER_NAME, i2c);
>   	if (ret) {
> -		dev_err(&pdev->dev, "Cannot claim IRQ\n");
> +		dev_err(&op->dev, "Cannot claim IRQ\n");
>   		goto request_irq_failed;
>   	}
>
>   	/* add i2c adapter to i2c tree */
> +	i2c->adap.id=0;
>   	ret = i2c_add_adapter(&i2c->adap);
>   	if (ret) {
> -		dev_err(&pdev->dev, "Failed to add adapter\n");
> +		dev_err(&op->dev, "Failed to add adapter\n");
>   		goto add_adapter_failed;
>   	}
>
> -	/* add in known devices to the bus */
> -	for (i = 0; i<  pdata->num_devices; i++)
> -		i2c_new_device(&i2c->adap, pdata->devices + i);
> +	of_register_i2c_devices(&i2c->adap, op->node);
>
>   	return 0;
>
>   add_adapter_failed:
> -	free_irq(irq, i2c);
> +	free_irq(i2c->irq, i2c);
>   request_irq_failed:
>   	xiic_deinit(i2c);
>   	iounmap(i2c->base);
>   map_failed:
> -	release_mem_region(res->start, resource_size(res));
> +	release_mem_region(i2c->iomem, i2c->iolen);
>   request_mem_failed:
> -	kfree(i2c);
>
>   	return ret;
>   resource_missing:
> -	dev_err(&pdev->dev, "IRQ or Memory resource is missing\n");
> +	kfree(i2c);
> +	dev_err(&op->dev, "IRQ or Memory resource is missing\n");
>   	return -ENOENT;
>   }
>
> -static int __devexit xiic_i2c_remove(struct platform_device* pdev)
> +
> +static int __devexit xiic_i2c_remove(struct of_device *op)
>   {
> -	struct xiic_i2c *i2c = platform_get_drvdata(pdev);
> -	struct resource *res;
> +	struct xiic_i2c *i2c = dev_get_drvdata(&op->dev);
>
>   	/* remove adapter&  data */
>   	i2c_del_adapter(&i2c->adap);
>
>   	xiic_deinit(i2c);
>
> -	platform_set_drvdata(pdev, NULL);
> +	dev_set_drvdata(&op->dev, NULL);
>
> -	free_irq(platform_get_irq(pdev, 0), i2c);
> +	free_irq(i2c->irq, i2c);
>
>   	iounmap(i2c->base);
>
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (res)
> -		release_mem_region(res->start, resource_size(res));
> +	release_mem_region(i2c->iomem, i2c->iolen);
>
>   	kfree(i2c);
>
>   	return 0;
>   }
>
> +/* Match table for of_platform binding */
> + static struct of_device_id __devinitdata xiic_match[] = {
> +	{ .compatible = "xlnx,xps-iic-2.00.a", },
> +	{},
> + };
>
> -/* work with hotplug and coldplug */
> -MODULE_ALIAS("platform:"DRIVER_NAME);
> +MODULE_DEVICE_TABLE(of, xiic_of_match);
>
> -static struct platform_driver xiic_i2c_driver = {
> +static struct of_platform_driver xiic_i2c_of_driver = {
> +	.match_table = xiic_match,
>   	.probe   = xiic_i2c_probe,
>   	.remove  = __devexit_p(xiic_i2c_remove),
> -	.driver  = {
> +	.driver = {
>   		.owner = THIS_MODULE,
>   		.name = DRIVER_NAME,
>   	},
> @@ -810,12 +817,12 @@ static struct platform_driver xiic_i2c_driver = {
>
>   static int __init xiic_i2c_init(void)
>   {
> -	return platform_driver_register(&xiic_i2c_driver);
> +	return of_register_platform_driver(&xiic_i2c_of_driver);
>   }
>
>   static void __exit xiic_i2c_exit(void)
>   {
> -	platform_driver_unregister(&xiic_i2c_driver);
> +	of_unregister_platform_driver(&xiic_i2c_of_driver);
>   }
>
>   module_init(xiic_i2c_init);
