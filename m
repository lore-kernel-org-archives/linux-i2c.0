From: Raag Jadav <raagjadav@gmail.com>
Subject: Re: [PATCH] i2c: at91: handle TXRDY interrupt spam
Date: Tue, 30 Apr 2019 04:03:32 +0530
Message-ID: <20190429223332.GA3908@pc>
References: <1556005008-6318-1-git-send-email-raagjadav@gmail.com>
 <20190429090005.f6ydghzu5n5yruav@M43218.corp.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190429090005.f6ydghzu5n5yruav@M43218.corp.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-i2c@vger.kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Apr 29, 2019 at 11:00:05AM +0200, Ludovic Desroches wrote:
> Hello Raag,
> 
> On Tue, Apr 23, 2019 at 01:06:48PM +0530, Raag Jadav wrote:
> > External E-Mail
> > 
> > 
> > Performing i2c write operation while SDA or SCL line is held
> > or grounded by slave device, we go into infinite at91_twi_write_next_byte
> > loop with TXRDY interrupt spam.
> 
> Sorry but I am not sure to have the full picture, the controller is in
> slave or master mode?
> 
> SVREAD is only used in slave mode. When SVREAD is set, it means that a read
> access is performed and your issue concerns the write operation.
> 
> Regards
> 
> Ludovic

Yes, even though the datasheet suggests that SVREAD is irrelevant in master mode,
TXRDY and SVREAD are the only ones being set in status register upon reproducing the issue.
Couldn't think of a better way to handle such strange behaviour.
Any suggestions would be appreciated.

Cheers,
Raag

> 
> > 
> > Signed-off-by: Raag Jadav <raagjadav@gmail.com>
> > ---
> >  drivers/i2c/busses/i2c-at91.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> > index 3f3e8b3..b2f5fdb 100644
> > --- a/drivers/i2c/busses/i2c-at91.c
> > +++ b/drivers/i2c/busses/i2c-at91.c
> > @@ -72,6 +72,7 @@
> >  #define	AT91_TWI_TXCOMP		BIT(0)	/* Transmission Complete */
> >  #define	AT91_TWI_RXRDY		BIT(1)	/* Receive Holding Register Ready */
> >  #define	AT91_TWI_TXRDY		BIT(2)	/* Transmit Holding Register Ready */
> > +#define	AT91_TWI_SVREAD		BIT(3)	/* Slave Read */
> >  #define	AT91_TWI_OVRE		BIT(6)	/* Overrun Error */
> >  #define	AT91_TWI_UNRE		BIT(7)	/* Underrun Error */
> >  #define	AT91_TWI_NACK		BIT(8)	/* Not Acknowledged */
> > @@ -571,7 +572,10 @@ static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
> >  		at91_disable_twi_interrupts(dev);
> >  		complete(&dev->cmd_complete);
> >  	} else if (irqstatus & AT91_TWI_TXRDY) {
> > -		at91_twi_write_next_byte(dev);
> > +		if ((status & AT91_TWI_SVREAD) && (dev->buf_len == 0))
> > +			at91_twi_write(dev, AT91_TWI_IDR, AT91_TWI_TXRDY);
> > +		else
> > +			at91_twi_write_next_byte(dev);
> >  	}
> >  
> >  	/* catch error flags */
> > -- 
> > 2.7.4
> > 
> > 
