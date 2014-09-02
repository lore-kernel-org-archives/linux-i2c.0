From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/3] mfd: add support for Diolan DLN-2 devices
Date: Tue, 2 Sep 2014 17:07:33 +0200
Message-ID: <20140902150733.GX4894@localhost>
References: <20140901083744.GE7374@lee--X1>
 <CAE1zotK0cddns4f4ay-GJie8O2pjb72+-yYndZvW0hbF0D83HA@mail.gmail.com>
 <20140901095127.GK7374@lee--X1>
 <CAE1zot+T6eq0jrL6_Qh=5nihNOgGEaWe5RCDk7_1XS8ZWaWKqA@mail.gmail.com>
 <20140901113949.GP7374@lee--X1>
 <CAE1zotKNBTEMX8DDYwdwOcq0qZgqxZWazE60TUQeiOmD0a4xbA@mail.gmail.com>
 <20140901154626.GH8796@lee--X1>
 <CAE1zotL-cjHqrdymzYhZq24zx+0qGY8-4JnrVZf-TGXDf5Sm3w@mail.gmail.com>
 <20140901175453.GR4894@localhost>
 <20140902080010.GD17117@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140902080010.GD17117@lee--X1>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 02, 2014 at 09:00:10AM +0100, Lee Jones wrote:
> On Mon, 01 Sep 2014, Johan Hovold wrote:

> > No, no. USB is not a function of the MFD device, it's the transport.
> > Thus there should be no USB MFD-cell. No subdriver can work without it.
> > 
> > And the USB id belongs in the MFD-driver in the same way that an
> > i2c id (address) does.
> > 
> > Just like an MFD device with i2c as a transport, this driver would
> > function as an arbiter to a shared resource (i.e. the register space).
> > The reason it seems much more USB-centric than an i2c-mfd driver is that
> > that transport API is simpler and some code have also already been
> > generalised (e.g. regmap), whereas we appear to have only two USB
> > mfd-drivers thus far.
> > 
> > The viperboard is perhaps a bad example in so far that it has pushed the
> > transport details down into the subdrivers (and thus into gpio, i2c and
> > iio subsystems) instead of handling it one place.
> 
> Thanks for your explanation.  I take your point about the USB ID and I
> did say I was guessing that the USB part should exist as a child
> device.
> 
> So after your comments I decided to do a little investigation.  It
> appears that this MFD driver is _just_ using the common API which all
> other devices utilising USB comms are forced to use.  Is that correct?

Yes, it's using the low-level USB API, but there's a lot of higher-level
interfaces in place for (fairly) standard things such as the USB class
drivers or the USB serial subsystem.

> If so, I have a question.  Is there no way to hide more of the USB
> specifics inside a better, simpler API?  It looks like the drivers
> which use USB are subjected to a lot (too much) of what might be
> considered internals.  Or is it just that the client has to tinker
> with too many dials to get anything sensible out? *shudders*

Unfortunately, anything that does not already have a driver is likely to
use some vendor-specific protocol and therefore must use the low-level
API.

> > I haven't looked at the details of the protocol for the device in
> > question, but it might even be possible to use regmap here (as I
> > mentioned in my comments on v1).
> 
> Obviously that would be preferred.

Simple register-based USB MFD devices (e.g. only using control
transfers) are conceivable though, and if we start seeing a lot of those
(which I doubt) perhaps that part could be refactored as a regmap bus.

Johan
