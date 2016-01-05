From: Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Subject: [PATCH v2 0/8] i2c mux cleanup and locking update
Date: Tue,  5 Jan 2016 16:57:10 +0100
Message-ID: <1452009438-27347-1-git-send-email-peda@lysator.liu.se>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>, Olli Salonen <olli.salonen-X3B1VOXEql0@public.gmane.org>Peter Rosin <pe>
List-Id: linux-i2c@vger.kernel.org

From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>

Hi!

I have a pair of boards with this i2c topology:

                       GPIO ---|  ------ BAT1
                        |      v /
   I2C  -----+------B---+---- MUX
             |                   \
           EEPROM                 ------ BAT2

	(B denotes the boundary between the boards)

The problem with this is that the GPIO controller sits on the same i2c bus
that it MUXes. For pca954x devices this is worked around by using unlocked
transfers when updating the MUX. I have no such luck as the GPIO is a general
purpose IO expander and the MUX is just a random bidirectional MUX, unaware
of the fact that it is muxing an i2c bus, and extending unlocked transfers
into the GPIO subsystem is too ugly to even think about. But the general hw
approach is sane in my opinion, with the number of connections between the
two boards minimized. To put is plainly, I need support for it.

So, I observe that while it is needed to have the i2c bus locked during the
actual MUX update in order to avoid random garbage on the slave side, it
is not strictly a must to have it locked over the whole sequence of a full
select-transfer-deselect operation. The MUX itself needs to be locked, so
transfers to clients behind the mux are serialized, and the MUX needs to be
stable during all i2c traffic (otherwise individual mux slave segments
might see garbage).

This series accomplishes this by adding a dt property to i2c-mux-gpio and
i2c-mux-pinctrl that can be used to state that the mux is updated by means
of the muxed master bus, and that the select-transfer-deselect operations
should be locked individually. When this holds, the i2c bus *is* locked
during muxing, since the muxing happens as part of i2c transfers. This
is true even if the MUX is updated with several transfers to the GPIO (at
least as long as *all* MUX changes are using the i2s master bus). A lock
is added to the mux so that transfers through the mux are serialized.

Concerns:
- The locking is perhaps too complex?
- I worry about the priority inheritance aspect of the adapter lock. When
  the transfers behind the mux are divided into select-transfer-deselect all
  locked individually, low priority transfers get more chances to interfere
  with high priority transfers.
- When doing an i2c_transfer() in_atomic() context of with irqs_disabled(),
  there is a higher possibility that the mux is not returned to its idle
  state after a failed (-EAGAIN) transfer due to trylock.

To summarize the series, there's some i2c-mux infrastructure cleanup work
first (I think that part stands by itself as desireable regardless), the
locking changes are in the last three patches of the series, with the real
meat in 8/8.

PS. needs a bunch of testing, I do not have access to all the involved hw

Changes since v1:
- Allocate mux core and (optional) priv in a combined allocation.
- Killed dev_err messages triggered by memory allocation failure.
- Fix the device specific i2c muxes that I had overlooked.
- Rebased on top of v4.4-rc8 (was based on v4.4-rc6 previously).

Cheers,
Peter

Peter Rosin (8):
  i2c-mux: add common core data for every mux instance
  i2c-mux: move select and deselect ops to i2c_mux_core
  i2c-mux: move the slave side adapter management to i2c_mux_core
  i2c-mux: remove the mux dev pointer from the mux per channel data
  i2c-mux: pinctrl: get rid of the driver private struct device pointer
  i2c: allow adapter drivers to override the adapter locking
  i2c: muxes always lock the parent adapter
  i2c-mux: relax locking of the top i2c adapter during i2c controlled
    muxing

 .../devicetree/bindings/i2c/i2c-mux-gpio.txt       |   2 +
 .../devicetree/bindings/i2c/i2c-mux-pinctrl.txt    |   4 +
 drivers/i2c/i2c-core.c                             |  59 ++---
 drivers/i2c/i2c-mux.c                              | 272 +++++++++++++++++----
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c         |  46 ++--
 drivers/i2c/muxes/i2c-mux-gpio.c                   |  58 ++---
 drivers/i2c/muxes/i2c-mux-pca9541.c                |  58 +++--
 drivers/i2c/muxes/i2c-mux-pca954x.c                |  66 ++---
 drivers/i2c/muxes/i2c-mux-pinctrl.c                |  89 +++----
 drivers/i2c/muxes/i2c-mux-reg.c                    |  63 ++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  33 +--
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |   2 +-
 drivers/media/dvb-frontends/m88ds3103.c            |  23 +-
 drivers/media/dvb-frontends/m88ds3103_priv.h       |   2 +-
 drivers/media/dvb-frontends/rtl2830.c              |  24 +-
 drivers/media/dvb-frontends/rtl2830_priv.h         |   2 +-
 drivers/media/dvb-frontends/rtl2832.c              |  30 ++-
 drivers/media/dvb-frontends/rtl2832_priv.h         |   2 +-
 drivers/media/dvb-frontends/si2168.c               |  29 ++-
 drivers/media/dvb-frontends/si2168_priv.h          |   2 +-
 drivers/media/usb/cx231xx/cx231xx-core.c           |   6 +-
 drivers/media/usb/cx231xx/cx231xx-i2c.c            |  48 ++--
 drivers/media/usb/cx231xx/cx231xx.h                |   4 +-
 drivers/of/unittest.c                              |  41 ++--
 include/linux/i2c-mux-gpio.h                       |   2 +
 include/linux/i2c-mux-pinctrl.h                    |   2 +
 include/linux/i2c-mux.h                            |  39 ++-
 include/linux/i2c.h                                |  28 ++-
 28 files changed, 612 insertions(+), 424 deletions(-)

-- 
2.1.4
