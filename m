From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 3/5] i2c: designware-baytrail: Only check
 iosf_mbi_available() for shared hosts
Date: Sat, 10 Dec 2016 20:26:31 +0100
Message-ID: <9135c524-8e11-0b3d-0b0b-ffc48e431559@redhat.com>
References: <20161210141908.16470-1-hdegoede@redhat.com>
 <20161210141908.16470-3-hdegoede@redhat.com>
 <1481381660.7188.7.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752335AbcLJT0f (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 10 Dec 2016 14:26:35 -0500
In-Reply-To: <1481381660.7188.7.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Vincent Gerris <vgerris@gmail.com>, linux-i2c@vger.kernel.org

Hi,

On 10-12-16 15:54, Andy Shevchenko wrote:
> On Sat, 2016-12-10 at 15:19 +0100, Hans de Goede wrote:
>> There is no need to delay the probe if iosf_mbi_available() returns
>> false when an i2c bus is not using the punit semaphore.
>
>> --- a/drivers/i2c/busses/i2c-designware-baytrail.c
>> +++ b/drivers/i2c/busses/i2c-designware-baytrail.c
>> @@ -139,14 +139,14 @@ int i2c_dw_eval_lock_support(struct dw_i2c_dev
>> *dev)
>>  		return 0;
>>
>>  	if (shared_host) {
>> +		if (!iosf_mbi_available())
>> +			return -EPROBE_DEFER;
>> +
>
> Looking to the implementation of i2c_dw_eval_lock_support() I would
> rewrite this like
>
> if (!shared_host)
>   return 0;

I had the same thought when writing this patch, so ack, will fix for v3.

Regards,

Hans



>
>>  		dev_info(dev->dev, "I2C bus managed by PUNIT\n");
>>  		dev->acquire_lock = baytrail_i2c_acquire;
>>  		dev->release_lock = baytrail_i2c_release;
>>  		dev->pm_runtime_disabled = true;
>>  	}
>>
>> -	if (!iosf_mbi_available())
>> -		return -EPROBE_DEFER;
>> -
>>  	return 0;
>>  }
>
