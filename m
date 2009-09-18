From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c updates for 2.6.32
Date: Fri, 18 Sep 2009 23:13:12 +0200
Message-ID: <20090918231312.133b833c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem updates for Linux 2.6.32 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

There is support for the AMD SB900 south bridge SMBus, a new driver for
standard ACPI SMBus implementations (SMBus CMI), 3 deprecated GPIO
drivers removed, a significant i2c-core change (i2c adapters changed
from class devices to bus devices), and a few other random fixes.

 Documentation/i2c/busses/i2c-piix4 |    2 +
 Documentation/i2c/chips/pca9539    |   58 -----
 Documentation/i2c/chips/pcf8574    |   65 ------
 Documentation/i2c/chips/pcf8575    |   69 ------
 MAINTAINERS                        |   16 ++
 drivers/gpio/pcf857x.c             |    1 +
 drivers/i2c/Kconfig                |    8 +
 drivers/i2c/busses/Kconfig         |   19 ++-
 drivers/i2c/busses/Makefile        |    3 +
 drivers/i2c/busses/i2c-piix4.c     |    9 +-
 drivers/i2c/busses/i2c-pnx.c       |    7 +-
 drivers/i2c/busses/i2c-scmi.c      |  430 ++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-taos-evm.c  |   45 ++--
 drivers/i2c/busses/scx200_acb.c    |    6 +-
 drivers/i2c/chips/Kconfig          |   48 ----
 drivers/i2c/chips/Makefile         |    3 -
 drivers/i2c/chips/pca9539.c        |  152 -------------
 drivers/i2c/chips/pcf8574.c        |  215 ------------------
 drivers/i2c/chips/pcf8575.c        |  198 -----------------
 drivers/i2c/chips/tsl2550.c        |   42 +---
 drivers/i2c/i2c-core.c             |  165 ++++++++++-----
 include/linux/i2c-id.h             |   11 -
 include/linux/i2c.h                |    2 -
 include/linux/pci_ids.h            |    1 +
 24 files changed, 641 insertions(+), 934 deletions(-)
 delete mode 100644 Documentation/i2c/chips/pca9539
 delete mode 100644 Documentation/i2c/chips/pcf8574
 delete mode 100644 Documentation/i2c/chips/pcf8575
 create mode 100644 drivers/i2c/busses/i2c-scmi.c
 delete mode 100644 drivers/i2c/chips/pca9539.c
 delete mode 100644 drivers/i2c/chips/pcf8574.c
 delete mode 100644 drivers/i2c/chips/pcf8575.c

---------------

Crane Cai (2):
      i2c-piix4: Add AMD SB900 SMBus device ID
      i2c: Add driver for SMBus Control Method Interface

Jean Delvare (7):
      i2c: Drop unused i2c_driver.id field
      i2c-taos-evm: Switch echo off to improve performance
      i2c/tsl2550: Use combined SMBus transactions
      i2c: Convert i2c clients to a device type
      i2c: Convert i2c adapters to bus devices
      i2c: Provide compatibility links for i2c adapters
      i2c: Clearly mark ACPI drivers as such

Julia Lawall (1):
      i2c-pnx: Correct use of request_region/request_mem_region

Willy Tarreau (1):
      i2c/scx200_acb: Provide more information on bus errors

Wolfram Sang (5):
      gpio/pcf857x: Copy i2c_device_id from old pcf8574 driver
      i2c/chips: Remove deprecated pcf8575 driver
      i2c/chips: Remove deprecated pca9539 driver
      i2c/chips: Remove deprecated pcf8574 driver
      MAINTAINERS: Add maintainer for AT24 and PCA9564/PCA9665

-- 
Jean Delvare
