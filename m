From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [wsa:i2c/for-next 42/44] drivers/i2c/busses/i2c-zx2967.c:87:2:
 error: implicit declaration of function 'writesb'
Date: Sat, 24 Jun 2017 22:26:49 +0800
Message-ID: <20170624142648.GE23753@dragon>
References: <201706240439.vcuBzSRT%fengguang.wu@intel.com>
 <20170624135754.GD23753@dragon>
 <20170624141500.GA1566@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751301AbdFXO1E (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 24 Jun 2017 10:27:04 -0400
Content-Disposition: inline
In-Reply-To: <20170624141500.GA1566@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: kbuild test robot <fengguang.wu@intel.com>, Baoyou Xie <baoyou.xie@linaro.org>, kbuild-all@01.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa-dev@sang-engineering.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Jun Nie <jun.nie@linaro.org>

On Sat, Jun 24, 2017 at 04:15:00PM +0200, Wolfram Sang wrote:
> 
> > I think what we should do is dropping COMPILE_TEST or adding !IA64
> > dependency.  @Wolfram, what do you think?
> 
> Let's drop COMPILE_TEST for now, I'd say.

I just sent you one patch doing that.

Shawn
