From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c updates for 2.6.33, round 1
Date: Sun, 6 Dec 2009 17:27:47 +0100
Message-ID: <20091206172747.6ad304d4@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull a first round of i2c subsystem updates for Linux 2.6.33
from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

There are many improvements to the i2c-powermac and i2c-stub bus
drivers, the removal of the deprecated i2c-voodoo3 driver, and the
first part of the I2C_CLIENT_INSMOD* macros removal.

 Documentation/feature-removal-schedule.txt |    9 -
 Documentation/i2c/busses/i2c-voodoo3       |   62 -------
 Documentation/i2c/i2c-stub                 |   16 ++-
 Documentation/i2c/old-module-parameters    |   44 +++++
 arch/powerpc/include/asm/pmac_low_i2c.h    |    6 +-
 arch/powerpc/platforms/powermac/low_i2c.c  |   25 +---
 drivers/i2c/Kconfig                        |    1 +
 drivers/i2c/busses/Kconfig                 |   16 --
 drivers/i2c/busses/Makefile                |    3 -
 drivers/i2c/busses/i2c-ali1535.c           |    2 +-
 drivers/i2c/busses/i2c-ali15x3.c           |    2 +-
 drivers/i2c/busses/i2c-i801.c              |    3 +
 drivers/i2c/busses/i2c-iop3xx.c            |    6 -
 drivers/i2c/busses/i2c-mv64xxx.c           |    3 -
 drivers/i2c/busses/i2c-powermac.c          |  139 ++++++++-------
 drivers/i2c/busses/i2c-sis5595.c           |    2 +-
 drivers/i2c/busses/i2c-sis630.c            |    2 +-
 drivers/i2c/busses/i2c-stub.c              |   34 ++++-
 drivers/i2c/busses/i2c-voodoo3.c           |  248 ----------------------------
 drivers/i2c/chips/Kconfig                  |   10 -
 drivers/i2c/chips/Makefile                 |    1 -
 drivers/i2c/i2c-core.c                     |  169 +++++---------------
 drivers/i2c/i2c-dev.c                      |   22 +--
 drivers/misc/Kconfig                       |   10 +
 drivers/misc/Makefile                      |    1 +
 drivers/{i2c/chips => misc}/ds1682.c       |    0
 drivers/misc/ics932s401.c                  |   37 ++---
 include/linux/i2c.h                        |   98 +-----------
 28 files changed, 248 insertions(+), 723 deletions(-)
 delete mode 100644 Documentation/i2c/busses/i2c-voodoo3
 create mode 100644 Documentation/i2c/old-module-parameters
 delete mode 100644 drivers/i2c/busses/i2c-voodoo3.c
 rename drivers/{i2c/chips => misc}/ds1682.c (100%)

---------------

Jean Delvare (16):
      i2c-powermac: Reject unsupported I2C transactions
      i2c-powermac: Refactor i2c_powermac_smbus_xfer
      i2c-powermac: Log errors
      i2c-powermac: Include the i2c_adapter in struct pmac_i2c_bus
      i2c-powermac: Drop temporary name buffer
      i2c-voodoo3: Delete
      i2c: Bus drivers don't have to support I2C_M_REV_DIR_ADDR
      i2c: Add missing __devinit markers to old i2c adapter drivers
      i2c: Drop probe, ignore and force module parameters
      i2c: Simplify i2c_detect_address
      ics932s401: Clean up detect function
      i2c-i801: Retry on lost arbitration
      i2c: Refactor for_each callbacks
      i2c-stub: Implement I2C block support
      i2c-stub: Allow user to disable some commands
      i2c-stub: Documentation update

Mika Kuoppala (1):
      i2c: Prevent priority inversion on top of bus lock

Vincent Sanders (1):
      i2c: Remove big kernel lock from i2cdev_open

Wolfram Sang (1):
      i2c/chips: Move ds1682 to drivers/misc

Thanks,
-- 
Jean Delvare
