From: "M'boumba Cedric Madianga" <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v9 2/5] i2c: Add STM32F4 I2C driver
Date: Thu, 19 Jan 2017 09:29:53 +0100
Message-ID: <CAOAejn1HdZACqBLfw9r-yXZeSatz=mYDBGc9fdQ2puPVhsOp1w@mail.gmail.com>
References: <1484666821-20551-1-git-send-email-cedric.madianga@gmail.com>
 <1484666821-20551-3-git-send-email-cedric.madianga@gmail.com>
 <20170117193752.e6hju25w74bb4i4z@pengutronix.de> <CAOAejn0ea2j_oUijOdHgiL3JU4TM0HZoL+-ggzjpPL2eA7tDCw@mail.gmail.com>
 <20170118184237.tvhlsksdcw2ckwan@pengutronix.de> <CAOAejn2LobTMfvsvmW8cCiToFHuM6n26s5QPLLXxLzb-WKkhQw@mail.gmail.com>
 <20170119080258.fovhfy2v6rrtgwgp@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170119080258.fovhfy2v6rrtgwgp-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

ok fine

2017-01-19 9:02 GMT+01:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutroni=
x.de>:
> Hello Cedric,
>
> On Wed, Jan 18, 2017 at 09:55:39PM +0100, M'boumba Cedric Madianga wrote:
>> 2017-01-18 19:42 GMT+01:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengut=
ronix.de>:
>> > Hello Cedric,
>> >
>> > On Wed, Jan 18, 2017 at 04:21:17PM +0100, M'boumba Cedric Madianga wro=
te:
>> >> >> +      * In standard mode, the maximum allowed SCL rise time is 10=
00 ns.
>> >> >> +      * If, in the I2C_CR2 register, the value of FREQ[5:0] bits =
is equal to
>> >> >> +      * 0x08 so period =3D 125 ns therefore the TRISE[5:0] bits m=
ust be
>> >> >> +      * programmed with 09h.(1000 ns / 125 ns =3D 8 + 1)
>> >> >
>> >> >         * programmed with 0x9.
>> >> > (1000 ns / 125 ns =3D 8)
>> >> >
>> >> >> +      * So, for I2C standard mode TRISE =3D FREQ[5:0] + 1
>> >> >> +      *
>> >> >> +      * In fast mode, the maximum allowed SCL rise time is 300 ns=
.
>> >> >> +      * If, in the I2C_CR2 register, the value of FREQ[5:0] bits =
is equal to
>> >> >> +      * 0x08 so period =3D 125 ns therefore the TRISE[5:0] bits m=
ust be
>> >> >> +      * programmed with 03h.(300 ns / 125 ns =3D 2 + 1)
>> >> >
>> >> > as above s/03h/0x3/;
>> >>
>> >> ok
>> >>
>> >> > s/.(/. (/;
>> >> ok
>> >>
>> >> > s/+ 1//;
>> >> This formula is use to understand how we find the result 0x3
>> >> So, 0x3 =3D> 300 ns / 125ns =3D 2 + 1
>> >
>> > Yeah, I understood that, but writing 300 ns / 125ns =3D 2 + 1 is
>> > irritating at best.
>>
>> Ok. I will write 0x3 (300 ns / 125 ns + 1) and 0x9 (1000 ns / 125 ns + 1=
)
>>
>> >> >         [...]
>> >> >         If DUTY =3D 1: (to reach 400 kHz)
>> >> >
>> >> > Strange.
>> >> >
>> >> >> +             val =3D DIV_ROUND_UP(i2c_dev->parent_rate, 400000 * =
3);
>> >> >
>> >> > the manual reads:
>> >> >
>> >> >         The minimum allowed value is 0x04, except in FAST DUTY mode
>> >> >         where the minimum allowed value is 0x01
>> >> >
>> >> > You don't check for that, right?
>> >>
>> >> As the minimum freq value is 6 Mhz in fast mode the minimum CCR is 5
>> >> as described in the comment.
>> >> So I don't need to check that again as it is already done by checking
>> >> parent frequency.
>> >
>> > That would then go into a comment.
>>
>> Is it really needed ?
>> Adding some comments to explain implementation choices or  hardware
>> way of working is clearly useful.
>> But for this kind of thing, I am really surprised...
>
> TL;DR: It's not needed, but it probably helps.
>
> Consider someone sees a breakage in your driver in five years. By then
> you either have other interests or at least forgot 95 % of the thoughts
> you had when implementing the driver.
>
> So when I see:
>
>         val =3D DIV_ROUND_UP(i2c_dev->parent_rate, 400000 * 3);
>         ccr |=3D STM32F4_I2C_CCR_CCR(val);
>         writel_relaxed(ccr, i2c_dev->base + STM32F4_I2C_CCR);
>
> after seeing that the bus freq is wrong the obvious thoughts are:
>
>  - Does this use the right algorithm?
>  - Does this calculation result in values that are usable by the
>    hardware?
>
> That you thought about this today doesn't mean it's still right in five
> years. During that time a new hardware variant is available with a
> higher parent freq. Or there is a new errata available for the SoC.
>
> So to help answer the questions above it helps if you add today the
> formulas from the manual and a quick reason for why val fits into the
> respective bits in the CCR register. That comment might be wrong until
> then, too, but that only means you should make it easy to verify.
> Something like:
>
>         /*
>          * Function bla_blub made sure that parent_rate is not higher
>          * than 23 * pi MHz. As a result val is at most 13.2 bits wide
>          * and so fits into the CCR bits.
>          */
>
> This gives you in five years time the opportunity to quickly check
> bla_blub if this is still true, add a printk for parent_rate to check
> this, or quickly identify the bug in the code or the mismatch to the
> manual.
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
