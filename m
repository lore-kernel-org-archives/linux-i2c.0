From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' for-linus/2639/i2c-1 branch
Date: Thu, 17 Mar 2011 10:36:08 +0000
Message-ID: <E1Q0AYq-00041e-Mp@freya>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 78f9bbb5a6f41fcb7934848c7821b99718f7e338:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../davem/net-2.6

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-linus/2639/i2c-1

Ben Dooks (1):
      Merge branches 'for-2639/i2c/i2c-tegra', 'for-2639/i2c/i2c-mpc' and 'for-2639/i2c/i2c-imx' into for-linus/2639/i2c-1

Colin Cross (1):
      i2c: tegra: Add i2c support

Kumar Gala (1):
      i2c-mpc: Add support for 64bit system

Wolfram Sang (1):
      i2c: add driver for Freescale i.MX28

 drivers/i2c/busses/Kconfig     |   19 +-
 drivers/i2c/busses/Makefile    |    2 +
 drivers/i2c/busses/i2c-mxs.c   |  412 +++++++++++++++++++++++
 drivers/i2c/busses/i2c-tegra.c |  700 ++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c-tegra.h      |   25 ++
 5 files changed, 1157 insertions(+), 1 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-mxs.c
 create mode 100644 drivers/i2c/busses/i2c-tegra.c
 create mode 100644 include/linux/i2c-tegra.h
