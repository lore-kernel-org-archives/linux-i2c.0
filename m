From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCHv3 2/2] i2c: cadence: Implement save restore
Date: Fri, 4 Mar 2016 09:55:39 +0530
Message-ID: <CAKfKVtG5sC7+2Gsq60irZAYgof1guqWTg=YCN+63xJV=tfmowg@mail.gmail.com>
References: <1456984240-17389-1-git-send-email-shubhraj@xilinx.com>
	<1456984240-17389-2-git-send-email-shubhraj@xilinx.com>
	<20160303204013.GC1711@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35290 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbcCDEZk (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 3 Mar 2016 23:25:40 -0500
Received: by mail-qk0-f175.google.com with SMTP id o6so16966523qkc.2
        for <linux-i2c@vger.kernel.org>; Thu, 03 Mar 2016 20:25:39 -0800 (PST)
In-Reply-To: <20160303204013.GC1711@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-i2c@vger.kernel.org, anirudh@xilinx.com, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Shubhrajyoti Datta <shubhraj@xilinx.com>

On Fri, Mar 4, 2016 at 2:10 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Thu, Mar 03, 2016 at 11:20:40AM +0530, Shubhrajyoti Datta wrote:
>
>> Implement save restore for i2c module.
>> Since we have only a couple of registers
>> an unconditional restore is done.
>
> But you only save one register instead of a couple? Also, the subject
> could be more descriptive IMO.
That is because the timeout is written a fixed value always so just restore
is done.

>
>> zynq-mp has the capability of going off.
>> the current kernel does not hit off however some day it will.
>> since the overhead of having the support is not much may be it is better to have it in the kernel.
>
> This sounds like the patch is not tested?
to simulate the suspend behavior I  did a reset of the module by writing to
slcr register.
And then did a transfer.

>
>> +static void cdns_i2c_init(struct cdns_i2c *id)
>> +{
>> +     cdns_i2c_writereg(id->ctrl_reg, CDNS_I2C_CR_OFFSET);
>> +     /*
>> +      * Cadence I2C controller has a bug wherein it generates
>> +      * invalid read transaction after HW timeout in master receiver mode.
>> +      * HW timeout is not used by this driver and the interrupt is disabled.
>> +      * But the feature itself cannot be disabled. Hence maximum value
>> +      * is written to this register to reduce the chances of error.
>> +      */
>> +     cdns_i2c_writereg(CDNS_I2C_TIMEOUT_MAX, CDNS_I2C_TIME_OUT_OFFSET);
>> +}
>
> This...

Writes the values to the register.

>
>> +
>> +/**
>>   * cdns_i2c_runtime_resume - Runtime resume
>>   * @dev:     Address of the platform_device structure
>>   *
>> @@ -853,6 +874,7 @@ static int __maybe_unused cdns_i2c_runtime_resume(struct device *dev)
>>               dev_err(dev, "Cannot enable clock.\n");
>>               return ret;
>>       }
>> +     cdns_i2c_init(xi2c);
>
> and this...
At resume .
(Actually this could be conditional however since we have 2 registers
so can be unconditioal)
>
>> -
>> -     /*
>> -      * Cadence I2C controller has a bug wherein it generates
>> -      * invalid read transaction after HW timeout in master receiver mode.
>> -      * HW timeout is not used by this driver and the interrupt is disabled.
>> -      * But the feature itself cannot be disabled. Hence maximum value
>> -      * is written to this register to reduce the chances of error.
>> -      */
>> -     cdns_i2c_writereg(CDNS_I2C_TIMEOUT_MAX, CDNS_I2C_TIME_OUT_OFFSET);
>> +     cdns_i2c_init(id);

And at init.
>
> ... and this look like a unrelated change to me?
>
