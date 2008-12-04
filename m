From: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH][resend] iMX/MXC support for I2C
Date: Thu, 04 Dec 2008 11:59:56 +0200
Message-ID: <4937AA1C.8050004@gmail.com>
References: <gh3f1h$fto$1@ger.gmane.org> <Pine.LNX.4.64.0812030917440.4717@axis700.grange> <20081203234317.GA4256@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081203234317.GA4256-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>> +static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx)
>>> +{
>>> +	unsigned long orig_jiffies = jiffies;
>>> +
>>> +	/* Wait for ack */
>>> +	while (readb(i2c_imx->base + IMX_I2C_I2SR) & I2SR_RXAK) {
>>> +		if (signal_pending(current)) {
>>> +			dev_dbg(&i2c_imx->adapter.dev,
>>> +				"<%s> I2C Interrupted\n", __func__);
>>> +			return -EINTR;
>>> +		}
>>> +		if (time_after(jiffies, orig_jiffies + HZ)) {
>>> +			dev_dbg(&i2c_imx->adapter.dev,
>>> +				"<%s> No ACK\n", __func__);
>>> +			return -EIO;
>>> +		}
>>> +		schedule();
>>> +	}
>> 1s is way too long here! i2cdetect takes ages to complete. The mxc driver 
>> doesn't wait here at all - as soon as a tx is complete, it checks the ack 
>> status. Could you verify if this would work on your MX1 too?
> 
> That does seem a problem, if we can detect a NAK immediately then all
> the better.

I tested on MX1. There delay is not needed at all.

>  
>>> +
>>> +	dev_dbg(&i2c_imx->adapter.dev, "<%s> ACK received\n", __func__);
>>> +	return 0;   /* No ACK */
>>> +}
>>> +
>>> +static void i2c_imx_start(struct imx_i2c_struct *i2c_imx)
>>> +{
>>> +	unsigned int temp = 0;
>>> +
>>> +	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
>>> +
>>> +	/* Enable I2C controller */
>>> +	writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
>>> +	/* Start I2C transaction */
>>> +	temp = readb(i2c_imx->base + IMX_I2C_I2CR);
>>> +	temp |= I2CR_MSTA;
>>> +	writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>>> +	temp |= I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
>>> +	writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>>> +}
>>> +
>>> +static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
>>> +{
>>> +	unsigned int temp = 0;
>>> +
>>> +	/* Stop I2C transaction */
>>> +	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
>>> +	temp = readb(i2c_imx->base + IMX_I2C_I2CR);
>>> +	temp &= ~I2CR_MSTA;
>>> +	writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>>> +	/* setup chip registers to defaults */
>>> +	writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
>>> +	writeb(0, i2c_imx->base + IMX_I2C_I2SR);
>>> +	/*
>>> +	 * This delay caused by an i.MXL hardware bug.
>>> +	 * If no (or too short) delay, no "STOP" bit will be generated.
>>> +	 */
>>> +	udelay(disable_delay);
>>> +	/* Disable I2C controller */
>>> +	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
>>> +}
>>> +
>>> +static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
>>> +							unsigned int rate)
>>> +{
>>> +	unsigned int i2c_clk_rate;
>>> +	unsigned int div;
>>> +	int i;
>>> +
>>> +	/* Divider value calculation */
>>> +	i2c_clk_rate = clk_get_rate(i2c_imx->clk);
>>> +	div = (i2c_clk_rate + rate - 1) / rate;
>>> +	if (div < i2c_clk_div[0][0])
>>> +		i = 0;
>>> +	else if (div > i2c_clk_div[ARRAY_SIZE(i2c_clk_div) - 1][0])
>>> +		i = ARRAY_SIZE(i2c_clk_div) - 1;
>>> +	else
>>> +		for (i = 0; i2c_clk_div[i][0] < div; i++);
>>> +
>>> +	/* Write divider value to register */
>>> +	writeb(i2c_clk_div[i][1], i2c_imx->base + IMX_I2C_IFDR);
>>> +
>>> +	/*
>>> +	 * There dummy delay is calculated.
>>> +	 * It should be about one I2C clock period long.
>>> +	 * This delay is used in I2C bus disable function
>>> +	 * to fix chip hardware bug.
>>> +	 */
>>> +	disable_delay = (500000U * i2c_clk_div[i][0]
>>> +		+ (i2c_clk_rate / 2) - 1) / (i2c_clk_rate / 2);
>>> +
>>> +	/* dev_dbg() can't be used, because adapter is not yet registered */
>>> +#ifdef CONFIG_I2C_DEBUG_BUS
>>> +	printk(KERN_DEBUG "I2C: <%s> I2C_CLK=%d, REQ DIV=%d\n",
>>> +		__func__, i2c_clk_rate, div);
>>> +	printk(KERN_DEBUG "I2C: <%s> IFDR[IC]=0x%x, REAL DIV=%d\n",
>>> +		__func__, i2c_clk_div[i][1], i2c_clk_div[i][0]);
>>> +#endif
> 
> not using dev_xxx() here?

because adapter is not yet registered.

> 
>>> +}
>>> +
>>> +static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
>>> +{
>>> +	struct imx_i2c_struct *i2c_imx = dev_id;
>>> +	unsigned int temp;
>>> +
>>> +	temp = readb(i2c_imx->base + IMX_I2C_I2SR);
>>> +	if (temp & I2SR_IIF) {
>>> +		/* save status register */
>>> +		i2c_imx->i2csr = temp;
>>> +		temp &= ~I2SR_IIF;
>>> +		writeb(temp, i2c_imx->base + IMX_I2C_I2SR);
>>> +		wake_up_interruptible(&i2c_imx->queue);
>>> +	}
>>> +
>>> +	return IRQ_HANDLED;
>>> +}
> 
> it would be nice if we returned IRQ_NONE if we didn't have anything
> to handle.

