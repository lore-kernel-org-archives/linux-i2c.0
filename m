From: Sifan Naeem <Sifan.Naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 7/8] i2c: img-scb: improve transaction complete handle
Date: Wed, 29 Jul 2015 13:35:33 +0000
Message-ID: <A0E307549471DA4DBAF2DE2DE6CBFB7E4966DCAA@hhmail02.hh.imgtec.org>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com>
 <1437997641-32575-8-git-send-email-sifan.naeem@imgtec.com>
 <55B8C56A.7050102@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55B8C56A.7050102-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: James Hogan <James.Hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "Stable kernel (v3.19+)" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi James,

> -----Original Message-----
> From: James Hogan
> Sent: 29 July 2015 13:22
> To: Sifan Naeem; Wolfram Sang; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Stable kernel (v3.19+)
> Subject: Re: [PATCH 7/8] i2c: img-scb: improve transaction complete handle
> 
> Hi Sifan,
> 
> On 27/07/15 12:47, Sifan Naeem wrote:
> > Clear line status and all interrupts when transaction is complete, as
> > not doing so might leave unserviced interrupts that might be
> 
> Do you have a specific example of when this might happen, and whether it
> could occur after img_i2c_complete_transaction()?
> 
> I'm just wondering if it would be better to do this before starting every new
> message instead of after handling the last irq that is of interest (maybe
> somewhere in img_i2c_xfer).
> 
Moved to happen before each transfer.

> > handled in the context of a new transfer. Soft reset if the the
> > transfer failed to bring back the i2c block to a reset state.
> >
> > Fixes: 27bce4 ("i2c: img-scb: Add Imagination Technologies I2C SCB
> > driver")
> > Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> > Cc: Stable kernel (v3.19+) <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-img-scb.c |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-img-scb.c
> > b/drivers/i2c/busses/i2c-img-scb.c
> > index 341130e..bbfee33 100644
> > --- a/drivers/i2c/busses/i2c-img-scb.c
> > +++ b/drivers/i2c/busses/i2c-img-scb.c
> > @@ -626,7 +626,10 @@ static void img_i2c_complete_transaction(struct
> img_i2c *i2c, int status)
> >  	img_i2c_switch_mode(i2c, MODE_INACTIVE);
> >  	if (status) {
> >  		i2c->msg_status = status;
> > -		img_i2c_transaction_halt(i2c, false);
> > +		img_i2c_soft_reset(i2c);
> 
> This seems like overkill. This will only happen in a couple of cases:
> (1) an automatic mode ack error, which is completely recoverable.
> (2) a fatal error (clock low timeout), which switches mode to MODE_FATAL
> anyway, preventing further transactions.
> 
Removed. 

Thanks,
Sifan
> Cheers
> James
> 
> > +	} else {
> > +		img_i2c_writel(i2c, SCB_INT_CLEAR_REG, ~0);
> > +		img_i2c_writel(i2c, SCB_CLEAR_REG, ~0);
> >  	}
> >  	complete(&i2c->msg_complete);
> >  }
> >
