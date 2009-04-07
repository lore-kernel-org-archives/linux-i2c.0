From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: pull request for bjdooks' i2c tree
Date: Tue, 7 Apr 2009 11:00:13 +0100
Message-ID: <20090407100012.GA13800@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi, Linus.

It seems my previous request for 'i2c-for-2630' has been lost, please
consider this new pull request 'i2c-for-2630-v2' which has additional
driver and cleanup patches.

The following changes since commit d508afb437daee7cf07da085b635c44a4ebf9b38:
  Trond Myklebust (1):
        NFS: Fix a double free in nfs_parse_mount_options()

are available in the git repository at:

  git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-for-2630-v2

Ben Dooks (1):
      i2c-s3c2410: sda_delay should be in ns, not clock ticks

Daniel Silverstone (1):
      i2c-s3c2410: Simplify bus frequency calculation

Darius Augulis (2):
      i2c: iMX/MXC support
      i2c: imx: Add missing request_mem_region in probe()

Mark Brown (1):
      i2c: i2c-s3c2410: Initialise Samsung I2C controller early

Oskar Schirmer (1):
      i2c: xtensa s6000 i2c driver

Wolfgang Grandegger (4):
      i2c: i2c-mpc: various coding style fixes
      i2c: i2c-mpc: use dev based printout function
      i2c: i2c-mpc: make I2C bus speed configurable
      powerpc/85xx: i2c-mpc: use new I2C bindings for the Socates board

Wolfram Sang (1):
      i2c: imx: Make disable_delay a per-device variable

 arch/arm/mach-s3c2410/mach-bast.c    |    3 +-
 arch/arm/mach-s3c2410/mach-n30.c     |    3 +-
 arch/arm/mach-s3c2412/mach-jive.c    |    3 +-
 arch/arm/plat-mxc/include/mach/i2c.h |   25 ++
 arch/arm/plat-s3c/dev-i2c0.c         |    7 +-
 arch/arm/plat-s3c/dev-i2c1.c         |    7 +-
 arch/arm/plat-s3c/include/plat/iic.h |   33 +-
 arch/powerpc/boot/dts/socrates.dts   |    8 +-
 drivers/i2c/busses/Kconfig           |   20 ++
 drivers/i2c/busses/Makefile          |    2 +
 drivers/i2c/busses/i2c-imx.c         |  624 ++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-mpc.c         |  322 +++++++++++++++---
 drivers/i2c/busses/i2c-s3c2410.c     |   77 ++---
 drivers/i2c/busses/i2c-s6000.c       |  407 ++++++++++++++++++++++
 drivers/i2c/busses/i2c-s6000.h       |   79 +++++
 include/linux/i2c/s6000.h            |   10 +
 16 files changed, 1504 insertions(+), 126 deletions(-)
 create mode 100644 arch/arm/plat-mxc/include/mach/i2c.h
 create mode 100644 drivers/i2c/busses/i2c-imx.c
 create mode 100644 drivers/i2c/busses/i2c-s6000.c
 create mode 100644 drivers/i2c/busses/i2c-s6000.h
 create mode 100644 include/linux/i2c/s6000.h
