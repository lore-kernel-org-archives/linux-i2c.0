From: Ben Dooks <ben-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Subject: what is in bjdooks' i2c-for-2630 tree
Date: Fri, 27 Mar 2009 11:02:10 +0000
Message-ID: <E1Ln9pC-00037e-Qn@teyla.home.fluff.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dsilvers-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84:
  Linus Torvalds (1):
        Linux 2.6.29

are available in the git repository at:

  git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-for-2630

Ben Dooks (1):
      i2c-s3c2410: sda_delay should be in ns, not clock ticks

Daniel Silverstone (1):
      i2c: Simplify i2c-s3c2410 frequency calculator.

Darius Augulis (1):
      i2c: iMX/MXC support

 arch/arm/mach-s3c2410/mach-bast.c    |    3 +-
 arch/arm/mach-s3c2410/mach-n30.c     |    3 +-
 arch/arm/mach-s3c2412/mach-jive.c    |    3 +-
 arch/arm/plat-mxc/include/mach/i2c.h |   25 ++
 arch/arm/plat-s3c/dev-i2c0.c         |    7 +-
 arch/arm/plat-s3c/dev-i2c1.c         |    7 +-
 arch/arm/plat-s3c/include/plat/iic.h |   33 +-
 drivers/i2c/busses/Kconfig           |   10 +
 drivers/i2c/busses/Makefile          |    1 +
 drivers/i2c/busses/i2c-imx.c         |  617 ++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-s3c2410.c     |   74 ++---
 11 files changed, 710 insertions(+), 73 deletions(-)
 create mode 100644 arch/arm/plat-mxc/include/mach/i2c.h
 create mode 100644 drivers/i2c/busses/i2c-imx.c
