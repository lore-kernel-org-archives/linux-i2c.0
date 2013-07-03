From: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c: i2c-mxs: Use DMA mode even for small transfers
Date: Wed, 03 Jul 2013 11:11:35 +0200
Message-ID: <1372842695.4440.3.camel@weser.hi.pengutronix.de>
References: <1372713261-20551-1-git-send-email-festevam@gmail.com>
	 <1372752969.4277.8.camel@weser.hi.pengutronix.de>
	 <201307030438.50069.marex@denx.de> <201307030637.05324.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201307030637.05324.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Am Mittwoch, den 03.07.2013, 06:37 +0200 schrieb Marek Vasut:
> Hi,
> 
> > Dear Lucas Stach,
> > 
> > > Am Montag, den 01.07.2013, 18:14 -0300 schrieb Fabio Estevam:
> > > > From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > > 
> > > > Recently we have been seing some reports about PIO mode not working
> > > > properly.
> > > > 
> > > > - http://www.spinics.net/lists/linux-i2c/msg11985.html
> > > > - http://marc.info/?l=linux-i2c&m=137235593101385&w=2
> > > > - https://lkml.org/lkml/2013/6/24/430
> > > > 
> > > > Let's use DMA mode even for small transfers.
> > > > 
> > > > Without this patch, i2c reads the incorrect sgtl5000 version on a
> > > > mx28evk when touchscreen is enabled:
> > > > 
> > > > [    5.856270] sgtl5000 0-000a: Device with ID register 0 is not a
> > > > sgtl5000 [    9.877307] sgtl5000 0-000a: ASoC: failed to probe CODEC
> > > > -19 [    9.883528] mxs-sgtl5000 sound.12: ASoC: failed to instantiate
> > > > card -19 [    9.892955] mxs-sgtl5000 sound.12: snd_soc_register_card
> > > > failed (-19)
> > > > 
> > > > Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> > > > Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > > ---
> > > > Applies against 3.10
> > > > 
> > > > Changes since v1:
> > > > - Keep the PIO code
> > > > 
> > > >  drivers/i2c/busses/i2c-mxs.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/i2c/busses/i2c-mxs.c
> > > > b/drivers/i2c/busses/i2c-mxs.c index 2039f23..6d8094d 100644
> > > > --- a/drivers/i2c/busses/i2c-mxs.c
> > > > +++ b/drivers/i2c/busses/i2c-mxs.c
> > > > @@ -494,7 +494,7 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter
> > > > *adap, struct i2c_msg *msg,
> > > > 
> > > >  	 * based on this empirical measurement and a lot of previous
> > > >  	 frobbing. */
> > > >  	
> > > >  	i2c->cmd_err = 0;
> > > > 
> > > > -	if (msg->len < 8) {
> > > > +	if (0) {	/* disable PIO mode until a proper fix is made */
> > > > 
> > > >  		ret = mxs_i2c_pio_setup_xfer(adap, msg, flags);
> > > >  		if (ret)
> > > >  		
> > > >  			mxs_i2c_reset(i2c);
> > > 
> > > I still plan to take another look at the PIO mode, but higher priority
> > > things keep popping up in front of me. So this patch is:
> > > Acked-by: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > 
> > Ok, update. So far I arrived at a point where I can avoid the PIO trouble.
> > 
> > If I only do transfers shorter or equal in length to 3 bytes via PIO, it
> > works as expected. If the transfer is longer, the LA shows very long
> > transfer happening actually. Therefore, the pumping of data in loop
> > to/from PIO via the DATA register doesn't work.
> > 
> > I will update you more later, once I figure out something else. Now I need
> > some sleep.
> 
> I'm attaching a patch. Alex, please give it a go and see if it fixes your issue. 
> It is _VERY_ ugly.
> 
> The basic idea behind the the patch is that, as (attempted to be) explained 
> above, subsequent writes to DATA register in PIO mode cause constant generation 
> of clock on the bus and therefore a very long transfer of zero data. This 
> confuses the I2C peripherals of course.
> 
> The patch implements clock stretching for PIO writes (maybe we need this for 
> reads too) by making the controller blast out only 4 (or less) bytes of data in 
> each write into the DATA register. To prevent interruption of the transfer 
> between writes into the DATA register, the SCK is held low using the 
> RETAIN_CLOCK bit.
> 
> But (!) here comes the caveat. The PIO was introduced to speed up small 
> transfers. Introducing clock stretching into PIO mode operation might completely 
> remove this advantage. This has to be measured again.
> 
> I will continue once I sleep a little. Pardon my {language, code}, it's too 
> early in the morning already.
> 

Ok, so if this patch works, we may just want to restrict PIO mode to 4
or 3 Byte transfers, where we don't need to use this ugly clock
stretching. This way we may gain the PIO speedup for single register
reads/writes, which is a pretty common operation, but fall back to the
more reliable DMA mode for bigger transfers.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
