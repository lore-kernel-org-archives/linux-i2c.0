From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: designware: Allow build Baytrail semaphore
 support when IOSF_MBI=m
Date: Thu, 10 Dec 2015 15:56:27 +0200
Message-ID: <5669848B.2090502@linux.intel.com>
References: <1449748124-20744-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1449748124-20744-2-git-send-email-jarkko.nikula@linux.intel.com>
 <1449752378.30729.89.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:35536 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbbLJN7E (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 10 Dec 2015 08:59:04 -0500
In-Reply-To: <1449752378.30729.89.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, David Box <david.e.box@linux.intel.com>

On 12/10/2015 02:59 PM, Andy Shevchenko wrote:
> On Thu, 2015-12-10 at 13:48 +0200, Jarkko Nikula wrote:
>> I believe i2c-designware-baytrail.c doesn't have strict dependency
>> that
>> Intel SoC IOSF Sideband support must be always built-in in order to
>> be
>> able to compile support for Intel Baytrail I2C bus sharing HW
>> semaphore.
>>
>> Redefine build dependencies so that CONFIG_IOSF_MBI=y is required
>> only
>> when CONFIG_I2C_DESIGNWARE_PLATFORM is built-in.
>>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> ---
>> Hi David. Can you ack/nak this patch as I'm not fully familiar with
>> this
>> HW semaphore can there be problems when IOSF_MBI is built as a
>> module.
>
>
>> At least I'm getting similar sensible looking "punit semaphore
>> acquired/held for x ms" debug messages when I modprobe/rmmod
>> i2c_designware_platform independently is the CONFIG_IOSF_MBI=y or =m.
>> ---
>>   drivers/i2c/busses/Kconfig | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index 69c46fe13777..76f4d024def0 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -490,7 +490,9 @@ config I2C_DESIGNWARE_PCI
>>
>>   config I2C_DESIGNWARE_BAYTRAIL
>>   	bool "Intel Baytrail I2C semaphore support"
>> -	depends on I2C_DESIGNWARE_PLATFORM && IOSF_MBI=y && ACPI
>> +	depends on ACPI
>> +	depends on (I2C_DESIGNWARE_PLATFORM=m && IOSF_MBI) || \
>> +		   (I2C_DESIGNWARE_PLATFORM=y && IOSF_MBI=y)
>
> Would it be more readable in the following way
>
> depends on ACPI
> depends on I2C_DESIGNWARE_PLATFORM
> depends on IOSF_MBI if I2C_DESIGNWARE_PLATFORM=m
> depends on IOSF_MBI=y if I2C_DESIGNWARE_PLATFORM=y
>
For my eyes it looks a bit more complex but I think it's matter of 
taste. However, the syntax you are proposing is not supported for 
"depends on" like it is for "select" statements.

-- 
Jarkko
