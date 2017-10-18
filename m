From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] i2c: riic: remove clock and frequency restrictions
Date: Wed, 18 Oct 2017 17:14:37 +0200
Message-ID: <CAMuHMdW8JLMzm9AQEO6UstW1MTHTjkf7rskLN8d4p95eZt0Z1g@mail.gmail.com>
References: <20171018140459.104351-1-chris.brandt@renesas.com>
 <CAMuHMdWLh=4mETrwXHZ0LSfx9mtBewaDV6dhHKhvhGJ=ii-Vxg@mail.gmail.com> <SG2PR06MB116572EFA9E1BD8C7BB47AB78A4D0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <SG2PR06MB116572EFA9E1BD8C7BB47AB78A4D0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-i2c@vger.kernel.org

Hi Chris,

On Wed, Oct 18, 2017 at 5:10 PM, Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Wednesday, October 18, 2017 1, Geert Uytterhoeven wrote:
>> > +       /*
>> > +        * Remove clock ticks for rise and fall times. Convert ns to
>> clock
>> > +        * ticks.
>> > +        */
>> > +       brl -= t->scl_fall_ns / (1000000000/rate);
>> > +       brh -= t->scl_rise_ns / (1000000000/rate);
>>
>> To avoid losing too much precision by the division, you can rewrite this
>> as
>> e.g.
>>
>>     brl -= t->scl_fall_ns * rate / 1000000000;
>>
>> ("scl_fall_ns * rate" should not overflow).
>> Perhaps DIV_ROUND_UP(), too?
>
> Unfortunately, I do not get the correct number every time.
>
> Sometimes I get the correct number, but most of the time I get 0.
>
> Note, if rate=33,330,000 and t->scl_fall_ns=300, then
>
> t->scl_fall_ns * rate  = 9,999,000,000 (0x253FCA1C0) a 34-bit number.
>
> So, I'd rather just stick with the less precision because it's not that
> much of a bit deal.

Oops, so the numbers are bigger than I had expected, naively.

Alternatively, you can use a 64-by-32 division, e.g.

    DIV_ROUND_UP_ULL((u64)t->scl_fall_ns * rate, 1000000000)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
