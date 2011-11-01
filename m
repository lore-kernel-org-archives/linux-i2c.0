From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' for-linus/i2c-3.2 branch
Date: Tue, 01 Nov 2011 00:58:03 +0000
Message-ID: <E1RL2fz-0005r0-Ih@freya>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 1fdb24e969110fafea36d3b393bea438f702c87f:

  Merge branch 'devel-stable' of http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm (2011-10-28 12:02:27 -0700)

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-linus/i2c-3.2

Andy Green (12):
      I2C: OMAP2+: Name registers in I2C IP V2 only accordingly
      I2C: OMAP: add rev to omap i2c platform data
      I2C: OMAP1: set IP revision in platform data
      I2C: OMAP2+: Pass hwmod rev knowledge via platform_data when i2c bus added
      I2C: OMAP2+: use platform_data ip revision to select register map
      I2C: OMAP2+: Solve array bounds overflow error on i2c idle
      I2C: OMAP2+: address confused probed version naming
      I2C: OMAP1/OMAP2+: add flags field to omap i2c platform data
      I2C: OMAP2+: Pass flags up to omap i2c platform_data as well
      I2C: OMAP1: set i2c unit feature implementation flags in platform data
      I2C: OMAP2+: Convert omap I2C driver to use feature implementation flags from platform data
      I2C: OMAP1/OMAP2+: prepend I2C IP version to probed version shown in dev_info

Ben Dooks (3):
      Merge branches 'for-32/i2c/omap-v4', 'for-32/i2c/imx-dt', 'for-32/i2c/eg20t-v4', 'for-32/i2c/designware-v5' and 'for-32/i2c/au1550' into for-linus/i2c-3.2
      Merge branch 'for-32/i2c/irqflags' into for-linus/i2c-3.2
      Merge branches 'for-32/i2c/nomadik', 'for-32/i2c/s3c2410-dt' and 'for-32/i2c/tegra-iomem' into for-linus/i2c-3.2

Dirk Brandewie (9):
      i2c-designware: Move checking of IP core version to i2c_dw_init()
      i2c-designware: split of i2c-designware.c into core and bus specific parts
      i2c-designware: Move retriveving the clock speed out of core code.
      i2c-designware: move i2c functionality bit field to be adapter specific
      i2c-designware: move controller config to bus specific portion of driver
      i2c-designware: Support multiple cores using same ISR
      i2c-designware: Push all register reads/writes into the core code.
      i2c-designware: Add support for Designware core behind PCI devices.
      i2c-designware: Add runtime power management support

Jean-Hugues Deschenes (3):
      i2c-designware: Use local version of readl & writel
      i2c-designware: Check component type register
      i2c-designware: Allow mixed endianness accesses

Jonas Aaberg (1):
      i2c-nomadik: cosmetic coding style corrections

Kevin Hilman (3):
      I2C: OMAP: remove unneccesary use of pdev
      I2C: OMAP: remove dev->idle, use usage counting provided by runtime PM
      I2C: OMAP: remove unused function pointers from pdata

Manuel Lauss (4):
      i2c-au1550: remove usage of volatile keyword
      i2c-au1550: remove unused ack_timeout
      i2c-au1550: increase timeout waiting for master done
      i2c-au1550: dev_pm_ops conversion

Octavian Purdila (1):
      i2c-designware: Fix PCI core warning on suspend/resume

Olof Johansson (1):
      i2c-tegra: __iomem annotation fix

Shawn Guo (2):
      i2c-imx: remove init/exit hooks from platform data
      i2c-imx: add device tree probe support

Shubhrajyoti D (1):
      OMAP4: I2C: Enable the wakeup in I2C_WE

Thomas Abraham (2):
      i2c-s3c2410: Keep a copy of platform data and use it
      i2c-s3c2410: Add device tree support

Tomoya MORINAGA (7):
      i2c-eg20t: Fix bus-idle waiting issue
      i2c-eg20t: Modify returned value s32 to long
      i2c-eg20t: Fix 10bit access issue
      i2c-eg20t: Separate error processing
      i2c-eg20t: add stop sequence in case wait-event timeout occurs
      i2c-eg20t: Fix flag setting issue
      i2c-eg20t: Add initialize processing in case i2c-error occurs

Yong Zhang (1):
      i2c: irq: Remove IRQF_DISABLED

 .../devicetree/bindings/i2c/fsl-imx-i2c.txt        |   25 ++
 .../devicetree/bindings/i2c/samsung-i2c.txt        |   39 ++
 arch/arm/plat-mxc/include/mach/i2c.h               |    4 -
 arch/arm/plat-omap/i2c.c                           |   27 ++
 arch/mips/include/asm/mach-au1x00/au1xxx_psc.h     |   13 -
 drivers/i2c/busses/Kconfig                         |   16 +-
 drivers/i2c/busses/Makefile                        |    5 +-
 drivers/i2c/busses/i2c-au1550.c                    |  280 ++++++---------
 drivers/i2c/busses/i2c-bfin-twi.c                  |    4 +-
 .../{i2c-designware.c => i2c-designware-core.c}    |  382 ++++++-------------
 drivers/i2c/busses/i2c-designware-core.h           |  105 ++++++
 drivers/i2c/busses/i2c-designware-pcidrv.c         |  392 ++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-platdrv.c        |  215 +++++++++++
 drivers/i2c/busses/i2c-eg20t.c                     |  270 ++++++++++----
 drivers/i2c/busses/i2c-highlander.c                |    2 +-
 drivers/i2c/busses/i2c-imx.c                       |   46 ++--
 drivers/i2c/busses/i2c-nomadik.c                   |   91 +++---
 drivers/i2c/busses/i2c-nuc900.c                    |    2 +-
 drivers/i2c/busses/i2c-omap.c                      |  164 +++++----
 drivers/i2c/busses/i2c-pmcmsp.c                    |    2 +-
 drivers/i2c/busses/i2c-s3c2410.c                   |  130 ++++++-
 drivers/i2c/busses/i2c-sh7760.c                    |    2 +-
 drivers/i2c/busses/i2c-sh_mobile.c                 |    2 +-
 drivers/i2c/busses/i2c-stu300.c                    |    2 +-
 drivers/i2c/busses/i2c-tegra.c                     |    2 +-
 include/linux/i2c-omap.h                           |    5 +-
 26 files changed, 1543 insertions(+), 684 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/fsl-imx-i2c.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/samsung-i2c.txt
 rename drivers/i2c/busses/{i2c-designware.c => i2c-designware-core.c} (65%)
 create mode 100644 drivers/i2c/busses/i2c-designware-core.h
 create mode 100644 drivers/i2c/busses/i2c-designware-pcidrv.c
 create mode 100644 drivers/i2c/busses/i2c-designware-platdrv.c
