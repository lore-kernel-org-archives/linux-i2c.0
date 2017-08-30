From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [wsa:i2c/for-next 65/74] i2c-sprd.c:undefined reference to `i2c_del_adapter'
Date: Wed, 30 Aug 2017 11:07:45 +0800
Message-ID: <CAMz4kuKBnw00WCbDa3KU3b9OchX5bHZzKYNMCdiSmNZvZ5d5sw@mail.gmail.com>
References: <201708301003.pzfftflw%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34887 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbdH3DHq (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 29 Aug 2017 23:07:46 -0400
Received: by mail-oi0-f53.google.com with SMTP id k77so42088601oib.2
        for <linux-i2c@vger.kernel.org>; Tue, 29 Aug 2017 20:07:46 -0700 (PDT)
In-Reply-To: <201708301003.pzfftflw%fengguang.wu@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Baolin Wang <baolin.wang@spreadtrum.com>, kbuild-all@01.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa-dev@sang-engineering.com>, Andy Shevchenko <andy.shevchenko@gmail.com>

Hi,

On 30 August 2017 at 10:24, kbuild test robot <fengguang.wu@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
> head:   60999e2bb4ed42743b81d718521deccdb8888335
> commit: 8b9ec0719834fe66146d138d62ed66cef025c864 [65/74] i2c: Add Spreadtrum I2C controller driver
> config: arm64-allmodconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 8b9ec0719834fe66146d138d62ed66cef025c864
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64
>
> All errors (new ones prefixed by >>):
>
>    drivers/i2c/busses/i2c-sprd.o: In function `sprd_i2c_remove':
>>> i2c-sprd.c:(.text+0x168): undefined reference to `i2c_del_adapter'
>    drivers/i2c/busses/i2c-sprd.o: In function `sprd_i2c_probe':
>>> i2c-sprd.c:(.text+0x1400): undefined reference to `i2c_add_numbered_adapter'

I realized Spreadtrum I2C driver can not be build as module, so it
should depend on I2C=y. Since Wolfram had applied this patch series, I
will send one patch to fix this build error. Thanks.

-- 
Baolin.wang
Best Regards
