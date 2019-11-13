From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] iio: adc: max9611: Defer probe on POR read
Date: Wed, 13 Nov 2019 10:41:23 +0100
Message-ID: <CAMuHMdWdr_Popu7=ywYGxikpYEcN4oF50+QwOwAyjpj87GLnHQ@mail.gmail.com>
References: <20191016102520.124370-1-jacopo+renesas@jmondi.org>
 <CAMuHMdUH0LrZ6iEuN1aWCTt_-jpgp=EjxubMAVdp11HLL=ayyQ@mail.gmail.com> <CAMuHMdULSOOmcoKrQ40TJaNVOAuBsCA=bgC3pMB8jOGpRCAMhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdULSOOmcoKrQ40TJaNVOAuBsCA=bgC3pMB8jOGpRCAMhg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: linux-iio@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Nov 10, 2019 at 7:45 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Oct 17, 2019 at 2:55 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, Oct 16, 2019 at 12:23 PM Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > > The max9611 driver tests communications with the chip by reading the die
> > > temperature during the probe function. If the temperature register
> > > POR (power-on reset) value is returned from the test read, defer probe to
> > > give the chip a bit more time to properly exit from reset.
> > >
> > > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >
> > >   I've not been able to reproduce the issue on my boards (M3-N
> > > Salvator-XS and M3-W Salvator-X). As you reported the issue you might be
> > > able to reproduce it, could you please test this?
> >
> > I can reproduce it on Salvator-XS with R-Car H3 ES2.0.
> > According to my logs, I've seen the issue on all Salvator-X(S) boards,
> > but not with the same frequency.  Probability is highest on H3 ES2.0
> > (ca. 5% of the boots since I first saw the issue), followed by H3 ES1.0,
> > M3-W, and M3-N.
> >
> > After more investigation, my findings are:
> >   1. I cannot reproduce the issue if the max9611 driver is modular.
> >      Is it related to using max9611 "too soon" after i2c bus init?
> >      How can "i2c bus init" impact a slave device?
> >      Perhaps due to pin configuration, e.g. changing from another pin
> >      function or GPIO to function i2c4?

Not true: I managed to reproduce it with a modular driver.

> >   2. Adding a delay at the top of max9611_init() fixes the issue.
> >      This would explain why the issue is less likely to happy on slower
> >      SoCs like M3-N.
> >   3. Disabling all other i2c slaves on i2c4 in DTS fixes the issue.
> >      Before, max9611 was initialized last, so this moves init earlier,
> >      contradicting theory #1.
> >   4. Just disabling the adv7482 (which registers 11 dummies i2c slaves)
> >      in DTS does not fix the issue.
> >
> > Unfortunately i2c4 is exposed on a 60-pin Samtec QSH connector only,
> > for which I have no breakout adapter.
>
> Some soldering fixed that. Still investigating.
> Here's a status update:
>
>   A. I can reproduce the issue at 100 kHz instead of 400 kHz.
>   B. 3 above doesn't seem to be true: I can reproduce it with all other
>      slaves disabled.
>   C. The code says:
>
>         /*
>          * need a delay here to make register configuration
>          * stabilize. 1 msec at least, from empirical testing.
>          */
>         usleep_range(1000, 2000);
>
>      However, the datasheet says:
>
>         Parameter            MIN     TYP     MAX
>         Conversion Time      -       2 ms    -
>
>      So 1 ms is definitely too short.
>      Unfortunately the datasheet has no maximum value.

usleep_range(1000, 2000) usually results in a sleep time of 2.0 ms: OK
It may take longer: I saw 4.8 -- 7.7 ms (nothing in between 2.0 -- 4.8!): OK
It may take shorter:
  - 1.2 -- 1.7 ms: FAIL
  - 1.8 ms - 2 ms: OK

So a minimum delay of 2 ms seems like a good value.

>   D. For 2: msleep(1) is sufficient, usleep_range(200, 500) is not.
>      And this is still not explained by C.

Without adding an msleep() call to max9611_init(), the usleep_range()
call in max9611_read_single() happens at an arbitrary moment.
After adding an msleep() call to max9611_init(), the code becomes
synchronized to the jiffies clock, and the usleep_range() call in
max9611_read_single() never completes in less than 2 ms, thus avoiding
the issue.

>      I also don't know yet who's resetting the chip on reboot, as it
>      does not have a reset line, but all registers are zeroed (except
>      for the POR temperature value).

Looks like the PMIC powers down the +3.3V rail for ca. 25 ms when PSCI
initiates a system reboot.

Patch sent: "[PATCH] iio: adc: max9611: Fix too short conversion time
delay"
(https://lore.kernel.org/lkml/20191113092133.23723-1-geert+renesas@glider.be/).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
