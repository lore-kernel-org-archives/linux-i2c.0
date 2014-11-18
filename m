From: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/4] dln2 fixes for ib-mfd-gpio-i2c-3.19
Date: Tue, 18 Nov 2014 14:57:56 +0200
Message-ID: <1416315480-2053-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, julia.lawall-L2FTfq7BK8M@public.gmane.org, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Lee,

Here are a few fixes for the DLN2 drivers for the ib-mfd-gpio-i2c-3.19 branch.

Thanks,
Tavi

Changes since v1:

 * fix coding style (add braces) and remove redundant ret = 0 statement

 * add two more fixes for issues reported by Dan Carpenter


Dan Carpenter (1):
  mfd: dln2: a couple endian fixes

Octavian Purdila (3):
  mfd: dln2: fix _dln2_transfer return code
  i2c: dln2: simplify return flow for dln2_i2c_enable
  mfd: dln2: add a limit check for invalid echo

 drivers/i2c/busses/i2c-dln2.c |  7 +------
 drivers/mfd/dln2.c            | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 12 deletions(-)

-- 
1.9.1
