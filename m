From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' i2c-fixes
Date: Fri, 01 Oct 2010 00:04:07 +0100
Message-ID: <E1P1SAZ-0001tp-ON@ben-laptop>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 4193d9163582b05e33aca3392e46649e5c3da8d1:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://oss.sgi.com/xfs/xfs

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-linus/i2c/2636-rc5

Bernhard Walle (1):
      i2c-octeon: Return -ETIMEDOUT in octeon_i2c_wait() on timeout

Jon Povey (1):
      i2c-davinci: Fix race when setting up for TX

MyungJoo Ham (1):
      i2c-s3c2410: fix calculation of SDA line delay

 drivers/i2c/busses/i2c-davinci.c |    6 +++---
 drivers/i2c/busses/i2c-octeon.c  |    2 +-
 drivers/i2c/busses/i2c-s3c2410.c |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)
