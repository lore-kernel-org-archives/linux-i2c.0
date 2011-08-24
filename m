From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [PULL] Please pull i2c fixes
Date: Wed, 24 Aug 2011 23:30:25 +0100
Message-ID: <E1QwLxp-0001T7-ST@freya>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit a53e77fa57145cef6e2a63925db3d426128b2335:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid (2011-08-24 11:25:08 -0700)

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-31-rc3/i2c-fixes

Kevin Hilman (1):
      Revert "i2c-omap: fix static suspend vs. runtime suspend"

Linus Walleij (1):
      i2c-nomadik: fix kerneldoc warning

srinidhi kasagar (1):
      i2c-nomadik: Do not use _interruptible_ variant call

 drivers/i2c/busses/i2c-nomadik.c |    9 +++++----
 drivers/i2c/busses/i2c-omap.c    |   29 -----------------------------
 2 files changed, 5 insertions(+), 33 deletions(-)
