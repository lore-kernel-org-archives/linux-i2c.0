From: Hubert Feurstein <h.feurstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-at91: fix data-loss issue
Date: Mon, 16 Apr 2012 11:27:29 +0200
Message-ID: <CAFfN3gV0Cd2rrZ7OpGk51MPi71S2u7ZxWt4VLeirY+zz11yESA@mail.gmail.com>
References: <20120413103937.GH7154@arwen.pp.htv.fi>
	<1334317476-10044-1-git-send-email-h.feurstein@gmail.com>
	<EF2E73589CA71846A15D0B2CDF79505D0905D5A1AA@wm021.weinmann.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <EF2E73589CA71846A15D0B2CDF79505D0905D5A1AA-qhZVaJ2D3XF9OWT4OSQXE9BPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Voss, Nikolaus" <N.Voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org" <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, "rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Am 16. April 2012 09:30 schrieb Voss, Nikolaus <N.Voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>:
> Hubert Feurstein wrote on 2012-04-13:
>> In the interrupt handler both status-flags (TXCOMP and RXRDY) might =
be
>> pending at the same time. In this case TXCOMP is handled but NOT RXR=
DY
>> which causes a data-loss on the current transfer
>
> Right, this is definitely a bug and must be corrected. Part of my
> motivation for exclusively or-ing the irq bits was not reading/
> writing beyond the buffer because of (still) pending bits despite
> of an already finished transfer, so I gave TXCOMP the highest prio.
>
> Because of other reasons, write_next_byte() already checks this and
> does nothing if all data already has been written. My suggestion is
> to have read_next_byte() do this check too, as I don't trust the
> hardware to reset RXRDY _immediately_ after reading.
Adding a check in read_next_byte() would be good just for safety.

>
>> @@ -161,18 +161,22 @@ static irqreturn_t atmel_twi_interrupt(int irq=
, void
>> *dev_id)
>> =A0{
>> =A0 =A0 =A0 struct at91_twi_dev *dev =3D dev_id;
>> =A0 =A0 =A0 const unsigned status =3D at91_twi_read(dev, AT91_TWI_SR=
);
>> - =A0 =A0 const unsigned irqstatus =3D status & at91_twi_read(dev, A=
T91_TWI_IMR);
>> + =A0 =A0 unsigned irqstatus =3D status & at91_twi_read(dev, AT91_TW=
I_IMR);
>> +
>> + =A0 =A0 irqstatus &=3D (AT91_TWI_RXRDY | AT91_TWI_TXRDY | AT91_TWI=
_TXCOMP);
>
> The above line should be unnecessary as no more than those interrupts
> are enabled anyway. Any special reason for this?
No special reason for this.

>
>> + =A0 =A0 if (!irqstatus)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_NONE;
>> +
>> + =A0 =A0 if (irqstatus & AT91_TWI_RXRDY)
>> + =A0 =A0 =A0 =A0 =A0 =A0 at91_twi_read_next_byte(dev);
>> +
>> + =A0 =A0 if (irqstatus & AT91_TWI_TXRDY)
>> + =A0 =A0 =A0 =A0 =A0 =A0 at91_twi_write_next_byte(dev);
>
> I would like to exclusively or TXRDY and RXRDY as those really should
> not be active at the same time. Keeps the decision tree lean ;-).
I agree, it should be save to xor at least those two.

>
>> @@ -189,6 +193,10 @@ static int
>> =A0at91_do_twi_transfer(struct at91_twi_dev *dev) =A0 =A0 =A0 if (de=
v->msg->flags &
>> =A0I2C_M_RD) { =A0 =A0 =A0 =A0 =A0unsigned start_flags =3D AT91_TWI_=
START;
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* clear any pending data */
>> + =A0 =A0 =A0 =A0 =A0 =A0 (void)at91_twi_read(dev, AT91_TWI_SR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 (void)at91_twi_read(dev, AT91_TWI_RHR);
>
> I would like to modify this, as this is a partial fix for the above b=
ug
> which should already be fully fixed by the modified isr.
> I fear subtle data-loss if we make (partial) tabula rasa before each
> transfer. I'd rather add an assertion to check if the corresponding
> irqs are active as an indication for a driver/hw-bug.
You also can add both, print an error/warning if the state in SR is
not as expected and then add the two recovery lines.

>
> I'll repost the driver with your fix on positive feedback from you.
> Thanks for tracking this down.
>
> Ben, is there any chance to get this driver into next?
>
> Niko
>
>

Hubert
