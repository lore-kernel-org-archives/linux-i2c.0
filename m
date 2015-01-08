From: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [wsa:i2c/quirks 7/11] drivers/i2c/busses/i2c-axxia.c:452:27: sparse:
 symbol 'axxia_i2c_quirks' was not declared. Should it be static?
Date: Fri, 9 Jan 2015 01:57:37 +0800
Message-ID: <201501090118.jHaamxHl%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux i2c/quirks
head:   b1d39af8ae21f4930854b0656aa83a83fd38049e
commit: 70181ecd2990326a91edb3dac1db4cce21e561f7 [7/11] i2c: axxia: make use of the new infrastructure for quirks
reproduce:
  # apt-get install sparse
  git checkout 70181ecd2990326a91edb3dac1db4cce21e561f7
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/i2c/busses/i2c-axxia.c:452:27: sparse: symbol 'axxia_i2c_quirks' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
