From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: what's in bjdooks' for-linus/i2c (fyi)
Date: Tue, 20 Apr 2010 01:07:41 +0100
Message-ID: <E1O4109-0006Uz-RM@teyla.home.fluff.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit b66696e3c0d8fc01efdbc701eba1276618332cb3:
  Linus Torvalds (1):
        Merge branch 'slabh' of git://git.kernel.org/.../tj/misc

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-linus/i2c

Arnaud Patard (1):
      i2c-imx: fix error handling

Kevin Wells (2):
      i2c-pnx: Limit maximum divider to 1023
      i2c-pnx: Add stop conditions for end of transfer

Mika Westerberg (1):
      i2c-omap: fix OOPS in omap_i2c_unidle() during probe

 drivers/i2c/busses/i2c-imx.c  |    6 ++++--
 drivers/i2c/busses/i2c-omap.c |   10 +++++-----
 drivers/i2c/busses/i2c-pnx.c  |    8 ++++++++
 3 files changed, 17 insertions(+), 7 deletions(-)
