From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' i2c tree
Date: Tue, 16 Jun 2009 22:45:10 +0100
Message-ID: <E1MGgSs-00047f-5Z@kira.home.fluff.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: apkm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 300df7dc89cc276377fc020704e34875d5c473b6:
  Linus Torvalds (1):
        Merge branch 'upstream-linus' of git://git.kernel.org/.../jlbec/ocfs2

are available in the git repository at:

  git://aeryn.fluff.org.uk/bjdooks/linux.git next-i2c

Ben Dooks (1):
      i2c-s3c2410: use resource_size()

Linus Walleij (3):
      i2c: ST DDC I2C U300 bus driver v3
      i2c: Use resource_size macro
      i2c-stu300: Make driver depend on MACH_U300

Mike Frysinger (1):
      i2c-bfin-twi: pull in io.h for ioremap()

 drivers/i2c/busses/Kconfig            |   13 +
 drivers/i2c/busses/Makefile           |    1 +
 drivers/i2c/busses/i2c-at91.c         |    8 +-
 drivers/i2c/busses/i2c-au1550.c       |    2 +-
 drivers/i2c/busses/i2c-bfin-twi.c     |    3 +-
 drivers/i2c/busses/i2c-highlander.c   |    2 +-
 drivers/i2c/busses/i2c-mv64xxx.c      |    2 +-
 drivers/i2c/busses/i2c-ocores.c       |    8 +-
 drivers/i2c/busses/i2c-omap.c         |    2 +-
 drivers/i2c/busses/i2c-pca-platform.c |   10 +-
 drivers/i2c/busses/i2c-pmcmsp.c       |    8 +-
 drivers/i2c/busses/i2c-pxa.c          |    9 +-
 drivers/i2c/busses/i2c-s3c2410.c      |    4 +-
 drivers/i2c/busses/i2c-stu300.c       | 1029 +++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-versatile.c    |    6 +-
 15 files changed, 1074 insertions(+), 33 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-stu300.c
