From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] i2c: bcm2835: Clear current message and count after a
 transaction
Date: Fri, 28 Dec 2018 16:06:05 +0100 (CET)
Message-ID: <513165257.381448.1546009565830@email.ionos.de>
References: <20181221121135.4847-1-paul.kocialkowski@bootlin.com>
 <1941132339.131316.1545481176339@email.ionos.de>
 <baa17fb765bf8b40fe6e91b4884b83af6fcf7641.camel@bootlin.com>
 <1232214204.268730.1545919526431@email.ionos.de>
 <87y38abzu7.fsf@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87y38abzu7.fsf@anholt.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Anholt <eric@anholt.net>, Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


> Eric Anholt <eric@anholt.net> hat am 27. Dezember 2018 um 19:15 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > Hi Paul,
> >
> >> Paul Kocialkowski <paul.kocialkowski@bootlin.com> hat am 24. Dezember 2018 um 10:10 geschrieben:
> >> 
> >> 
> >> Hi,
> >> 
> >> On Sat, 2018-12-22 at 13:19 +0100, Stefan Wahren wrote:
> >> > Hi Paul,
> >> > 
> >> > > Paul Kocialkowski <paul.kocialkowski@bootlin.com> hat am 21. Dezember 2018 um 13:11 geschrieben:
> >> > > 
> >> > > 
> >> > > The driver's interrupt handler checks whether a message is currently
> >> > > being handled with the curr_msg pointer. When it is NULL, the interrupt
> >> > > is considered to be unexpected. Similarly, the i2c_start_transfer
> >> > > routine checks for the remaining number of messages to handle in
> >> > > num_msgs.
> >> > > 
> >> > > However, these values are never cleared and always keep the message and
> >> > > number relevant to the latest transfer (which might be done already and
> >> > > the underlying message memory might have been freed).
> >> > > 
> >> > > When an unexpected interrupt hits with the DONE bit set, the isr will
> >> > > then try to access the flags field of the curr_msg structure, leading
> >> > > to a fatal page fault.
> >> > > 
> >> > > Fix the issue by systematically clearing curr_msg and num_msgs in the
> >> > > driver-wide device structure when a transfer is considered complete.
> >> > > 
> >> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> >> > > ---
> >> > >  drivers/i2c/busses/i2c-bcm2835.c | 3 +++
> >> > >  1 file changed, 3 insertions(+)
> >> > > 
> >> > > diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> >> > > index 44deae78913e..5486252f5f2f 100644
> >> > > --- a/drivers/i2c/busses/i2c-bcm2835.c
> >> > > +++ b/drivers/i2c/busses/i2c-bcm2835.c
> >> > > @@ -298,6 +298,9 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
> >> > >  		return -ETIMEDOUT;
> >> > >  	}
> >> > >  
> >> > > +	i2c_dev->curr_msg = NULL;
> >> > > +	i2c_dev->num_msgs = 0;
> >> > 
> >> > AFAIU this would reduce the chance of a use-after-free dramatically but not completely.
> >> 
> >> Do you have a specific case of use-after-free related to these
> >> variables in mind that this cleanup would not fix (except for the
> >> timeout case)?
> >
> > okay i was wrong about the use-after-free. But i'm not sure about this scenario on the I2C bus shared with the VC4:
> >
> > 1. ARM core starts I2C transfer (bcm2835_i2c_start_transfer)
> > 2. VC4 triggers a BCM2835_I2C_S_DONE interrupt
> > 3. ARM core catches this interrupt before the VC4
> 
> We don't share I2C buses with VC4, though, right?  That would just be
> totally broken.

All i remember is this comment on Github:
https://github.com/anholt/linux/issues/89#issuecomment-280111496

and currently all 3 I2C busses are enabled for the ARM core in bcm2835-rpi.dtsi.

Stefan
