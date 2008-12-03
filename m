From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH][resend] iMX/MXC support for I2C
Date: Wed, 3 Dec 2008 23:48:33 +0000
Message-ID: <20081203234833.GC4256@fluff.org.uk>
References: <gh3f1h$fto$1@ger.gmane.org> <Pine.LNX.4.64.0812031355120.4717@axis700.grange> <gh609o$gs0$1@ger.gmane.org> <Pine.LNX.4.64.0812032155350.7961@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0812032155350.7961-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 03, 2008 at 09:58:10PM +0100, Guennadi Liakhovetski wrote:
> Hi Darius,
> 
> it would be better, if you didn't drop my email from cc, thanks.
> 
> On Wed, 3 Dec 2008, Darius wrote:
> 
> > Guennadi Liakhovetski wrote:
> > > One more thing: you also want to do something like this
> > > 
> > > 	i2c_imx->adapter.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD;
> > 
> > some time ago, it was I2C_CLASS_ALL, but Jean told, that it will be removed at
> > all :)
> > 
> > > 
> > > in i2c_imx_probe().
> > > 
> > > If you want, I can send you my current version of your driver, so you can
> > > compare.
> > 
> > yes, please send it.
> 
> Below.
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> 
> >From 1d592e3a94b3e13537a680e3e0198c345248692d Mon Sep 17 00:00:00 2001
> From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
> Date: Wed, 3 Dec 2008 17:02:37 +0100
> Subject: [PATCH] i2x-imx: fix client addresses, remove needless delays, support multiple busses
> 
> With above bugs fixed now also tested to work on i.MX31. bus frequency is now
> configured over platform data, which allows different frequencies on different
> busses. Add an adapter.class assignment.
> 
> Signed-off-by: Guennadi Liakhovetski <lg-ynQEQJNshbs@public.gmane.org>
> ---
>  arch/arm/plat-mxc/include/mach/i2c.h |    8 ++
>  drivers/i2c/busses/i2c-imx.c         |  143 ++++++++++++++++------------------
>  2 files changed, 76 insertions(+), 75 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/i2c.h b/arch/arm/plat-mxc/include/mach/i2c.h
> index 9e6a9d8..37d068b 100644
> --- a/arch/arm/plat-mxc/include/mach/i2c.h
> +++ b/arch/arm/plat-mxc/include/mach/i2c.h
> @@ -10,8 +10,16 @@
>  #define __ASM_ARCH_I2C_H_
>  
>  struct imxi2c_platform_data {
> +	u32 i2c_clk;
>  	int (*init)(struct device *dev);
>  	int (*exit)(struct device *dev);
>  };
>  
> +struct imxi2c_board_data {
> +	struct imxi2c_platform_data	data;
> +	unsigned int			id;
> +};
> +
> +extern int mxc_i2c_register_adapters(struct imxi2c_board_data *data, int n);

if there are only 1 or two busses, why not do

mx2_i2c_register_board(int i2c_channel_nr, struct
		       imx_i2c_platform_data *pd);

