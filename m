From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: [RFC PATCH v2 0/7] mux controller abstraction and iio/i2c muxes
Date: Thu, 17 Nov 2016 22:48:02 +0100
Message-ID: <1479419289-17553-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi!

This is work in progress, I'm asking for early feedback.
The code depends on the _available work in iio which can
be found in linux-next.

v1 -> v2 changes
- fixup export of mux_control_put reported by kbuild
- drop devicetree iio-ext-info property as noted by Lars-Peter,
  and replace the functionality by exposing all ext_info
  attributes of the parent channel for each of the muxed
  channels. A cache on top of that and each muxed channel
  gets its own view of the ext_info of the parent channel.
- implement idle-state for muxes
- clear out the cache on failure in order to force a mux
  update on the following use
- cleanup the probe of i2c-mux-simple driver
- fix a bug in the i2c-mux-simple driver, where failure in
  the selection of the mux caused a deadlock when the mux
  was later unconditionally deselected.

I have a piece of hardware that is using the same 3 GPIO pins
to control four 8-way muxes. Three of them control ADC lines
to an ADS1015 chip with an iio driver, and the last one
controls the SDA line of an i2c bus. We have some deployed
code to handle this, but you do not want to see it or ever
hear about it. I'm not sure why I even mention it. Anyway,
the situation has nagged me to no end for quite some time.

So, after first getting more intimate with the i2c muxing code
and later discovering the drivers/iio/inkern.c file and
writing a couple of drivers making use of it, I came up with
what I think is an acceptable solution; add a generic mux
controller driver that is shared between all instances, and
combine that with an iio mux driver and a new generic i2c mux
driver. The new i2c mux I called "simple" since it is only
hooking the i2c muxing and the new mux controller (much like
the alsa simple card driver does for ASoC).

My initial (private) version didn't add "mux" as a new bus,
but I couldn't get decent type-checking and nice devicetree
integration with that. It does however feel a bit rich to
add a new bus for something as small as mux controllers?

One thing that I would like to do, but don't see a solution
for, is to move the mux control code that is present in
various drivers in drivers/i2c/muxes to this new minimalistic
muxing subsystem, thus converting all present i2c muxes (but
perhaps not gates and arbitrators) to be i2c-mux-simple muxes.

I'm using an rwsem to lock a mux, but that isn't really a
perfect fit. Is there a better locking primitive that I don't
know about that fits better? I had a mutex at one point, but
that didn't allow any concurrent accesses at all. At least
the rwsem allows concurrent access as long as all users
agree on the mux state, but I suspect that the rwsem will
degrade to the mutex situation pretty quickly if there is
any contention.

Also, the "mux" name feels a bit ambitious, there are many muxes
in the world, and this tiny bit of code is probably not good
enough to be a nice fit for all...

This is all very fresh code and only lightly tested, but it
feels very promising! Now, go ahead and rip this to pieces...

Cheers,
Peter

Peter Rosin (7):
  dt-bindings: document devicetree bindings for mux-gpio
  misc: minimal mux subsystem and gpio-based mux controller
  iio: inkern: api for manipulating ext_info of iio channels
  dt-bindings: iio: iio-mux: document iio-mux bindings
  iio: multiplexer: new iio category and iio-mux driver
  dt-bindings: i2c: i2c-mux-simple: document i2c-mux-simple bindings
  i2c: i2c-mux-simple: new driver

 .../devicetree/bindings/i2c/i2c-mux-simple.txt     |  91 +++++
 .../bindings/iio/multiplexer/iio-mux.txt           |  49 +++
 .../devicetree/bindings/misc/mux-gpio.txt          |  79 ++++
 drivers/i2c/muxes/Kconfig                          |  12 +
 drivers/i2c/muxes/Makefile                         |   1 +
 drivers/i2c/muxes/i2c-mux-simple.c                 | 168 ++++++++
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/inkern.c                               |  55 +++
 drivers/iio/multiplexer/Kconfig                    |  17 +
 drivers/iio/multiplexer/Makefile                   |   6 +
 drivers/iio/multiplexer/iio-mux.c                  | 444 +++++++++++++++++++++
 drivers/misc/Kconfig                               |   6 +
 drivers/misc/Makefile                              |   2 +
 drivers/misc/mux-core.c                            | 299 ++++++++++++++
 drivers/misc/mux-gpio.c                            | 115 ++++++
 include/linux/iio/consumer.h                       |   6 +
 include/linux/mux.h                                |  53 +++
 18 files changed, 1405 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt
 create mode 100644 Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
 create mode 100644 Documentation/devicetree/bindings/misc/mux-gpio.txt
 create mode 100644 drivers/i2c/muxes/i2c-mux-simple.c
 create mode 100644 drivers/iio/multiplexer/Kconfig
 create mode 100644 drivers/iio/multiplexer/Makefile
 create mode 100644 drivers/iio/multiplexer/iio-mux.c
 create mode 100644 drivers/misc/mux-core.c
 create mode 100644 drivers/misc/mux-gpio.c
 create mode 100644 include/linux/mux.h

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
