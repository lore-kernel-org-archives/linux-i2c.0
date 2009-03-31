From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' i2c tree
Date: Tue, 31 Mar 2009 23:50:40 +0100
Message-ID: <E1Lomn2-0002o8-Vo@teyla.home.fluff.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84:
  Linus Torvalds (1):
        Linux 2.6.29

are available in the git repository at:

  git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-for-2630

Ben Dooks (1):
      i2c-s3c2410: sda_delay should be in ns, not clock ticks

Daniel Silverstone (1):
      i2c-s3c2410: Simplify bus frequency calculation

Darius Augulis (2):
      i2c: iMX/MXC support
      i2c: imx: Add missing request_mem_region in probe()

Mark Brown (1):
      i2c: i2c-s3c2410: Initialise Samsung I2C controller early

 arch/arm/mach-s3c2410/mach-bast.c    |    3 +-
 arch/arm/mach-s3c2410/mach-n30.c     |    3 +-
 arch/arm/mach-s3c2412/mach-jive.c    |    3 +-
 arch/arm/plat-mxc/include/mach/i2c.h |   25 ++
 arch/arm/plat-s3c/dev-i2c0.c         |    7 +-
 arch/arm/plat-s3c/dev-i2c1.c         |    7 +-
 arch/arm/plat-s3c/include/plat/iic.h |   33 +-
 drivers/i2c/busses/Kconfig           |   10 +
 drivers/i2c/busses/Makefile          |    1 +
 drivers/i2c/busses/i2c-imx.c         |  625 ++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-s3c2410.c     |   77 ++---
 11 files changed, 720 insertions(+), 74 deletions(-)
 create mode 100644 arch/arm/plat-mxc/include/mach/i2c.h
 create mode 100644 drivers/i2c/busses/i2c-imx.c
