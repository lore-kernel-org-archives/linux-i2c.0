From: Sifan Naeem <Sifan.Naeem@imgtec.com>
Subject: RE: [PATCH 6/8] i2c: img-scb: remove start bit detected status
 after handling
Date: Wed, 29 Jul 2015 12:49:04 +0000
Message-ID: <A0E307549471DA4DBAF2DE2DE6CBFB7E4966DA5C@hhmail02.hh.imgtec.org>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com>
 <1437997641-32575-7-git-send-email-sifan.naeem@imgtec.com>
 <55B7893D.4020409@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <55B7893D.4020409@imgtec.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: James Hogan <James.Hogan@imgtec.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: "Stable kernel (v3.19+)" <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org



> -----Original Message-----
> From: James Hogan
> Sent: 28 July 2015 14:53
> To: Sifan Naeem; Wolfram Sang; linux-i2c@vger.kernel.org
> Cc: Stable kernel (v3.19+)
> Subject: Re: [PATCH 6/8] i2c: img-scb: remove start bit detected status after
> handling
> 
> On 27/07/15 12:47, Sifan Naeem wrote:
> > Remove start bit detected status after it is handled, doing so will
> > prevent this condition being hit for every interrupt on a particular
> > transfer.
> >
> > Fixes: 27bce4 ("i2c: img-scb: Add Imagination Technologies I2C SCB
> > driver")
> > Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
> > Cc: Stable kernel (v3.19+) <stable@vger.kernel.org>
> > ---
> >  drivers/i2c/busses/i2c-img-scb.c |   16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-img-scb.c
> > b/drivers/i2c/busses/i2c-img-scb.c
> > index 653f9bd..341130e 100644
> > --- a/drivers/i2c/busses/i2c-img-scb.c
> > +++ b/drivers/i2c/busses/i2c-img-scb.c
> > @@ -871,10 +871,18 @@ static unsigned int img_i2c_auto(struct img_i2c
> *i2c,
> >  	}
> >
> >  	/* Enable transaction halt on start bit */
> > -	if (!i2c->last_msg && i2c->line_status & LINESTAT_START_BIT_DET) {
> 
> i2c->line_status accumulates the line status bits that have been seen
> with each interrupt. If we're only interested in that bit from the current
> interrupt, should it just be referring to line_status (the argument to
> img_i2c_auto) instead of i2c->line_status?
> 
Yes, I can't think of why we cannot use line_status from the argument.

Thanks,
Sifan

> Cheers
> James
> 
> > -		img_i2c_transaction_halt(i2c, true);
> > -		/* we're no longer interested in the slave event */
> > -		i2c->int_enable &= ~INT_SLAVE_EVENT;
> > +	if (i2c->line_status & LINESTAT_START_BIT_DET) {
> > +		if (!i2c->last_msg) {
> > +			img_i2c_transaction_halt(i2c, true);
> > +			/* we're no longer interested in the slave event */
> > +			i2c->int_enable &= ~INT_SLAVE_EVENT;
> > +		}
> > +		/*
> > +		 * Remove start bit detected status after it is handled,
> > +		 * doing so will prevent this condition being hit for
> > +		 * every interrupt on a particular transfer.
> > +		 */
> > +		i2c->line_status &= ~LINESTAT_START_BIT_DET;
> >  	}
> >
> >  	mod_timer(&i2c->check_timer, jiffies + msecs_to_jiffies(1));
> >
