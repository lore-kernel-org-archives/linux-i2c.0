From: Jean Delvare <khali@linux-fr.org>
Subject: [GIT PULL] i2c updates for 2.6.26
Date: Tue, 22 Apr 2008 22:54:58 +0200
Message-ID: <20080422225458.5779d2fb@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762958AbYDVU4R@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux I2C <i2c@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-i2c@vger.kernel.org

Linus,

Please pull the i2c subsystem updates for Linux 2.6.26 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus

There are 3 new I2C bus drivers (for the SuperH Mobile, the Renesas
SH7760 and the Philips PCA9564), many cleanups and improvements to the
i2c-bfin-twi (Blackfin) bus driver, and random fixes and cleanups.

 drivers/i2c/algos/Kconfig             |   39 +--
 drivers/i2c/algos/i2c-algo-pca.c      |  126 ++++----
 drivers/i2c/algos/i2c-algo-pca.h      |   26 --
 drivers/i2c/busses/Kconfig            |   73 +++--
 drivers/i2c/busses/Makefile           |    3 +
 drivers/i2c/busses/i2c-at91.c         |    2 +-
 drivers/i2c/busses/i2c-au1550.c       |    1 +
 drivers/i2c/busses/i2c-bfin-twi.c     |  475 +++++++++++++++++----------
 drivers/i2c/busses/i2c-davinci.c      |    9 +-
 drivers/i2c/busses/i2c-gpio.c         |    1 +
 drivers/i2c/busses/i2c-ibm_iic.c      |  197 +++++++++++-
 drivers/i2c/busses/i2c-iop3xx.c       |    1 +
 drivers/i2c/busses/i2c-ixp2000.c      |    1 +
 drivers/i2c/busses/i2c-mpc.c          |    3 +
 drivers/i2c/busses/i2c-ocores.c       |    3 +
 drivers/i2c/busses/i2c-omap.c         |    1 +
 drivers/i2c/busses/i2c-pca-isa.c      |   53 ++--
 drivers/i2c/busses/i2c-pca-platform.c |  298 +++++++++++++++++
 drivers/i2c/busses/i2c-pmcmsp.c       |    7 +-
 drivers/i2c/busses/i2c-pnx.c          |   45 ++--
 drivers/i2c/busses/i2c-powermac.c     |    3 +
 drivers/i2c/busses/i2c-pxa.c          |    3 +-
 drivers/i2c/busses/i2c-s3c2410.c      |    5 +-
 drivers/i2c/busses/i2c-sh7760.c       |  577 +++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-sh_mobile.c    |  500 ++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-simtec.c       |    3 +
 drivers/i2c/busses/i2c-versatile.c    |    1 +
 drivers/i2c/busses/scx200_acb.c       |    2 +-
 drivers/i2c/chips/isp1301_omap.c      |   28 +-
 drivers/i2c/i2c-core.c                |    2 +-
 drivers/i2c/i2c-dev.c                 |  329 ++++++++++---------
 include/asm-sh/i2c-sh7760.h           |   22 ++
 include/linux/i2c-algo-pca.h          |   37 ++-
 include/linux/i2c-pca-platform.h      |   12 +
 34 files changed, 2313 insertions(+), 575 deletions(-)
 delete mode 100644 drivers/i2c/algos/i2c-algo-pca.h
 create mode 100644 drivers/i2c/busses/i2c-pca-platform.c
 create mode 100644 drivers/i2c/busses/i2c-sh7760.c
 create mode 100644 drivers/i2c/busses/i2c-sh_mobile.c
 create mode 100644 include/asm-sh/i2c-sh7760.h
 create mode 100644 include/linux/i2c-pca-platform.h

---------------

Adrian Bunk (1):
      i2c/scx200_acb: Don't use 0 as NULL pointer

Bryan Wu (4):
      i2c-bfin-twi: Add platform_resource interface to support multi-port TWI controllers
      i2c-bfin-twi: Add missing pin mux operation
      i2c-bfin-twi: Cleanup driver descriptions, versions and some module useful information
      i2c-bfin-twi: Just let i2c-bfin-twi driver depends on BLACKFIN

Hans Schillstrom (1):
      i2c-bfin-twi: Fix mismatch in add timer and delete timer

Harvey Harrison (1):
      i2c: Replace remaining __FUNCTION__ occurrences

Jean Delvare (2):
      i2c: Remove the algorithm drivers from the config menu
      i2c-dev: Split i2cdev_ioctl

Kay Sievers (1):
      i2c: Fix platform driver hotplug/coldplug

Magnus Damm (1):
      i2c: New driver for the SuperH Mobile I2C bus controller

Manuel Lauss (1):
      i2c: Renesas SH7760 I2C master driver

Mike Frysinger (1):
      i2c-bfin-twi: Use simpler comment headers and strip out information that is maintained in the scm's log

Sean MacLennan (2):
      i2c-ibm_iic: Change the log levels
      i2c-ibm_iic: Support building as an of_platform driver

Sonic Zhang (1):
      i2c-bfin-twi: Add repeat start feature to avoid break of a bundle of i2c master xfer operation

Wolfram Sang (4):
      i2c-algo-pca: Remove trailing whitespaces and unnecessary UTF
      i2c-algo-pca: Extend for future drivers
      i2c: Add platform driver on top of the new pca-algorithm
      i2c: Remove trailing whitespaces in busses/Kconfig

I hope to have another round of i2c patches for 2.6.26 before rc1.

Thanks,
-- 
Jean Delvare
