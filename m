From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [i2c: dev] d6760b14d4:  BUG: KASAN: slab-out-of-bounds in
 of_device_uevent at addr ffff8800091b4c49
Date: Sat, 28 May 2016 15:24:33 +0800
Message-ID: <20160528072433.GA1844@wfg-t540p.sh.intel.com>
References: <57493af0.akIr4abjopweDkBu%fengguang.wu@intel.com>
 <20160528071234.GA1714@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:7498 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbcE1HYj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 28 May 2016 03:24:39 -0400
Content-Disposition: inline
In-Reply-To: <20160528071234.GA1714@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Erico Nunes <erico.nunes@datacom.ind.br>, LKP <lkp@01.org>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Ye Xiaolong <xiaolong.ye@intel.com>

On Sat, May 28, 2016 at 09:12:34AM +0200, Wolfram Sang wrote:
> > 0day kernel testing robot got the below dmesg and the first bad commit is
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> So, I got a success message from buildbot "[wsa:i2c/for-next]
> 72a71f869c95dc11b73f09fe18c593d4a0618c3f BUILD SUCCESS".
> 
> I assume now that the above message covers only compile-testing while

That's right. "BUILD SUCCESS" only covers compile testing and static
checks.

> linus master tree also gets boot testing? Correct?

All branches will get boot testing. linus/master naturally receives
much more tests since all branches are eventually based on some Linus
commit.

> I was under the impression before that the above message also covers
> simple boot tests.

There will be simple boot tests quickly after the compile tests.
However boot tests typically need more time to be detected, bisected
and especially manual checked. We are yet to automate more boot error
reports.

Thanks,
Fengguang
