From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 03/14] net: davicom: dm9000: allow to pass MAC address
 through mac_addr module parameter
Date: Wed, 12 Feb 2020 09:07:52 +0100
Message-ID: <CAMuHMdX6f+aGZjQSQqVjT=npojq5xH2k2Js8qxG5=n26Z4uFBw@mail.gmail.com>
References: <cover.1581457290.git.hns@goldelico.com> <4e11dd4183da55012198824ca7b8933b1eb57e4a.1581457290.git.hns@goldelico.com>
 <20200211222506.GP19213@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20200211222506.GP19213@lunn.ch>
Sender: linux-gpio-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Paul Cercueil <paul@crapouillou.net>, Paul Boddie <paul@boddie.org.uk>, Alex Smith <alex.smith@imgtec.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "David S. Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, Andi Kleen <ak@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Miquel Raynal <miquel.raynal@bootlin.com>, =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>, Richard Fontana <rfontana@redhat.com>Allison Randal <all>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 11, 2020 at 11:25 PM Andrew Lunn <andrew@lunn.ch> wrote:
> On Tue, Feb 11, 2020 at 10:41:20PM +0100, H. Nikolaus Schaller wrote:
> > This is needed to give the MIPS Ingenic CI20 board a stable MAC address
> > which can be optionally provided by vendor U-Boot.
> >
> > For get_mac_addr() we use an adapted copy of from ksz884x.c which
> > has very similar functionality.
> >
> > Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>
> Hi Nikolaus
>
> Please split these patches by subsystem. So this one patch needs to go
> via netdev.
>
> > +static char *mac_addr = ":";
> > +module_param(mac_addr, charp, 0);
> > +MODULE_PARM_DESC(mac_addr, "MAC address");
>
> Module parameters are not liked.
>
> Can it be passed via device tree? The driver already has code to get
> it out of the device tree.

Yep, typically U-Boot adds an appropriate "local-mac-address" property to the
network device's device node, based on the "ethernet0" alias.

However, the real clue here may be "vendor U-Boot", i.e. no support for the
above?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
