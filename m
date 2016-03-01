From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH 1/2] i2c: cadence: Fix the Documentation
Date: Tue, 1 Mar 2016 14:53:57 +0530
Message-ID: <CAKfKVtG6vPDbF=BuANpkW7URG6cAMekiDcX95yioOHkj6AE=aw@mail.gmail.com>
References: <1456813959-20398-1-git-send-email-shubhraj@xilinx.com>
	<56D545B5.9060304@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qg0-f68.google.com ([209.85.192.68]:33437 "EHLO
	mail-qg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbcCAJX6 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 1 Mar 2016 04:23:58 -0500
Received: by mail-qg0-f68.google.com with SMTP id y89so12214614qge.0
        for <linux-i2c@vger.kernel.org>; Tue, 01 Mar 2016 01:23:57 -0800 (PST)
In-Reply-To: <56D545B5.9060304@xilinx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-i2c@vger.kernel.org, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Wolfram Sang <wsa@the-dreams.de>, Shubhrajyoti Datta <shubhraj@xilinx.com>

On Tue, Mar 1, 2016 at 1:03 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 1.3.2016 07:32, Shubhrajyoti Datta wrote:
>> The runtime adaptation patch missed the documentation update.
>> This fixes the same.
>> No functional change.
>>
>> Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
>> ---
>>  drivers/i2c/busses/i2c-cadence.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
>> index 6b08d16..a761520 100644
>> --- a/drivers/i2c/busses/i2c-cadence.c
>> +++ b/drivers/i2c/busses/i2c-cadence.c
>> @@ -815,7 +815,7 @@ static int cdns_i2c_clk_notifier_cb(struct notifier_block *nb, unsigned long
>>  }
>>
>>  /**
>> - * cdns_i2c_suspend - Suspend method for the driver
>> + * cdns_i2c_runtime_suspend -  Runtime suspend method for the driver
>>   * @_dev:    Address of the platform_device structure
>
> you should fix this parameter too.
yes
>
>>   *
>>   * Put the driver into low power mode.
>> @@ -833,7 +833,7 @@ static int __maybe_unused cdns_i2c_runtime_suspend(struct device *dev)
>>  }
>>
>>  /**
>> - * cdns_i2c_resume - Resume from suspend
>> + * cdns_i2c_runtime_resume - Runtime resume
>>   * @_dev:    Address of the platform_device structure
>
> and here too.
ok
>
>>   *
>>   * Resume operation after suspend.
>>
>
> There is also undocumented dev. Please fix it too.
> drivers/i2c/busses/i2c-cadence.c:126: info: Scanning doc for struct cdns_i2c
> drivers/i2c/busses/i2c-cadence.c:164: warning: No description found for
> parameter 'dev'
Sent a v2 fixing all the comments.


Thanks for the review

>
> Thanks,
> Michal
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