>  #endif /* __ASM_ARCH_I2C_H_ */
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index fd2d16d..eeea7d7 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -23,12 +23,6 @@
>   *	Implementation of I2C Adapter/Algorithm Driver
>   *	for I2C Bus integrated in Freescale i.MX/MXC processors
>   *
> - *	module parameters:
> - *		- clkfreq:
> - *			Sets the desired clock rate
> - *			The default value is 100000
> - *			Max value is 400000
> - *
>   *	Derived from Motorola GSG China I2C example driver
>   *
>   *	Copyright (C) 2005 Torsten Koschorrek <koschorrek at synertronixx.de
> @@ -64,14 +58,6 @@
>  /* This will be the driver name the kernel reports */
>  #define DRIVER_NAME "imx-i2c"
>  
> -/* Default values of module parameters */
> -#define IMX_I2C_BIT_RATE	100000	/* 100kHz */
> -
> -/* Timeouts */
> -#define I2C_IMX_TIME_BUSY	2000	/* loop count */
> -#define I2C_IMX_TIME_ACK	2000	/* loop count */
> -#define I2C_IMX_TIME_TRX	5	/* seconds */
> -
>  /* IMX I2C registers */
>  #define IMX_I2C_IADR	0x00	/* i2c slave address */
>  #define IMX_I2C_IFDR	0x04	/* i2c frequency divider */
> @@ -97,7 +83,6 @@
>  /** Variables ******************************************************************
>  *******************************************************************************/
>  
> -static unsigned int clkfreq = IMX_I2C_BIT_RATE;
>  static unsigned int disable_delay;	/* Dummy delay */
>  
>  /*
> @@ -135,6 +120,21 @@ struct imx_i2c_struct {
>  	unsigned long		i2csr;
>  };
>  
> +/*
> + * i.MX has 32-bit registers, i.MX31 16-bit, but only 8 bits are used. So far
> + * 8-bit access seems to work on both.
> + */
> +static inline unsigned int reg_read(const void __iomem *p)
> +{
> +	return __raw_readb(p);
> +}
> +
> +static inline void reg_write(unsigned int value, void __iomem *p)
> +{
> +	__raw_writeb(value, p);
> +}

readb and writeb() are the right verions to use here.

