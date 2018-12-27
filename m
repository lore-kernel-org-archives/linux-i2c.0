From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH] i2c: bcm2835: Clear current message and count after a
 transaction
Date: Thu, 27 Dec 2018 16:10:18 +0100
Message-ID: <3c5dd6c834406ffc1e674af7839eea09fea748ee.camel@bootlin.com>
References: <20181221121135.4847-1-paul.kocialkowski@bootlin.com>
         <1941132339.131316.1545481176339@email.ionos.de>
         <baa17fb765bf8b40fe6e91b4884b83af6fcf7641.camel@bootlin.com>
         <1232214204.268730.1545919526431@email.ionos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1232214204.268730.1545919526431@email.ionos.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Eric Anholt <eric@anholt.net>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Stefan,

On Thu, 2018-12-27 at 15:05 +0100, Stefan Wahren wrote:
> Hi Paul,
> 
> > Paul Kocialkowski <paul.kocialkowski@bootlin.com> hat am 24. Dezember 2018 um 10:10 geschrieben:
> > 
> > 
> > Hi,
> > 
> > On Sat, 2018-12-22 at 13:19 +0100, Stefan Wahren wrote:
> > > Hi Paul,
> > > 
> > > > Paul Kocialkowski <paul.kocialkowski@bootlin.com> hat am 21. Dezember 2018 um 13:11 geschrieben:
> > > > 
> > > > 
> > > > The driver's interrupt handler checks whether a message is currently
> > > > being handled with the curr_msg pointer. When it is NULL, the interrupt
> > > > is considered to be unexpected. Similarly, the i2c_start_transfer
> > > > routine checks for the remaining number of messages to handle in
> > > > num_msgs.
> > > > 
> > > > However, these values are never cleared and always keep the message and
> > > > number relevant to the latest transfer (which might be done already and
> > > > the underlying message memory might have been freed).
> > > > 
> > > > When an unexpected interrupt hits with the DONE bit set, the isr will
> > > > then try to access the flags field of the curr_msg structure, leading
> > > > to a fatal page fault.
> > > > 
> > > > Fix the issue by systematically clearing curr_msg and num_msgs in the
> > > > driver-wide device structure when a transfer is considered complete.
> > > > 
> > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > ---
> > > >  drivers/i2c/busses/i2c-bcm2835.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> > > > index 44deae78913e..5486252f5f2f 100644
> > > > --- a/drivers/i2c/busses/i2c-bcm2835.c
> > > > +++ b/drivers/i2c/busses/i2c-bcm2835.c
> > > > @@ -298,6 +298,9 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
> > > >  		return -ETIMEDOUT;
> > > >  	}
> > > >  
> > > > +	i2c_dev->curr_msg = NULL;
> > > > +	i2c_dev->num_msgs = 0;
> > > 
> > > AFAIU this would reduce the chance of a use-after-free dramatically but not completely.
> > 
> > Do you have a specific case of use-after-free related to these
> > variables in mind that this cleanup would not fix (except for the
> > timeout case)?
> 
> okay i was wrong about the use-after-free. But i'm not sure about this scenario on the I2C bus shared with the VC4:
> 
> 1. ARM core starts I2C transfer (bcm2835_i2c_start_transfer)
> 2. VC4 triggers a BCM2835_I2C_S_DONE interrupt
> 3. ARM core catches this interrupt before the VC4

Well, I thought the VC4 has precedence over the ARM core, so if the
interrupts hits in hardware, it should be seen by the VC4 first and
forwarded to the ARM core if needed (I might be wrong though). So in
that case, perhaps the ARM core wouldn't see the interrupt and just
timeout?

Either way, I'm don't think that having both the VC4 and the ARM core
poke on the same bus is a scenario we can realisticly aim to support.
Although it should definitely not make our driver crash if that
happens.

The HDMI DDC bus is an I2C bus shared between the ARM core and VC4, but
the VC4 firmware should detect from the device-tree that Linux will
attempt to drive the bus and let the ARM core deal with it without
interference.

Thanks for your feedback!

Cheers,

Paul

> > The msg_buf element (in association with msg_buf_remaining keeping its
> > previous value) could also lead to similar problems, so I'm thinking of
> > making a bcm2835_i2c_finish_transfer function to group all the cleanups
> > and call that right after wait_for_completion_timeout.
> > 
> > > Btw: Why did you leave of the i2c transfer timeout case?
> > 
> > I should definitely have included it, actually.
> > 
> > Cheers,
> > 
> > Paul
> > 
> > > Thanks
> > > Stefan
> > > 
> > > > +
> > > >  	if (!i2c_dev->msg_err)
> > > >  		return num;
> > > >  
> > > > -- 
> > > > 2.20.1
> > > > 
> > -- 
> > Paul Kocialkowski, Bootlin (formerly Free Electrons)
> > Embedded Linux and kernel engineering
> > https://bootlin.com
> > 
-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
