From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] i2c/busses: Add i2c-icy for I2C on m68k/Amiga
Date: Tue, 13 Aug 2019 08:53:14 +0200
Message-ID: <CAMuHMdWr8VNBBVjgcu9wtdby-0pznEtg=GeVmAcrk78Of7gwNA@mail.gmail.com>
References: <20190811043253.24938-1-max@enpas.org> <CAMuHMdVJJxjH-gPraW==smrkOOMcGYPKB8BPzrYPU4bstASX3A@mail.gmail.com>
 <0d61e12f-5fc5-7cb6-755f-298ebf4c935f@enpas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0d61e12f-5fc5-7cb6-755f-298ebf4c935f@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Staudt <max@enpas.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
List-Id: linux-i2c@vger.kernel.org

Hi Max,

On Tue, Aug 13, 2019 at 12:21 AM Max Staudt <max@enpas.org> wrote:
> On 08/12/2019 11:37 AM, Geert Uytterhoeven wrote:
> >> +       iowrite8(val, address);
> >
> > As this is on a Zorro bus, z_writeb()?
>
> I forgot to ask about this.
>
> What is the reasoning behind having a separate z_writeb() for Zorro?
> As far as I can see in arch/m68k/include/asm this maps 1:1 to a direct memory access, and it prohibits cross-arch code as in i2c-elektor.

write*() and friends are intended for PCI, and thus little endian, while
the Zorro bus is big endian. For byte accesses this doesn't matter,
obviously.

Note that this predates iowrite*(), which does have *be variants.
If you want to add compile-testing to your driver, using iowrite*() is fine.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
