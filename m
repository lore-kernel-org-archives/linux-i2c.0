From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: Rework the PIO mode operation
Date: Tue, 16 Jul 2013 01:24:09 +0200
Message-ID: <201307160124.09964.marex@denx.de>
References: <1373312807-13227-1-git-send-email-marex@denx.de> <1373892198.4172.17.camel@weser.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1373892198.4172.17.camel-WzVe3FnzCwFR6QfukMTsflXZhhPuCNm+@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Lucas,

> As promised some comments without a real test, yet.
> 
> Am Montag, den 08.07.2013, 21:46 +0200 schrieb Marek Vasut:
> > Analyze and rework the PIO mode operation. The PIO mode operation
> > was unreliable on MX28, by analyzing the bus with LA, the checks
> > for when data were available or were to be sent were wrong.
> > 
> > The PIO WRITE has to be completely reworked as it multiple problems.
> > The MX23 datasheet helped here, see comments in the code for details.
> > The problems boil down to:
> > - RUN bit in CTRL0 must be set after DATA register was written
> > - The PIO transfer must be 4 bytes long tops, otherwise use
> > 
> >   clock stretching.
> > 
> > Both of these fixes are implemented.
> > 
> > The PIO READ operation can only be done for up to four bytes as
> > we are unable to read out the data from the DATA register fast
> > enough.
> > 
> > This patch also tries to document the investigation within the
> > code.
> > 
> > Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> > Cc: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > Cc: Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Cc: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> > Cc: <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
> > ---
> > 
> >  drivers/i2c/busses/i2c-mxs.c |  202
> >  ++++++++++++++++++++++++++++++------------ 1 file changed, 147
> >  insertions(+), 55 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> > index df8ff5a..c176aa8 100644
> > --- a/drivers/i2c/busses/i2c-mxs.c
> > +++ b/drivers/i2c/busses/i2c-mxs.c
> > @@ -1,5 +1,5 @@
> > 
> >  /*
> > 
> > - * Freescale MXS I2C bus driver
> > + * Freescale MX28 I2C bus driver
> > 
> >   *
> >   * Copyright (C) 2011-2012 Wolfram Sang, Pengutronix e.K.
> >   *
> > 
> > @@ -7,6 +7,8 @@
> > 
> >   *
> >   * Copyright (C) 2009-2010 Freescale Semiconductor, Inc. All Rights
> >   Reserved. *
> > 
> > + * WARNING: This driver does NOT yet support i.MX23.
> > + *
> > 
> >   * This program is free software; you can redistribute it and/or modify
> >   * it under the terms of the GNU General Public License as published by
> >   * the Free Software Foundation; either version 2 of the License, or
> > 
> > @@ -301,6 +303,19 @@ static int mxs_i2c_pio_wait_dmareq(struct
> > mxs_i2c_dev *i2c)
> > 
> >  	return 0;
> >  
> >  }
> 
> The comment above is wrong. Only PIO mode doesn't work on MX23. We have
> customer hardware here at Pengutronix, which is working just fine with
> MX23 i2c when only using the DMA mode.

Check the bus with an LA, I think I saw some trouble on MX23EVK. It'd be nice to 
verify if what you see on the bus is really clean.

> If your patch doesn't fix MX23,
> please pick up Juergens fix to differentiate between the chip types in
> the driver and disable PIO accordingly.

I suspect we will need Jurgens' patch anyway, since the PIO is either FUBAR'd on 
MX23 or I do not know yet how to operate it. On the other hand, the MX23 manual 
does mention some PIO operation (the PIO bit in CTRL register).
[...]

> > @@ -404,68 +459,99 @@ static int mxs_i2c_pio_setup_xfer(struct
> > i2c_adapter *adap,
> > 
> >  		for (i = 0; i < msg->len; i++) {
> >  		
> >  			if ((i & 3) == 0) {
> > 
> > -				ret = mxs_i2c_pio_wait_dmareq(i2c);
> > -				if (ret)
> > -					return ret;
> > +				/*
> > +				 * Wait a bit until the data arrive in the
> > +				 * DATA register so we can read them.
> > +				 */
> > +				mdelay(5);
> 
> This is more than a bit, 5msecs seems excessive. Aside from possibly
> nullifying any benefits from the PIO mode, hogging the CPU for this
> duration just to wait for data to arrive is crazy. If this is really
> needed AND you still see benefits from PIO mode, consider sleeping here.

This needs to be fixed. I just didn't find a bit that the I2C block asserts to 
signalize it has all the data. I have an idea, but I'll need to verify my idea.
[...]

> > -	 * The current boundary to select between PIO/DMA transfer method
> > -	 * is set to 8 bytes, transfers shorter than 8 bytes are transfered
> > -	 * using PIO mode while longer transfers use DMA. The 8 byte border is
> > -	 * based on this empirical measurement and a lot of previous frobbing.
> > +	 * The MX28 I2C IP block can only do PIO READ for transfer of to up
> > +	 * 4 bytes of length. The write transfer is not limited as it can use
> > +	 * clock stretching to avoid FIFO underruns.
> > 
> >  	 */
> > 
> > +	if ((msg->flags & I2C_M_RD) && (msg->len <= 4))
> > +		use_pio = 1;
> > +	if (!(msg->flags & I2C_M_RD) && (msg->len < 7))
> > +		use_pio = 1;
> > +
> 
> Why do you need to split this out? I think the statement is reasonable
> sized to go into the if(), especially with the comment above it. No need
> to use a local variable + you don't loose lazy evaluation.

The compiler does optimize this anyway, or do you see it does not? Anyway, you 
might be right about the condition being simple enough for an ugly two-liner.

> >  	i2c->cmd_err = 0;
> > 
> > -	if (msg->len < 8) {
> > +	if (use_pio) {
> > 
> >  		ret = mxs_i2c_pio_setup_xfer(adap, msg, flags);
> > 
> > -		if (ret)
> > +		/* No need to reset the block if NAK was received. */
> > +		if (ret && (ret != -ENXIO))
> > 
> >  			mxs_i2c_reset(i2c);
> >  	
> >  	} else {
> >  	
> >  		INIT_COMPLETION(i2c->cmd_complete);
> > 
> > @@ -507,9 +599,11 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter
> > *adap, struct i2c_msg *msg,
> > 
> >  						msecs_to_jiffies(1000));
> >  		
> >  		if (ret == 0)
> >  		
> >  			goto timeout;
> > 
> > +
> > +		ret = i2c->cmd_err;
> 
> All those error code swaps between ret and cmd_err are really confusing.
> Perhaps we should record the error in _one_ of both only and then assign
> one to the other at the very end of this function.

The error reporting is horrible, it needs fixing.

Best regards,
Marek Vasut
