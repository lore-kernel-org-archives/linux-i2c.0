From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/3] mfd: add support for Diolan DLN-2 devices
Date: Mon, 1 Sep 2014 19:54:53 +0200
Message-ID: <20140901175453.GR4894@localhost>
References: <1409349654-24841-1-git-send-email-octavian.purdila@intel.com>
 <1409349654-24841-2-git-send-email-octavian.purdila@intel.com>
 <20140901083744.GE7374@lee--X1>
 <CAE1zotK0cddns4f4ay-GJie8O2pjb72+-yYndZvW0hbF0D83HA@mail.gmail.com>
 <20140901095127.GK7374@lee--X1>
 <CAE1zot+T6eq0jrL6_Qh=5nihNOgGEaWe5RCDk7_1XS8ZWaWKqA@mail.gmail.com>
 <20140901113949.GP7374@lee--X1>
 <CAE1zotKNBTEMX8DDYwdwOcq0qZgqxZWazE60TUQeiOmD0a4xbA@mail.gmail.com>
 <20140901154626.GH8796@lee--X1>
 <CAE1zotL-cjHqrdymzYhZq24zx+0qGY8-4JnrVZf-TGXDf5Sm3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAE1zotL-cjHqrdymzYhZq24zx+0qGY8-4JnrVZf-TGXDf5Sm3w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 01, 2014 at 07:22:39PM +0300, Octavian Purdila wrote:
> On Mon, Sep 1, 2014 at 6:46 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > On Mon, 01 Sep 2014, Octavian Purdila wrote:
> >
> >> On Mon, Sep 1, 2014 at 2:39 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> >> > On Mon, 01 Sep 2014, Octavian Purdila wrote:
> >> >> On Mon, Sep 1, 2014 at 12:51 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> >> >> > You should have a small MFD driver which controls resources and
> >> >> > registers children.  All other functionality should live in their
> >> >> > respective drivers/X locations i.e. USB functionallity should normally
> >> >> > live in drivers/usb.
> >> >> >
> >> >>
> >> >> OK, that sounds better. I am not sure how to handle the registration
> >> >> part though, since in this case we need to create the children at
> >> >> runtime, from the usb probe routine.
> >> >>
> >> >> The only solution I see is to move the driver completely to
> >> >> usb/drivers and continue to use the MFD infrastructure. Does that
> >> >> sound OK to you?
> >> >
> >> > I have no problem with that.  If this is an MFD driver, it _should_
> >> > live in drivers/mfd.  However, all of that USB specific stuff
> >> > defiantly should not.
> >> >
> >> > >> It is a multi-function driver which is using the USB interface, so I
> >> am not sure where it belongs. The only driver that calls
> >> mfd_add_devices and is not in drivers/mfd is the hid sensor hub
> >> driver.
> >>
> >> BTW, the mfd/viperboard.c driver is very similar with this driver. It
> >> has less USB specific stuff because the protocol is simpler, but still
> >> has some.
> >
> > Looking at viperboard.c, it seems to use some basic generic framework
> > calls to obtain some information about the device information like
> > version numbers.  Your driver is leaps and bounds more USB centric.
> >
> > Your MFD driver should know about things like; regmap, platform data,
> > memory allocation, same-chip devices (children), etc.  Your MFD driver
> > should not need to concern itself with; endpoints, slots, URBs, USB
> > device IDs and the like.  The later knowledge belongs in drivers/usb.
> >
> > You should be calling mfd_add_devices() from within the MFD driver.
> > At a guess, I would say that you need a new entry for the USB stuff in
> > your mfd_cells structure.
> >
> 
> Makes sense, thanks for making clearing up what the MFD part of the
> driver should do.
> 
> Here is how I think it could work:
> 
>  * keep the usb probe routine in the MFD driver (and keep it a usb driver)
> 
>  * add a new cell for the usb part
> 
>  * pass the usb_interface via platform_data to the USB sub-driver's
> platform_device probe routine and continue the USB setup there
> 
> Lee, USB folks, is this acceptable?

No, no. USB is not a function of the MFD device, it's the transport.
Thus there should be no USB MFD-cell. No subdriver can work without it.

And the USB id belongs in the MFD-driver in the same way that an
i2c id (address) does.

Just like an MFD device with i2c as a transport, this driver would
function as an arbiter to a shared resource (i.e. the register space).
The reason it seems much more USB-centric than an i2c-mfd driver is that
that transport API is simpler and some code have also already been
generalised (e.g. regmap), whereas we appear to have only two USB
mfd-drivers thus far.

The viperboard is perhaps a bad example in so far that it has pushed the
transport details down into the subdrivers (and thus into gpio, i2c and
iio subsystems) instead of handling it one place.

I haven't looked at the details of the protocol for the device in
question, but it might even be possible to use regmap here (as I
mentioned in my comments on v1).

Johan
