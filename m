From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] i2c: designware: Round down ACPI provided clk to nearest
 supported clk
Date: Tue, 29 Aug 2017 14:52:33 +0200
Message-ID: <078c7214-230e-2a68-734b-2a01003ee378@redhat.com>
References: <20170829120835.17276-1-hdegoede@redhat.com>
 <1504009379.25945.142.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751286AbdH2Mwf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 29 Aug 2017 08:52:35 -0400
In-Reply-To: <1504009379.25945.142.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

Hi,

On 29-08-17 14:22, Andy Shevchenko wrote:
> On Tue, 2017-08-29 at 14:08 +0200, Hans de Goede wrote:
>> The Lenovo Miix2 8 DSDT contains an i2c clk / bus speed of 1700000 Hz
>> for one if its devices, which is not supported.
>>
>> This is the second DSDT to show up with an unsupported clk in a short
>> time, remove the hardcoded fix for DSDTs with a 1 MiHz clock and
>> simply
>> always round down the clk to the nearest supported value.
>>
>> Reported-by: russianneuromancer@ya.ru
>> Fixes: 682c6c2188 ("i2c: designware: Some broken DSTDs use 1MiHz ...")
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/i2c/busses/i2c-designware-platdrv.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
>> b/drivers/i2c/busses/i2c-designware-platdrv.c
>> index 57248bccadbc..2b98a173136f 100644
>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>> @@ -256,7 +256,8 @@ static int dw_i2c_plat_probe(struct
>> platform_device *pdev)
>>   	struct dw_i2c_dev *dev;
>>   	u32 acpi_speed, ht = 0;
>>   	struct resource *mem;
>> -	int irq, ret;
>> +	int i, irq, ret;
>> +	const int supported_speeds[] = { 0, 100000, 400000, 1000000,
>> 3400000 };
>>   
>>   	irq = platform_get_irq(pdev, 0);
>>   	if (irq < 0)
>> @@ -297,9 +298,16 @@ static int dw_i2c_plat_probe(struct
>> platform_device *pdev)
>>   	}
>>   
>>   	acpi_speed = i2c_acpi_find_bus_speed(&pdev->dev);
>> -	/* Some broken DSTDs use 1MiHz instead of 1MHz */
>> -	if (acpi_speed == 1048576)
>> -		acpi_speed = 1000000;
>> +	/*
>> +	 * Some DSTDs use a non standard speed, round down to the
>> lowest
>> +	 * standard speed.
>> +	 */
>> +	for (i = 1; i < ARRAY_SIZE(supported_speeds); i++) {
>> +		if (acpi_speed < supported_speeds[i])
>> +			break;
>> +	}
>> +	acpi_speed = supported_speeds[i - 1];
> 
> I dunno what standard says if we may or may not use 100 kHz as a last
> resort even for speeds defined less than 100 kHz.

The < 100000 case is for when i2c_acpi_find_bus_speed() returns 0, so
that we then keep it 0, in which case the code a bit lower will pick
a default. Since speeds < 100000 are clearly not valid treating them
as ACPI not providing any bus-speed info seems sensible to me.

Regards,

Hans
