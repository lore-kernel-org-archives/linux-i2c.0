From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: Add PIO and mixed-DMA support
Date: Thu, 24 Jan 2013 13:39:12 +0100
Message-ID: <201301241339.12940.marex@denx.de>
References: <1353477088-9660-1-git-send-email-marex@denx.de> <20130124072519.GC8364@nekote.pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130124072519.GC8364-8EAEigeeuNG034pCzgS/Qg7AFbiQbgqx@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

> Hi Marek,
> 
> On Wed, Nov 21, 2012 at 06:51:28AM +0100, Marek Vasut wrote:
> > Add support for the PIO mode and mixed PIO/DMA mode support. The mixed
> > PIO/DMA is the default mode of operation. This shall leverage overhead
> > that the driver creates due to setting up DMA descriptors even for very
> > short transfers.
> > 
> > The current boundary between PIO/DMA 8 bytes, transfers shorter than 8
> > bytes are transfered by PIO, longer transfers use DMA. The performance
> > of write transfers remains unchanged, while there is a minor improvement
> > of read performance. Reading 16KB EEPROM with DMA-only operations gives
> > a read speed of 39.5KB/s, while with then new mixed-mode the speed is
> > blazing 40.6KB/s.
> > 
> > Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> > Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> > 
> >  drivers/i2c/busses/i2c-mxs.c |  163
> >  ++++++++++++++++++++++++++++++++++++++---- 1 file changed, 150
> >  insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> > index 47d5d53..9048f34 100644
> > --- a/drivers/i2c/busses/i2c-mxs.c
> > +++ b/drivers/i2c/busses/i2c-mxs.c
> > @@ -39,6 +39,7 @@
> > 
> >  #define MXS_I2C_CTRL0_SET	(0x04)
> >  
> >  #define MXS_I2C_CTRL0_SFTRST			0x80000000
> > 
> > +#define MXS_I2C_CTRL0_RUN			0x20000000
> > 
> >  #define MXS_I2C_CTRL0_SEND_NAK_ON_LAST		0x02000000
> >  #define MXS_I2C_CTRL0_RETAIN_CLOCK		0x00200000
> >  #define MXS_I2C_CTRL0_POST_SEND_STOP		0x00100000
> > 
> > @@ -64,6 +65,13 @@
> > 
> >  #define MXS_I2C_CTRL1_SLAVE_STOP_IRQ		0x02
> >  #define MXS_I2C_CTRL1_SLAVE_IRQ			0x01
> > 
> > +#define MXS_I2C_DATA		(0xa0)
> > +
> > +#define MXS_I2C_DEBUG0		(0xb0)
> > +#define MXS_I2C_DEBUG0_CLR	(0xb8)
> > +
> > +#define MXS_I2C_DEBUG0_DMAREQ	0x80000000
> > +
> > 
> >  #define MXS_I2C_IRQ_MASK	(MXS_I2C_CTRL1_DATA_ENGINE_CMPLT_IRQ | \
> >  
> >  				 MXS_I2C_CTRL1_NO_SLAVE_ACK_IRQ | \
> >  				 MXS_I2C_CTRL1_EARLY_TERM_IRQ | \
> > 
> > @@ -298,6 +306,128 @@ write_init_pio_fail:
> >  	return -EINVAL;
> >  
> >  }
> > 
> > +static int mxs_i2c_pio_wait_dmareq(struct mxs_i2c_dev *i2c)
> > +{
> > +	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
> > +
> > +	while (!(readl(i2c->regs + MXS_I2C_DEBUG0) &
> > +		MXS_I2C_DEBUG0_DMAREQ)) {
> > +		if (time_after(jiffies, timeout))
> > +			return -ETIMEDOUT;
> > +		cond_resched();
> > +	}
> > +
> > +	writel(MXS_I2C_DEBUG0_DMAREQ, i2c->regs + MXS_I2C_DEBUG0_CLR);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mxs_i2c_pio_wait_cplt(struct mxs_i2c_dev *i2c)
> > +{
> > +	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
> > +
> > +	while (!(readl(i2c->regs + MXS_I2C_CTRL1) &
> > +		MXS_I2C_CTRL1_DATA_ENGINE_CMPLT_IRQ)) {
> > +		if (time_after(jiffies, timeout))
> > +			return -ETIMEDOUT;
> > +		cond_resched();
> > +	}
> > +
> > +	writel(MXS_I2C_CTRL1_DATA_ENGINE_CMPLT_IRQ,
> > +		i2c->regs + MXS_I2C_CTRL1_CLR);
> > +
> > +	return 0;
> > +}
> 
> That's a lot of polling. Didn't interrupts work?

Oh they do work, but check below, it transfers 8 bytes of data max via PIO. The 
overhead of interrupt handling would be much larger. Thus, polling.

> > +static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
> > +			struct i2c_msg *msg, uint32_t flags)
> > +{
> > +	struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
> > +	uint32_t addr_data = msg->addr << 1;
> > +	uint32_t data = 0;
> > +	int i, shifts_left, ret;
> > +
> > +	/* Mute IRQs coming from this block. */
> > +	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_CLR);
> > +
> > +	if (msg->flags & I2C_M_RD) {
> > +		addr_data |= I2C_SMBUS_READ;
> > +
> > +		/* SELECT command. */
> > +		writel(MXS_I2C_CTRL0_RUN | MXS_CMD_I2C_SELECT,
> > +			i2c->regs + MXS_I2C_CTRL0);
> > +
> > +		ret = mxs_i2c_pio_wait_dmareq(i2c);
> > +		if (ret)
> > +			return ret;
> > +
> > +		writel(addr_data, i2c->regs + MXS_I2C_DATA);
> > +
> > +		ret = mxs_i2c_pio_wait_cplt(i2c);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* READ command. */
> > +		writel(MXS_I2C_CTRL0_RUN | MXS_CMD_I2C_READ | flags |
> > +			MXS_I2C_CTRL0_XFER_COUNT(msg->len),
> > +			i2c->regs + MXS_I2C_CTRL0);
> > +
> > +		for (i = 0; i < msg->len; i++) {
> > +			if ((i & 3) == 0) {
> > +				ret = mxs_i2c_pio_wait_dmareq(i2c);
> > +				if (ret)
> > +					return ret;
> > +				data = readl(i2c->regs + MXS_I2C_DATA);
> > +			}
> > +			msg->buf[i] = data & 0xff;
> > +			data >>= 8;
> > +		}
> > +	} else {
> > +		addr_data |= I2C_SMBUS_WRITE;
> > +
> > +		/* WRITE command. */
> > +		writel(MXS_I2C_CTRL0_RUN | MXS_CMD_I2C_WRITE | flags |
> > +			MXS_I2C_CTRL0_XFER_COUNT(msg->len + 1),
> > +			i2c->regs + MXS_I2C_CTRL0);
> > +
> > +		/*
> > +		 * The LSB of data buffer is the first byte blasted across
> > +		 * the bus. Higher order bytes follow. Thus the following
> > +		 * filling schematic.
> > +		 */
> 
> Ah, my old code again :) What was wrong with my comment?

