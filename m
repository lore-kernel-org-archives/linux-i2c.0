From: "M'boumba Cedric Madianga" <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v9 2/5] i2c: Add STM32F4 I2C driver
Date: Wed, 18 Jan 2017 16:21:17 +0100
Message-ID: <CAOAejn0ea2j_oUijOdHgiL3JU4TM0HZoL+-ggzjpPL2eA7tDCw@mail.gmail.com>
References: <1484666821-20551-1-git-send-email-cedric.madianga@gmail.com>
 <1484666821-20551-3-git-send-email-cedric.madianga@gmail.com> <20170117193752.e6hju25w74bb4i4z@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170117193752.e6hju25w74bb4i4z-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Uwe,

2017-01-17 20:37 GMT+01:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutron=
ix.de>:
> Hello,
>
> On Tue, Jan 17, 2017 at 04:26:58PM +0100, M'boumba Cedric Madianga wrote:
>> +static void stm32f4_i2c_set_rise_time(struct stm32f4_i2c_dev *i2c_dev)
>> +{
>> +     u32 freq =3D DIV_ROUND_UP(i2c_dev->parent_rate, HZ_TO_MHZ);
>> +     u32 trise;
>> +
>> +     /*
>> +      * These bits must be programmed with the maximum SCL rise time gi=
ven in
>> +      * the I2C bus specification, incremented by 1.
>> +      *
>> +      * In standard mode, the maximum allowed SCL rise time is 1000 ns.
>> +      * If, in the I2C_CR2 register, the value of FREQ[5:0] bits is equ=
al to
>> +      * 0x08 so period =3D 125 ns therefore the TRISE[5:0] bits must be
>> +      * programmed with 09h.(1000 ns / 125 ns =3D 8 + 1)
>
>         * programmed with 0x9.
> (1000 ns / 125 ns =3D 8)
>
>> +      * So, for I2C standard mode TRISE =3D FREQ[5:0] + 1
>> +      *
>> +      * In fast mode, the maximum allowed SCL rise time is 300 ns.
>> +      * If, in the I2C_CR2 register, the value of FREQ[5:0] bits is equ=
al to
>> +      * 0x08 so period =3D 125 ns therefore the TRISE[5:0] bits must be
>> +      * programmed with 03h.(300 ns / 125 ns =3D 2 + 1)
>
> as above s/03h/0x3/;

ok

> s/.(/. (/;
ok

> s/+ 1//;
This formula is use to understand how we find the result 0x3
So, 0x3 =3D> 300 ns / 125ns =3D 2 + 1

>
>> +      * So, for I2C fast mode TRISE =3D FREQ[5:0] * 300 / 1000 + 1
>> +      */
>> +     if (i2c_dev->speed =3D=3D STM32F4_I2C_SPEED_STANDARD)
>> +             trise =3D freq + 1;
>> +     else
>> +             trise =3D freq * 300 / 1000 + 1;
>
> I'd use
>
>         * 3 / 10
>
> without downside and lesser chance to overflow.

There is no chance of overflow as the max freq value allowed is 46

>
>> +
>> +     writel_relaxed(STM32F4_I2C_TRISE_VALUE(trise),
>> +                    i2c_dev->base + STM32F4_I2C_TRISE);
>> +}
>> +
>> +static void stm32f4_i2c_set_speed_mode(struct stm32f4_i2c_dev *i2c_dev)
>> +{
>> +     u32 val;
>> +     u32 ccr =3D 0;
>> +
>> +     if (i2c_dev->speed =3D=3D STM32F4_I2C_SPEED_STANDARD) {
>> +             /*
>> +              * In standard mode:
>> +              * t_scl_high =3D t_scl_low =3D CCR * I2C parent clk perio=
d
>> +              * So to reach 100 kHz, we have:
>> +              * CCR =3D I2C parent rate / 100 kHz >> 1
>> +              *
>> +              * For example with parent rate =3D 2 MHz:
>> +              * CCR =3D 2000000 / (100000 << 1) =3D 10
>> +              * t_scl_high =3D t_scl_low =3D 10 * (1 / 2000000) =3D 500=
0 ns
>> +              * t_scl_high + t_scl_low =3D 10000 ns so 100 kHz is reach=
ed
>> +              */
>> +             val =3D i2c_dev->parent_rate / (100000 << 1);
>> +     } else {
>> +             /*
>> +              * In fast mode, we compute CCR with duty =3D 0 as with lo=
w
>> +              * frequencies we are not able to reach 400 kHz.
>> +              * In that case:
>> +              * t_scl_high =3D CCR * I2C parent clk period
>> +              * t_scl_low =3D 2 * CCR * I2C parent clk period
>> +              * So, CCR =3D I2C parent rate / (400 kHz * 3)
>> +              *
>> +              * For example with parent rate =3D 6 MHz:
>> +              * CCR =3D 6000000 / (400000 * 3) =3D 5
>> +              * t_scl_high =3D 5 * (1 / 6000000) =3D 833 ns > 600 ns
>> +              * t_scl_low =3D 2 * 5 * (1 / 6000000) =3D 1667 ns > 1300 =
ns
>> +              * t_scl_high + t_scl_low =3D 2500 ns so 400 kHz is reache=
d
>> +              */
>
> Huh, that's surprising. So you don't use DUTY any more. I found two
> hints in the manual that contradict here:

Yes with the above formula we could use duty =3D 0 by default

>
>         f_{PCLK1} must be at least 2 MHz to achieve Sm mode I2C frequenci=
es

STM32F4_I2C_MIN_STANDARD_FREQ =3D 2

>         It must be at least 4 MHz to achieve Fm mode I2C frequencies.

STM32F4_I2C_MIN_FAST_FREQ =3D 6

> It must be a multiple of 10MHz to reach the 400 kHz maximum I2C Fm mode c=
lock.

If we use this rule only 3 values are allowed 10 Mhz, 20 Mhz, 30 Mhz and 40=
 Mhz.
It is very restrictive.
So I don't take it into account in order to have more frequencies even
if 400 Khz is not reached.
Indeed, in many cases we are very close to 400 Khz.
For example, the default I2C parent clock in my board is 45 Mhz
I reach 395 kHz in theory and 390 kHz by testing.
I am in Fast mode but not with the max freq but very close.

>
> and
>
>         [...]
>         If DUTY =3D 1: (to reach 400 kHz)
>
> Strange.
>
>> +             val =3D DIV_ROUND_UP(i2c_dev->parent_rate, 400000 * 3);
>
> the manual reads:
>
>         The minimum allowed value is 0x04, except in FAST DUTY mode
>         where the minimum allowed value is 0x01
>
> You don't check for that, right?

As the minimum freq value is 6 Mhz in fast mode the minimum CCR is 5
as described in the comment.
So I don't need to check that again as it is already done by checking
parent frequency.

> CCR is 11 bits wide. A comment confirming that this cannot overflow
> would be nice.

Again there is no chance of overflow thanks to parent frequency check

>
> +               /* select Fast Mode */
>> +             ccr |=3D STM32F4_I2C_CCR_FS;

ok

>
> I didn't check the rest of the code, so let's assume it's good :-)

ok Thanks

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
