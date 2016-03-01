From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH 2/2] i2c: cadence: Implement save restore
Date: Tue, 1 Mar 2016 14:55:27 +0530
Message-ID: <CAKfKVtHiE6PviPj42BBKZjUhs7e7YF6zQJD2z04=TZd4=PfNTA@mail.gmail.com>
References: <1456813959-20398-1-git-send-email-shubhraj@xilinx.com>
	<1456813959-20398-2-git-send-email-shubhraj@xilinx.com>
	<56D545F6.1070209@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qg0-f66.google.com ([209.85.192.66]:33678 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbcCAJZ2 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 1 Mar 2016 04:25:28 -0500
Received: by mail-qg0-f66.google.com with SMTP id y89so12216160qge.0
        for <linux-i2c@vger.kernel.org>; Tue, 01 Mar 2016 01:25:28 -0800 (PST)
In-Reply-To: <56D545F6.1070209@xilinx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-i2c@vger.kernel.org, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Wolfram Sang <wsa@the-dreams.de>, Shubhrajyoti Datta <shubhraj@xilinx.com>

On Tue, Mar 1, 2016 at 1:04 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 1.3.2016 07:32, Shubhrajyoti Datta wrote:
>> Implement save restore for i2c module.
>> Since we have only a couple of registers
>> an unconditional restore is done.
>>
>> Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
>> ---
>> zynq-mp has the capability of going off.
>> the current kernel does not hit off however some day it will.
>> since the overhead of having the support is not much may be it is better
>> to have it in the kernel.
>>
>>  drivers/i2c/busses/i2c-cadence.c |   32 ++++++++++++++++++--------------
>>  1 files changed, 18 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
>> index a761520..3d50914 100644
>> --- a/drivers/i2c/busses/i2c-cadence.c
>> +++ b/drivers/i2c/busses/i2c-cadence.c
>> @@ -161,6 +161,7 @@ struct cdns_i2c {
>>       struct clk *clk;
>>       struct notifier_block clk_rate_change_nb;
>>       u32 quirks;
>> +     u32 ctrl_reg;
>
> kernel-doc update too.

missed it fixed in v2
>
>>  };
>>
>>  struct cdns_platform_data {
>> @@ -743,12 +744,11 @@ static int cdns_i2c_setclk(unsigned long clk_in, struct cdns_i2c *id)
>>       if (ret)
>>               return ret;
>>
>> -     ctrl_reg = cdns_i2c_readreg(CDNS_I2C_CR_OFFSET);
>> +     ctrl_reg = id->ctrl_reg;
>>       ctrl_reg &= ~(CDNS_I2C_CR_DIVA_MASK | CDNS_I2C_CR_DIVB_MASK);
>>       ctrl_reg |= ((div_a << CDNS_I2C_CR_DIVA_SHIFT) |
>>                       (div_b << CDNS_I2C_CR_DIVB_SHIFT));
>> -     cdns_i2c_writereg(ctrl_reg, CDNS_I2C_CR_OFFSET);
>> -
>> +     id->ctrl_reg = ctrl_reg;
>>       return 0;
>>  }
>>
>> @@ -831,6 +831,18 @@ static int __maybe_unused cdns_i2c_runtime_suspend(struct device *dev)
>>
>>       return 0;
>>  }
>
> You probably want to put empty line here. And most of functions have
> kernel-doc and will be good to follow this up.
>
Agree sent v2 fixing the same.
Thanks for review
