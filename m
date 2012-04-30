From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/2] I2C: Implement DMA support into mxs-i2c
Date: Mon, 30 Apr 2012 14:10:14 +0200
Message-ID: <201204301410.14393.marex@denx.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de> <1335738969-27445-2-git-send-email-marex@denx.de> <20120430060554.GB7926@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120430060554.GB7926-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

> On Mon, Apr 30, 2012 at 12:36:09AM +0200, Marek Vasut wrote:
> > This patch implements DMA support into mxs-i2c. DMA transfers are now
> > enabled by default, though it is possible for example for debugging
> > purposes, to disable them via i2c->dma_mode.
> > 
> > Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> > Cc: Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>
> > Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
> > Cc: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
> > Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> Looks promising, will give it a shot this week! Thanks.
> Very quick review.
> 
> > ---
> > 
> >  arch/arm/mach-mxs/devices/platform-mxs-i2c.c    |    5 +
> >  arch/arm/mach-mxs/include/mach/devices-common.h |    1 +
> >  drivers/i2c/busses/i2c-mxs.c                    |  261
> >  +++++++++++++++++++++-- 3 files changed, 245 insertions(+), 22
> >  deletions(-)
> > 
> > diff --git a/arch/arm/mach-mxs/devices/platform-mxs-i2c.c
> > b/arch/arm/mach-mxs/devices/platform-mxs-i2c.c index 79222ec..a94f308
> > 100644
> > --- a/arch/arm/mach-mxs/devices/platform-mxs-i2c.c
> > +++ b/arch/arm/mach-mxs/devices/platform-mxs-i2c.c
> > @@ -14,6 +14,7 @@
> > 
> >  	{								\
> >  	
> >  		.id = _id,						\
> >  		.iobase = soc ## _I2C ## _id ## _BASE_ADDR,		\
> > 
> > +		.dma	= soc ## _DMA_I2C ## _id,			\
> > 
> >  		.errirq = soc ## _INT_I2C ## _id ## _ERROR,		\
> >  		.dmairq = soc ## _INT_I2C ## _id ## _DMA,		\
> >  	
> >  	}
> > 
> > @@ -37,6 +38,10 @@ struct platform_device *__init mxs_add_mxs_i2c(
> > 
> >  			.end = data->iobase + SZ_8K - 1,
> >  			.flags = IORESOURCE_MEM,
> >  		
> >  		}, {
> > 
> > +			.start	= data->dma,
> > +			.end	= data->dma,
> > +			.flags	= IORESOURCE_DMA,
> > +		}, {
> > 
> >  			.start = data->errirq,
> >  			.end = data->errirq,
> >  			.flags = IORESOURCE_IRQ,
> > 
> > diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h
> > b/arch/arm/mach-mxs/include/mach/devices-common.h index f2e3839..791d99c
> > 100644
> > --- a/arch/arm/mach-mxs/include/mach/devices-common.h
> > +++ b/arch/arm/mach-mxs/include/mach/devices-common.h
> > @@ -80,6 +80,7 @@ mxs_add_gpmi_nand(const struct gpmi_nand_platform_data
> > *pdata,
> > 
> >  struct mxs_mxs_i2c_data {
> >  
> >  	int id;
> >  	resource_size_t iobase;
> > 
> > +	resource_size_t dma;
> > 
> >  	resource_size_t errirq;
> >  	resource_size_t dmairq;
> >  
> >  };
> 
> You need to either split this and send via alkml or I need an ACK from
> Shawn if it shall go in via I2C. You don't have Shawn on CC, please use
> scripts/get_maintainer.pl on your patchesr; you have been missing
> people/lists at least for the third time now.
> 
> >  static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, int
> >  len) {
> > 
> > -	u32 data;
> > +	u32 data = 0;
> 
> Unrelated, useless change.

Have you tried compiling the code with gcc 4.7?

> 
> >  	int i;
> > 
> > +
> > +	/*
> > +	 * The MXS I2C DMA mode is prefered and enabled by default.
> > +	 * The PIO mode is still supported, but should be used only
> > +	 * for debuging purposes etc.
> > +	 */
> 
> For exactness, should be "PIOQUEUE" instead of PIO. There is a PIO mode,
> but we don't use it.

Ok, it indeed should.

> 
> > +	i2c->dma_mode = 1;
> 
> Have you measured the overhead of DMA? I'd still think that
> 
> 	if (MX23 || msg->len > 24)
> 		do_dma
> 	else
> 		do_pioqueue
> 
> might be worth considered.

It might, but in the 2.6.35.3 I have from FSL, it only does:

WARN_ONCE(len > 24, "choose DMA mode if xfer len > 24 bytes\n");

Also, I tried switching PIOQUEUE/DMA, but didn't get it working. We might as 
well make this dma/pioqueue mode configurable as well as speed via platform data 
until someone comes up with a patch that can mix pioqueue and dma?
> 
> Regards,
> 
>    Wolfram
