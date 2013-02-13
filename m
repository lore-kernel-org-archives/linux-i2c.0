From: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Subject: Re: [PATCH] i2c: vt8500: Add support for Wondermedia I2C master-mode
Date: Thu, 14 Feb 2013 12:41:04 +1300
Message-ID: <1360798864.18078.21.camel@gitbox>
References: <1358315546-2201-1-git-send-email-linux@prisktech.co.nz>
	 <1358315546-2201-2-git-send-email-linux@prisktech.co.nz>
	 <20130213201307.GA8795@nekote.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130213201307.GA8795-8EAEigeeuNG034pCzgS/Qg7AFbiQbgqx@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Thanks for the review.
My replies are inline. Mostly 'ok' and 'will dos'.

To save you trawling through it all, here's the two replies/comments
that are *different*:

1) I am working on pinmux at the moment - will hold off on this driver
until pinmux is completed.

2)
> +	i2c_dev->clk = of_clk_get(np, 0);
> 
> There is also devm_clk_get.
devm_clk_get requires a 'clock name'.
Since vt8500 is DT-only, and clock-names is an optional property in the
clocks binding I preferred not to *require* an optional property.

If I am misunderstanding this, please correct me.

Regards
Tony Prisk


On Wed, 2013-02-13 at 21:13 +0100, Wolfram Sang wrote:
> Ho Tony,
> 
> here is my review.
> 
> On Wed, Jan 16, 2013 at 06:52:26PM +1300, Tony Prisk wrote:
> > This patch adds support for the I2C controller found on Wondermedia
> > SoCs.
> > 
> > Due to the lack of pinmux support, GPIO pin alternate functions are
> > configured by machine's compatible property, as are pullups.
> 
> Is there pinmux support planned/on its way? Maybe it is worth waiting
> for it? If not, I'd think the setup should be done in mach-code, not the
> driver.

I am actually working on pinmux at the moment so I will remove this
gpio-setup code and get the pinmux code into mainline first before
resubmitting this driver.
> 
> > diff --git a/drivers/i2c/busses/i2c-wmt.c b/drivers/i2c/busses/i2c-wmt.c
> > new file mode 100644
> > index 0000000..07d86e3
> > --- /dev/null
> > +++ b/drivers/i2c/busses/i2c-wmt.c
> > @@ -0,0 +1,636 @@
> > +/*
> > + *  Wondermedia I2C Master Mode Driver
> > + *
> > + *  Copyright (C) 2012 Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
> > + *
> > + *  Derived from GPL licensed source:
> > + *  - Copyright (C) 2008 WonderMedia Technologies, Inc.
> > + *
> > + *  This program is free software; you can redistribute it and/or modify
> > + *  it under the terms of the GNU General Public License version 2 as
> > + *  published by the Free Software Foundation
> > + */
> 
> Are the sources you derived from also V2 only? Otherwise you might be
> changing other people's license decision.

