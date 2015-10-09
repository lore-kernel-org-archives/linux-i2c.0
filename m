From: Sifan Naeem <Sifan.Naeem@imgtec.com>
Subject: RE: [PATCH v2 2/5] i2c: img-scb: remove fifo EMPTYING interrupts
 handle
Date: Fri, 9 Oct 2015 08:43:41 +0000
Message-ID: <A0E307549471DA4DBAF2DE2DE6CBFB7E4967297F@hhmail02.hh.imgtec.org>
References: <1439567447-8139-1-git-send-email-sifan.naeem@imgtec.com>
 <1439567447-8139-3-git-send-email-sifan.naeem@imgtec.com>
 <55E80AA8.9070501@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:12013 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934031AbbJIInp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 9 Oct 2015 04:43:45 -0400
In-Reply-To: <55E80AA8.9070501@imgtec.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: James Hogan <James.Hogan@imgtec.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Hi James,


> -----Original Message-----
> From: James Hogan
> Sent: 03 September 2015 09:54
> To: Sifan Naeem; Wolfram Sang; linux-i2c@vger.kernel.org; Ezequiel Garcia
> Cc: Ionela Voinescu
> Subject: Re: [PATCH v2 2/5] i2c: img-scb: remove fifo EMPTYING interrupts
> handle
> 
> On 14/08/15 16:50, Sifan Naeem wrote:
> > Now that we are using the transaction halt interrupt to safely control
> 
> Is that referring to patch 4, which comes after this one?
Yes, sorry will update the commit message.

> 
> > repeated start transfers, we no longer need to handle the fifo
> > emptying interrupts.
> >
> > Handling this interrupt along with Transaction Halt interrupt can
> > cause erratic behaviour.
> 
> You said in response to my question before:
> > EMPTYING interrupt indicates that the transfer is in its last byte,
> > and in old ip versions it was safe to start a new transfer at this
> > point.  The erratic behaviour I saw was due to how the latest IP
> > handles Master Halt. In this IP a transaction is halted after each
> > byte of a transfer.  Having to halt the transfer after the last byte
> > means we can no longer service the EMPTYING interrupt, doing so may
> > cause repeated start transfers to fails.
> 
> That doesn't look like its what the code did though. If emptying and not
> empty, it only wrote to fifo, but didn't start the next transaction.
> 
The issue might be caused by the data being written to the fifo, hence i2c->msg.len = 0, but the transfer is actually still halted. So it will need the T_halt being lifted.
And as I saw this issue intermittently, it might be a case of the order interrupts are serviced.
Where as in the old IP, after data is written it was safe to return ISR_WAITSTOP.

Thanks,
Sifan
> >
> > Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
> > ---
> >  drivers/i2c/busses/i2c-img-scb.c |   16 +++-------------
> >  1 file changed, 3 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-img-scb.c
> > b/drivers/i2c/busses/i2c-img-scb.c
> > index ad1d1df943db..75a44e794d75 100644
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
> 
> img_i2c_write_fifo also clears INT_FIFO_EMPTYING from int_enable if
> nothing left to write. That would seem redundant after this change.
> 
> Cheers
> James
> 
> >
> >  #define INT_ENABLE_MASK_WAITSTOP	(INT_SLAVE_EVENT      | \
> >  					 INT_ADDR_ACK_ERR     | \
> > @@ -882,16 +880,8 @@ static unsigned int img_i2c_auto(struct img_i2c
> *i2c,
> >  				return ISR_WAITSTOP;
> >  		}
> >  	} else {
> > -		if (int_status & INT_FIFO_EMPTY_EMPTYING) {
> > -			/*
> > -			 * The write fifo empty indicates that we're in the
> > -			 * last byte so it's safe to start a new write
> > -			 * transaction without losing any bytes from the
> > -			 * previous one.
> > -			 * see 2.3.7 Repeated Start Transactions.
> > -			 */
> > -			if ((int_status & INT_FIFO_EMPTY) &&
> > -			    i2c->msg.len == 0)
> > +		if (int_status & INT_FIFO_EMPTY) {
> > +			if (i2c->msg.len == 0)
> >  				return ISR_WAITSTOP;
> >  			img_i2c_write_fifo(i2c);
> >  		}
> >
