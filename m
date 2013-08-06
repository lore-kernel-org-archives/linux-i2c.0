From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH V2 2/3] i2c: mxs: Rework the PIO mode operation
Date: Tue, 6 Aug 2013 15:35:50 +0200
Message-ID: <201308061535.50470.marex@denx.de>
References: <1375219237-9594-1-git-send-email-marex@denx.de> <201308051621.51146.marex@denx.de> <20130806082029.GA2979@katana>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130806082029.GA2979@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>, Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

> > > One question: Wouldn't it be more logical to have this patch first (fix
> > > pio) and then squash patches 1 and 3 as one on the top (add mx23 to now
> > > working pio)? I am not pushing too hard if this means a lot of work,
> > > but it sounds a bit more logical to me.
> > 
> > I would prefer to keep Juergens' patch separate from mine if you don't
> > mind to be clear on the authorship.
> 
> If you add both SoB, everything should be fine. We often work on someone
> else's patches, no?

I agree, but I still don't like squashing the two patches together. I forgot to 
mention it last time, but please, look at the patches one more time. Jurgens' 
does the DT change and mine fixes the PIO on MX23, I'd like to keep these 
changes separate.

> > > >  	if (msg->flags & I2C_M_RD) {
> > > > 
> > > > +		/*
> > > > +		 * PIO READ transfer:
> > > > +		 *
> > > > +		 * This transfer MUST be limited to 4 bytes maximum. It 
is not
> > > > +		 * possible to transfer more than four bytes via PIO, 
since we
> > > > +		 * can not in any way make sure we can read the data 
from the
> > > > +		 * DATA register fast enough. Besides, the RX FIFO is 
only four
> > > > +		 * bytes deep, thus we can only really read up to four 
bytes at
> > > > +		 * time. Finally, there is no bit indicating us that new 
data
> > > > +		 * arrived at the FIFO and can thus be fetched from the 
DATA
> > > > +		 * register.
> > > > +		 */
> > > > +		BUG_ON(msg->len > 4);
> > > 
> > > How could this happen? There is a check in mxs_i2c_xfer_msg.
> > 
> > It cannot happen, I added the check here to make sure when someone
> > becomes adventurous enough to start messing with these constants, it
> > will stop him early enough.
> 
> Then, add the comment to the check so ppl will notice there?

If I could add a big red flashing sign into the code stating "If you go over 4 
bytes here, a kitten will die", then by all means, I would add it. 
Unfortunatelly, there is no such thing possible.

> I like to
> keep BUG_ON sparse, since it is hard to tell if the occasion is really
> worth stopping the machine.

While I agree with you on this, I would also like for the kernel to check if 
someone accidentally screwed up and thoroughly warn him. We cannot continue 
anyway, because if more than 4 bytes are requested, the controller would simply 
not give us more than the last 4 bytes and this would result in an undefined 
behavior and data corruption during reception. We simply do not want that.

Maybe WARN_ONCE and return with error might just work?

Best regards,
Marek Vasut
