From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c updates for 2.6.30
Date: Sat, 28 Mar 2009 21:39:50 +0100
Message-ID: <20090328213950.1c788471@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull the i2c subsystem updates for Linux 2.6.30 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus

This adds support for 6 new SMBus controllers (nVidia MCP67, MCP73,
MCP78S and MCP79, AMD SB800 and Broadcom HT1100), plus the usual amount
of cleanups and random improvements, in particular to the i2c-algo-pca
and i2c-algo-pcf drivers. Also a new document explaining the different
way I2C devices can be instantiated. No core changes.

 Documentation/feature-removal-schedule.txt |    3 +-
 Documentation/i2c/busses/i2c-nforce2       |   12 +-
 Documentation/i2c/busses/i2c-piix4         |    2 +-
 Documentation/i2c/instantiating-devices    |  167 ++++++++++++++++++
 Documentation/i2c/writing-clients          |   19 ++-
 arch/sh/boards/board-sh7785lcr.c           |    2 +-
 drivers/i2c/algos/i2c-algo-bit.c           |    4 +-
 drivers/i2c/algos/i2c-algo-pca.c           |  250 ++++++++++++++++++++++-----
 drivers/i2c/algos/i2c-algo-pcf.c           |  261 +++++++++++++---------------
 drivers/i2c/busses/Kconfig                 |    9 +-
 drivers/i2c/busses/i2c-davinci.c           |    8 +-
 drivers/i2c/busses/i2c-ibm_iic.c           |    6 +-
 drivers/i2c/busses/i2c-iop3xx.c            |    2 +-
 drivers/i2c/busses/i2c-mpc.c               |    4 +-
 drivers/i2c/busses/i2c-mv64xxx.c           |    7 +-
 drivers/i2c/busses/i2c-nforce2.c           |   12 +-
 drivers/i2c/busses/i2c-pca-isa.c           |   39 +++--
 drivers/i2c/busses/i2c-pca-platform.c      |   48 +++---
 drivers/i2c/busses/i2c-piix4.c             |   77 ++++++++-
 drivers/i2c/busses/i2c-powermac.c          |    3 +-
 drivers/i2c/busses/i2c-pxa.c               |    9 +-
 drivers/i2c/i2c-core.c                     |   36 +++--
 drivers/misc/eeprom/Kconfig                |    2 +-
 include/linux/i2c-algo-pca.h               |   33 ++++-
 include/linux/i2c-pca-platform.h           |    2 +-
 include/linux/pci_ids.h                    |    5 +
 26 files changed, 746 insertions(+), 276 deletions(-)
 create mode 100644 Documentation/i2c/instantiating-devices

---------------

Flavio Leitner (1):
      i2c-piix4: Add support for the Broadcom HT1100 chipset

Frank Seidel (2):
      i2c: Add missing KERN_* constants to printks
      i2c: Adapt debug macros for KERN_* constants

Jean Delvare (7):
      i2c: Document the different ways to instantiate i2c devices
      i2c: Let checkpatch shout on users of the legacy model
      i2c: Clarify which clients are auto-removed
      i2c-nforce2: Add support for MCP67, MCP73, MCP78S and MCP79
      i2c: Set a default timeout value for all adapters
      i2c: Adapter timeout is in jiffies
      i2c-davinci: Fix timeout handling

Marco Aurelio da Costa (1):
      i2c-algo-pca: Add PCA9665 support

Roel Kluin (2):
      i2c-algo-pcf: Style cleanups
      i2c-algo-pcf: Handle timeout correctly

Shane Huang (1):
      i2c-piix4: Add support to SB800 SMBus changes

Wolfram Sang (4):
      eeprom/at24: Remove EXPERIMENTAL
      i2c-algo-pca: Rework waiting for a free bus
      i2c-algo-pca: Use timeout for checking the state machine
      i2c-pca-platform: Use defaults if no platform_data given

Zhenwen Xu (1):
      i2c-core: Some style cleanups

Thanks,
-- 
Jean Delvare
