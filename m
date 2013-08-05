From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH V2 2/3] i2c: mxs: Rework the PIO mode operation
Date: Mon, 5 Aug 2013 16:21:50 +0200
Message-ID: <201308051621.51146.marex@denx.de>
References: <1375219237-9594-1-git-send-email-marex@denx.de> <1375219237-9594-2-git-send-email-marex@denx.de> <20130805103647.GB9694@katana>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130805103647.GB9694@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>, Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

> On Tue, Jul 30, 2013 at 11:20:36PM +0200, Marek Vasut wrote:
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
> 
> Thanks. I'd love to see Acked, Reviewed or Tested tags cause I know ppl
> have used these patches. Don't be shy :)
> 
> > Cc: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > Cc: Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>
> > Cc: Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
> > Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> > ---
> > 
> >  drivers/i2c/busses/i2c-mxs.c |  263
> >  ++++++++++++++++++++++++++---------------- 1 file changed, 166
> >  insertions(+), 97 deletions(-)
> > 
> > V2: - Fix the data register shift computation algorithm and document that
> > 
> >       some more. The original algo failed for short 1-byte writes as seen
> >       in
> >       http://www.mail-archive.com/linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg12812.htm
> >       l
> >     
> >     - Add me a copyright/authorship line, since according to git blame, I
> >     
> >       have quite a lot of authored lines in the driver. Wolfram, I
> >       brought this up some time ago already, but finally got to it.
> >       You're OK with this, right?
> 
> Sure.
> 
> One question: Wouldn't it be more logical to have this patch first (fix
> pio) and then squash patches 1 and 3 as one on the top (add mx23 to now
> working pio)? I am not pushing too hard if this means a lot of work, but
> it sounds a bit more logical to me.

I would prefer to keep Juergens' patch separate from mine if you don't mind to 
be clear on the authorship.

> >  	if (msg->flags & I2C_M_RD) {
> > 
> > +		/*
> > +		 * PIO READ transfer:
> > +		 *
> > +		 * This transfer MUST be limited to 4 bytes maximum. It is not
> > +		 * possible to transfer more than four bytes via PIO, since we
> > +		 * can not in any way make sure we can read the data from the
> > +		 * DATA register fast enough. Besides, the RX FIFO is only four
> > +		 * bytes deep, thus we can only really read up to four bytes at
> > +		 * time. Finally, there is no bit indicating us that new data
> > +		 * arrived at the FIFO and can thus be fetched from the DATA
> > +		 * register.
> > +		 */
> > +		BUG_ON(msg->len > 4);
> 
> How could this happen? There is a check in mxs_i2c_xfer_msg.

It cannot happen, I added the check here to make sure when someone becomes 
adventurous enough to start messing with these constants, it will stop him early 
enough.

Best regards,
Marek Vasut
