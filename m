From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/3] mfd: add support for Diolan DLN-2 devices
Date: Mon, 1 Sep 2014 12:39:49 +0100
Message-ID: <20140901113949.GP7374@lee--X1>
References: <1409349654-24841-1-git-send-email-octavian.purdila@intel.com>
 <1409349654-24841-2-git-send-email-octavian.purdila@intel.com>
 <20140901083744.GE7374@lee--X1>
 <CAE1zotK0cddns4f4ay-GJie8O2pjb72+-yYndZvW0hbF0D83HA@mail.gmail.com>
 <20140901095127.GK7374@lee--X1>
 <CAE1zot+T6eq0jrL6_Qh=5nihNOgGEaWe5RCDk7_1XS8ZWaWKqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAE1zot+T6eq0jrL6_Qh=5nihNOgGEaWe5RCDk7_1XS8ZWaWKqA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 01 Sep 2014, Octavian Purdila wrote:

> On Mon, Sep 1, 2014 at 12:51 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wro=
te:
> > On Mon, 01 Sep 2014, Octavian Purdila wrote:
> >
> >> On Mon, Sep 1, 2014 at 11:37 AM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> =
wrote:
> >> > On Sat, 30 Aug 2014, Octavian Purdila wrote:
> >> >
> >> >> This patch implements the USB part of the Diolan USB-I2C/SPI/GP=
IO
> >> >> Master Adapter DLN-2. Details about the device can be found her=
e:
> >> >>
> >> >> https://www.diolan.com/i2c/i2c_interface.html.
> >> >>
> >> >> Information about the USB protocol can be found in the Programm=
er's
> >> >> Reference Manual [1], see section 1.7.
> >> >>
> >> >> Because the hardware has a single transmit endpoint and a singl=
e
> >> >> receive endpoint the communication between the various DLN2 dri=
vers
> >> >> and the hardware will be muxed/demuxed by this driver.
> >> >>
> >> >> Each DLN2 module will be identified by the handle field within =
the DLN2
> >> >> message header. If a DLN2 module issues multiple commands in pa=
rallel
> >> >> they will be identified by the echo counter field in the messag=
e header.
> >> >>
> >> >> The DLN2 modules can use the dln2_transfer() function to issue =
a
> >> >> command and wait for its response. They can also register a cal=
lback
> >> >> that is going to be called when a specific event id is generate=
d by
> >> >> the device (e.g. GPIO interrupts). The device uses handle 0 for
> >> >> sending events.
> >> >>
> >> >> [1] https://www.diolan.com/downloads/dln-api-manual.pdf
> >> >
> >> > MFD is not a dumping ground for misfit h/w.  Almost all of this =
code
> >> > looks like it belongs in drivers/usb.  Please move it there.
> >> >
> >>
> >> We initially submitted this driver as a pure USB driver, with our =
own
> >> module registration mechanism, but during the first round of revie=
ws
> >> people pointed out that a MFD driver is the better approach, and I
> >> agree. I also see that there are already a couple of USB drivers
> >> implemented as MFD drivers.
> >
> > Can you link me to your previous submission please?
>=20
> Sure, here it is:
>=20
> https://lkml.org/lkml/2014/8/20/228
>=20
> >
> >> Do you see a better approach?
> >
> > You should have a small MFD driver which controls resources and
> > registers children.  All other functionality should live in their
> > respective drivers/X locations i.e. USB functionallity should norma=
lly
> > live in drivers/usb.
> >
>=20
> OK, that sounds better. I am not sure how to handle the registration
> part though, since in this case we need to create the children at
> runtime, from the usb probe routine.
>=20
> The only solution I see is to move the driver completely to
> usb/drivers and continue to use the MFD infrastructure. Does that
> sound OK to you?

I have no problem with that.  If this is an MFD driver, it _should_
live in drivers/mfd.  However, all of that USB specific stuff
defiantly should not.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
