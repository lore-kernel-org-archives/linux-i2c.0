From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH RFC] Splitting i2c-designware.c to support PCI drivers
Date: Fri, 14 Jan 2011 11:27:27 -0800
Message-ID: <1295033256-30077-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This patch set splits i2c-designware.c core and bus specific portions
in to support the Designware core being behind a PCI device.

The Intel Moorsetown and Medfield SOC's are supported in the PCI
portion of the driver.

This patch set is still a work in progress while I work with Shinya to
make sure I did not break anything on the platform driver side.  The
runtime power management stuff needs more test but doesn't break
anything but I am not sure it's right either. This has been tested on
the Intel Moorestown development platform. 

TODO:
Move the values used for  DW_IC_[FS,SS]_SCL_HCNT
DW_IC_[FS,SS]_SCL_LCNT to be adapter/contoller specific  

Comments/Suggestions gratefully accepted.
--Dirk

Dirk Brandewie (9):
  i2c-designware: Add designware PCI config option
  i2c-designware: Initial split of i2c-designware.c into core and bus
    specific parts
  i2c-designware: retrieve clock frequency based CONFIG_HAVE_CLK
  i2c-designware: Add support for Designware core behind PCI devices.
  i2c-designware: move i2c functionality bit field to be adapter
    specific
  i2c-designware: move controller config to bus specific portion of
    driver
  i2c-designware: Allow mixed endianness accesses
  i2c-designware-pci: Add runtime power management support
  i2c-designware: Support multiple cores using same ISR

 drivers/i2c/busses/Kconfig               |   20 +
 drivers/i2c/busses/Makefile              |    4 +
 drivers/i2c/busses/i2c-designware-core.c |  619 ++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-core.h |  214 ++++++++++
 drivers/i2c/busses/i2c-designware-pci.c  |  403 +++++++++++++++++++
 drivers/i2c/busses/i2c-designware-plat.c |  210 ++++++++++
 6 files changed, 1470 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-designware-core.c
 create mode 100644 drivers/i2c/busses/i2c-designware-core.h
 create mode 100644 drivers/i2c/busses/i2c-designware-pci.c
 create mode 100644 drivers/i2c/busses/i2c-designware-plat.c

-- 
1.7.3.4
