From: Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/7] i2c/pxa2xx: reset the chip if the bus is not free
Date: Thu, 25 Nov 2010 10:30:04 +0800
Message-ID: <AANLkTikvN+==eTkoh7CTQyN0mbfvPhH6Uh9NX5QW7WFx@mail.gmail.com>
References: <1290633617-15311-1-git-send-email-bigeasy@linutronix.de>
	<1290633617-15311-7-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1290633617-15311-7-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 25, 2010 at 5:20 AM, Sebastian Andrzej Siewior
<bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wrote:
> I haven't seen this (yet) during a normal transfer but starting
> i2cdetect seems to hang the bus. On my Sodaville board, i2cdetect run=
s
> fine on bus zero and runs into timeouts on bus one and two. The chip
> never recovers from this condition. The following transfers hang as
> well. The ISR_UB never disappears.
> Issuing a chip reset fixes the timeout and following transfer succeed=
=2E
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> =A0drivers/i2c/busses/i2c-pxa.c | =A0 35 +++++++++++++++++++---------=
-------
> =A01 files changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-px=
a.c
> index bd4b885..1a48470 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -257,23 +257,7 @@ static void i2c_pxa_abort(struct pxa_i2c *i2c)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 _ICR(i2c));
> =A0}
>
> -static int i2c_pxa_wait_bus_not_busy(struct pxa_i2c *i2c)
> -{
> - =A0 =A0 =A0 int timeout =3D DEF_TIMEOUT;
>
> - =A0 =A0 =A0 while (timeout-- && readl(_ISR(i2c)) & (ISR_IBB | ISR_U=
B)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((readl(_ISR(i2c)) & ISR_SAD) !=3D 0=
)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout +=3D 4;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(2);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_state(i2c);
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 if (timeout < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_state(i2c);
> -
> - =A0 =A0 =A0 return timeout < 0 ? I2C_RETRY : 0;
> -}
>
> =A0static int i2c_pxa_wait_master(struct pxa_i2c *i2c)
> =A0{
> @@ -425,6 +409,25 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
> =A0 =A0 =A0 =A0udelay(100);
> =A0}
>
> +static int i2c_pxa_wait_bus_not_busy(struct pxa_i2c *i2c)
> +{
> + =A0 =A0 =A0 int timeout =3D DEF_TIMEOUT;
> +
> + =A0 =A0 =A0 while (timeout-- && readl(_ISR(i2c)) & (ISR_IBB | ISR_U=
B)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((readl(_ISR(i2c)) & ISR_SAD) !=3D 0=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout +=3D 4;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_state(i2c);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (timeout < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_state(i2c);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_pxa_reset(i2c);
> + =A0 =A0 =A0 }

Even you reset I2C controller, it shouldn't help you since bus isn't
free. I thinkt that you should reset I2C bus before you reseting I2C
controller.

> +
> + =A0 =A0 =A0 return timeout < 0 ? I2C_RETRY : 0;
> +}
>
> =A0#ifdef CONFIG_I2C_PXA_SLAVE
> =A0/*
> --
> 1.7.3.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
