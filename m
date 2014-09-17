From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/3] mfd: add support for Diolan DLN-2 devices
Date: Wed, 17 Sep 2014 08:56:15 -0700
Message-ID: <20140917155615.GG30918@lee--X1>
References: <1410290686-6680-1-git-send-email-octavian.purdila@intel.com>
 <1410290686-6680-2-git-send-email-octavian.purdila@intel.com>
 <20140916232149.GB30918@lee--X1>
 <CAE1zotJWUnduPUd9C8EgSHHSo-OCgdj7c-sKaT5M2Ajj2CmNWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE1zotJWUnduPUd9C8EgSHHSo-OCgdj7c-sKaT5M2Ajj2CmNWw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, wsa@the-dreams.de, Samuel Ortiz <sameo@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Johan Hovold <johan@kernel.org>, Daniel Baluta <daniel.baluta@intel.com>, Laurentiu Palcu <laurentiu.palcu@intel.com>, linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 17 Sep 2014, Octavian Purdila wrote:
> On Wed, Sep 17, 2014 at 2:21 AM, Lee Jones <lee.jones@linaro.org> wro=
te:
> >
> > On Tue, 09 Sep 2014, Octavian Purdila wrote:
> >
> > > This patch implements the USB part of the Diolan USB-I2C/SPI/GPIO
> > > Master Adapter DLN-2. Details about the device can be found here:
> > >
> > > https://www.diolan.com/i2c/i2c_interface.html.
> > >
> > > Information about the USB protocol can be found in the Programmer=
's
> > > Reference Manual [1], see section 1.7.
> > >
> > > Because the hardware has a single transmit endpoint and a single
> > > receive endpoint the communication between the various DLN2 drive=
rs
> > > and the hardware will be muxed/demuxed by this driver.
> > >
> > > Each DLN2 module will be identified by the handle field within th=
e DLN2
> > > message header. If a DLN2 module issues multiple commands in para=
llel
> > > they will be identified by the echo counter field in the message =
header.
> > >
> > > The DLN2 modules can use the dln2_transfer() function to issue a
> > > command and wait for its response. They can also register a callb=
ack
> > > that is going to be called when a specific event id is generated =
by
> > > the device (e.g. GPIO interrupts). The device uses handle 0 for
> > > sending events.
> > >
> > > [1] https://www.diolan.com/downloads/dln-api-manual.pdf
> > >
> > > Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> > > ---
> > >  drivers/mfd/Kconfig      |   9 +
> > >  drivers/mfd/Makefile     |   1 +
> > >  drivers/mfd/dln2.c       | 681 +++++++++++++++++++++++++++++++++=
++++++++++++++
> > >  include/linux/mfd/dln2.h |  71 +++++
> > >  4 files changed, 762 insertions(+)
> > >  create mode 100644 drivers/mfd/dln2.c
> > >  create mode 100644 include/linux/mfd/dln2.h

[...]

> > > diff --git a/include/linux/mfd/dln2.h b/include/linux/mfd/dln2.h
> > > new file mode 100644
> > > index 0000000..197565d
> > > --- /dev/null
> > > +++ b/include/linux/mfd/dln2.h
> > > @@ -0,0 +1,71 @@
> > > +#ifndef __LINUX_USB_DLN2_H
> > > +#define __LINUX_USB_DLN2_H
> > > +
> > > +#define DLN2_CMD(cmd, id)            ((cmd) | ((id) << 8))
> > > +
> > > +struct dln2_platform_data {
> > > +     u16 handle;
> > > +     union {
> > > +             struct {
> > > +                     u8 port;
> > > +             } i2c;
> > > +     };
> > > +};
> >
> > Why this complexity?
>=20
> There is also an SPI interface on this adapter which will probably th=
e
> port information and maybe some additional information. Would you
> prefer to add the union later, when we add the SPI driver?

Yes please.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
