From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' for-linus/i2c
Date: Wed, 21 Apr 2010 23:48:13 +0100
Message-ID: <E1O4iiL-00037h-Ke@teyla.home.fluff.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 01bf0b64579ead8a82e7cfc32ae44bc667e7ad0f:
  Linus Torvalds (1):
        Linux 2.6.34-rc5

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-linus/i2c

Arnaud Patard (1):
      i2c-imx: fix error handling

Dan Carpenter (1):
      i2c-stu300: off by one issue

Kevin Wells (2):
      i2c-pnx: Limit maximum divider to 1023
      i2c-pnx: Add stop conditions for end of transfer

Mika Westerberg (1):
      i2c-omap: fix OOPS in omap_i2c_unidle() during probe

 drivers/i2c/busses/i2c-imx.c    |    6 ++++--
 drivers/i2c/busses/i2c-omap.c   |   10 +++++-----
 drivers/i2c/busses/i2c-pnx.c    |    8 ++++++++
 drivers/i2c/busses/i2c-stu300.c |    2 +-
 4 files changed, 18 insertions(+), 8 deletions(-)
