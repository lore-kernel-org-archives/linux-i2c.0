From: Ben Dooks <ben-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Subject: what is in bjdooks' i2c-next tree
Date: Tue, 16 Dec 2008 22:10:24 +0000
Message-ID: <E1LCi7U-0000YA-U3@teyla.home.fluff.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 1bda71282ded6a2e09a2db7c8884542fb46bfd4f:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../ieee1394/linux1394-2.6

are available in the git repository at:

  git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-next

Ben Dooks (2):
      Merge branch 'i2c-for-ben' of git://git.kernel.org/.../tmlind/linux-omap-2.6 into i2c-next
      i2c-omap: fix type of irq handler function

Chandra shekhar (1):
      i2c-omap: Add support for omap34xx

Jarkko Nikula (1):
      i2c-omap: Do not use interruptible wait call in omap_i2c_xfer_msg

Kalle Jokiniemi (1):
      i2c-omap: Enable I2C wakeups for 34xx

Nishanth Menon (1):
      i2c-omap: FIFO handling support and broken hw workaround for i2c-omap

Paul Walmsley (6):
      i2c-omap: Close suspected race between omap_i2c_idle() and omap_i2c_isr()
      i2c-omap: Mark init-only functions as __init
      i2c-omap: Don't compile in OMAP15xx I2C ISR for non-OMAP15xx builds
      i2c-omap: fix I2C timeouts due to recursive omap_i2c_{un,}idle()
      i2c-omap: convert 'rev1' flag to generic 'rev' u8
      i2c-omap: reprogram OCP_SYSCONFIG register after reset

Syed Mohammed Khasim (1):
      i2c-omap: Add high-speed support to omap-i2c

Tony Lindgren (1):
      i2c-omap: Clean-up i2c-omap

 arch/arm/mach-omap2/clock24xx.h |    4 +-
 drivers/i2c/busses/i2c-omap.c   |  420 ++++++++++++++++++++++++++++++---------
 2 files changed, 330 insertions(+), 94 deletions(-)
