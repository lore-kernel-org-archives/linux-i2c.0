From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [wsa:i2c/for-next 42/44] drivers/i2c/busses/i2c-zx2967.c:87:2:
 error: implicit declaration of function 'writesb'
Date: Sat, 24 Jun 2017 21:57:55 +0800
Message-ID: <20170624135754.GD23753@dragon>
References: <201706240439.vcuBzSRT%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751281AbdFXN6P (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 24 Jun 2017 09:58:15 -0400
Content-Disposition: inline
In-Reply-To: <201706240439.vcuBzSRT%fengguang.wu@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Baoyou Xie <baoyou.xie@linaro.org>, kbuild-all@01.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa-dev@sang-engineering.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Jun Nie <jun.nie@linaro.org>

On Sat, Jun 24, 2017 at 04:50:44AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
> head:   5ff37d1a67e2fed0cae537ad682abb7f6647cca4
> commit: 9615a01f71ca02858f5265b1b545280758562aa2 [42/44] i2c: zx2967: add i2c controller driver for ZTE's zx2967 family
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 6.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 9615a01f71ca02858f5265b1b545280758562aa2
>         # save the attached .config to linux build tree
>         make.cross ARCH=ia64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/i2c/busses/i2c-zx2967.c: In function 'zx2967_i2c_writesb':
> >> drivers/i2c/busses/i2c-zx2967.c:87:2: error: implicit declaration of function 'writesb' [-Werror=implicit-function-declaration]
>      writesb(i2c->reg_base + reg, data, len);
>      ^~~~~~~
>    drivers/i2c/busses/i2c-zx2967.c: In function 'zx2967_i2c_readsb':
> >> drivers/i2c/busses/i2c-zx2967.c:93:2: error: implicit declaration of function 'readsb' [-Werror=implicit-function-declaration]
>      readsb(i2c->reg_base + reg, data, len);
>      ^~~~~~
>    cc1: some warnings being treated as errors

It's caused by that writesb/readsb are unavailable on ia64 architecture.
We do have the accessors in include/asm-generic/io.h, but ia64 asm io.h
doesn't include this header.  It seems that including the header in ia64
io.h causes more build issue.

I think what we should do is dropping COMPILE_TEST or adding !IA64
dependency.  @Wolfram, what do you think?

Shawn
