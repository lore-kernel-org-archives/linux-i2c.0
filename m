From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' for-linus/2639/i2c-2 branch
Date: Mon, 21 Mar 2011 22:58:04 +0000
Message-ID: <E1Q1o32-0007kE-0x@freya>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit a952baa034ae7c2e4a66932005cbc7ebbccfe28d:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../dtor/input

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-linus/2639/i2c-2

Ben Dooks (2):
      Merge branch 'for-2639/i2c/i2c-u2c12' into for-linus/2639/i2c-12
      Merge branches 'for-2639/i2c/i2c-ce4100-v6', 'for-2639/i2c/i2c-eg20t-v3' and 'for-2639/i2c/i2c-imx' into for-linus/2639/i2c-2

Guenter Roeck (1):
      i2c/busses: Add support for Diolan U2C-12 USB-I2C adapter

Sascha Hauer (1):
      i2c-mxs: set controller to pio queue mode after reset

Sebastian Andrzej Siewior (6):
      i2c-pxa2xx: use dynamic register layout
      ARM: pxa2xx: reorganize I2C files
      i2c-pxa2xx: Add PCI support for PXA I2C controller
      i2c-pxa2xx: add support for shared IRQ handler
      i2c-pxa2xx: check timeout correctly
      i2c-pxa2xx: pass of_node from platform driver to adapter and publish

Tomoya MORINAGA (1):
      i2c-eg20t: support new device OKI SEMICONDUCTOR ML7213 IOH

Vasily Khoruzhick (1):
      i2c-pxa2xx: Fix register offsets

 Documentation/i2c/busses/i2c-diolan-u2c            |   26 +
 MAINTAINERS                                        |    6 +
 arch/arm/mach-mmp/include/mach/mmp2.h              |    2 +-
 arch/arm/mach-mmp/include/mach/pxa168.h            |    2 +-
 arch/arm/mach-mmp/include/mach/pxa910.h            |    2 +-
 arch/arm/mach-pxa/balloon3.c                       |    3 +-
 arch/arm/mach-pxa/cm-x300.c                        |    2 +-
 arch/arm/mach-pxa/colibri-evalboard.c              |    3 +-
 arch/arm/mach-pxa/colibri-pxa270-income.c          |    3 +-
 arch/arm/mach-pxa/corgi.c                          |    2 +-
 arch/arm/mach-pxa/csb726.c                         |    2 +-
 arch/arm/mach-pxa/devices.c                        |    2 +-
 arch/arm/mach-pxa/em-x270.c                        |    2 +-
 arch/arm/mach-pxa/ezx.c                            |    2 +-
 arch/arm/mach-pxa/hx4700.c                         |    2 +-
 arch/arm/mach-pxa/littleton.c                      |    2 +-
 arch/arm/mach-pxa/magician.c                       |    2 +-
 arch/arm/mach-pxa/mainstone.c                      |    2 +-
 arch/arm/mach-pxa/mioa701.c                        |    2 +-
 arch/arm/mach-pxa/mxm8x10.c                        |    2 +-
 arch/arm/mach-pxa/palm27x.c                        |    3 +-
 arch/arm/mach-pxa/pcm990-baseboard.c               |    2 +-
 arch/arm/mach-pxa/poodle.c                         |    2 +-
 arch/arm/mach-pxa/pxa27x.c                         |    3 +-
 arch/arm/mach-pxa/pxa3xx.c                         |    2 +-
 arch/arm/mach-pxa/pxa95x.c                         |    2 +-
 arch/arm/mach-pxa/raumfeld.c                       |    2 +-
 arch/arm/mach-pxa/saar.c                           |    2 +-
 arch/arm/mach-pxa/saarb.c                          |    3 +-
 arch/arm/mach-pxa/spitz.c                          |    3 +-
 arch/arm/mach-pxa/stargate2.c                      |    2 +-
 arch/arm/mach-pxa/tavorevb3.c                      |    3 +-
 arch/arm/mach-pxa/tosa.c                           |    2 +-
 arch/arm/mach-pxa/trizeps4.c                       |    2 +-
 arch/arm/mach-pxa/viper.c                          |    2 +-
 arch/arm/mach-pxa/vpac270.c                        |    3 +-
 arch/arm/mach-pxa/xcep.c                           |    3 +-
 arch/arm/mach-pxa/z2.c                             |    3 +-
 arch/arm/mach-pxa/zeus.c                           |    3 +-
 arch/arm/mach-pxa/zylonite_pxa300.c                |    2 +-
 drivers/i2c/busses/Kconfig                         |   32 +-
 drivers/i2c/busses/Makefile                        |    2 +
 drivers/i2c/busses/i2c-diolan-u2c.c                |  535 ++++++++++++++++++++
 drivers/i2c/busses/i2c-eg20t.c                     |  161 ++++---
 drivers/i2c/busses/i2c-mxs.c                       |    4 +-
 drivers/i2c/busses/i2c-pxa-pci.c                   |  176 +++++++
 drivers/i2c/busses/i2c-pxa.c                       |  116 ++++-
 .../plat/i2c.h => include/linux/i2c/pxa-i2c.h      |    0
 48 files changed, 998 insertions(+), 148 deletions(-)
 create mode 100644 Documentation/i2c/busses/i2c-diolan-u2c
 create mode 100644 drivers/i2c/busses/i2c-diolan-u2c.c
 create mode 100644 drivers/i2c/busses/i2c-pxa-pci.c
 rename arch/arm/plat-pxa/include/plat/i2c.h => include/linux/i2c/pxa-i2c.h (100%)
