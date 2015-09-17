From: Luis de Bethencourt <luis-HiykPkW1eAzzDCI4PIEvbQC/G2K4zDHf@public.gmane.org>
Subject: [PATCH 0/4] i2c: Fix module autoload for OF platform driver
Date: Thu, 17 Sep 2015 18:34:35 +0200
Message-ID: <20150917163435.GA26143@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

These patches add the missing MODULE_DEVICE_TABLE() for OF to export
the information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519

Thanks,
Luis

Luis de Bethencourt (4):
  i2c: ibm-iic: Fix module autoload for OF platform driver
  i2c: meson: Fix module autoload for OF platform driver
  i2c: rk3x: Fix module autoload for OF platform driver
  i2c: stu300: Fix module autoload for OF platform driver

 drivers/i2c/busses/i2c-ibm_iic.c | 1 +
 drivers/i2c/busses/i2c-meson.c   | 1 +
 drivers/i2c/busses/i2c-rk3x.c    | 1 +
 drivers/i2c/busses/i2c-stu300.c  | 1 +
 4 files changed, 4 insertions(+)

-- 
2.4.6
