From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' for-2639-rc7/i2c-fixes branch
Date: Tue, 08 Mar 2011 23:16:33 +0000
Message-ID: <E1Px68n-0006ek-Sw@freya>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit fb62c00a6d8942775abc23d1621db1252e2d93d1:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../sage/ceph-client

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-2639-rc7/i2c-fixes

Grant Likely (1):
      i2c-ocores: Fix pointer type mismatch error

Rajendra Nayak (1):
      i2c-omap: Program I2C_WE on OMAP4 to enable i2c wakeup

Wolfram Sang (1):
      i2c-eg20t: include slab.h for memory allocations

 drivers/i2c/busses/i2c-eg20t.c  |    1 +
 drivers/i2c/busses/i2c-ocores.c |    2 +-
 drivers/i2c/busses/i2c-omap.c   |    4 +---
 3 files changed, 3 insertions(+), 4 deletions(-)
