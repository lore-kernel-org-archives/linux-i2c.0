From: Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/7] i2c/pxa2xx: reset the chip if the bus is not free
Date: Thu, 25 Nov 2010 15:04:42 +0800
Message-ID: <AANLkTi=1CkW=uw8i53kQX8j1Lp5y-cPb72VrYkcTynJ2@mail.gmail.com>
References: <1290633617-15311-1-git-send-email-bigeasy@linutronix.de>
	<1290633617-15311-7-git-send-email-bigeasy@linutronix.de>
	<AANLkTikvN+==eTkoh7CTQyN0mbfvPhH6Uh9NX5QW7WFx@mail.gmail.com>
	<AANLkTi=8Xy3M7QGO54nt_r0_12z3+o8G5fAqQmxkTH4o@mail.gmail.com>
	<4CEE05A4.6030201@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CEE05A4.6030201-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "eric.y.miao" <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, sodaville <sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ben-linux <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, tglx <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 25, 2010 at 2:43 PM, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org=
> wrote:
> =A0Hi,
>
> On 11/25/10 04:49, Haojian Zhuang wrote:
>> On Thu, Nov 25, 2010 at 10:30 AM, Haojian Zhuang
>> <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> On Thu, Nov 25, 2010 at 5:20 AM, Sebastian Andrzej Siewior
>>> <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wrote:
>>>> I haven't seen this (yet) during a normal transfer but starting
>>>> i2cdetect seems to hang the bus. On my Sodaville board, i2cdetect =
runs
>>>> fine on bus zero and runs into timeouts on bus one and two. The ch=
ip
>>>> never recovers from this condition. The following transfers hang a=
s
>>>> well. The ISR_UB never disappears.
>>>> Issuing a chip reset fixes the timeout and following transfer succ=
eed.
>>>>
>>>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
>>>> Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>> ---
>>>> =A0drivers/i2c/busses/i2c-pxa.c | =A0 35 +++++++++++++++++++------=
----------
>>>> =A01 files changed, 19 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c=
-pxa.c
>>>> index bd4b885..1a48470 100644
>>>> --- a/drivers/i2c/busses/i2c-pxa.c
>>>> +++ b/drivers/i2c/busses/i2c-pxa.c
>>>> @@ -257,23 +257,7 @@ static void i2c_pxa_abort(struct pxa_i2c *i2c=
)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 _ICR(i2c));
>>>> =A0}
>>>>
>>>> -static int i2c_pxa_wait_bus_not_busy(struct pxa_i2c *i2c)
>>>> -{
>>>> - =A0 =A0 =A0 int timeout =3D DEF_TIMEOUT;
>>>>
>>>> - =A0 =A0 =A0 while (timeout-- && readl(_ISR(i2c)) & (ISR_IBB | IS=
R_UB)) {
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((readl(_ISR(i2c)) & ISR_SAD) !=3D=
 0)
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout +=3D 4;
>>>> -
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(2);
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_state(i2c);
>>>> - =A0 =A0 =A0 }
>>>> -
>>>> - =A0 =A0 =A0 if (timeout < 0)
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_state(i2c);
>>>> -
>>>> - =A0 =A0 =A0 return timeout < 0 ? I2C_RETRY : 0;
>>>> -}
>>>>
>>>> =A0static int i2c_pxa_wait_master(struct pxa_i2c *i2c)
>>>> =A0{
>>>> @@ -425,6 +409,25 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c=
)
>>>> =A0 =A0 =A0 =A0udelay(100);
>>>> =A0}
>>>>
>>>> +static int i2c_pxa_wait_bus_not_busy(struct pxa_i2c *i2c)
>>>> +{
>>>> + =A0 =A0 =A0 int timeout =3D DEF_TIMEOUT;
>>>> +
>>>> + =A0 =A0 =A0 while (timeout-- && readl(_ISR(i2c)) & (ISR_IBB | IS=
R_UB)) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((readl(_ISR(i2c)) & ISR_SAD) !=3D=
 0)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout +=3D 4;
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(2);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_state(i2c);
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 if (timeout < 0) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_state(i2c);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_pxa_reset(i2c);
>>>> + =A0 =A0 =A0 }
>>> Even you reset I2C controller, it shouldn't help you since bus isn'=
t
>>> free. I thinkt that you should reset I2C bus before you reseting I2=
C
>>> controller.
>>>
>> Excuse me that my previous comments are for PXA master mode.
>>
>> I think that you're focused on pxa working on slave mode. But if pxa
>> is working in master mode, it seems that we needn't reset I2C
>> controller since it doesn't help.
>
> As for PXA3xx, the Developer Manual states:
> "Software must ensure that the TWSI unit is not busy (ISR[UB] =3D 0)
> before it asserts a reset. Software must also ensure that the TWSI bu=
s is idle (ISR[IBB] =3D 0)
> when the unit is enabled after reset."
>
> From my experience, in master mode resetting the controller
> does not help and if the bus is busy for too much time,
> there always was a h/w problem involved.
>

Yes, it's true. Actually there's some not smart firmware on some I2C
client devices that they may fetch wrong data as slave address and
command. There're two solutions for this bus busy issue. One is _not_
using this kind of client device. The other one is sending enough dump
clock to push these client device back to idle state.

>>>> +
>>>> + =A0 =A0 =A0 return timeout < 0 ? I2C_RETRY : 0;
>>>> +}
>>>>
>>>> =A0#ifdef CONFIG_I2C_PXA_SLAVE
>>>> =A0/*
>>>> --
>>>> 1.7.3.2
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
> --
> Regards,
> Igor.
>
>
