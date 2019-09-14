From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] i2c: at91: Send bus clear command if SCL or SDA is down
Date: Sat, 14 Sep 2019 21:05:28 +0200
Message-ID: <20190914190528.wnxhcjo5s66qive6@sekiro>
References: <20190911095854.5141-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190911095854.5141-1-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, wsa@the-dreams.de
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 11, 2019 at 12:58:54PM +0300, Codrin Ciubotariu wrote:
> After a transfer timeout, some faulty I2C slave devices might hold down
> the SCL or the SDA pins. We can generate a bus clear command, hoping that
> the slave might release the pins.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

I'll be off for three weeks so if there are minor changes, you can keep my
ack.

Thanks

Ludovic

> ---
>  drivers/i2c/busses/i2c-at91-master.c | 20 ++++++++++++++++++++
>  drivers/i2c/busses/i2c-at91.h        |  6 +++++-
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91-master.c b/drivers/i2c/busses/i2c-at91-master.c
> index a3fcc35ffd3b..5f544a16db96 100644
> --- a/drivers/i2c/busses/i2c-at91-master.c
> +++ b/drivers/i2c/busses/i2c-at91-master.c
> @@ -599,6 +599,26 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
>  		at91_twi_write(dev, AT91_TWI_CR,
>  			       AT91_TWI_THRCLR | AT91_TWI_LOCKCLR);
>  	}
> +
> +	/*
> +	 * After timeout, some faulty I2C slave devices might hold SCL/SDA down;
> +	 * we can send a bus clear command, hoping that the pins will be
> +	 * released
> +	 */
> +	if (!(dev->transfer_status & AT91_TWI_SDA) ||
> +	    !(dev->transfer_status & AT91_TWI_SCL)) {
> +		dev_dbg(dev->dev,
> +			"SDA/SCL are down; sending bus clear command\n");
> +		if (dev->use_alt_cmd) {
> +			unsigned int acr;
> +
> +			acr = at91_twi_read(dev, AT91_TWI_ACR);
> +			acr &= ~AT91_TWI_ACR_DATAL_MASK;
> +			at91_twi_write(dev, AT91_TWI_ACR, acr);
> +		}
> +		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_CLEAR);
> +	}
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/i2c/busses/i2c-at91.h b/drivers/i2c/busses/i2c-at91.h
> index 499b506f6128..ffb870f3ffc6 100644
> --- a/drivers/i2c/busses/i2c-at91.h
> +++ b/drivers/i2c/busses/i2c-at91.h
> @@ -36,6 +36,7 @@
>  #define	AT91_TWI_SVDIS		BIT(5)	/* Slave Transfer Disable */
>  #define	AT91_TWI_QUICK		BIT(6)	/* SMBus quick command */
>  #define	AT91_TWI_SWRST		BIT(7)	/* Software Reset */
> +#define	AT91_TWI_CLEAR		BIT(15) /* Bus clear command */
>  #define	AT91_TWI_ACMEN		BIT(16) /* Alternative Command Mode Enable */
>  #define	AT91_TWI_ACMDIS		BIT(17) /* Alternative Command Mode Disable */
>  #define	AT91_TWI_THRCLR		BIT(24) /* Transmit Holding Register Clear */
> @@ -69,6 +70,8 @@
>  #define	AT91_TWI_NACK		BIT(8)	/* Not Acknowledged */
>  #define	AT91_TWI_EOSACC		BIT(11)	/* End Of Slave Access */
>  #define	AT91_TWI_LOCK		BIT(23) /* TWI Lock due to Frame Errors */
> +#define	AT91_TWI_SCL		BIT(24) /* TWI SCL status */
> +#define	AT91_TWI_SDA		BIT(25) /* TWI SDA status */
>  
>  #define	AT91_TWI_INT_MASK \
>  	(AT91_TWI_TXCOMP | AT91_TWI_RXRDY | AT91_TWI_TXRDY | AT91_TWI_NACK \
> @@ -81,7 +84,8 @@
>  #define	AT91_TWI_THR		0x0034	/* Transmit Holding Register */
>  
>  #define	AT91_TWI_ACR		0x0040	/* Alternative Command Register */
> -#define	AT91_TWI_ACR_DATAL(len)	((len) & 0xff)
> +#define	AT91_TWI_ACR_DATAL_MASK	GENMASK(15, 0)
> +#define	AT91_TWI_ACR_DATAL(len)	((len) & AT91_TWI_ACR_DATAL_MASK)
>  #define	AT91_TWI_ACR_DIR	BIT(8)
>  
>  #define	AT91_TWI_FMR		0x0050	/* FIFO Mode Register */
> -- 
> 2.20.1
> 
