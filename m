From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 00/13] V2 Split i2c-designware.c to support PCI drivers.
Date: Thu, 10 Feb 2011 08:21:16 -0800
Message-ID: <1297354889-20721-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This patch set reworks i2c-designware.c to enable supporting multiple
instances of the driver in the system and adds support for Designware
I2C IP cores behind PCI devices.

The patch set has been refactored to hopefully make it easier to
review.

TODO:
Ben disliked the module names, they haven't changed yet waiting for
feedback on the list.
 
Changes since V1 of the patch set:

Patches 1-3 are now Jean-Hugues Deschenes patches unmodified from
http://www.spinics.net/lists/linux-i2c/msg02421.html

Patch 4 moves the version checking introduced in Jean's code to the
core init function.

Patch 5 splits i2c-designware.c into IP core and bus specific files.

Patch 6-9 rework i2c-designware-core.c and i2c-designware-platdrv.c to
add the ability to support multiple instances of the driver.

Patch 10 Finishes moving all register access and associated offset and
bit definitions into the core.

Patch 11 Adds support for designware I2C IP cores behind PCI
devices on the Moorestown and Medfield platforms. removed change to
authors name.

Patch 12 Adds runtime power management to the PCI driver.    


Dirk Brandewie (10):
  i2c-designware: Move checking of IP core version to i2c_dw_init()
  i2c-designware: split of i2c-designware.c into core and bus specific
    parts
  i2c-designware: Move retriveving the clock speed out of core code.
  i2c-designware: move i2c functionality bit field to be adapter
    specific
  i2c-designware: move controller config to bus specific portion of
    driver
  i2c-designware: Support multiple cores using same ISR
  i2c-designware: Push all register reads/writes into the core code.
  i2c-designware: Add support for Designware core behind PCI devices.
  i2c-designware: Add runtime power management support
  i2c-intel-mid.c: Remove i2c-intel-mid.c

Jean-Hugues Deschenes (3):
  i2c-designware: Use local version of readl & writel
  i2c-designware: Check component type register
  i2c-designware: Allow mixed endianness accesses

 drivers/i2c/busses/Kconfig                         |   25 +-
 drivers/i2c/busses/Makefile                        |    6 +-
 .../{i2c-designware.c => i2c-designware-core.c}    |  391 +++-----
 drivers/i2c/busses/i2c-designware-core.h           |  105 ++
 drivers/i2c/busses/i2c-designware-pcidrv.c         |  402 +++++++
 drivers/i2c/busses/i2c-designware-platdrv.c        |  215 ++++
 drivers/i2c/busses/i2c-intel-mid.c                 | 1135 --------------------
 7 files changed, 868 insertions(+), 1411 deletions(-)
 rename drivers/i2c/busses/{i2c-designware.c => i2c-designware-core.c} (65%)
 create mode 100644 drivers/i2c/busses/i2c-designware-core.h
 create mode 100644 drivers/i2c/busses/i2c-designware-pcidrv.c
 create mode 100644 drivers/i2c/busses/i2c-designware-platdrv.c
 delete mode 100644 drivers/i2c/busses/i2c-intel-mid.c

-- 
1.7.3.4
