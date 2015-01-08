From: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [wsa:i2c/quirks 8/11] drivers/i2c/busses/i2c-dln2.c:184:27: sparse:
 symbol 'dln2_i2c_quirks' was not declared. Should it be static?
Date: Fri, 9 Jan 2015 02:02:00 +0800
Message-ID: <201501090243.rmSyDkOe%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux i2c/quirks
head:   b1d39af8ae21f4930854b0656aa83a83fd38049e
commit: dfd33ddaa80259918c200cfacb9076c75cf1da82 [8/11] i2c: dln2: make use of the new infrastructure for quirks
reproduce:
  # apt-get install sparse
  git checkout dfd33ddaa80259918c200cfacb9076c75cf1da82
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/i2c/busses/i2c-dln2.c:184:27: sparse: symbol 'dln2_i2c_quirks' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
