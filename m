From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [kbuild-all] [wsa:i2c/for-4.13 15/51] warning: __mcount_loc
 already exists: drivers/i2c/algos/i2c-algo-bit.o
Date: Tue, 11 Jul 2017 15:55:55 +0800
Message-ID: <20170711075555.e5ktanutreueotu7@wfg-t540p.sh.intel.com>
References: <201707111232.THY3DhFS%fengguang.wu@intel.com>
 <20170711065431.GA2342@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:40308 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755257AbdGKHz6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 11 Jul 2017 03:55:58 -0400
Content-Disposition: inline
In-Reply-To: <20170711065431.GA2342@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa-dev@sang-engineering.com>, kbuild-all@01.org, Philip Li <philip.li@intel.com>

Hi Wolfram,

On Tue, Jul 11, 2017 at 08:54:31AM +0200, Wolfram Sang wrote:
>On Tue, Jul 11, 2017 at 12:16:34PM +0800, kbuild test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-4.13
>> head:   8f1a357d41a22009150cf404b5aa5876efdb59b1
>> commit: d44005672d83f89d7d797efc490a751a696e7d91 [15/51] i2c: stub: fix build warning regression
>> config: i386-allmodconfig (attached as .config)
>> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
>> reproduce:
>>         git checkout d44005672d83f89d7d797efc490a751a696e7d91
>>         # save the attached .config to linux build tree
>>         make ARCH=i386
>>
>> All warnings (new ones prefixed by >>):
>>
>> >> warning: __mcount_loc already exists: drivers/i2c/algos/i2c-algo-bit.o
>> --
>> >> warning: __mcount_loc already exists: drivers/i2c/busses/i2c-emev2.o
>> --
>> >> warning: __mcount_loc already exists: drivers/i2c/busses/i2c-xlp9xx.o
>> --
>> >> warning: __mcount_loc already exists: drivers/i2c/busses/i2c-rcar.o
>
>False positive? How can a commit that only touches the DEBUG define in
>i2c-algo-bit have effects on the latter three drivers?

You are right, I just confirmed that it's a false positive.

The bisect didn't run distclean, which may explain the warnings on
duplicate __mcount_loc.

Cheers,
Fengguang
