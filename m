From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] i2c: designware: Print clock freq on invalid clock
 freq error
Date: Sun, 9 Jul 2017 20:53:26 +0200
Message-ID: <1cfb0eeb-050a-c517-1e83-e9046a6c7a6b@redhat.com>
References: <20170708131052.13524-1-hdegoede@redhat.com>
 <1499522069.22624.305.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752430AbdGISxa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 9 Jul 2017 14:53:30 -0400
In-Reply-To: <1499522069.22624.305.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org

Hi,

On 08-07-17 15:54, Andy Shevchenko wrote:
> On Sat, 2017-07-08 at 15:10 +0200, Hans de Goede wrote:
>> When we refuse to probe due to an invalid clock frequency, log
>> the frequency which is causing this error.
> 
> Shouldn't it have \n as well?

Right will fix for v2.

Regards,

Hans


> 
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/i2c/busses/i2c-designware-platdrv.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
>> b/drivers/i2c/busses/i2c-designware-platdrv.c
>> index d1263b82d646..d5acaf8d65bf 100644
>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>> @@ -275,7 +275,8 @@ static int dw_i2c_plat_probe(struct
>> platform_device *pdev)
>>   	if (dev->clk_freq != 100000 && dev->clk_freq != 400000
>>   	    && dev->clk_freq != 1000000 && dev->clk_freq != 3400000)
>> {
>>   		dev_err(&pdev->dev,
>> -			"Only 100kHz, 400kHz, 1MHz and 3.4MHz
>> supported");
>> +			"%d Hz is unsupported, only 100kHz, 400kHz,
>> 1MHz and 3.4MHz are supported",
>> +			dev->clk_freq);
>>   		r = -EINVAL;
>>   		goto exit_reset;
>>   	}
> 
