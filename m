From: Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/7] i2c/pxa2xx: add support for shared IRQ handler
Date: Thu, 25 Nov 2010 10:26:28 +0800
Message-ID: <AANLkTik11gr1fg=vht2FYBpDZBBhxLXezS8ih752xj=5@mail.gmail.com>
References: <1290633617-15311-1-git-send-email-bigeasy@linutronix.de>
	<1290633617-15311-5-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1290633617-15311-5-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 25, 2010 at 5:20 AM, Sebastian Andrzej Siewior
<bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wrote:
> Sodaville has three of them on a single IRQ. IRQF_DISABLED is removed
> because it is a NOP allready and scheduled for removal.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> =A0drivers/i2c/busses/i2c-pxa.c | =A0 10 ++++++++--
> =A01 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-px=
a.c
> index dc66fde..7647361 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -905,11 +905,17 @@ static void i2c_pxa_irq_rxfull(struct pxa_i2c *=
i2c, u32 isr)
> =A0 =A0 =A0 =A0writel(icr, _ICR(i2c));
> =A0}
>
> +#define VALID_INT_SOURCE =A0 =A0 =A0 (ISR_SSD | ISR_ALD | ISR_ITE | =
ISR_IRF | \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ISR_SAD=
 | ISR_BED)
> =A0static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id)
> =A0{
> =A0 =A0 =A0 =A0struct pxa_i2c *i2c =3D dev_id;
> =A0 =A0 =A0 =A0u32 isr =3D readl(_ISR(i2c));
>
> + =A0 =A0 =A0 isr &=3D VALID_INT_SOURCE;
> + =A0 =A0 =A0 if (!isr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_NONE;
> +

If you return at here, the valid interrupt status event won't be
cleared in IRQ handler. So I2C interrupt handler will be triggered at
next time.

> =A0 =A0 =A0 =A0if (i2c_debug > 2 && 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&i2c->adap.dev, "%s: ISR=3D%08=
x, ICR=3D%08x, IBMR=3D%02x\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, isr, readl(_=
ICR(i2c)), readl(_IBMR(i2c)));
> @@ -924,7 +930,7 @@ static irqreturn_t i2c_pxa_handler(int this_irq, =
void *dev_id)
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Always clear all pending IRQs.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 writel(isr & (ISR_SSD|ISR_ALD|ISR_ITE|ISR_IRF|ISR_SAD|I=
SR_BED), _ISR(i2c));
> + =A0 =A0 =A0 writel(isr, _ISR(i2c));
>
> =A0 =A0 =A0 =A0if (isr & ISR_SAD)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c_pxa_slave_start(i2c, isr);
> @@ -1062,7 +1068,7 @@ static int i2c_pxa_probe(struct platform_device=
 *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c->adap.algo =3D &i2c_pxa_pio_algori=
thm;
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c->adap.algo =3D &i2c_pxa_algorithm;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D request_irq(irq, i2c_pxa_handle=
r, IRQF_DISABLED,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D request_irq(irq, i2c_pxa_handle=
r, IRQF_SHARED,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2=
c->adap.name, i2c);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto ereqirq;
> --
> 1.7.3.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
