From: Sifan Naeem <Sifan.Naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 3/7] i2c: img-scb: mark transaction as complete when all
 data is read
Date: Wed, 29 Jul 2015 14:37:54 +0000
Message-ID: <A0E307549471DA4DBAF2DE2DE6CBFB7E4966DD41@hhmail02.hh.imgtec.org>
References: <1437998162-32724-1-git-send-email-sifan.naeem@imgtec.com>
 <1437998162-32724-4-git-send-email-sifan.naeem@imgtec.com>
 <55B8E15B.9070002@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55B8E15B.9070002-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: James Hogan <James.Hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi James,

> 
> On 27/07/15 12:55, Sifan Naeem wrote:
> > We can mark the transfer as complete without waiting for the stop bit.
> > This is important when handling repeated start transfers as we have to
> > start the next transfer without the stop bit being issued.
> >
> > Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-img-scb.c |    7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-img-scb.c
> > b/drivers/i2c/busses/i2c-img-scb.c
> > index 24b09fe..e27c3e0 100644
> > --- a/drivers/i2c/busses/i2c-img-scb.c
> > +++ b/drivers/i2c/busses/i2c-img-scb.c
> > @@ -903,8 +903,11 @@ static unsigned int img_i2c_auto(struct img_i2c
> *i2c,
> >  	if (i2c->msg.flags & I2C_M_RD) {
> >  		if (int_status & INT_FIFO_FULL_FILLING) {
> >  			img_i2c_read_fifo(i2c);
> > -			if (i2c->msg.len == 0)
> > -				return ISR_WAITSTOP;
> > +			if (i2c->msg.len == 0) {
> > +				if (i2c->last_msg)
> > +					return ISR_WAITSTOP;
> > +				return ISR_COMPLETE(0);
> 
> That already happens in img_i2c_isr().
> 
Will drop this patch from v2.

Sifan
> Cheers
> James
