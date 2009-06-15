From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c updates for 2.6.31, part 1
Date: Mon, 15 Jun 2009 19:59:22 +0200
Message-ID: <20090615195922.3a9a6b5d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull a first set of i2c subsystem updates for Linux 2.6.31 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

More updates will come after the last legacy i2c driver (ir-kbd-i2c, a
V4L driver) has been converted.

 Documentation/i2c/busses/i2c-viapro          |    4 +
 arch/mips/configs/bigsur_defconfig           |    2 +-
 arch/mips/configs/mtx1_defconfig             |    2 +-
 arch/powerpc/configs/ppc6xx_defconfig        |    2 +-
 drivers/i2c/busses/Kconfig                   |    6 +-
 drivers/i2c/busses/i2c-viapro.c              |    4 +
 drivers/i2c/busses/i2c-voodoo3.c             |    1 -
 drivers/i2c/chips/Kconfig                    |   15 ---
 drivers/i2c/chips/Makefile                   |    1 -
 drivers/i2c/i2c-core.c                       |   43 ++++++---
 drivers/macintosh/therm_adt746x.c            |   84 +++++++++---------
 drivers/macintosh/therm_pm72.c               |   95 +++++++++----------
 drivers/macintosh/therm_windtunnel.c         |  126 ++++++++++++-------------
 drivers/macintosh/windfarm_lm75_sensor.c     |  129 +++++++++++++++-----------
 drivers/macintosh/windfarm_max6690_sensor.c  |  103 ++++++++++++---------
 drivers/macintosh/windfarm_smu_sat.c         |  109 +++++++++++++---------
 drivers/misc/eeprom/Kconfig                  |   14 +++
 drivers/misc/eeprom/Makefile                 |    1 +
 drivers/{i2c/chips => misc/eeprom}/max6875.c |    2 +-
 drivers/video/tdfxfb.c                       |    1 -
 20 files changed, 403 insertions(+), 341 deletions(-)
 rename drivers/{i2c/chips => misc/eeprom}/max6875.c (99%)

---------------

Clifford Wolf (1):
      i2c: Retry automatically on arbitration loss

Harald Welte (1):
      i2c-viapro: Add new PCI device ID for VX855

Jack Stone (1):
      i2c: Remove void casts

Jean Delvare (6):
      i2c: Do not probe for TV chips on Voodoo3 adapters
      i2c: Do not give adapters a default parent
      therm_pm72: Convert to a new-style i2c driver
      windfarm: Convert to new-style i2c drivers
      therm_adt746x: Convert to a new-style i2c driver
      therm_windtunnel: Convert to a new-style i2c driver

Wolfram Sang (1):
      i2c/chips: Move max6875 to drivers/misc/eeprom

Thanks,
-- 
Jean Delvare
