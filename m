From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Date: Tue, 24 Jul 2018 17:46:09 +0200
Message-ID: <CAMuHMdXJ_FGXXwNx8h0ZfskJGRWES1xLuTQpD59Vw1Smp6FTRg@mail.gmail.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se> <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
 <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se> <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
 <20180720151751.242d4809@bbrezillon> <CAK8P3a14_6uf9VLYU0YnmFp0Q=DZBKc0cAesBh0opanGDZMFRA@mail.gmail.com>
 <20180724162806.318a92c6@bbrezillon> <CAK8P3a3YQbiiJMTHTVh63fOvtA1sa0J5Eb4z7xbnpBPwUDkqxg@mail.gmail.com>
 <CAMuHMdXif_iufXx0Y+UJjKs9TNLfrTONoFvUSyrpkfaT0=ydRQ@mail.gmail.com> <CAK8P3a0jc1k9weTNbqSJXkCSFefus9OPyU5_v5=mTFxiDd0q5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0jc1k9weTNbqSJXkCSFefus9OPyU5_v5=mTFxiDd0q5Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll>
List-Id: linux-i2c@vger.kernel.org

Hi Arnd,

On Tue, Jul 24, 2018 at 5:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Jul 24, 2018 at 5:15 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Tue, Jul 24, 2018 at 5:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> >> That's not the case I was describing here, I was thinking of what
> >> Wolfram described with the Renesas SoC that has two i2c masters
> >> multiplexed through the pinmux layer. I would assume that we
> >> can still do the same thing in i3c by shutting down the current
> >> master without a handover, and reprobing everything from scratch.
> >
> > The major disadvantage of reprobing is that it may cause visual disturbances
> > when i2c slaves are involved with e.g. the display pipeline (think HDMI encoders
> > etc.).
>
> Do you mean we should reuse the device pointer and association with
> the driver even when we switch out the i3c master using the pinmux?
>
> Or do you mean we need to be prepared for driving a single
> slave through multiple masters over the lifetime of that device,
> but using the i3c master handover protocol?
> In the second case, how do we decide which master to use
> for accessing a device for a given request?

I'll have to defer to Wolfram. He's the i2c and muxing expert.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
