From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v3 0/4] i2c: designware: add i2c gpio recovery option
Date: Thu, 28 Sep 2017 12:55:41 +0300
Message-ID: <ae1244f3-9d6d-a28a-f4fb-31bd452516d9@linux.intel.com>
References: <1504073857-122449-1-git-send-email-preid@electromag.com.au>
 <1b54a382-c447-2f42-fd00-6a033449d394@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:59117 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751396AbdI1Jzo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 28 Sep 2017 05:55:44 -0400
In-Reply-To: <1b54a382-c447-2f42-fd00-6a033449d394@electromag.com.au>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, tim@krieglstein.org, linux-i2c@vger.kernel.org

On 09/28/2017 10:37 AM, Phil Reid wrote:
> On 30/08/2017 14:17, Phil Reid wrote:
>> Changes from V1:
>> - In review Andy suggested change the i2c core to use the gpiod
>>    I've added a patch that allows the gradual switching of drivers
>>    to using gpiod interface. The old interface is preserved so
>>    that changes can be made incrementally.
>> - I've update Tim's patch for the designware driver to use the new
>>    interface. Tweaked a couple of things to his patch and fixed
>>    up things Andy id in last review.
>>    The core changes in p1 don't require the get/set scl/sda functions.
>>    Hopefully I've done the right thing with preserving authorship and
>>    signoff.
>>
>> Changes from V2:
>> - Rebase on 
>> https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git/
>>    i2c/for-next
>>    No intentional changes, but needed to move i2c_dw_plat_prepare_clk 
>> to common
>>    for the master recovery functions to use. which is included as two 
>> additional
>>    patches.
>>
>>
>> Phil Reid (4):
>>    i2c: Switch to using gpiod interface for gpio bus recovery
>>    i2c: designware: move i2c_dw_plat_prepare_clk to common
>>    i2c: designware: rename i2c_dw_plat_prepare_clk to i2c_dw_prepare_clk
>>
>> Tim Sander (1):
>>    i2c: designware: add i2c gpio recovery option
>>
>>   drivers/i2c/busses/i2c-designware-common.c  | 24 ++++++++++--
>>   drivers/i2c/busses/i2c-designware-core.h    |  2 +
>>   drivers/i2c/busses/i2c-designware-master.c  | 57 
>> +++++++++++++++++++++++++++++
>>   drivers/i2c/busses/i2c-designware-platdrv.c | 18 ++-------
>>   drivers/i2c/i2c-core-base.c                 | 22 +++++++++--
>>   include/linux/i2c.h                         |  2 +
>>   6 files changed, 103 insertions(+), 22 deletions(-)
>>
> 
> Any comments on this series?
> 
Thanks for reminder. This got buried under other activity... 
i2c-designware changes look ok at quick look.

-- 
Jarkko
