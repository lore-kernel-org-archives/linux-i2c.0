From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCHv2 3/3] Add platform driver on top of the new
 pca-algorithm
Date: Fri, 14 Mar 2008 19:46:28 +0100
Message-ID: <20080314194628.07630698@hyperion.delvare>
References: <20080308111337.440a7c83@hyperion.delvare>
	<20080310112640.GB12128@pengutronix.de>
	<20080310223116.73277c4f@hyperion.delvare>
	<20080314145010.GA28612@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080314145010.GA28612-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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

On Fri, 14 Mar 2008 15:50:10 +0100, Wolfram Sang wrote:
> Hello,
> 
> I sent this patch to myself a minute ago and could apply it. Dunno what went
> wrong the last time. I am very sorry (I know that patch fixing is
> annoying).
> 
> All the best,
> 
>    Wolfram
> 
> ---
> 
> Subject: Add platform driver on top of the new pca-algorithm
> From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> Changes since last revision:
>  - use <linux/gpio.h> and remove #ifdefs CONFIG_GENERIC_GPIO
>  - correct reference to gpio_is_valid()
>  - register and setup gpio in the driver
>  - just print whole lines with printk
>  - removed warnings
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
> 
> Changes since last revision:
>  - check against CONFIG_GENERIC_GPIO (was GENERIC_GPIO :( )
>  - don't use platform data anymore, copy all over to own struct
>  - give info about mem & irq when booting (and switch to printk
>    as device is not yet registered)
>  - add comment about problems with polling
>  - added proper __devinit and __devexit
>  - added owner to module
>  - removed whitespace alignment in code
>  - driver now named "i2c-pca-platform" (as the module)
>  - fixed typos in Kconfig
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
> 
> Tested on a blackfin.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> ---
>  drivers/i2c/busses/Kconfig            |   15 +
>  drivers/i2c/busses/Makefile           |    1 
>  drivers/i2c/busses/i2c-pca-platform.c |  298 ++++++++++++++++++++++++++++++++++
>  include/linux/i2c-pca-platform.h      |   12 +
>  4 files changed, 324 insertions(+), 2 deletions(-)
> 
> Index: linux-playground/drivers/i2c/busses/i2c-pca-platform.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-playground/drivers/i2c/busses/i2c-pca-platform.c	2008-03-14 14:45:34.000000000 +0100
> (...)
> +static int __devinit i2c_pca_pf_probe(struct platform_device *pdev)
> +{
> +	struct i2c_pca_pf_data *i2c;
> +	struct resource *res;
> +	struct i2c_pca9564_pf_platform_data *platform_data =
> +				pdev->dev.platform_data;
> +	int ret = 0;
> +	int irq;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	irq = platform_get_irq(pdev, 0);
> +	/* If irq is 0, we do polling. */
> +
> +	if (res == NULL) {
> +		ret = -ENODEV;
> +		goto e_print;
> +	}
> +
> +	if (!request_mem_region(res->start, res_len(res), res->name)) {
> +		ret = -ENOMEM;
> +		goto e_print;
> +	}
> +
> +	i2c = kzalloc(sizeof(struct i2c_pca_pf_data), GFP_KERNEL);
> +	if (!i2c) {
> +		ret = -ENOMEM;
> +		goto e_alloc;
> +	}
> +
> +	init_waitqueue_head(&i2c->wait);
> +
> +	i2c->reg_base = ioremap(res->start, res_len(res));
> +	if (!i2c->reg_base) {
> +		ret = -EIO;
> +		goto e_remap;
> +	}
> +	i2c->io_base = res->start;
> +	i2c->io_size = res_len(res);
> +	i2c->irq = irq;
> +
> +	i2c->adap.nr = pdev->id >= 0 ? pdev->id : 0;
> +	i2c->adap.owner = THIS_MODULE;
> +	snprintf(i2c->adap.name, sizeof(i2c->adap.name), "PCA9564 at 0x%08lx",
> +		(unsigned long) res->start);
> +	i2c->adap.algo_data = &i2c->algo_data;
> +	i2c->adap.dev.parent = &pdev->dev;
> +	i2c->adap.timeout = platform_data->timeout;
> +
> +	i2c->algo_data.i2c_clock = platform_data->i2c_clock_speed;
> +	i2c->algo_data.data = i2c;
> +
> +	switch (res->flags & IORESOURCE_MEM_TYPE_MASK) {
> +	case IORESOURCE_MEM_32BIT:
> +		i2c->algo_data.write_byte = i2c_pca_pf_writebyte32;
> +		i2c->algo_data.read_byte = i2c_pca_pf_readbyte32;
> +		break;
> +	case IORESOURCE_MEM_16BIT:
> +		i2c->algo_data.write_byte = i2c_pca_pf_writebyte16;
> +		i2c->algo_data.read_byte = i2c_pca_pf_readbyte16;
> +		break;
> +	case IORESOURCE_MEM_8BIT:
> +	default:
> +		i2c->algo_data.write_byte = i2c_pca_pf_writebyte8;
> +		i2c->algo_data.read_byte = i2c_pca_pf_readbyte8;
> +		break;
> +	}
> +
> +	i2c->algo_data.wait_for_completion = i2c_pca_pf_waitforcompletion;
> +
> +

No double blank lines inside functions please (they confuse patch too
easily.)

> +	i2c->gpio = platform_data->gpio;
> +	i2c->algo_data.reset_chip = i2c_pca_pf_dummyreset;
> +
> +	/* Use gpio_is_valid() when in mainline */
> +	if (i2c->gpio > -1)
> +		ret = gpio_request(i2c->gpio, i2c->adap.name);
> +		if (ret == 0) {
> +			gpio_direction_output(i2c->gpio, 1);
> +			i2c->algo_data.reset_chip = i2c_pca_pf_resetchip;
> +		} else {
> +			printk(KERN_WARNING "%s: Registering gpio failed!\n",
> +				i2c->adap.name);
> +			i2c->gpio = ret;
> +		}

You're missing curly braces around this block, aren't you?

> +
> +	if (irq) {
> +		ret = request_irq(irq, i2c_pca_pf_handler,
> +			IRQF_TRIGGER_FALLING, i2c->adap.name, i2c);
> +		if (ret)
> +			goto e_reqirq;
> +	}
> +
> +	if (i2c_pca_add_numbered_bus(&i2c->adap) < 0) {
> +		ret = -ENODEV;
> +		goto e_adapt;
> +	}
> +
> +	platform_set_drvdata(pdev, i2c);
> +
> +	printk(KERN_INFO "%s registered.\n", i2c->adap.name);
> +
> +	return 0;
> +
> +e_adapt:
> +	if (irq)
> +		free_irq(irq, i2c);
> +e_reqirq:
> +	if (i2c->gpio > -1)
> +		gpio_free(i2c->gpio);
> +
> +	iounmap(i2c->reg_base);
> +e_remap:
> +	kfree(i2c);
> +e_alloc:
> +	release_mem_region(res->start, res_len(res));
> +e_print:
> +	printk(KERN_ERR "Registering PCA9564 FAILED! (%d)\n", ret);
> +	return ret;
> +}

The rest looks OK, so I can fix this myself and queue up your patch for
2.6.26.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
