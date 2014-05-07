From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 00/16] i2c: remove unnecessary OOM messages
Date: Wed, 07 May 2014 13:14:09 +0900
Message-ID: <018301cf69aa$cb7987d0$626c9770$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message. For example,
k.alloc and v.alloc failures use dump_stack().

Jingoo Han (16):
      i2c: bcm2835: remove unnecessary OOM messages
      i2c: diolan-u2c: remove unnecessary OOM messages
      i2c: efm32: remove unnecessary OOM messages
      i2c: eg20t: remove unnecessary OOM messages
      i2c: exynos5: remove unnecessary OOM messages
      i2c: imx: remove unnecessary OOM messages
      i2c: omap: remove unnecessary OOM messages
      i2c: rcar: remove unnecessary OOM messages
      i2c: s3c2410: remove unnecessary OOM messages
      i2c: sh_mobile: remove unnecessary OOM messages
      i2c: simtec: remove unnecessary OOM messages
      i2c: sirf: remove unnecessary OOM messages
      i2c: stu300: remove unnecessary OOM messages
      i2c: tegra: remove unnecessary OOM messages
      i2c: wmt: remove unnecessary OOM messages
      i2c: scx200_acb: remove unnecessary OOM messages
---
 drivers/i2c/busses/i2c-bcm2835.c    |    4 +---
 drivers/i2c/busses/i2c-diolan-u2c.c |    1 -
 drivers/i2c/busses/i2c-efm32.c      |    4 +---
 drivers/i2c/busses/i2c-eg20t.c      |    4 +---
 drivers/i2c/busses/i2c-exynos5.c    |    4 +---
 drivers/i2c/busses/i2c-imx.c        |    4 +---
 drivers/i2c/busses/i2c-omap.c       |    4 +---
 drivers/i2c/busses/i2c-rcar.c       |    4 +---
 drivers/i2c/busses/i2c-s3c2410.c    |    8 ++------
 drivers/i2c/busses/i2c-sh_mobile.c  |    4 +---
 drivers/i2c/busses/i2c-simtec.c     |    4 +---
 drivers/i2c/busses/i2c-sirf.c       |    1 -
 drivers/i2c/busses/i2c-stu300.c     |    4 +---
 drivers/i2c/busses/i2c-tegra.c      |    4 +---
 drivers/i2c/busses/i2c-wmt.c        |    4 +---
 drivers/i2c/busses/scx200_acb.c     |    4 +---
 16 files changed, 15 insertions(+), 47 deletions(-)
