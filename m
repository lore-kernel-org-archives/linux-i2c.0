From: Sifan Naeem <Sifan.Naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 6/7] i2c: img-scb: add handle for stop detected interrupt
Date: Wed, 29 Jul 2015 17:06:24 +0000
Message-ID: <A0E307549471DA4DBAF2DE2DE6CBFB7E4966DE38@hhmail02.hh.imgtec.org>
References: <1437998162-32724-1-git-send-email-sifan.naeem@imgtec.com>
 <1437998162-32724-7-git-send-email-sifan.naeem@imgtec.com>
 <55B8F271.6060003@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55B8F271.6060003-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: James Hogan <James.Hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi James,

> -----Original Message-----
> From: James Hogan
> Sent: 29 July 2015 16:34
> To: Sifan Naeem; Wolfram Sang; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH 6/7] i2c: img-scb: add handle for stop detected interrupt
> 
> On 27/07/15 12:56, Sifan Naeem wrote:
> > Stop Detected interrupt is triggered when a Stop bit is detected on
> > the bus, which indicates the end of the current transfer.
> >
> > When the end of a transfer is indicated by the Stop bit interrupt,
> > drain the FIFO and signal completion for the transaction. But if the
> > interrupt was triggered before all data is written to the fifo or with
> > more data expected return error with transfer complete signal.
> >
> > Halting the bus is no longer necessary after a stop bit is detected on
> > the bus, as there cannot be a repeated start transfer when the stop
> > bit has been issued, hence remove the transaction halt bit.
> >
> > Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-img-scb.c |   28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-img-scb.c
> > b/drivers/i2c/busses/i2c-img-scb.c
> > index 10141a9..90faf48 100644
> > --- a/drivers/i2c/busses/i2c-img-scb.c
> > +++ b/drivers/i2c/busses/i2c-img-scb.c
> > @@ -152,6 +152,7 @@
> >  #define INT_TRANSACTION_DONE		BIT(15)
> >  #define INT_SLAVE_EVENT			BIT(16)
> >  #define INT_TIMING			BIT(18)
> > +#define INT_STOP_DETECTED		BIT(19)
> >
> >  #define INT_FIFO_FULL_FILLING	(INT_FIFO_FULL  |
> INT_FIFO_FILLING)
> >
> > @@ -175,7 +176,8 @@
> >  					 INT_WRITE_ACK_ERR    | \
> >  					 INT_FIFO_FULL        | \
> >  					 INT_FIFO_FILLING     | \
> > -					 INT_FIFO_EMPTY)
> > +					 INT_FIFO_EMPTY       | \
> > +					 INT_STOP_DETECTED)
> >
> >  #define INT_ENABLE_MASK_WAITSTOP	(INT_SLAVE_EVENT      | \
> >  					 INT_ADDR_ACK_ERR     | \
> > @@ -907,6 +909,18 @@ static unsigned int img_i2c_auto(struct img_i2c
> *i2c,
> >  				return ISR_COMPLETE(0);
> >  			}
> >  		}
> > +		if (int_status & INT_STOP_DETECTED) {
> > +			int ret;
> > +			/*
> > +			 * Stop bit indicates the end of the transfer, it means
> > +			 * we should read all the data (or drain the FIFO). We
> > +			 * must signal completion for this transaction.
> > +			 */
> > +			img_i2c_transaction_halt(i2c, false);
> 
> to get a stop bit detected, wouldn't transaction halt already have to be off?

Yes, but in case we were too slow re-enabling the master halt and a stop was detected simultaneously to when master halt was set.
> 
> > +			img_i2c_read_fifo(i2c);
> > +			ret = (i2c->msg.len == 0) ? 0 : EIO;
> 
> If it wasn't fully transferred, wouldn't that already imply an
> INT_WRITE_ACK_ERR or INT_ADDR_ACK_ERR, which should've already been
> handled?
> 
This was added as a safety check, yes I guess it's impossible to get a stop bit before all data is transferred without an error condition.
>
> Could it then be as simple as this? (untested):
> 
Yes, this would do.

Thanks,
Sifan
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-
> scb.c
> index 00ffd6613680..f694b47dcf74 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -867,6 +867,13 @@ static unsigned int img_i2c_auto(struct img_i2c *i2c,
> 
>  	mod_timer(&i2c->check_timer, jiffies + msecs_to_jiffies(1));
> 
> +	if (int_status & INT_STOP_DETECTED) {
> +		/* Drain remaining data in FIFO and complete transaction */
> +		if (i2c->msg.flags & I2C_M_RD)
> +			img_i2c_read_fifo(i2c);
> +		return ISR_COMPLETE(0);
> +	}
> +
>  	if (i2c->msg.flags & I2C_M_RD) {
>  		if (int_status & INT_FIFO_FULL_FILLING) {
>  			img_i2c_read_fifo(i2c);
> 
> Cheers
> James
> 
> > +			return ISR_COMPLETE(ret);
> > +		}
> >  	} else {
> >  		if (int_status & INT_FIFO_EMPTY) {
> >  			if (i2c->msg.len == 0) {
> > @@ -916,6 +930,18 @@ static unsigned int img_i2c_auto(struct img_i2c
> *i2c,
> >  			}
> >  			img_i2c_write_fifo(i2c);
> >  		}
> > +		if (int_status & INT_STOP_DETECTED) {
> > +			int ret;
> > +
> > +			img_i2c_transaction_halt(i2c, false);
> > +			/*
> > +			 * Stop bit indicates the end of a transfer and if the
> > +			 * transfer has ended before all data is written to the
> > +			 * fifo, return an error with transfer complete signal.
> > +			 */
> > +			ret = (i2c->msg.len == 0) ? 0 : EIO;
> > +			return ISR_COMPLETE(ret);
> > +		}
> >  	}
> >
> >  	return 0;
> >
