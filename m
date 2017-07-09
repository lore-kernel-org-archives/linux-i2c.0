From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/2] i2c: designware: Some broken DSTDs use 1MiHz instead
 of 1MHz
Date: Sun, 9 Jul 2017 20:54:19 +0200
Message-ID: <bd305689-84ca-b6f3-3997-d6eb779d7b6a@redhat.com>
References: <20170708131052.13524-1-hdegoede@redhat.com>
 <20170708131052.13524-2-hdegoede@redhat.com>
 <1499522154.22624.307.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1499522154.22624.307.camel@linux.intel.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 08-07-17 15:55, Andy Shevchenko wrote:
> On Sat, 2017-07-08 at 15:10 +0200, Hans de Goede wrote:
>> At least the Acer Iconia Tab8 / aka W1-810 uses 1MiHz instead of
>> 1MHz for one of its busses, fix this up to 1MHz instead of failing
>> the probe of that bus.
>>
>> This fixes the accelerometer on the Acer Iconia Tab8 not working.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/i2c/busses/i2c-designware-platdrv.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
>> b/drivers/i2c/busses/i2c-designware-platdrv.c
>> index d5acaf8d65bf..c6f5a41d72b5 100644
>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>> @@ -254,6 +254,9 @@ static int dw_i2c_plat_probe(struct
>> platform_device *pdev)
>>   	}
>>   
>>   	acpi_speed = i2c_acpi_find_bus_speed(&pdev->dev);
>> +	/* Some broken DSTDs use 1MiHz instead of 1MHz */
>> +	if (acpi_speed == 1048576)
>> +		acpi_speed = 1000000;
> 
> I would rather convert to choose closest one, though I am not sure at
> all which approach would be better in long term.

We could always choose the closest lower one. I've been thinking
about doing that instead myself.

Wolfram, do you have any opinion on this ?

Regards,

Hans


> 
>>   	/*
>>   	 * Find bus speed from the "clock-frequency" device property,
>> ACPI
>>   	 * or by using fast mode if neither is set.
> 
