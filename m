From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [PULL] Please pull i2c fixes
Date: Fri, 08 Jul 2011 00:07:03 +0100
Message-ID: <E1Qexex-0007jg-Ai@freya>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit af4087e0e682df12bdffec5cfafc2fec9208716e:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mason/btrfs-unstable (2011-06-27 13:32:14 -0700)

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-30-rc5/all-i2c

Ben Dooks (1):
      Merge branches 'for-30-rc4/i2c-bfin', 'for-30-rc4/i2c-omap', 'for-30-rc4/i2c-s3c' and 'for-30-rc4/i2c-tegra' into for-30-rc5/all-i2c

Huisung Kang (1):
      i2c-s3c2410: Fix typo 'i2s' -> 'i2c'

Jonghwan Choi (1):
      i2c-s3c2410: Remove useless break code

Sonic Zhang (1):
      i2c-bfin-twi: abort transfer is MEM bit is reset unexpectedly

Stephen Warren (1):
      i2c: tegra: Assign unused slave address

 drivers/i2c/busses/i2c-bfin-twi.c |    8 +++++++-
 drivers/i2c/busses/i2c-s3c2410.c  |    7 +++----
 drivers/i2c/busses/i2c-tegra.c    |    8 +++++++-
 3 files changed, 17 insertions(+), 6 deletions(-)
