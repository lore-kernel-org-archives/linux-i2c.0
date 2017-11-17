From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 4/6] arm64: renesas: draak: enable I2C controller 0 and
 EEPROM
Date: Fri, 17 Nov 2017 06:31:21 -0800
Message-ID: <20171117143120.ayattgah6q54425c@verge.net.au>
References: <1510759526-30346-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1510759526-30346-5-git-send-email-ulrich.hecht+renesas@gmail.com>
 <CAMuHMdWmZEoNGRjsumOc+yPe3JTCBobVZd8arzUfcymjF0imDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWmZEoNGRjsumOc+yPe3JTCBobVZd8arzUfcymjF0imDA@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 16, 2017 at 10:27:56AM +0100, Geert Uytterhoeven wrote:
> Hi Ulrich,
> 
> On Wed, Nov 15, 2017 at 4:25 PM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
> > Enables EEPROM on I2C0 on the Draak board.
> >
> > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> 
> Thanks for your patch!
> 
> > --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> 
> > @@ -67,6 +72,18 @@
> >         };
> >  };
> >
> > +&i2c0 {
> > +       pinctrl-0 = <&i2c0_pins>;
> > +       pinctrl-names = "default";
> > +       status = "okay";
> > +
> > +       eeprom@50 {
> > +               compatible = "atmel,24c01";
> 
> This is actually a ROHM Semiconductor BR24T01FVM-W, so it should be
> 
>         compatible = "rohm,br24t01", "atmel,24c01";

Applied with the above change.

> Please also submit a patch to add that compatible value to
> Documentation/devicetree/bindings/eeprom/eeprom.txt.

Ulrich, please follow-up on this, thanks!

> With the above fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
