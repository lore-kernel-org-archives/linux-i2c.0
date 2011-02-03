From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 00/10] Split i2c-designware.c to support PCI drivers.
Date: Wed,  2 Feb 2011 18:19:58 -0800
Message-ID: <1296699608-13227-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

 
This patch set splits i2c-designware.c into core and bus specific
partions. 

Support for the Intel Moorestown and Medfield is provided in the PCI
portion of the driver.

This patch set has been tested on a Moorestown and Medfield based platforms.

Changes since RFC patch set:
The patch set now starts with i2c-designware.c as the base to make
following the evolution of i2c-designware.c easier.

My spin on the patch set by Jean-Hugues Deschenes moved to the head of
the series. 

All accesses to core registers are now done in i2c-designware-core.c

File names for PCI and platform driver files have changed.

Name of resulting drivers have changed to i2c-designware-[pci|plat] 

Bug fix in the PCI driver to fix core clock input value and FIFO
depth.

Review comments/improvements recieved from the list and from Shinya
integrated. 

Patch added to remove i2c-intel-mid.c
 
Dirk Brandewie (10):
  i2c-designware: Allow mixed endianness accesses
  i2c-designware: split of i2c-designware.c into core and bus specific
    parts
  i2c-designware: retrieve clock frequency based CONFIG_HAVE_CLK
  i2c-designware: Add support for Designware core behind PCI devices.
  i2c-designware: move i2c functionality bit field to be adapter
    specific
  i2c-designware: move controller config to bus specific portion of
    driver
  i2c-designware: Support multiple cores using same ISR
  i2c-designware: Push all register reads/writes into the core code.
  i2c-designware: Add runtime power management support
  i2c-intel-mid.c:  Remove i2c-intel-mid.c

 drivers/i2c/busses/Kconfig                  |   25 +-
 drivers/i2c/busses/Makefile                 |    6 +-
 drivers/i2c/busses/i2c-designware-core.c    |  623 +++++++++++++++
 drivers/i2c/busses/i2c-designware-core.h    |  203 +++++
 drivers/i2c/busses/i2c-designware-pcidrv.c  |  395 ++++++++++
 drivers/i2c/busses/i2c-designware-platdrv.c |  209 +++++
 drivers/i2c/busses/i2c-designware.c         |  847 --------------------
 drivers/i2c/busses/i2c-intel-mid.c          | 1135 ---------------------------
 8 files changed, 1446 insertions(+), 1997 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-designware-core.c
 create mode 100644 drivers/i2c/busses/i2c-designware-core.h
 create mode 100644 drivers/i2c/busses/i2c-designware-pcidrv.c
 create mode 100644 drivers/i2c/busses/i2c-designware-platdrv.c
 delete mode 100644 drivers/i2c/busses/i2c-designware.c
 delete mode 100644 drivers/i2c/busses/i2c-intel-mid.c

-- 
1.7.3.4
