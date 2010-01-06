From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3] [MFD] i2c-htcpld: Add the HTCPLD driver
Date: Wed, 6 Jan 2010 13:35:33 +0100
Message-ID: <20100106123532.GB5500@sortiz.org>
References: <1260841135-6680-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1260841135-6680-1-git-send-email-darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Cory,

late review, sorry about that...

On Mon, Dec 14, 2009 at 05:38:55PM -0800, Cory Maccarrone wrote:
> This change introduces a driver for the HTC PLD chip found
> on some smartphones, such as the HTC Wizard and HTC Herald.
> It works through the I2C bus and acts as a GPIO extender.
> Specifically:
> 
>  * it can have several sub-devices, each with its own I2C
>    address
>  * Each sub-device provides 8 output and 8 input pins
>  * The chip attaches to one GPIO to signal when any of the
>    input GPIOs change -- at which point all chips must be
>    scanned for changes
> 
> This driver implements the GPIOs throught the kernel's
> GPIO and IRQ framework.  This allows any GPIO-servicing
> drivers to operate on htcpld pins, such as the gpio-keys
> and gpio-leds drivers.
The driver looks fine to me, but I get 23 checkpatch warnings and 5 errors for
it.
Could you please fix them, keeping in mind that I'm fine with printk/dev_*
strings being more than 80 chars.

A couple of additional comments:

> diff --git a/drivers/mfd/htc-i2cpld.c b/drivers/mfd/htc-i2cpld.c
> new file mode 100644
> index 0000000..23338ff
> --- /dev/null
> +++ b/drivers/mfd/htc-i2cpld.c
> @@ -0,0 +1,591 @@
> +/*
> + *  htc-i2cpld.c
> + *  Chip driver for a ?cpld? found on omap850 HTC devices like the
?cpld? ??


> +static irqreturn_t htcpld_handler(int irq, void *dev)
> +{
> +	struct htcpld_data *htcpld = dev;
> +	unsigned int i;
> +	unsigned long flags;
> +	int irqpin;
> +	struct irq_desc *desc;
> +
> +	if (!htcpld) {
> +		printk(KERN_INFO "htcpld is null\n");
Please use pr_* instead. It seems you're using it already, so let's be
consistent.


> +static int __devinit htcpld_core_probe(struct platform_device *pdev)
> +{
This routine is fairly big, and could be more readable by calling some
subroutines. The chips initialisation part could be extracted out for example.


> +	struct htcpld_data *htcpld;
> +	struct device *dev = &pdev->dev;
> +	struct htcpld_core_platform_data *pdata;
> +	struct resource *res;
> +	int i, ret = 0;
> +	unsigned int irq, irq_end;
> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	pdata = dev->platform_data;
> +	if (!pdata) {
> +		printk(KERN_ERR "Platform data not found for htcpld core!\n");
> +		return -ENXIO;
> +	}
> +
> +	htcpld = kzalloc(sizeof(struct htcpld_data), GFP_KERNEL);
> +	if (!htcpld)
> +		return -ENOMEM;
> +
> +	/* Find chained irq */
> +	ret = -EINVAL;
> +	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (res)
> +		htcpld->chained_irq = res->start;
> +
> +	platform_set_drvdata(pdev, htcpld);
> +
> +	htcpld->int_reset_gpio_hi = pdata->int_reset_gpio_hi;
> +	htcpld->int_reset_gpio_lo = pdata->int_reset_gpio_lo;
> +
> +	/* Setup each chip's output GPIOs */
> +	htcpld->nchips = pdata->num_chip;
> +	htcpld->chip = kzalloc(sizeof(struct htcpld_chip) * htcpld->nchips, GFP_KERNEL);
> +	if (!htcpld->chip) {
> +		ret = -ENOMEM;
> +		goto fail;
> +	}
> +
> +	for (i = 0; i < htcpld->nchips; i++) {
> +		struct i2c_adapter *adapter;
> +		struct i2c_client *client;
> +		struct i2c_board_info info;
> +		struct gpio_chip *chip;
> +		int ret;
> +
> +		/* Setup the HTCPLD chips */
> +		htcpld->chip[i].reset = pdata->chip[i].reset;
> +		htcpld->chip[i].cache_out = pdata->chip[i].reset;
> +		htcpld->chip[1].cache_in = 0;
Shouldnt it be: htcpld->chip[i].cache_in = 0; instead ?

> +		htcpld->chip[i].dev = dev;
> +		htcpld->chip[i].irq_start = pdata->chip[i].irq_base;
> +		htcpld->chip[i].nirqs = pdata->chip[i].num_irqs;
> +
> +		INIT_WORK(&(htcpld->chip[i].set_val_work), &htcpld_chip_set_ni);
> +		spin_lock_init(&(htcpld->chip[i].lock));
> +
> +		/* Setup the IRQs */
> +		if (htcpld->chained_irq) {
> +			int error = 0, flags;
> +
> +			/* Setup irq handlers */
> +			irq_end = htcpld->chip[i].irq_start + htcpld->chip[i].nirqs;
> +			for (irq = htcpld->chip[i].irq_start; irq < irq_end; irq++) {
> +				set_irq_chip(irq, &htcpld_muxed_chip);
> +				set_irq_chip_data(irq, &htcpld->chip[i]);
> +				set_irq_handler(irq, handle_simple_irq);
> +				set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
> +			}
> +
> +			flags = IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING | IRQF_SAMPLE_RANDOM;
> +			error = request_threaded_irq(
> +					htcpld->chained_irq,
> +					NULL,
> +					htcpld_handler,
> +					flags,
> +					pdev->name,
> +					htcpld);
You could have a nicer indentation here:
			error = request_threaded_irq(htcpld->chained_irq,
		                                     NULL, htcpld_handler,
						     flags, pdev->name, htcpld);



Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
