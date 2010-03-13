From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c fixes for 2.6.34
Date: Sat, 13 Mar 2010 22:51:57 +0100
Message-ID: <20100313225157.34190a35@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem fixes for Linux 2.6.34 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

 drivers/i2c/Kconfig                   |    9 ---------
 drivers/i2c/Makefile                  |    2 +-
 drivers/i2c/algos/i2c-algo-bit.c      |    9 +++++++++
 drivers/i2c/busses/i2c-i801.c         |    6 ++++--
 drivers/i2c/busses/i2c-powermac.c     |   25 ++++++++++++++++++-------
 drivers/i2c/chips/Kconfig             |   19 -------------------
 drivers/i2c/chips/Makefile            |   18 ------------------
 drivers/i2c/i2c-smbus.c               |    5 ++---
 drivers/misc/Kconfig                  |   10 ++++++++++
 drivers/misc/Makefile                 |    1 +
 drivers/misc/eeprom/at24.c            |    1 +
 drivers/{i2c/chips => misc}/tsl2550.c |    4 ++--
 include/linux/i2c-algo-bit.h          |    2 ++
 13 files changed, 50 insertions(+), 61 deletions(-)
 delete mode 100644 drivers/i2c/chips/Kconfig
 delete mode 100644 drivers/i2c/chips/Makefile
 rename drivers/{i2c/chips => misc}/tsl2550.c (99%)

---------------

Jean Delvare (5):
      i2c-powermac: Be less verbose in the absence of real errors.
      i2c-i801: Don't use the block buffer for I2C block writes
      tsl2550: Move from i2c/chips to misc
      i2c: Drop configure option I2C_DEBUG_CHIP
      i2c-algo-bit: Add pre- and post-xfer hooks

Stephen Rothwell (1):
      i2c-smbus: Use device_lock/device_unlock

Wolfram Sang (1):
      at24: Init dynamic bin_attribute structures

Thanks,
-- 
Jean Delvare
