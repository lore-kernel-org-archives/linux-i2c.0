From: Ben Dooks <ben-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Subject: i2c-next pull request
Date: Mon, 05 Jan 2009 10:57:39 +0000
Message-ID: <E1LJn9P-00013j-2W@teyla.home.fluff.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following changes since commit 4a6908a3a050aacc9c3a2f36b276b46c0629ad91:
  Linus Torvalds (1):
        Linux 2.6.28

are available in the git repository at:

  git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-next

Ben Dooks (8):
      i2c-s3c2410: Fixup style problems from checkpatch.pl
      i2c-s3c2410: Use platform data for gpio configuration
      i2c-s3c2410: Remove default platform data.
      i2c-s3c2410: Allow more than one i2c-s3c2410 adapter
      i2c-s3c2410: Change IRQ to be plain integer.
      Merge branch 'i2c-for-ben' of git://git.kernel.org/.../tmlind/linux-omap-2.6 into i2c-next
      i2c-omap: fix type of irq handler function
      Merge branch 'i2c-next-s3c' into i2c-next

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

 arch/arm/mach-omap2/clock24xx.h  |    4 +-
 drivers/i2c/busses/i2c-omap.c    |  420 +++++++++++++++++++++++++++++---------
 drivers/i2c/busses/i2c-s3c2410.c |  185 +++++++----------
 3 files changed, 408 insertions(+), 201 deletions(-)
