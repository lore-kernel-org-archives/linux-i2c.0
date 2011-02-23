From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Current i2c-next
Date: Wed, 23 Feb 2011 01:15:33 +0000
Message-ID: <E1Ps3KH-00028m-UF@freya>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit d8204a37baf5474d3154eb536c936369be2bd5c0:
  Linus Torvalds (1):
        Merge branch 'urgent' of git://git.kernel.org/.../brodo/pcmcia-2.6

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git next-i2c

Balaji T K (1):
      i2c-omap: fix build for !CONFIG_SUSPEND

Ben Dooks (3):
      i2c-omap: fixup commit cb527ede1bf6ff2008a025606f25344b8ed7b4ac whitespace
      Merge branch 'for-2639/i2c/i2c-tegra' into next-i2c
      Merge branch 'for-2639/i2c/i2c-imx' into next-i2c

Colin Cross (1):
      i2c: tegra: Add i2c support

Guenter Roeck (1):
      i2c/busses: Add support for Diolan U2C-12 USB-I2C adapter

Kevin Hilman (1):
      i2c-omap: fix static suspend vs. runtime suspend

Richard woodruff (1):
      i2c-omap: Double clear of ARDY status in IRQ handler

Wolfram Sang (2):
      i2c-stu300: make sure adapter-name is terminated
      i2c: add driver for Freescale i.MX28

 Documentation/i2c/busses/i2c-diolan-u2c |   26 ++
 MAINTAINERS                             |    6 +
 drivers/i2c/busses/Kconfig              |   27 ++
 drivers/i2c/busses/Makefile             |    3 +
 drivers/i2c/busses/i2c-diolan-u2c.c     |  535 +++++++++++++++++++++++
 drivers/i2c/busses/i2c-mxs.c            |  412 ++++++++++++++++++
 drivers/i2c/busses/i2c-omap.c           |   35 ++-
 drivers/i2c/busses/i2c-stu300.c         |    2 +-
 drivers/i2c/busses/i2c-tegra.c          |  700 +++++++++++++++++++++++++++++++
 include/linux/i2c-tegra.h               |   25 ++
 10 files changed, 1769 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/i2c/busses/i2c-diolan-u2c
 create mode 100644 drivers/i2c/busses/i2c-diolan-u2c.c
 create mode 100644 drivers/i2c/busses/i2c-mxs.c
 create mode 100644 drivers/i2c/busses/i2c-tegra.c
 create mode 100644 include/linux/i2c-tegra.h