I will add this.

>>> +	if (!request_mem_region(res->start, res_size, res->name)) {
>>> +		dev_err(&pdev->dev, "can't allocate %d bytes at %d address\n",
>>> +			res_size, res->start);
>>> +		return -ENOMEM;
>>> +	}
>> I was once told, one doesn't need request_mem_region() on regions from 
>> platform data resources - this is already done implicitly.
> 
> I belive that request_mem_region() is the correct thing to do, IIRC,
> the platform_device_register() calls insert_resource() on all the
> resource regions of the device so that it is guarnateed to appear in
> the /proc/ioport or /proc/iomem map. However I belive this does not
> actually make a reservation of that resource.
>  

confused... Guennadi, can you please explain more your mention?

>>> +
>>> +	if (pdata->init) {
>>> +		ret = pdata->init(&pdev->dev);
>>> +		if (ret)
>>> +			goto fail0;
>>> +	}
>>> +
>>> +	base = ioremap(res->start, res_size);
>>> +	if (!base) {
>>> +		dev_err(&pdev->dev, "ioremap failed\n");
>>> +		ret = -EIO;
>>> +		goto fail1;
>>> +	}
>>> +
>>> +	i2c_imx = kzalloc(sizeof(struct imx_i2c_struct), GFP_KERNEL);
>>> +	if (!i2c_imx) {
>>> +		dev_err(&pdev->dev, "can't allocate interface\n");
>>> +		ret = -ENOMEM;
>>> +		goto fail2;
>>> +	}
>>> +
>>> +	/* Setup i2c_imx driver structure */
>>> +	strcpy(i2c_imx->adapter.name, pdev->name);
>>> +	i2c_imx->adapter.owner		= THIS_MODULE;
>>> +	i2c_imx->adapter.algo		= &i2c_imx_algo;
>>> +	i2c_imx->adapter.dev.parent	= &pdev->dev;
>>> +	i2c_imx->adapter.nr 		= pdev->id;
>>> +	i2c_imx->irq			= irq;
>>> +	i2c_imx->base			= base;
>>> +	i2c_imx->res			= res;
>>> +
>>> +	/* Get I2C clock */
>>> +	i2c_imx->clk = clk_get(NULL, "i2c_clk");
>> There can be several i2c busses on the system, so you want:
>>
>> +	i2c_imx->clk = clk_get(&pdev->dev, "i2c_clk");
> 
> tbh, the bus clock should be defined as NULL, any extra clocks for
> a device get names. However this may need fixing in the platform
> as well. I belive RMK is already making these changes for AMBA and
> I will probably follow suit with the s3c architectures as soon as
> the rest of the development work is out of the way.
>  
>>> +	if (IS_ERR(i2c_imx->clk)) {
>>> +		ret = PTR_ERR(i2c_imx->clk);
>>> +		dev_err(&pdev->dev, "can't get I2C clock\n");
>>> +		goto fail3;
>>> +	}
>>> +	clk_enable(i2c_imx->clk);
>>> +
>>> +	/* Request IRQ */
>>> +	ret = request_irq(i2c_imx->irq, i2c_imx_isr,
>>> +		IRQF_DISABLED, pdev->name, i2c_imx);
> 
> do you really need to run your i2c isr with interrupts disabled?

no, interrupts can be enabled. will fix.


> 
> kernel doc comments would be nice for this to actually say what is
> expected of the implementation and what these calls are there for.
> 
>>> +struct imxi2c_platform_data {
>>> +	int (*init)(struct device *dev);
>>> +	int (*exit)(struct device *dev);
>> What are you going to use .exit() for? Is it really needed? Even if it is, 
>> it can easily return void I guess?
>>

Where to put commnets? Right here in driver code or is better in /Documentation?
