From: "Voss, Nikolaus" <N.Voss@weinmann.de>
Subject: RE: [PATCH] i2c-at91: fix data-loss issue
Date: Mon, 16 Apr 2012 09:30:02 +0200
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D0905D5A1AA@wm021.weinmann.com>
References: <20120413103937.GH7154@arwen.pp.htv.fi>
 <1334317476-10044-1-git-send-email-h.feurstein@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1334317476-10044-1-git-send-email-h.feurstein@gmail.com>
Content-Language: de-DE
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Hubert Feurstein' <h.feurstein@gmail.com>
Cc: "'rmallon@gmail.com'" <rmallon@gmail.com>, "'nicolas.ferre@atmel.com'" <nicolas.ferre@atmel.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'balbi@ti.com'" <balbi@ti.com>, "'linux-i2c@vger.kernel.org'" <linux-i2c@vger.kernel.org>, "'ben-linux@fluff.org'" <ben-linux@fluff.org>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

Hubert Feurstein wrote on 2012-04-13:
> In the interrupt handler both status-flags (TXCOMP and RXRDY) might be
> pending at the same time. In this case TXCOMP is handled but NOT RXRDY
> which causes a data-loss on the current transfer

Right, this is definitely a bug and must be corrected. Part of my
motivation for exclusively or-ing the irq bits was not reading/
writing beyond the buffer because of (still) pending bits despite
of an already finished transfer, so I gave TXCOMP the highest prio.

Because of other reasons, write_next_byte() already checks this and
does nothing if all data already has been written. My suggestion is
to have read_next_byte() do this check too, as I don't trust the
hardware to reset RXRDY _immediately_ after reading.

> @@ -161,18 +161,22 @@ static irqreturn_t atmel_twi_interrupt(int irq, void
> *dev_id)
>  {
>  	struct at91_twi_dev *dev = dev_id;
>  	const unsigned status = at91_twi_read(dev, AT91_TWI_SR);
> -	const unsigned irqstatus = status & at91_twi_read(dev, AT91_TWI_IMR);
> +	unsigned irqstatus = status & at91_twi_read(dev, AT91_TWI_IMR);
> +
> +	irqstatus &= (AT91_TWI_RXRDY | AT91_TWI_TXRDY | AT91_TWI_TXCOMP);

The above line should be unnecessary as no more than those interrupts
are enabled anyway. Any special reason for this?
 
> +	if (!irqstatus)
> +		return IRQ_NONE;
> +
> +	if (irqstatus & AT91_TWI_RXRDY)
> +		at91_twi_read_next_byte(dev);
> +
> +	if (irqstatus & AT91_TWI_TXRDY)
> +		at91_twi_write_next_byte(dev);

I would like to exclusively or TXRDY and RXRDY as those really should
not be active at the same time. Keeps the decision tree lean ;-).

> @@ -189,6 +193,10 @@ static int
>  at91_do_twi_transfer(struct at91_twi_dev *dev) 	if (dev->msg->flags &
>  I2C_M_RD) { 		unsigned start_flags = AT91_TWI_START;
> +		/* clear any pending data */
> +		(void)at91_twi_read(dev, AT91_TWI_SR);
> +		(void)at91_twi_read(dev, AT91_TWI_RHR);

I would like to modify this, as this is a partial fix for the above bug
which should already be fully fixed by the modified isr.
I fear subtle data-loss if we make (partial) tabula rasa before each
transfer. I'd rather add an assertion to check if the corresponding
irqs are active as an indication for a driver/hw-bug.

I'll repost the driver with your fix on positive feedback from you.
Thanks for tracking this down.

Ben, is there any chance to get this driver into next?

Niko
