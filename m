From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' i2c-fixes
Date: Thu, 24 Dec 2009 01:59:47 +0000
Message-ID: <E1NNczT-0002xL-Tg@teyla.home.fluff.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit c9f937e4a3f4ebf9924ec21d80632e5eb61d949c:
  Linus Torvalds (1):
        Merge branch 'upstream-linus' of git://git.kernel.org/.../jgarzik/libata-dev

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git i2c-fixes

Cory Maccarrone (1):
      i2c-omap: Don't write IE state in unidle if 0

Manjunatha GK (1):
      i2c-omap: OMAP3: Fix I2C lockup during timeout/error cases

Sonic Zhang (1):
      i2c-bfin-twi: fix CLKDIV calculation

 drivers/i2c/busses/i2c-bfin-twi.c |    6 +++---
 drivers/i2c/busses/i2c-omap.c     |   13 ++++++++++++-
 2 files changed, 15 insertions(+), 4 deletions(-)
