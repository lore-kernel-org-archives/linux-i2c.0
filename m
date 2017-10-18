From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] i2c: riic: remove clock and frequency restrictions
Date: Wed, 18 Oct 2017 16:25:01 +0200
Message-ID: <CAMuHMdWLh=4mETrwXHZ0LSfx9mtBewaDV6dhHKhvhGJ=ii-Vxg@mail.gmail.com>
References: <20171018140459.104351-1-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:55182 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbdJROZD (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 18 Oct 2017 10:25:03 -0400
In-Reply-To: <20171018140459.104351-1-chris.brandt@renesas.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>

Hi Chris,

On Wed, Oct 18, 2017 at 4:04 PM, Chris Brandt <chris.brandt@renesas.com> wrote:
> Remove the restriction that the parent clock has to be a specific frequency
> and also allow any speed to be supported.
>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Thanks for your patch!

> --- a/drivers/i2c/busses/i2c-riic.c
> +++ b/drivers/i2c/busses/i2c-riic.c
> @@ -288,48 +283,101 @@ static const struct i2c_algorithm riic_algo = {
>         .functionality  = riic_func,
>  };
>
> -static int riic_init_hw(struct riic_dev *riic, u32 spd)
> +static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
>  {

> +       /*
> +        * Determine reference clock rate. We must be able to get the desired
> +        * frequency with only 62 clock ticks max (31 high, 31 low).
> +        * Aim for a duty of 60% LOW, 40% HIGH.
> +        */
> +       total_ticks = rate / t->bus_freq_hz;
> +       if (rate % t->bus_freq_hz)              /* round up */
> +               total_ticks++;

DIV_ROUND_UP()

> +       /*
> +        * Remove clock ticks for rise and fall times. Convert ns to clock
> +        * ticks.
> +        */
> +       brl -= t->scl_fall_ns / (1000000000/rate);
> +       brh -= t->scl_rise_ns / (1000000000/rate);

To avoid losing too much precision by the division, you can rewrite this as
e.g.

    brl -= t->scl_fall_ns * rate / 1000000000;

("scl_fall_ns * rate" should not overflow).
Perhaps DIV_ROUND_UP(), too?

> +       pr_debug("i2c-riic: freq=%lu, duty=%d, fall=%lu, rise=%lu, cks=%d, brl=%d, brh=%d\n",
> +                rate/total_ticks, ((brl+3)*100)/(brl+brh+6),
> +                t->scl_fall_ns / (1000000000/rate),
> +                t->scl_rise_ns / (1000000000/rate), cks, brl, brh);

Likewise (or: reuse the values from above?).

Gr{oetje,eeting}s,

                        Geert
