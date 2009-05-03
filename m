From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: i2c fixes for 2.6.30-rc5
Date: Sun, 3 May 2009 23:36:56 +0100
Message-ID: <20090503223656.GA12866@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Currently, I've got the following in my tree, if anyone
thinks i've missed anything, then let me know before the end
of Tuesday (5th) and I'll add it to the pull request.

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
      i2c: i2c-mpc: bug fix for MPC52xx clock setting and printout

 drivers/i2c/busses/Kconfig   |    2 +-
 drivers/i2c/busses/i2c-cpm.c |   16 ++++++++--------
 drivers/i2c/busses/i2c-mpc.c |   34 ++++++++++++++++++++--------------
 drivers/i2c/busses/i2c-pxa.c |    6 +++---
 4 files changed, 32 insertions(+), 26 deletions(-)
