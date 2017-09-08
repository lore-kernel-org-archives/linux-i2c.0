From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: Re: [PATCH 1/2] i2c: designware: Remove needless
 pm_runtime_put_noidle() call
Date: Fri, 8 Sep 2017 11:23:18 +0100
Message-ID: <df26d065-54e4-a1ad-52e0-3a47b49e852f@synopsys.com>
References: <20170815143445.26167-1-jarkko.nikula@linux.intel.com>
 <20170817155708.iakoglf7qrdf66bc@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:38919 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdIHKXX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 8 Sep 2017 06:23:23 -0400
In-Reply-To: <20170817155708.iakoglf7qrdf66bc@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Luis Oliveira <Luis.Oliveira@synopsys.com>

On 17-Aug-17 16:57, Wolfram Sang wrote:
> On Tue, Aug 15, 2017 at 05:34:44PM +0300, Jarkko Nikula wrote:
>> I guess pm_runtime_put_noidle() call in i2c_dw_probe_slave() was copied
>> by accident from similar master mode adapter registration code. It is
>> unbalanced due missing pm_runtime_get_noresume() but harmless since it
>> doesn't decrease dev->power.usage_count below zero.
>>
>> In theory we can hit similar needless runtime suspend/resume cycle
>> during slave mode adapter registration that was happening when
>> registering the master mode adapter. See commit cd998ded5c12 ("i2c:
>> designware: Prevent runtime suspend during adapter registration").
>>
>> However, since we are slave, we can consider it as a wrong configuration
>> if we have other slaves attached under this adapter and can omit the
>> pm_runtime_get_noresume()/pm_runtime_put_noidle() calls for simplicity.
>>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> 
> Applied to for-current, thanks! Not really a bugfix, but 2/2 is, so,
> well... BTW, Luis, are you still there? Holiday season?
> 

Hi all,

Sorry I was on holidays yes. I will get my setup ready to test this ASAP.

But it makes sense what Jarkko said in 2/2.
If it helps, for what I can remember I also used i2c-rcar slave mode as
inspiration for this implementation.

Thank you,
Luis
