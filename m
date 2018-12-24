From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH] i2c: bcm2835: Clear current message and count after a
 transaction
Date: Mon, 24 Dec 2018 09:54:48 +0100
Message-ID: <eaad72f27b69259c9d460f031a2c7c392f19a969.camel@bootlin.com>
References: <20181221121135.4847-1-paul.kocialkowski@bootlin.com>
         <4892f080-dff5-8d08-c78f-3c8b85f5a454@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4892f080-dff5-8d08-c78f-3c8b85f5a454@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Fri, 2018-12-21 at 09:52 -0800, Florian Fainelli wrote:
> On 12/21/18 4:11 AM, Paul Kocialkowski wrote:
> > The driver's interrupt handler checks whether a message is currently
> > being handled with the curr_msg pointer. When it is NULL, the interrupt
> > is considered to be unexpected. Similarly, the i2c_start_transfer
> > routine checks for the remaining number of messages to handle in
> > num_msgs.
> > 
> > However, these values are never cleared and always keep the message and
> > number relevant to the latest transfer (which might be done already and
> > the underlying message memory might have been freed).
> > 
> > When an unexpected interrupt hits with the DONE bit set, the isr will
> > then try to access the flags field of the curr_msg structure, leading
> > to a fatal page fault.
> > 
> > Fix the issue by systematically clearing curr_msg and num_msgs in the
> > driver-wide device structure when a transfer is considered complete.
> 
> Should not this get a Fixes tag?

Yes it totally should! Thanks for the suggestion.

Cheers,

Paul

> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/i2c/busses/i2c-bcm2835.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> > index 44deae78913e..5486252f5f2f 100644
> > --- a/drivers/i2c/busses/i2c-bcm2835.c
> > +++ b/drivers/i2c/busses/i2c-bcm2835.c
> > @@ -298,6 +298,9 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
> >  		return -ETIMEDOUT;
> >  	}
> >  
> > +	i2c_dev->curr_msg = NULL;
> > +	i2c_dev->num_msgs = 0;
> > +
> >  	if (!i2c_dev->msg_err)
> >  		return num;
> >  
> > 
> 
> 
-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
