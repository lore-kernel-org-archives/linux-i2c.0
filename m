From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PULL REQUEST] i2c-embedded for 3.8
Date: Tue, 18 Dec 2012 17:04:03 -0800
Message-ID: <CA+55aFyV5ROO-Zy4UxhXx0Lu6biyBzmrre=NY1x0yx7tK+Lz8g@mail.gmail.com>
References: <20121218234150.GA32374@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121218234150.GA32374-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Ugh, guys. Please check this out.

On Tue, Dec 18, 2012 at 3:41 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
>
> please pull the i2c-embedded changes for 3.8 which include:
>
> * CBUS driver (an I2C variant)
> * continued rework of the omap driver
> * s3c2410 gets lots of fixes and gains pinctrl support
> * at91 gains DMA support
> * the GPIO muxer gains devicetree probing
> * typical fixes and additions all over
>
> All patches have been in linux-next before. Please pull.

I get a conflict because both sides have this:

   Revert "ARM: OMAP: convert I2C driver to PM QoS for MPU latency constraints"

which re-introduced the omap-specific ->set_mpu_wkup_lat() thing.

But in mainline the only *user* of that has gone away. And the call
location where it originally existed has moved.

It originally existed in

  arch/arm/plat-omap/i2c.c

but looking at the history, the omap i2c code first got split into
omap1 and omap2, and at that point the call-site got moved to

  arch/arm/mach-omap2/i2c.c

but then the code that the revert re-introduced got lost.

Now, in the merge I just did, I *reinstated* that
->set_mpu_wkup_lat() code that had gotten lost in mainline. But quite
frankly, the thing is ugly as heck, and I hope it could just be
deleted. Clearly nobody had noticed yet that it got lost in some merge
(possibly an earlier one of mine, but considering that I usually
notice things like this, I suspect it's one of the internal ARM ones).

I'm adding Arnd, Tony and Olof to the participants list, since they
are the main suspects.

And guys, if you decide to remove the  ->set_mpu_wkup_lat() from
arch/arm/mach-omap2/i2c.c again, please make sure that you remove the
whole infrastructure too:

  include/linux/i2c-omap.h
  drivers/i2c/busses/i2c-omap.c

Hmm? Somebody *really* needs to double-check my merge, it's possibly
quite broken, since I have in no way tested it, and I did this by
looking at some *very* messy history with code being moved across
different files etc etc.

               Linus
