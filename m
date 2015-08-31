From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 0/6] i2c: designware: Code duplication removal and cleanups
Date: Mon, 31 Aug 2015 17:31:27 +0300
Message-ID: <1441031493-18938-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

It bothered to me to see "static struct i2c_algorithm i2c_dw_algo {}"
defined twice both in i2c-designware-pcidrv.c and
i2c-designware-platdrv.c and so many exported i2c-designware-core
functions.

It turned out some of them became unused or are local and there were
also duplicated probe code that I moved to new common i2c_dw_probe().

Object sizes below before and after this set from CONFIG_X86_64=y build.

   text	   data	    bss	    dec	    hex	filename
   6439	   1096	      0	   7535	   1d6f	drivers/i2c/busses/i2c-designware-core.ko
   5123	   1588	     16	   6727	   1a47	drivers/i2c/busses/i2c-designware-pci.ko
   5274	   1096	     16	   6386	   18f2	drivers/i2c/busses/i2c-designware-platform.ko
  16836	   3780	     32	  20648	   50a8	(TOTALS)

   text	   data	    bss	    dec	    hex	filename
   7225	   1120	     16	   8361	   20a9	drivers/i2c/busses/i2c-designware-core.ko
   4281	   1524	      0	   5805	   16ad	drivers/i2c/busses/i2c-designware-pci.ko
   4337	   1072	      0	   5409	   1521	drivers/i2c/busses/i2c-designware-platform.ko
  15843	   3716	     16	  19575	   4c77	(TOTALS)

Jarkko Nikula (6):
  i2c: designware: Remove interrupt clearing from i2c_dw_pci_probe()
  i2c: designware: Disable interrupts before requesting PCI device
    interrupt
  i2c: designware: Remove unused functions
  i2c: designware: Make dw_readl() and dw_writel() static
  i2c: designware: Rename platform driver probe and PM functions
  i2c: designware: Move common probe code into i2c_dw_probe()

 drivers/i2c/busses/i2c-designware-core.c    | 73 ++++++++++++++++++-----------
 drivers/i2c/busses/i2c-designware-core.h    | 10 +---
 drivers/i2c/busses/i2c-designware-pcidrv.c  | 31 ++----------
 drivers/i2c/busses/i2c-designware-platdrv.c | 52 ++++++--------------
 4 files changed, 63 insertions(+), 103 deletions(-)

-- 
2.5.0
