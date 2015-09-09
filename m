From: Kieran Bingham <kieranbingham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 0/8] i2c: Relax mandatory I2C ID table passing
Date: Wed,  9 Sep 2015 19:33:39 +0100
Message-ID: <1441823627-6227-1-git-send-email-kieranbingham@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kieran Bingham <kieranbingham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

I have picked this patchset [0] up from Lee to rebase it, with an aim to
get this series moving again.

A couple of minor issues were resolved in the rebase. As it stood, Javier
proposed [1] to merge this series, and use a follow up series to make sure
that all I2C drivers are using a MODLE_DEVICE_TABLE(of,...)

I have prepared a Coccinelle patch to work through the bulk of the changes
required for the conversion, which will assist the transition process.

[0] https://lkml.org/lkml/2014/8/28/283
[1] https://lkml.org/lkml/2014/9/12/496

Lee's most recent cover-letter (from 12 months ago) follows:

Hi Wolfram,

Placing this firmly back on your plate.  I truly hope we don't miss
another merge-window.  This patch-set has the support of some pretty
senior kernel maintainers, so I hope acceptance shouldn't be too
difficult.

As previously discussed I believe it should be okay for an I2C device
driver _not_ supply an I2C ID table to match to.  The I2C subsystem
should be able to match via other means, such as via OF tables.  The
blocking factor during our previous conversation was to keep
registering via sysfs up and running.  This set does that.

After thinking more deeply about the problem, it occurred to me that
any I2C device driver which uses the sysfs method and issues an
of_match_device() would also fail their probe().  Bolted on to this
set is a new, more generic way for these devices to match against
either of the I2C/OF tables.

I hope this ticks all of your boxes.

v4: [Kieran Bingham]
  - Rebase to v4.2
  - adapt for dev_pm_domain_{attach,detach}
  - strnicmp to strncasecmp

v3: [Lee Jones]
  - Insist on passing 'struct i2c_client' instead of 'struct device'
  - Remove hook from of_match_device()

v2: [Lee Jones]
  - Removal of ACPI support (this is really an OF issue).
  - Add a new .probe2( with will seamlessly replace
  - Supply a warning on devices matching via OF without a suitable compatible
  - Remove unified match_device() - bad idea as it subverts type-safe behaviour
  - Provide examples of the kind of clean-up possible after this set.
    - I already have the full support from the maintainer of these drivers =;-)

Lee Jones (8):
  i2c: Add pointer dereference protection to i2c_match_id()
  i2c: Add the ability to match device to compatible string without an
    of_node
  i2c: Match using traditional OF methods, then by vendor-less
    compatible strings
  i2c: Make I2C ID tables non-mandatory for DT'ed devices
  i2c: Export i2c_match_id() for direct use by device drivers
  i2c: Provide a temporary .probe2() call-back type
  mfd: 88pm860x: Move over to new I2C device .probe() call
  mfd: as3722: Rid driver of superfluous I2C device ID structure

 drivers/i2c/i2c-core.c      | 82 +++++++++++++++++++++++++++++++++++++--------
 drivers/mfd/88pm860x-core.c |  5 ++-
 drivers/mfd/as3722.c        | 12 ++-----
 include/linux/i2c.h         | 22 +++++++++++-
 4 files changed, 93 insertions(+), 28 deletions(-)

-- 
2.1.4
