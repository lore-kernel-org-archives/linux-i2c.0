From: Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Subject: [PATCH 00/10] i2c mux cleanup and locking update
Date: Mon,  4 Jan 2016 16:10:05 +0100
Message-ID: <1451920215-29167-1-git-send-email-peda@lysator.liu.se>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
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
locking changes are in the second half of the series, with the real meat
in 8/10. The tail of the series cleans up the open-coded unlocked i2c-
transfers in the pca9541 and pca954x drivers.

Further work: Looking at i2c_adapter_lock users in drivers/, it seems that
at least some of them are there just so that the driver can work behind an
i2c controlled mux (e.g. media/dvb-frontends/rtl2830.c). Those kind of
kludges can be removed. Other users lump several transfers together to
prevent mishaps, and at least some of those could probably be converted to
lock the i2c segment instead of the master bus adapter, so that the driver
doesn't deadlock even if the device sits behind an i2c controlled mux.

PS. needs a bunch of testing, I do not have access to all the involved hw

Cheers,
Peter

Peter Rosin (10):
  i2c-mux: add common core data for every mux instance
  i2c-mux: move select and deselect ops to i2c_mux_core
  i2c-mux: move the slave side adapter management to i2c_mux_core
  i2c-mux: remove the mux dev pointer from the mux per channel data
  i2c-mux: pinctrl: get rid of the driver private struct device pointer
  i2c: allow adapter drivers to override the adapter locking
  i2c: muxes always lock the parent adapter
  i2c-mux: relax locking of the top i2c adapter during i2c controlled
    muxing
  i2c: pca9541: get rid of the i2c deadlock workaround
  i2c: pca954x: get rid of the i2c deadlock workaround

 .../devicetree/bindings/i2c/i2c-mux-gpio.txt       |   2 +
 .../devicetree/bindings/i2c/i2c-mux-pinctrl.txt    |   4 +
 drivers/i2c/i2c-core.c                             |  59 ++---
 drivers/i2c/i2c-mux.c                              | 279 +++++++++++++++++----
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c         |  46 ++--
 drivers/i2c/muxes/i2c-mux-gpio.c                   |  58 ++---
 drivers/i2c/muxes/i2c-mux-pca9541.c                | 141 ++++-------
 drivers/i2c/muxes/i2c-mux-pca954x.c                | 104 ++++----
 drivers/i2c/muxes/i2c-mux-pinctrl.c                |  85 +++----
 drivers/i2c/muxes/i2c-mux-reg.c                    |  63 ++---
 include/linux/i2c-mux-gpio.h                       |   2 +
 include/linux/i2c-mux-pinctrl.h                    |   2 +
 include/linux/i2c-mux.h                            |  39 ++-
 include/linux/i2c.h                                |  28 ++-
 14 files changed, 524 insertions(+), 388 deletions(-)

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
