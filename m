From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Please pull bjdooks' i2c-fixes
Date: Tue, 12 May 2009 00:42:18 +0100
Message-ID: <E1M3f8U-0007Px-7I@kira.home.fluff.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 091438dd5668396328a3419abcbc6591159eb8d1:
  Linus Torvalds (1):
        Linux 2.6.30-rc4

are available in the git repository at:

  git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-for-2630-rc5

Mark Brown (1):
      i2c: Enable i2c-s3c2410 for S3C64XX too

Mark Ware (1):
      i2c-cpm: Pass dev ptr to dma_*_coherent rather than NULL

Roel Kluin (1):
      i2c-pxa.c: timeouts off by 1

Wolfgang Grandegger (1):
      i2c-mpc: bug fix for MPC52xx clock setting and printout

 drivers/i2c/busses/Kconfig   |    2 +-
 drivers/i2c/busses/i2c-cpm.c |   16 ++++++++--------
 drivers/i2c/busses/i2c-mpc.c |   34 ++++++++++++++++++++--------------
 drivers/i2c/busses/i2c-pxa.c |    6 +++---
 4 files changed, 32 insertions(+), 26 deletions(-)
