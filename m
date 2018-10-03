From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v8 05/10] dt-bindings: i3c: Add macros to help fill
 I3C/I2C device's reg property
Date: Wed, 3 Oct 2018 20:45:02 +0200
Message-ID: <CAMuHMdVA7eKD+qfzzCqrXus69NPb3Qd_G0k=TYvrdt=2pRG51A@mail.gmail.com>
References: <20181003132212.12619-1-boris.brezillon@bootlin.com>
 <20181003132212.12619-6-boris.brezillon@bootlin.com> <c7b929a8c8ebaec7ce0f0e09f803e414e74f986b.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c7b929a8c8ebaec7ce0f0e09f803e414e74f986b.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll>
List-Id: linux-i2c@vger.kernel.org

Hi Joe,

On Wed, Oct 3, 2018 at 8:37 PM Joe Perches <joe@perches.com> wrote:
> On Wed, 2018-10-03 at 15:22 +0200, Boris Brezillon wrote:
> > The reg property of devices connected to an I3C bus have 3 cells, and
> > filling them manually is not trivial. Provides macros to help doing
> > that.
>
> This patch logic seems excessively fragile.

> > --- /dev/null
> > +++ b/include/dt-bindings/i3c/i3c.h

> > +
> > +#define I3C_PID(manufid, partid, instid, extrainfo)          \
> > +     ((manufid) << 1)                                        \
> > +     (((partid) << 16) | ((instid) << 12) | (extrainfo))
>
> This macro doesn't make any sense.  Missing a shift and an or?

No, it generates two of the three cells.

> > +
> > +#define I3C_DEV_WITH_STATIC_ADDR(addr, manufid, partid,              \
> > +                              instid, extrainfo)             \
> > +     (addr) I3C_PID(manufid, partid, instid, extrainfo)
> > +
> > +#define I3C_DEV(manufid, partid, instid, extrainfo)          \
> > +     I3C_DEV_WITH_STATIC_ADDR(0x0, manufid, partid,          \
> > +                              instid, extrainfo)

And the above two macros generate all three cells.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
