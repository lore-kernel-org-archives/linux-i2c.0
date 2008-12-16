From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdoo ks' i2c-fixes
Date: Tue, 16 Dec 2008 21:13:45 +0000
Message-ID: <E1LChEf-0000Ts-53@teyla.home.fluff.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 1bda71282ded6a2e09a2db7c8884542fb46bfd4f:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../ieee1394/linux1394-2.6

are available in the git repository at:

  git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-fixes

Ben Dooks (1):
      i2c-s3c2410: fix check for being in suspend.

Mike Ditto (1):
      i2c-cpm: Detect and report NAK right away instead of timing out

 drivers/i2c/busses/i2c-cpm.c     |    1 +
 drivers/i2c/busses/i2c-s3c2410.c |   18 +++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)
