From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] i2c: at91: handle TXRDY interrupt spam
Date: Tue, 14 May 2019 10:42:54 +0200
Message-ID: <20190514084254.zc526whem6yxfu7l@M43218.corp.atmel.com>
References: <1556005008-6318-1-git-send-email-raagjadav@gmail.com>
 <20190429090005.f6ydghzu5n5yruav@M43218.corp.atmel.com>
 <20190429223332.GA3908@pc>
 <20190502140116.rim72idpgvq4h4vc@M43218.corp.atmel.com>
 <20190503235851.GA4242@pc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190503235851.GA4242@pc>
Sender: linux-kernel-owner@vger.kernel.org
To: Raag Jadav <raagjadav@gmail.com>
Cc: linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Sat, May 04, 2019 at 05:28:51AM +0530, Raag Jadav wrote:
> On Thu, May 02, 2019 at 04:01:16PM +0200, Ludovic Desroches wrote:
> > On Tue, Apr 30, 2019 at 04:03:32AM +0530, Raag Jadav wrote:
> > > External E-Mail
> > > 
> > > 
> > > On Mon, Apr 29, 2019 at 11:00:05AM +0200, Ludovic Desroches wrote:
> > > > Hello Raag,
> > > > 
> > > > On Tue, Apr 23, 2019 at 01:06:48PM +0530, Raag Jadav wrote:
> > > > > External E-Mail
> > > > > 
> > > > > 
> > > > > Performing i2c write operation while SDA or SCL line is held
> > > > > or grounded by slave device, we go into infinite at91_twi_write_next_byte
> > > > > loop with TXRDY interrupt spam.
> > > > 
> > > > Sorry but I am not sure to have the full picture, the controller is in
> > > > slave or master mode?
> > > > 
> > > > SVREAD is only used in slave mode. When SVREAD is set, it means that a read
> > > > access is performed and your issue concerns the write operation.
> > > > 
> > > > Regards
> > > > 
> > > > Ludovic
> > > 
> > > Yes, even though the datasheet suggests that SVREAD is irrelevant in master mode,
> > > TXRDY and SVREAD are the only ones being set in status register upon reproducing the issue.
> > > Couldn't think of a better way to handle such strange behaviour.
> > > Any suggestions would be appreciated.
> > 
> > I have the confirmation that you can't rely on the SVREAD flag when in
> > master mode. This flag should always have the same value.
> > 
> > I am trying to understand what could lead to your situation. Can you
> > give me more details. What kind of device it is? What does lead to this
> > situation? Does it happen randomly or not?
> 
> One of the sama5d2 based board I worked on, was having trouble complete its boot
> because of a faulty i2c device, which was randomly holding down the SDA line
> on i2c write operation, not allowing the controller to complete its transmission,
> causing a massive TXRDY interrupt spam, ultimately hanging the processor.
> 
> Another strange observation was that SVREAD was being set in the status register
> along with TXRDY, every time I reproduced the issue.
> You can reproduce it by simply grounding the SDA line and performing i2c write
> on the bus.

Thanks for the details, I'll discussed it with hw guys but expect some
dealy as I'll be off next 2 weeks.

Regards

Ludovic

> 
> Note that NACK, LOCK or TXCOMP are never set as the transmission never completes.
> I'm not sure why slave bits are being set in master mode,
> but it's been working reliably for me.
> 
> This patch doesn't recover the SDA line. It just prevents the processor from
> getting hanged in case of i2c bus lockup.
> 
> Cheers,
> Raag
> 
> > 
> > Regards
> > 
> > Ludovic
> > 
> > > 
> > > Cheers,
> > > Raag
> > > 
> > > > 
> > > > > 
> > > > > Signed-off-by: Raag Jadav <raagjadav@gmail.com>
> > > > > ---
> > > > >  drivers/i2c/busses/i2c-at91.c | 6 +++++-
> > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> > > > > index 3f3e8b3..b2f5fdb 100644
> > > > > --- a/drivers/i2c/busses/i2c-at91.c
> > > > > +++ b/drivers/i2c/busses/i2c-at91.c
> > > > > @@ -72,6 +72,7 @@
> > > > >  #define	AT91_TWI_TXCOMP		BIT(0)	/* Transmission Complete */
> > > > >  #define	AT91_TWI_RXRDY		BIT(1)	/* Receive Holding Register Ready */
> > > > >  #define	AT91_TWI_TXRDY		BIT(2)	/* Transmit Holding Register Ready */
> > > > > +#define	AT91_TWI_SVREAD		BIT(3)	/* Slave Read */
> > > > >  #define	AT91_TWI_OVRE		BIT(6)	/* Overrun Error */
> > > > >  #define	AT91_TWI_UNRE		BIT(7)	/* Underrun Error */
> > > > >  #define	AT91_TWI_NACK		BIT(8)	/* Not Acknowledged */
> > > > > @@ -571,7 +572,10 @@ static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
> > > > >  		at91_disable_twi_interrupts(dev);
> > > > >  		complete(&dev->cmd_complete);
> > > > >  	} else if (irqstatus & AT91_TWI_TXRDY) {
> > > > > -		at91_twi_write_next_byte(dev);
> > > > > +		if ((status & AT91_TWI_SVREAD) && (dev->buf_len == 0))
> > > > > +			at91_twi_write(dev, AT91_TWI_IDR, AT91_TWI_TXRDY);
> > > > > +		else
> > > > > +			at91_twi_write_next_byte(dev);
> > > > >  	}
> > > > >  
> > > > >  	/* catch error flags */
> > > > > -- 
> > > > > 2.7.4
> > > > > 
> > > > > 
> > > 
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > > 