> +
> +
>  /** Functions for IMX I2C adapter driver ***************************************
>  *******************************************************************************/
>  
> @@ -145,7 +145,7 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx)
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
>  
>  	/* wait for bus not busy */
> -	while (readb(i2c_imx->base + IMX_I2C_I2SR) & I2SR_IBB) {
> +	while (reg_read(i2c_imx->base + IMX_I2C_I2SR) & I2SR_IBB) {
>  		if (signal_pending(current)) {
>  			dev_dbg(&i2c_imx->adapter.dev,
>  				"<%s> I2C Interrupted\n", __func__);
> @@ -167,7 +167,7 @@ static int i2c_imx_trx_complete(struct imx_i2c_struct *i2c_imx)
>  	int result;
>  
>  	result = wait_event_interruptible_timeout(i2c_imx->queue,
> -		i2c_imx->i2csr & I2SR_IIF, I2C_IMX_TIME_TRX * HZ);
> +		i2c_imx->i2csr & I2SR_IIF, i2c_imx->adapter.timeout);
>  
>  	if (unlikely(result < 0)) {
>  		dev_dbg(&i2c_imx->adapter.dev, "<%s> result < 0\n", __func__);
> @@ -183,62 +183,50 @@ static int i2c_imx_trx_complete(struct imx_i2c_struct *i2c_imx)
>  
>  static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx)
>  {
> -	unsigned long orig_jiffies = jiffies;
> -
> -	/* Wait for ack */
> -	while (readb(i2c_imx->base + IMX_I2C_I2SR) & I2SR_RXAK) {
> -		if (signal_pending(current)) {
> -			dev_dbg(&i2c_imx->adapter.dev,
> -				"<%s> I2C Interrupted\n", __func__);
> -			return -EINTR;
> -		}
> -		if (time_after(jiffies, orig_jiffies + HZ)) {
> -			dev_dbg(&i2c_imx->adapter.dev,
> -				"<%s> No ACK\n", __func__);
> -			return -EIO;
> -		}
> -		schedule();
> +	if (reg_read(i2c_imx->base + IMX_I2C_I2SR) & I2SR_RXAK) {
> +		dev_dbg(&i2c_imx->adapter.dev, "<%s> No ACK\n", __func__);
> +		return -EIO;   /* No ACK */
>  	}
>  
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s> ACK received\n", __func__);
> -	return 0;   /* No ACK */
> +	return 0;
>  }
>  
>  static void i2c_imx_start(struct imx_i2c_struct *i2c_imx)
>  {
> -	unsigned int temp = 0;
> +	unsigned int temp;
>  
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
>  
>  	/* Enable I2C controller */
> -	writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
> +	reg_write(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
>  	/* Start I2C transaction */
> -	temp = readb(i2c_imx->base + IMX_I2C_I2CR);
> +	temp = reg_read(i2c_imx->base + IMX_I2C_I2CR);
>  	temp |= I2CR_MSTA;
> -	writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> +	reg_write(temp, i2c_imx->base + IMX_I2C_I2CR);
>  	temp |= I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
> -	writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> +	reg_write(temp, i2c_imx->base + IMX_I2C_I2CR);
>  }
>  
>  static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
>  {
> -	unsigned int temp = 0;
> +	unsigned int temp;
>  
>  	/* Stop I2C transaction */
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> -	temp = readb(i2c_imx->base + IMX_I2C_I2CR);
> +	temp = reg_read(i2c_imx->base + IMX_I2C_I2CR);
>  	temp &= ~I2CR_MSTA;
> -	writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> +	reg_write(temp, i2c_imx->base + IMX_I2C_I2CR);
>  	/* setup chip registers to defaults */
> -	writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
> -	writeb(0, i2c_imx->base + IMX_I2C_I2SR);
> +	reg_write(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
> +	reg_write(0, i2c_imx->base + IMX_I2C_I2SR);
>  	/*
>  	 * This delay caused by an i.MXL hardware bug.
>  	 * If no (or too short) delay, no "STOP" bit will be generated.
>  	 */
>  	udelay(disable_delay);
>  	/* Disable I2C controller */
> -	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
> +	reg_write(0, i2c_imx->base + IMX_I2C_I2CR);
>  }
>  
>  static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
> @@ -259,7 +247,7 @@ static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
>  		for (i = 0; i2c_clk_div[i][0] < div; i++);
>  
>  	/* Write divider value to register */
> -	writeb(i2c_clk_div[i][1], i2c_imx->base + IMX_I2C_IFDR);
> +	reg_write(i2c_clk_div[i][1], i2c_imx->base + IMX_I2C_IFDR);
>  
>  	/*
>  	 * There dummy delay is calculated.
> @@ -284,12 +272,12 @@ static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
>  	struct imx_i2c_struct *i2c_imx = dev_id;
>  	unsigned int temp;
>  
> -	temp = readb(i2c_imx->base + IMX_I2C_I2SR);
> +	temp = reg_read(i2c_imx->base + IMX_I2C_I2SR);
>  	if (temp & I2SR_IIF) {
>  		/* save status register */
>  		i2c_imx->i2csr = temp;
>  		temp &= ~I2SR_IIF;
> -		writeb(temp, i2c_imx->base + IMX_I2C_I2SR);
> +		reg_write(temp, i2c_imx->base + IMX_I2C_I2SR);
>  		wake_up_interruptible(&i2c_imx->queue);
>  	}
>  
> @@ -299,12 +287,15 @@ static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
>  static int i2c_imx_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
>  {
>  	int i, result;
> +	unsigned int addr_trans;
>  
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s> write slave address: addr=0x%x\n",
>  		__func__, msgs->addr);
>  
> +	addr_trans = msgs->addr << 1;
> +
>  	/* write slave address */
> -	writeb(msgs->addr, i2c_imx->base + IMX_I2C_I2DR);
> +	reg_write(addr_trans, i2c_imx->base + IMX_I2C_I2DR);
>  	result = i2c_imx_trx_complete(i2c_imx);
>  	if (result)
>  		return result;
> @@ -318,7 +309,7 @@ static int i2c_imx_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
>  		dev_dbg(&i2c_imx->adapter.dev,
>  			"<%s> write byte: B%d=0x%X\n",
>  			__func__, i, msgs->buf[i]);
> -		writeb(msgs->buf[i], i2c_imx->base + IMX_I2C_I2DR);
> +		reg_write(msgs->buf[i], i2c_imx->base + IMX_I2C_I2DR);
>  		result = i2c_imx_trx_complete(i2c_imx);
>  		if (result)
>  			return result;
> @@ -333,13 +324,16 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
>  {
>  	int i, result;
>  	unsigned int temp;
> +	unsigned int addr_trans;
>  
>  	dev_dbg(&i2c_imx->adapter.dev,
>  		"<%s> write slave address: addr=0x%x\n",
>  		__func__, msgs->addr | 0x01);
>  
> +	addr_trans = (msgs->addr << 1) | 0x01;
> +
>  	/* write slave address */
> -	writeb(msgs->addr | 0x01, i2c_imx->base + IMX_I2C_I2DR);
> +	reg_write(addr_trans, i2c_imx->base + IMX_I2C_I2DR);
>  	result = i2c_imx_trx_complete(i2c_imx);
>  	if (result)
>  		return result;
> @@ -350,12 +344,12 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s> setup bus\n", __func__);
>  
>  	/* setup bus to read data */
> -	temp = readb(i2c_imx->base + IMX_I2C_I2CR);
> +	temp = reg_read(i2c_imx->base + IMX_I2C_I2CR);
>  	temp &= ~I2CR_MTX;
>  	if (msgs->len - 1)
>  		temp &= ~I2CR_TXAK;
> -	writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> -	readb(i2c_imx->base + IMX_I2C_I2DR); /* dummy read */
> +	reg_write(temp, i2c_imx->base + IMX_I2C_I2CR);
> +	reg_read(i2c_imx->base + IMX_I2C_I2DR); /* dummy read */
>  
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s> read data\n", __func__);
>  
> @@ -367,17 +361,17 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
>  		if (i == (msgs->len - 1)) {
>  			dev_dbg(&i2c_imx->adapter.dev,
>  				"<%s> clear MSTA\n", __func__);
> -			temp = readb(i2c_imx->base + IMX_I2C_I2CR);
> +			temp = reg_read(i2c_imx->base + IMX_I2C_I2CR);
>  			temp &= ~I2CR_MSTA;
> -			writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> +			reg_write(temp, i2c_imx->base + IMX_I2C_I2CR);
>  		} else if (i == (msgs->len - 2)) {
>  			dev_dbg(&i2c_imx->adapter.dev,
>  				"<%s> set TXAK\n", __func__);
> -			temp = readb(i2c_imx->base + IMX_I2C_I2CR);
> +			temp = reg_read(i2c_imx->base + IMX_I2C_I2CR);
>  			temp |= I2CR_TXAK;
> -			writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> +			reg_write(temp, i2c_imx->base + IMX_I2C_I2CR);
>  		}
> -		msgs->buf[i] = readb(i2c_imx->base + IMX_I2C_I2DR);
> +		msgs->buf[i] = reg_read(i2c_imx->base + IMX_I2C_I2DR);
>  		dev_dbg(&i2c_imx->adapter.dev,
>  			"<%s> read byte: B%d=0x%X\n",
>  			__func__, i, msgs->buf[i]);
> @@ -407,21 +401,21 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
>  		if (i) {
>  			dev_dbg(&i2c_imx->adapter.dev,
>  				"<%s> repeated start\n", __func__);
> -			temp = readb(i2c_imx->base + IMX_I2C_I2CR);
> +			temp = reg_read(i2c_imx->base + IMX_I2C_I2CR);
>  			temp |= I2CR_RSTA;
> -			writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> +			reg_write(temp, i2c_imx->base + IMX_I2C_I2CR);
>  		}
>  		dev_dbg(&i2c_imx->adapter.dev,
>  			"<%s> transfer message: %d\n", __func__, i);
>  		/* write/read data */
>  #ifdef CONFIG_I2C_DEBUG_BUS
> -		temp = readb(i2c_imx->base + IMX_I2C_I2CR);
> +		temp = reg_read(i2c_imx->base + IMX_I2C_I2CR);
>  		dev_dbg(&i2c_imx->adapter.dev, "<%s> CONTROL: IEN=%d, IIEN=%d, "
>  			"MSTA=%d, MTX=%d, TXAK=%d, RSTA=%d\n", __func__,
>  			(temp & I2CR_IEN ? 1 : 0), (temp & I2CR_IIEN ? 1 : 0),
>  			(temp & I2CR_MSTA ? 1 : 0), (temp & I2CR_MTX ? 1 : 0),
>  			(temp & I2CR_TXAK ? 1 : 0), (temp & I2CR_RSTA ? 1 : 0));
> -		temp = readb(i2c_imx->base + IMX_I2C_I2SR);
> +		temp = reg_read(i2c_imx->base + IMX_I2C_I2SR);
>  		dev_dbg(&i2c_imx->adapter.dev,
>  			"<%s> STATUS: ICF=%d, IAAS=%d, IBB=%d, "
>  			"IAL=%d, SRW=%d, IIF=%d, RXAK=%d\n", __func__,
> @@ -442,8 +436,8 @@ fail0:
>  
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s> exit with: %s: %d\n", __func__,
>  		(result < 0) ? "error" : "success msg",
> -			(result < 0) ? result : num);
> -	return (result < 0) ? result : num;
> +			result < 0 ? result : num);
> +	return result < 0 ? result : num;
>  }
>  
>  static u32 i2c_imx_func(struct i2c_adapter *adapter)
> @@ -518,12 +512,14 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  	i2c_imx->adapter.algo		= &i2c_imx_algo;
>  	i2c_imx->adapter.dev.parent	= &pdev->dev;
>  	i2c_imx->adapter.nr 		= pdev->id;
> +	i2c_imx->adapter.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD;
> +	i2c_imx->adapter.timeout	= 1;
>  	i2c_imx->irq			= irq;
>  	i2c_imx->base			= base;
>  	i2c_imx->res			= res;
>  
>  	/* Get I2C clock */
> -	i2c_imx->clk = clk_get(NULL, "i2c_clk");
> +	i2c_imx->clk = clk_get(&pdev->dev, "i2c_clk");
>  	if (IS_ERR(i2c_imx->clk)) {
>  		ret = PTR_ERR(i2c_imx->clk);
>  		dev_err(&pdev->dev, "can't get I2C clock\n");
> @@ -546,11 +542,11 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
>  
>  	/* Set up clock divider */
> -	i2c_imx_set_clk(i2c_imx, clkfreq);
> +	i2c_imx_set_clk(i2c_imx, pdata->i2c_clk);
>  
>  	/* Set up chip registers to defaults */
> -	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
> -	writeb(0, i2c_imx->base + IMX_I2C_I2SR);
> +	reg_write(0, i2c_imx->base + IMX_I2C_I2CR);
> +	reg_write(0, i2c_imx->base + IMX_I2C_I2SR);
>  
>  	/* Add I2C adapter */
>  	ret = i2c_add_numbered_adapter(&i2c_imx->adapter);
> @@ -604,10 +600,10 @@ static int __exit i2c_imx_remove(struct platform_device *pdev)
>  	free_irq(i2c_imx->irq, i2c_imx);
>  
>  	/* setup chip registers to defaults */
> -	writeb(0, i2c_imx->base + IMX_I2C_IADR);
> -	writeb(0, i2c_imx->base + IMX_I2C_IFDR);
> -	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
> -	writeb(0, i2c_imx->base + IMX_I2C_I2SR);
> +	reg_write(0, i2c_imx->base + IMX_I2C_IADR);
> +	reg_write(0, i2c_imx->base + IMX_I2C_IFDR);
> +	reg_write(0, i2c_imx->base + IMX_I2C_I2CR);
> +	reg_write(0, i2c_imx->base + IMX_I2C_I2SR);
>  
>  	/* Shut down hardware */
>  	if (pdata->exit)
> @@ -647,9 +643,6 @@ static void __exit i2c_adap_imx_exit(void)
>  module_init(i2c_adap_imx_init);
>  module_exit(i2c_adap_imx_exit);
>  
> -module_param(clkfreq, uint, S_IRUGO);
> -MODULE_PARM_DESC(clkfreq, "desired IMX I2C Clock Rate in Hz");
> -
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Darius Augulis");
>  MODULE_DESCRIPTION("I2C adapter driver for IMX I2C bus");
> -- 
> 1.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
