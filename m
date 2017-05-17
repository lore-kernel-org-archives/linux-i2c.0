From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Fix false warning from i2c_dw_clk_rate()
Date: Wed, 17 May 2017 09:12:11 +0300
Message-ID: <7f48d8e6-4e24-a463-1d65-85b63d90f844@linux.intel.com>
References: <20170511124949.26650-1-jarkko.nikula@linux.intel.com>
 <1494511249.6967.11.camel@linux.intel.com>
 <20170516212914.bjc77ogqbklm4udi@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:31743 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751386AbdEQGMP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 17 May 2017 02:12:15 -0400
In-Reply-To: <20170516212914.bjc77ogqbklm4udi@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On 05/17/2017 12:29 AM, Wolfram Sang wrote:
>
>>> +	switch (dev->master_cfg & DW_IC_CON_SPEED_MASK) {
>>> +	case DW_IC_CON_SPEED_STD:
>>> +		i2c_dw_set_timings_sm(dev);
>>> +		break;
>>> +	case DW_IC_CON_SPEED_FAST:
>>> +		i2c_dw_set_timings_fm(dev);
>>> +		break;
>>> +	case DW_IC_CON_SPEED_HIGH:
>>> +		i2c_dw_set_timings_hsm(dev);
>>> +		break;
>>>  	}
>>
>> I would put same suffixes to the helper functions, i.e.
>> _sm -> _std
>> _fm -> _fast
>> _hsm-> _high
>
> BTW is this a bugfix? I tend to think, yes.
>
Maybe in grey area but not enough for linux-stable I think. Unless log 
spamming qualifies as a regression.

Lorenzo: does my patch fix the issue for you? I was waiting your comment 
before sending version 2 addressing Andy's comment.

-- 
Jarkko
