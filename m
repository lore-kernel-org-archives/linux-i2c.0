From: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] fixes for ib-mfd-gpio-i2c-3.19
Date: Tue, 11 Nov 2014 14:20:55 +0200
Message-ID: <1415708457-18798-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, julia.lawall-L2FTfq7BK8M@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Lee,

A couple of patches that fixes a coccinelle warning found by Julia and
kbuild test robot. They are not critical and I don't know if they must
be pull through ib-mfd-gpio-i2c-3.19, please let me know if I need to
submit them elsewhere.

Thanks,
Tavi


Octavian Purdila (2):
  mfd: dln2: fix _dln2_transfer return code
  i2c: dln2: simplify return flow for dln2_i2c_enable

 drivers/i2c/busses/i2c-dln2.c | 7 +------
 drivers/mfd/dln2.c            | 3 ++-
 2 files changed, 3 insertions(+), 7 deletions(-)

-- 
1.9.1