Oh dear.. almost.
Original source was v2 or later. I will update the license text to
indicate 'later' is also applicable.
> 
> > +static int wmt_i2c_wait_bus_not_busy(struct wmt_i2c_dev *i2c_dev)
> > +{
> > +	u16 val;
> > +	int i;
> > +	int ret = 0;
> > +
> > +	for (i = 0; i < 10000000; i++) {
> > +		val = readw(i2c_dev->base + REG_CSR);
> > +		if (val & CSR_READY_MASK)
> > +			break;
> > +
> > +		udelay(1);
> > +	}
> > +	if (i >= 9999999)
> > +		ret = -EBUSY;
> > +
> > +	return ret;
> > +}
> 
> That's 10 seconds (max) of busy looping? Nah, please don't hog the CPU
> for that.
Eek. Not sure how I missed that. Will fix.
> 
> > +
> > +static int wmt_check_status(struct wmt_i2c_dev *i2c_dev)
> > +{
> > +	int ret = 0;
> > +
> > +	if (i2c_dev->cmd_status & ISR_NACK_ADDR)
> > +		ret = -EIO;
> > +
> > +	if (i2c_dev->cmd_status & ISR_SCL_TIMEOUT)
> > +		ret = -ETIMEDOUT;
> > +
> > +	return ret;
> > +}
> > +
> > +static int wmt_i2c_write(struct i2c_adapter *adap, struct i2c_msg *pmsg,
> > +						   int restart, int last)
> > +{
> > +	struct wmt_i2c_dev *i2c_dev = i2c_get_adapdata(adap);
> > +	u16 val;
> > +	u16 tcr_val;
> 
> I'd prefer to aggregate the last two lines (here and in general), but no
> strong opinion on that.
My preference is for one variable per line but I'm happy to go with the
majority (if there is one).
> 
> > +	int ret;
> > +	int wait_result;
> > +	u32 xfer_len = 0;
> > +
> > +	if (pmsg->len < 0)
> > +		return -EINVAL;
> 
> len is a u16.
Sorry - copied verbatim from the vendor source.. I should know better by
now.
> 
> > +
> > +	if (restart == 0) {
> 
> I think '!restart' is a tad more readable, but again, no strong opinion.
Agree - will change.
> 
> > +		ret = wmt_i2c_wait_bus_not_busy(i2c_dev);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> > +	if (pmsg->len == 0)
> > +		writew(0, i2c_dev->base + REG_CDR);
> > +	else
> > +		writew(pmsg->buf[0] & 0xFF, i2c_dev->base + REG_CDR);
> > +
> > +	if (restart == 0) {
> > +		val = readw(i2c_dev->base + REG_CR);
> > +		val &= ~CR_TX_END;
> > +		writew(val, i2c_dev->base + REG_CR);
> > +
> > +		val = readw(i2c_dev->base + REG_CR);
> > +		val |= CR_CPU_RDY;
> > +		writew(val, i2c_dev->base + REG_CR);
> 
> Just to make sure: Not possible to do both in one write?
I don't know the answer to that question. The original vendor source did
it with two separate read-modify-write calls, so I kept it the same.

I can test it, although at first glance, I would guess it's done this
way because val |= CR_CPU_RDY will start the transfer immediately and
the val &= ~CR_TX_END may not have been processed within the
hardware?!?!

> 
> > +	}
> > +
> > +	init_completion(&i2c_dev->complete);
> > +
> > +	if (i2c_dev->mode == I2C_MODE_STANDARD)
> > +		tcr_val = TCR_STANDARD_MODE;
> > +	else
> > +		tcr_val = TCR_FAST_MODE;
> > +
> > +	tcr_val |= (TCR_MASTER_WRITE | (pmsg->addr & TCR_SLAVE_ADDR_MASK));
> > +
> > +	writew(tcr_val, i2c_dev->base + REG_TCR);
> > +
> > +	if (restart == 1) {
> > +		val = readw(i2c_dev->base + REG_CR);
> > +		val |= CR_CPU_RDY;
> > +		writew(val, i2c_dev->base + REG_CR);
> > +	}
> > +
> > +	ret = 0;
> > +
> > +	for (;;) {
> 
> Have you tried 'while (xfer_len < pmsg->len) ...' and directly 'return
> err' on errors? Might have potential to be more concise.
Can do.
> 
> > +		wait_result = wait_for_completion_interruptible_timeout(
> > +				&i2c_dev->complete, 500 * HZ / 1000);
> 
> Please don't use interruptible here. Most drivers had lots of problems
> with it and it seems you are not checking the signals anyhow.
Again, taken from vendor source - will change.
> 
> > +
> > +		if (wait_result == 0) {
> > +			dev_dbg(i2c_dev->dev, "wait timeout (tx)\n");
> > +			ret = -ETIMEDOUT;
> > +			break;
> > +		}
> > +
> > +		ret = wmt_check_status(i2c_dev);
> > +		if (ret)
> > +			break;
> > +
> > +		xfer_len++;
> > +
> > +		val = readw(i2c_dev->base + REG_CSR);
> > +		if ((val & CSR_RCV_ACK_MASK) == CSR_RCV_NOT_ACK) {
> > +			dev_dbg(i2c_dev->dev, "write RCV NACK error\n");
> > +			ret = -EIO;
> > +			break;
> > +		}
> > +
> > +		if (pmsg->len == 0) {
> > +			val = CR_TX_END | CR_CPU_RDY | CR_ENABLE;
> > +			writew(val, i2c_dev->base + REG_CR);
> > +			break;
> > +		}
> > +
> > +		if (pmsg->len > xfer_len) {
> > +			writew(pmsg->buf[xfer_len] & 0xFF, i2c_dev->base +
> > +								REG_CDR);
> > +			writew(CR_CPU_RDY | CR_ENABLE, i2c_dev->base + REG_CR);
> > +		} else if (pmsg->len == xfer_len) {
> > +			if (last != 1)
> > +				writew(CR_ENABLE, i2c_dev->base + REG_CR);
> > +			break;
> > +		} else {
> > +			dev_dbg(i2c_dev->dev, "unknown error (tx)\n");
> > +			ret = -EIO;
> > +			break;
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int wmt_i2c_read(struct i2c_adapter *adap, struct i2c_msg *pmsg,
> > +						  int restart, int last)
> 
> Same comment as for the write function. 
> 
> > +{
> > +	struct wmt_i2c_dev *i2c_dev = i2c_get_adapdata(adap);
> > +	u16 val;
> > +	u16 tcr_val;
> > +	int ret;
> > +	int wait_result;
> > +	u32 xfer_len = 0;
> > +
> > +	if (pmsg->len <= 0)
> > +		return -EINVAL;
> > +
> > +	if (restart == 0) {
> > +		ret = wmt_i2c_wait_bus_not_busy(i2c_dev);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> > +	val = readw(i2c_dev->base + REG_CR);
> > +	val &= ~CR_TX_END;
> > +	writew(val, i2c_dev->base + REG_CR);
> > +
> > +	val = readw(i2c_dev->base + REG_CR);
> > +	val &= ~CR_TX_NEXT_NO_ACK;
> > +	writew(val, i2c_dev->base + REG_CR);
> > +
> > +	if (restart == 0) {
> > +		val = readw(i2c_dev->base + REG_CR);
> > +		val |= CR_CPU_RDY;
> > +		writew(val, i2c_dev->base + REG_CR);
> > +	}
> > +
> > +	if (pmsg->len == 1) {
> > +		val = readw(i2c_dev->base + REG_CR);
> > +		val |= CR_TX_NEXT_NO_ACK;
> > +		writew(val, i2c_dev->base + REG_CR);
> > +	}
> > +
> > +	init_completion(&i2c_dev->complete);
> > +
> > +	if (i2c_dev->mode == I2C_MODE_STANDARD)
> > +		tcr_val = TCR_STANDARD_MODE;
> > +	else
> > +		tcr_val = TCR_FAST_MODE;
> > +
> > +	tcr_val |= TCR_MASTER_READ | (pmsg->addr & TCR_SLAVE_ADDR_MASK);
> > +
> > +	writew(tcr_val, i2c_dev->base + REG_TCR);
> > +
> > +	if (restart == 1) {
> > +		val = readw(i2c_dev->base + REG_CR);
> > +		val |= CR_CPU_RDY;
> > +		writew(val, i2c_dev->base + REG_CR);
> > +	}
> > +
> > +	ret = 0;
> > +
> > +	for (;;) {
> > +		wait_result = wait_for_completion_interruptible_timeout(
> > +				&i2c_dev->complete, 500 * HZ / 1000);
> 
> no interruptible
> 
> > +
> > +		if (wait_result == 0) {
> > +			dev_dbg(i2c_dev->dev, "wait timeout (tx)\n");
> > +			ret = -ETIMEDOUT;
> > +			break;
> > +		}
> > +
> > +		ret = wmt_check_status(i2c_dev);
> > +		if (ret)
> > +			break;
> > +
> > +		pmsg->buf[xfer_len] = readw(i2c_dev->base + REG_CDR) >> 8;
> > +		xfer_len++;
> > +
> > +		if (pmsg->len > xfer_len) {
> > +			if (pmsg->len - 1 == xfer_len) {
> > +				val = readw(i2c_dev->base + REG_CR);
> > +				val |= (CR_TX_NEXT_NO_ACK | CR_CPU_RDY);
> > +				writew(val, i2c_dev->base + REG_CR);
> > +			} else {
> > +				val = readw(i2c_dev->base + REG_CR);
> > +				val |= CR_CPU_RDY;
> > +				writew(val, i2c_dev->base + REG_CR);
> > +			}
> > +		} else if (pmsg->len == xfer_len) {
> > +			break;
> > +		} else {
> > +			ret = -EIO;
> > +			break;
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int wmt_i2c_xfer(struct i2c_adapter *adap,
> > +			struct i2c_msg msgs[],
> > +			int num)
> > +{
> > +	struct i2c_msg *pmsg;
> > +	int i;
> > +	int ret = 0;
> > +	int is_last;
> > +	int restart;
> > +
> > +	for (i = 0; ret >= 0 && i < num; i++) {
> > +		is_last = ((i + 1) == num);
> > +		restart = (i != 0);
> > +
> > +		pmsg = &msgs[i];
> > +		if (pmsg->flags & I2C_M_NOSTART)
> > +			restart = 1;
> > +		if (pmsg->flags & I2C_M_RD)
> > +			ret = wmt_i2c_read(adap, pmsg, restart, is_last);
> > +		else
> > +			ret = wmt_i2c_write(adap, pmsg, restart, is_last);
> > +	}
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +	else
> > +		return i;
> > +}
> 
> return ret < 0 ? ret : i;
> 
> > +
> > +static u32 wmt_i2c_func(struct i2c_adapter *adap)
> > +{
> > +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> 
> I2C_FUNC_NOSTART is missing.
Again - taken from vendor source as is. Will read the book (to find out
what it does) and add.
> 
> > +}
> > +
> > +static const struct i2c_algorithm wmt_i2c_algo = {
> > +	.master_xfer	= wmt_i2c_xfer,
> > +	.functionality	= wmt_i2c_func,
> > +};
> > +
> > +static irqreturn_t wmt_i2c_isr(int irq, void *data)
> > +{
> > +	struct wmt_i2c_dev *i2c_dev = data;
> > +
> > +	/* save the status and write-clear it */
> > +	i2c_dev->cmd_status = readw(i2c_dev->base + REG_ISR);
> > +	writew(i2c_dev->cmd_status, i2c_dev->base + REG_ISR);
> > +
> > +	complete(&i2c_dev->complete);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +/*
> > + * Due to a lack of pinmux functionality we need to manually configure
> > + * the GPIO pullup. Once pinmux is implemented, this function should be
> > + * removed. Pullup's are not available on vt8500 or wm8505 so we skip.
> > + */
> 
> As mentioned above, move to mach-code?
Will drop before v2.
> 
> ...
> 
> > +static int wmt_i2c_reset_hardware(struct wmt_i2c_dev *i2c_dev)
> > +{
> > +	int err;
> > +
> > +	err = clk_prepare_enable(i2c_dev->clk);
> > +	if (err) {
> > +		dev_err(i2c_dev->dev, "failed to enable clock\n");
> > +		return err;
> > +	}
> > +
> > +	err = clk_set_rate(i2c_dev->clk, 20000000);
> > +	if (err) {
> > +		dev_err(i2c_dev->dev, "failed to set clock = 20Mhz\n");
> > +		return err;
> > +	}
> > +
> > +	err = wmt_i2c_setup_gpio(i2c_dev);
> > +	if (err)
> > +		return err;
> > +
> > +	writew(0, i2c_dev->base + REG_CR);
> > +	writew(12, i2c_dev->base + REG_MCR);
> > +	writew(ISR_WRITE_ALL, i2c_dev->base + REG_ISR);
> > +	writew(IMR_ENABLE_ALL, i2c_dev->base + REG_IMR);
> > +	writew(CR_ENABLE, i2c_dev->base + REG_CR);
> > +	readw(i2c_dev->base + REG_CSR);		/* read clear */
> > +	writew(ISR_WRITE_ALL, i2c_dev->base + REG_ISR);
> > +
> > +	if (i2c_dev->mode == I2C_MODE_STANDARD)
> > +		writew(0x8064, i2c_dev->base + REG_TR);
> > +	else
> > +		writew(0x8019, i2c_dev->base + REG_TR);
> > +
> > +	return 0;
> 
> Too many magic numbers in this last block.
When I wrote this piece of code I had no idea what these magic numbers
meant. I've since figured it out and will redo.
> 
> > +}
> > +
> > +static int wmt_i2c_probe(struct platform_device *pdev)
> > +{
> > +	struct device_node	*np = pdev->dev.of_node;
> > +	struct wmt_i2c_dev	*i2c_dev;
> > +	struct i2c_adapter	*adap;
> > +	struct resource		*res;
> 
> No special alignment, please.
Ok.
> 
> > +	int err;
> > +	u32 clk_rate;
> > +
> > +	if (!np) {
> > +		dev_err(&pdev->dev, "device node not found\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "no memory resource defined\n");
> > +		return -ENODEV;
> > +	}
> 
> devm_request_and_ioremap will check res for you.
Ok. Will drop the error check.
> 
> > +
> > +	i2c_dev = devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL);
> > +	if (!i2c_dev) {
> > +		dev_err(&pdev->dev, "device memory allocation failed\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	i2c_dev->base = devm_request_and_ioremap(&pdev->dev, res);
> > +	if (!i2c_dev->base) {
> > +		dev_err(&pdev->dev, "memory region unavailable\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	i2c_dev->irq = irq_of_parse_and_map(np, 0);
> > +	if (!i2c_dev->irq) {
> > +		dev_err(&pdev->dev, "irq missing or invalid\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	i2c_dev->clk = of_clk_get(np, 0);
> 
> There is also devm_clk_get.
devm_clk_get requires a 'clock name'.
Since vt8500 is DT-only, and clock-names is an optional property in the
clocks binding I preferred not to *require* an optional property.

If I am misunderstanding this, please correct me.
> 
> > +	if (IS_ERR(i2c_dev->clk)) {
> > +		dev_err(&pdev->dev, "unable to request clock\n");
> > +		return PTR_ERR(i2c_dev->clk);
> > +	}
> > +
> > +	i2c_dev->mode = I2C_MODE_STANDARD;
> > +	err = of_property_read_u32(np, "clock-frequency", &clk_rate);
> > +	if ((!err) && (clk_rate == 400000))
> > +		i2c_dev->mode = I2C_MODE_FAST;
> > +
> > +	i2c_dev->dev = &pdev->dev;
> > +
> > +	err = devm_request_irq(&pdev->dev, i2c_dev->irq, wmt_i2c_isr, 0,
> > +							"i2c", i2c_dev);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "failed to request irq %i\n", i2c_dev->irq);
> > +		return err;
> > +	}
> > +
> > +	adap = &i2c_dev->adapter;
> > +	i2c_set_adapdata(adap, i2c_dev);
> > +	strlcpy(adap->name, "WMT I2C adapter", sizeof(adap->name));
> > +	adap->owner		= THIS_MODULE;
> > +	adap->class		= I2C_CLASS_HWMON;
> > +	adap->algo		= &wmt_i2c_algo;
> > +	adap->dev.parent	= &pdev->dev;
> > +	adap->dev.of_node	= pdev->dev.of_node;
> > +	adap->nr		= of_alias_get_id(pdev->dev.of_node, "i2c");
> 
> No alignment with tabs, please.
Ok.
> 
> > +
> > +	err = wmt_i2c_reset_hardware(i2c_dev);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "error initializing hardware\n");
> > +		return err;
> > +	}
> > +
> > +	if (adap->nr < 0)
> > +		err = i2c_add_adapter(adap);
> > +	else
> > +		err = i2c_add_numbered_adapter(adap);
> > +
> > +	if (err) {
> > +		dev_err(&pdev->dev, "failed to add adapter\n");
> > +		return err;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, i2c_dev);
> > +
> > +	of_i2c_register_devices(adap);
> > +
> > +	return 0;
> > +}
> > +
> > +static int wmt_i2c_remove(struct platform_device *pdev)
> > +{
> > +	struct wmt_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
> > +
> > +	i2c_del_adapter(&i2c_dev->adapter);
> 
> Is it guaranteed that interrupts cannot occur anymore? Otherwise OOPS
> might happen, since the adapter is cleared here already but devm will
> remove the interrupt only a little later.
Hmm.. good point. I will add some hw-stop code in here as well.
> 
> > +
> > +	return 0;
> > +}
> > +
> > +static struct of_device_id wmt_i2c_dt_ids[] = {
> > +	{ .compatible = "wm,wm8505-i2c" },
> > +	{ /* Sentinel */ },
> > +};
> > +
> > +static struct platform_driver wmt_i2c_driver = {
> > +	.probe		= wmt_i2c_probe,
> > +	.remove		= wmt_i2c_remove,
> > +	.driver		= {
> > +		.name	= "wmt-i2c",
> > +		.owner	= THIS_MODULE,
> > +		.of_match_table = wmt_i2c_dt_ids,
> > +	},
> > +};
> > +
> > +module_platform_driver(wmt_i2c_driver);
> > +
> > +MODULE_DESCRIPTION("Wondermedia I2C master-mode bus adapter");
> > +MODULE_AUTHOR("Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DEVICE_TABLE(of, wmt_i2c_dt_ids);
> 
> Also, checkpatch found a trailing whitespace somewhere.
> 
> Thanks,
> 
>    Wolfram
