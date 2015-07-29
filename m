From: Sifan Naeem <Sifan.Naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 5/7] i2c: img-scb: remove fifo EMPTYING interrupts handle
Date: Wed, 29 Jul 2015 17:00:25 +0000
Message-ID: <A0E307549471DA4DBAF2DE2DE6CBFB7E4966DE24@hhmail02.hh.imgtec.org>
References: <1437998162-32724-1-git-send-email-sifan.naeem@imgtec.com>
 <1437998162-32724-6-git-send-email-sifan.naeem@imgtec.com>
 <55B8F8C1.8030507@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55B8F8C1.8030507-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: James Hogan <James.Hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi James,

> -----Original Message-----
> From: James Hogan
> Sent: 29 July 2015 17:01
> To: Sifan Naeem; Wolfram Sang; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH 5/7] i2c: img-scb: remove fifo EMPTYING interrupts
> handle
> 
> On 27/07/15 12:56, Sifan Naeem wrote:
> > This interrupt could have been useful for repeated start transfers as
> > the current transfer could be marked as complete while it's processing
> > the final byte of the transfer.
> > But having to use the transaction halt interrupt to safely control
> > repeated start transfers, means handling of the fifo EMPTYING
> > interrupts is no longer necessary.
> >
> > Handling this interrupt along with Transaction Halt interrupt can
> > cause erratic behaviour.
> 
> I'd be interested to know the cause of the erratic behaviour. It feels a little
> like we're just masking a real bug somewhere.
> 

EMPTYING interrupt indicates that the transfer is in its last byte, and in old ip versions it was safe to start a new transfer at this point.
The erratic behaviour I saw was due to how the latest IP handles Master Halt. In this IP a transaction is halted after each byte of a transfer.
Having to halt the transfer after the last byte means we can no longer service the EMPTYING interrupt, doing so may cause repeated start transfers to fails.

Thanks,
Sifan
> Cheers
> James
> 
> >
> > Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-img-scb.c |    6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-img-scb.c
> > b/drivers/i2c/busses/i2c-img-scb.c
> > index efad4d7..10141a9 100644
> > --- a/drivers/i2c/busses/i2c-img-scb.c
> > +++ b/drivers/i2c/busses/i2c-img-scb.c
> > @@ -154,7 +154,6 @@
> >  #define INT_TIMING			BIT(18)
> >
> >  #define INT_FIFO_FULL_FILLING	(INT_FIFO_FULL  |
> INT_FIFO_FILLING)
> > -#define INT_FIFO_EMPTY_EMPTYING	(INT_FIFO_EMPTY |
> INT_FIFO_EMPTYING)
> >
> >  /* Level interrupts need clearing after handling instead of before */
> >  #define INT_LEVEL			0x01e00
> > @@ -176,8 +175,7 @@
> >  					 INT_WRITE_ACK_ERR    | \
> >  					 INT_FIFO_FULL        | \
> >  					 INT_FIFO_FILLING     | \
> > -					 INT_FIFO_EMPTY       | \
> > -					 INT_FIFO_EMPTYING)
> > +					 INT_FIFO_EMPTY)
> >
> >  #define INT_ENABLE_MASK_WAITSTOP	(INT_SLAVE_EVENT      | \
> >  					 INT_ADDR_ACK_ERR     | \
> > @@ -910,7 +908,7 @@ static unsigned int img_i2c_auto(struct img_i2c *i2c,
> >  			}
> >  		}
> >  	} else {
> > -		if (int_status & INT_FIFO_EMPTY_EMPTYING) {
> > +		if (int_status & INT_FIFO_EMPTY) {
> >  			if (i2c->msg.len == 0) {
> >  				if (i2c->last_msg)
> >  					return ISR_WAITSTOP;
> >
