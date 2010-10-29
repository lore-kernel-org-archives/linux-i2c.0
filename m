From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [PULL] bjdooks' i2c tree
Date: Fri, 29 Oct 2010 23:55:09 +0100
Message-ID: <E1PBxqn-0001Dv-Qg@ben-laptop>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit b18cae4224bde7e5a332c19bc99247b2098ea232:
  Linus Torvalds (1):
        Merge branch 'for-next' of git://android.git.kernel.org/kernel/tegra

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-2637/i2c-all

Alan Cox (1):
      i2c-intel-mid: support for Moorestown and Medfield platform

Arnaud Patard (1):
      i2c-s3c2410: Enable i2c clock only when doing some transfert

Ben Dooks (2):
      Merge branch 'for-2637/i2c/i2c-nomadik' into next-i2c
      Merge branch 'for-2637/i2c/samsung' into next-i2c

Linus Walleij (4):
      i2c-nomadik: documentation fixes
      i2c-nomadik: dynamic clocking
      i2c-nomadik: support smbus emulation
      i2c-nomadik: fixup bus delays

Randy Dunlap (1):
      i2c-intel-mid: Driver depends on PCI

 drivers/i2c/busses/Kconfig         |   10 +
 drivers/i2c/busses/Makefile        |    1 +
 drivers/i2c/busses/i2c-intel-mid.c | 1135 ++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-nomadik.c   |   36 +-
 drivers/i2c/busses/i2c-s3c2410.c   |   10 +-
 5 files changed, 1176 insertions(+), 16 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-intel-mid.c
