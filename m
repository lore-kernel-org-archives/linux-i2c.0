From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: current -next tree from bjdooks
Date: Tue, 4 Jan 2011 01:30:05 +0000
Message-ID: <20110104013005.GE817@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Updated my next tree, and published it. I've included a pull-request
as an overview. Please review and re-post anything that either was
asked to be reviewed and has been sorted, or items that are missing.

The following changes since commit 03ed6a3aa600c48593c3984812fda2d5945ddb46:

  Merge branch 'perf-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip (2011-01-03 11:51:22 -0800)

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git next-i2c

Aaro Koskinen (1):
      i2c-iop3xx: add iomem annotation

Ben Dooks (5):
      Merge branch 'for-2638/i2c/iop' into next-i2c
      Merge branch 'for-2638/i2c/mv64xx' into next-i2c
      Merge branch 'for-2638/i2c/nomadik' into next-i2c
      Merge branch 'for-2638/i2c/ocores' into next-i2c
      Merge branch 'for-2638/i2c/omap' into next-i2c

Jonas Bonn (3):
      i2c-ocores: Adapt for device tree
      i2c-ocores: Use devres for resource allocation
      i2c-ocores: add some device tree documentation

Linus Walleij (1):
      i2c-nomadik: fix regression on adapter name

Rodolfo Giometti (1):
      i2c-mv64xxx: send repeated START between messages in xfer

Samu Onkalo (1):
      i2c-omap: Set latency requirements only once for several messages

Tomoya MORINAGA (1):
      i2c-eg20t: add driver for Intel EG20T

 drivers/i2c/busses/Kconfig       |    8 +
 drivers/i2c/busses/Makefile      |    1 +
 drivers/i2c/busses/i2c-eg20t.c   |  900 ++++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-iop3xx.c  |    6 +-
 drivers/i2c/busses/i2c-iop3xx.h  |    2 +-
 drivers/i2c/busses/i2c-mv64xxx.c |   45 ++-
 drivers/i2c/busses/i2c-nomadik.c |    6 +-
 drivers/i2c/busses/i2c-ocores.c  |  145 +++++--
 drivers/i2c/busses/i2c-omap.c    |   10 +-
 9 files changed, 1063 insertions(+), 60 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-eg20t.c

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