You're right, I recycled this portion from somewhere, I think from the old PIOQ 
code. I just shortened it.

> > +		data = addr_data << 24;
> > +		for (i = 0; i < msg->len; i++) {
> > +			data >>= 8;
> > +			data |= (msg->buf[i] << 24);
> > +			if ((i & 3) == 2) {
> > +				ret = mxs_i2c_pio_wait_dmareq(i2c);
> > +				if (ret)
> > +					return ret;
> > +				writel(data, i2c->regs + MXS_I2C_DATA);
> > +			}
> > +		}
> > +
> > +		shifts_left = 24 - (i & 3) * 8;
> > +		if (shifts_left) {
> > +			data >>= shifts_left;
> > +			ret = mxs_i2c_pio_wait_dmareq(i2c);
> > +			if (ret)
> > +				return ret;
> > +			writel(data, i2c->regs + MXS_I2C_DATA);
> > +		}
> > +	}
> > +
> > +	ret = mxs_i2c_pio_wait_cplt(i2c);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Clear any dangling IRQs and re-enable interrupts. */
> > +	writel(MXS_I2C_IRQ_MASK, i2c->regs + MXS_I2C_CTRL1_CLR);
> > +	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
> > +
> > +	return 0;
> > +}
> > +
> > 
> >  /*
> >  
> >   * Low level master read/write transaction.
> >   */
> > 
> > @@ -316,24 +446,31 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter
> > *adap, struct i2c_msg *msg,
> > 
> >  	if (msg->len == 0)
> >  	
> >  		return -EINVAL;
> > 
> > -	INIT_COMPLETION(i2c->cmd_complete);
> > -	i2c->cmd_err = 0;
> > -
> > -	ret = mxs_i2c_dma_setup_xfer(adap, msg, flags);
> > -	if (ret)
> > -		return ret;
> > +	if (msg->len < 8) {
> 
> Some THRESHOLD define would be nice here.

True, lemme roll out a V2.

> > +		ret = mxs_i2c_pio_setup_xfer(adap, msg, flags);
> > +		if (ret)
> > +			mxs_i2c_reset(i2c);
> > +	} else {
> > +		i2c->cmd_err = 0;
> > +		INIT_COMPLETION(i2c->cmd_complete);
> > +		ret = mxs_i2c_dma_setup_xfer(adap, msg, flags);
> > +		if (ret)
> > +			return ret;
> > 
> > -	ret = wait_for_completion_timeout(&i2c->cmd_complete,
> > +		ret = wait_for_completion_timeout(&i2c->cmd_complete,
> > 
> >  						msecs_to_jiffies(1000));
> > 
> > -	if (ret == 0)
> > -		goto timeout;
> > +		if (ret == 0)
> > +			goto timeout;
> > +
> > +		if (i2c->cmd_err == -ENXIO)
> > +			mxs_i2c_reset(i2c);
> > 
> > -	if (i2c->cmd_err == -ENXIO)
> > -		mxs_i2c_reset(i2c);
> > +		ret = i2c->cmd_err;
> > +	}
> > 
> > -	dev_dbg(i2c->dev, "Done with err=%d\n", i2c->cmd_err);
> > +	dev_dbg(i2c->dev, "Done with err=%d\n", ret);
> > 
> > -	return i2c->cmd_err;
> > +	return ret;
> > 
> >  timeout:
> >  	dev_dbg(i2c->dev, "Timeout!\n");
> 
> Regards,
> 
>    Wolfram
