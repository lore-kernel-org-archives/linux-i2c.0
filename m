From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v11 0/3] add support for Diolan DLN-2
Date: Mon, 10 Nov 2014 16:03:51 +0000
Message-ID: <20141110160351.GJ24004@x1>
References: <1415281685-14866-1-git-send-email-octavian.purdila@intel.com>
 <20141110151019.GC24004@x1>
 <CAE1zotLmLMLm=3HMmL55TXWf4frCryWCLGnhEUw8f9H+GpY4tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAE1zotLmLMLm=3HMmL55TXWf4frCryWCLGnhEUw8f9H+GpY4tA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 10 Nov 2014, Octavian Purdila wrote:

> On Mon, Nov 10, 2014 at 5:10 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wro=
te:
> > Linus, Wolfram,
> >
> > Enjoy!
> >
> > The following changes since commit f114040e3ea6e07372334ade75d1ee07=
75c355e1:
> >
> >   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib=
-mfd-gpio-i2c-v3.19
>=20
> Hi Lee,
>=20
> Not sure if this matter, but this tree seems to miss the
> mfd_add_hotplug_devices patches from Johan, which are needed by the
> patches below.

Yes, that will definitely matter.

> > for you to fetch changes up to e7d146b11a8a33b6033220b0f4fc4de2ab29=
218a:
> >
> >   gpio: add support for the Diolan DLN-2 USB GPIO driver (2014-11-1=
0 15:05:49 +0000)
> >
> > ----------------------------------------------------------------
> > Immutable branch between MFD, GPIO and I2C
> >
> > ----------------------------------------------------------------
> > Daniel Baluta (1):
> >       gpio: add support for the Diolan DLN-2 USB GPIO driver
> >
> > Laurentiu Palcu (1):
> >       i2c: add support for Diolan DLN-2 USB-I2C adapter
> >
> > Octavian Purdila (1):
> >       mfd: Add support for Diolan DLN-2 devices
> >
> >  drivers/gpio/Kconfig          |  12 +
> >  drivers/gpio/Makefile         |   1 +
> >  drivers/gpio/gpio-dln2.c      | 553 ++++++++++++++++++++++++++++++
> >  drivers/i2c/busses/Kconfig    |  10 +
> >  drivers/i2c/busses/Makefile   |   1 +
> >  drivers/i2c/busses/i2c-dln2.c | 267 +++++++++++++++
> >  drivers/mfd/Kconfig           |  10 +
> >  drivers/mfd/Makefile          |   1 +
> >  drivers/mfd/dln2.c            | 763 ++++++++++++++++++++++++++++++=
++++++++++++
> >  include/linux/mfd/dln2.h      | 103 ++++++
> >  10 files changed, 1721 insertions(+)
> >  create mode 100644 drivers/gpio/gpio-dln2.c
> >  create mode 100644 drivers/i2c/busses/i2c-dln2.c
> >  create mode 100644 drivers/mfd/dln2.c
> >  create mode 100644 include/linux/mfd/dln2.h
> >

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
