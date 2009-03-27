From: Ben Dooks <ben-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Subject: what is in bjdooks' i2c-for-2630 tree
Date: Fri, 27 Mar 2009 10:56:40 +0000
Message-ID: <E1Ln9js-00030o-8s@teyla.home.fluff.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84:
  Linus Torvalds (1):
        Linux 2.6.29

are available in the git repository at:

  git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-for-2630

Darius Augulis (1):
      [I2C] iMX/MXC support

 arch/arm/plat-mxc/include/mach/i2c.h |   25 ++
 drivers/i2c/busses/Kconfig           |   10 +
 drivers/i2c/busses/Makefile          |    1 +
 drivers/i2c/busses/i2c-imx.c         |  617 ++++++++++++++++++++++++++++++++++
 4 files changed, 653 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/include/mach/i2c.h
 create mode 100644 drivers/i2c/busses/i2c-imx.c
