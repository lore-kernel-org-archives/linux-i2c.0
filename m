From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] iio: adc: max9611: Defer probe on POR read
Date: Sun, 10 Nov 2019 17:15:26 +0000
Message-ID: <20191110171526.2bd269a9@archlinux>
References: <20191016102520.124370-1-jacopo+renesas@jmondi.org>
        <CAMuHMdUH0LrZ6iEuN1aWCTt_-jpgp=EjxubMAVdp11HLL=ayyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUH0LrZ6iEuN1aWCTt_-jpgp=EjxubMAVdp11HLL=ayyQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, linux-iio@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


On Thu, 17 Oct 2019 14:55:58 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Jacopo,
> 
> CC i2c

Ping. Wolfram, a query in here for you.

Thanks,

Jonathan

> 
> On Wed, Oct 16, 2019 at 12:23 PM Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > The max9611 driver tests communications with the chip by reading the die
> > temperature during the probe function. If the temperature register
> > POR (power-on reset) value is returned from the test read, defer probe to
> > give the chip a bit more time to properly exit from reset.
> >
> > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>  
> 
> Thanks for your patch!
> 
> > Geert,
> >   I've not been able to reproduce the issue on my boards (M3-N
> > Salvator-XS and M3-W Salvator-X). As you reported the issue you might be
> > able to reproduce it, could you please test this?  
> 
> I can reproduce it on Salvator-XS with R-Car H3 ES2.0.
> According to my logs, I've seen the issue on all Salvator-X(S) boards,
> but not with the same frequency.  Probability is highest on H3 ES2.0
> (ca. 5% of the boots since I first saw the issue), followed by H3 ES1.0,
> M3-W, and M3-N.
> 
> After more investigation, my findings are:
>   1. I cannot reproduce the issue if the max9611 driver is modular.
>      Is it related to using max9611 "too soon" after i2c bus init?
>      How can "i2c bus init" impact a slave device?
>      Perhaps due to pin configuration, e.g. changing from another pin
>      function or GPIO to function i2c4?
>   2. Adding a delay at the top of max9611_init() fixes the issue.
>      This would explain why the issue is less likely to happy on slower
>      SoCs like M3-N.
>   3. Disabling all other i2c slaves on i2c4 in DTS fixes the issue.
>      Before, max9611 was initialized last, so this moves init earlier,
>      contradicting theory #1.
>   4. Just disabling the adv7482 (which registers 11 dummies i2c slaves)
>      in DTS does not fix the issue.
> 
> Unfortunately i2c4 is exposed on a 60-pin Samtec QSH connector only,
> for which I have no breakout adapter.
> 
> Wolfram: do you have any clues?
> 
> > Also, I opted for deferring probe instead of arbitrary repeat the
> > temperature read. What's your opinion?  
> 
> While this is probably OK if the max9611 driver is built-in, I'm afraid
> this may lead to unbounded delays for a reprobe in case the driver
> is modular.
> 
> > --- a/drivers/iio/adc/max9611.c
> > +++ b/drivers/iio/adc/max9611.c
> > @@ -80,6 +80,7 @@
> >   * The complete formula to calculate temperature is:
> >   *     ((adc_read >> 7) * 1000) / (1 / 480 * 1000)
> >   */
> > +#define MAX9611_TEMP_POR               0x8000
> >  #define MAX9611_TEMP_MAX_POS           0x7f80
> >  #define MAX9611_TEMP_MAX_NEG           0xff80
> >  #define MAX9611_TEMP_MIN_NEG           0xd980
> > @@ -480,8 +481,10 @@ static int max9611_init(struct max9611_dev *max9611)
> >         if (ret)
> >                 return ret;
> >
> > -       regval &= MAX9611_TEMP_MASK;
> > +       if (regval == MAX9611_TEMP_POR)
> > +               return -EPROBE_DEFER;
> >
> > +       regval &= MAX9611_TEMP_MASK;
> >         if ((regval > MAX9611_TEMP_MAX_POS &&
> >              regval < MAX9611_TEMP_MIN_NEG) ||
> >              regval > MAX9611_TEMP_MAX_NEG) {  
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
