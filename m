From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 6/6] i2c: designware: Move common probe code into i2c_dw_probe()
Date: Wed, 21 Oct 2015 17:10:26 +0300
Message-ID: <56279CD2.80308@linux.intel.com>
References: <20151010075725.GF1619@katana> <1444658135-9281-1-git-send-email-jarkko.nikula@linux.intel.com> <20151020163216.GA1014@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36414 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733AbbJUOLR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 21 Oct 2015 10:11:17 -0400
In-Reply-To: <20151020163216.GA1014@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

Hi

On 10/20/2015 07:32 PM, Wolfram Sang wrote:
> There was a merge conflict with a bugfix from i2c/for-current. I think
> it is okay, but you may want to double check my i2c/for-next.
>
Looks like pm_runtime_disable() got dropped from your 36d48fb5766a 
("i2c: designware-platdrv: enable RuntimePM before registering to the 
core") while handling the merge conflict. I'll send a fix.

> What about this irq-clearing-in-probe thingie on top of this series? :)
>
I'll have a look at it. What's not entirely clear to me would it be 
no-op or not. HW is actually disabled after i2c_dw_init() which is 
called before requesting the interrupt but is not clear to me from the 
spec does HW clear interrupts while it goes idle.

So as a result I'd expect either a explicit interrupt clearing patch (to 
be more robust against potential unmasking changes) or a comment in 
__i2c_dw_enable() :-)

-- 
Jarkko
