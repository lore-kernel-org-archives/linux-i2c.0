From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' i2c-fixes
Date: Wed, 15 Jul 2009 00:06:39 +0100
Message-ID: <E1MQr55-00035T-Q2@kira.home.fluff.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 6847e154e3cd74fca6084124c097980a7634285a:
  Linus Torvalds (1):
        Linux 2.6.31-rc3

are available in the git repository at:

  git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-for-2631-rc3

David Brownell (1):
      i2c-davinci: behave with i2cdetect

Julia Lawall (1):
      i2c: Use resource_size

Kevin Hilman (1):
      i2c-davinci: convert clock usage after clkdev conversion

 drivers/i2c/busses/i2c-davinci.c   |   26 ++++++++++++++++++--------
 drivers/i2c/busses/i2c-omap.c      |    6 +++---
 drivers/i2c/busses/i2c-sh_mobile.c |    2 +-
 drivers/i2c/busses/i2c-simtec.c    |    2 +-
 4 files changed, 23 insertions(+), 13 deletions(-)
