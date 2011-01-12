From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [pull] Please pull bjdooks' i2c git
Date: Wed, 12 Jan 2011 22:29:04 +0000
Message-ID: <E1Pd9Bg-0001Lb-SI@ben-laptop>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit f878133bf022717b880d0e0995b8f91436fd605c:

  Merge branch 'drm-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6 (2011-01-12 08:40:25 -0800)

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-linus/i2c-2638

Aaro Koskinen (1):
      i2c-iop3xx: add iomem annotation

Ben Dooks (7):
      Merge branch 'for-2638/i2c/mv64xx' into for-linus/i2c-2638
      Merge branch 'for-2638/i2c/omap' into for-linus/i2c-2638
      Merge branch 'for-2638/i2c/iop' into for-linus/i2c-2638
      Merge branch 'for-2638/i2c/ocores' into for-linus/i2c-2638
      Merge branch 'for-2638/i2c/intel' into for-linus/i2c-2638
      Merge branch 'for-2638/i2c/nomadik' into for-linus/i2c-2638
      Merge branch 'for-2638/i2c/bfin2' into for-linus/i2c-2638

Jonas Bonn (3):
      i2c-ocores: Adapt for device tree
      i2c-ocores: Use devres for resource allocation
      i2c-ocores: add some device tree documentation

Linus Walleij (1):
      i2c-nomadik: fix regression on adapter name

Michael Hennerich (2):
      i2c-bfin-twi: handle faulty slave devices better
      i2c-bfin-twi: move setup to the earlier subsys initcall

Rodolfo Giometti (1):
      i2c-mv64xxx: send repeated START between messages in xfer

Samu Onkalo (1):
      i2c-omap: Set latency requirements only once for several messages

Tomoya MORINAGA (1):
      i2c-eg20t: add driver for Intel EG20T

 drivers/i2c/busses/Kconfig        |    8 +
 drivers/i2c/busses/Makefile       |    1 +
 drivers/i2c/busses/i2c-bfin-twi.c |   24 +-
 drivers/i2c/busses/i2c-eg20t.c    |  900 +++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-iop3xx.c   |    6 +-
 drivers/i2c/busses/i2c-iop3xx.h   |    2 +-
 drivers/i2c/busses/i2c-mv64xxx.c  |   45 ++-
 drivers/i2c/busses/i2c-nomadik.c  |    6 +-
 drivers/i2c/busses/i2c-ocores.c   |  145 +++++--
 drivers/i2c/busses/i2c-omap.c     |   10 +-
 10 files changed, 1086 insertions(+), 61 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-eg20t.c
