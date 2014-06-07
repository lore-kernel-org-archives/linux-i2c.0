From: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v4] i2c: add driver for Rockchip RK3xxx SoC I2C adapter
Date: Sat, 07 Jun 2014 17:32:09 +0200
Message-ID: <1468105.xYIQWVNzVZ@typ>
References: <5192968.EzcUiXba22@typ> <1547619.upPdAXDT0W@typ> <20140602120854.GA2654@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140602120854.GA2654@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

thanks for the review!

> > +
> > +	/* Settings */
> > +	unsigned int scl_frequency;
> > +
> > +	/* Synchronization & notification */
> > +	spinlock_t lock;
> 
> Why the lock? The core has per-adapter locks anyhow.

I'm using it to lock the rk3x_i2c struct during interrupts. It's needed there 
because an operation can timeout, which means the interrupt can occur at any 
time and possibly conflict with the cleanup I do after a timeout.

I looked around in i2c-exynos5.c, i2c-pxa.c and others, and they do it the 
same way. Could you explain in more detail why it's not needed?

> > +static void rk3x_i2c_handle_write(struct rk3x_i2c *i2c, unsigned int ipd)
> > +{
> > +	if (!(ipd & REG_INT_MBTF)) {
> > +		rk3x_i2c_stop(i2c, -ENXIO);
> > +		dev_err(i2c->dev, "unexpected irq in WRITE: 0x%x\n", ipd);
> > +		rk3x_i2c_clean_ipd(i2c);
> > +		return;
> > +	}
> > +
> > +	/* ack interrupt */
> > +	i2c_writel(i2c, REG_INT_MBTF, REG_IPD);
> > +
> > +	/* are we finished? */
> > +	if (i2c->processed == i2c->msg->len)
> > +		rk3x_i2c_stop(i2c, i2c->error);
> > +	else
> > +		rk3x_i2c_fill_transmit_buf(i2c);
> 
> It looks to me that you STOP after every message? You should use
> REPEATED_START inbetween messages and only stop after the last message
> of a transfer.

I had a fight with the hw today and finally got it to issue a REPEATED_START 
for multiple "boring" messages. Will be included in the next version.

> > +/**
> > + * Setup I2C registers for an I2C operation specified by msgs, num.
> > + *
> > + * Must be called with i2c->lock held.
> > + *
> > + * @msgs: I2C msgs to process
> > + * @num: Number of msgs
> > + *
> > + * returns: Number of I2C msgs processed or negative in case of error
> > + */
> > +static int rk3x_i2c_setup(struct rk3x_i2c *i2c, struct i2c_msg *msgs, int
> > num) +{
> > +	u32 addr = (msgs[0].addr & 0x7f) << 1;
> > +	int ret = 0;
> > +
> > +	/*
> > +	 * The I2C adapter can issue a small (len < 4) write packet before
> > +	 * reading. This speeds up SMBus-style register reads.
> > +	 * The MRXADDR/MRXRADDR hold the slave address and the slave register
> > +	 * address in this case.
> > +	 */
> > +
> > +	if (num >= 2 && msgs[0].len < 4
> > +	    && !(msgs[0].flags & I2C_M_RD)
> > +	    && (msgs[1].flags & I2C_M_RD)) {
> > +		u32 reg_addr = 0;
> > +
> > +		dev_dbg(i2c->dev, "Combined write/read from addr 0x%x\n",
> > +			addr >> 1);
> > +
> > +		if (msgs[0].len == 0)
> > +			return -EINVAL;
> 
> Can the controller do SMBUS_QUICK (len == 0) in general? For the case it
> cannot do it only in this multi-packet mode, then you should fall back
> to the "boring" mode.

Actually, I wasn't aware that (len == 0) is a valid case. The hw supports it 
in both modes, I just tested that. So the check is going away.

I'm cleaning up now and you can expect a new version of the patch today.

Cheers,
  Max
