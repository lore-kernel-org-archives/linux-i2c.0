From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Get selected speed mode sda-hold-time
 via ACPI
Date: Mon, 13 Feb 2017 11:33:25 +0200
Message-ID: <9a3c955b-6252-bc25-4b33-8a95e03eddaf@linux.intel.com>
References: <1486726118-19447-1-git-send-email-chin.yew.tan@intel.com>
 <1486726118-19447-2-git-send-email-chin.yew.tan@intel.com>
 <1486729916.2133.444.camel@linux.intel.com>
 <1E48613D81AD0745B344B23C7C5E26B0010043FF@PGSMSX103.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:64107 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751058AbdBMJde (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 13 Feb 2017 04:33:34 -0500
In-Reply-To: <1E48613D81AD0745B344B23C7C5E26B0010043FF@PGSMSX103.gar.corp.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Tan, Chin Yew" <chin.yew.tan@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On 13.02.2017 10:41, Tan, Chin Yew wrote:
>
>> On Fri, 2017-02-10 at 19:28 +0800, chin.yew.tan@intel.com wrote:
>>> From: Tan Chin Yew <chin.yew.tan@intel.com>
>>>
>>> Sda-hold-time is an important parameter for tuning i2c to meet the
>>> electrical specification especially for high speed. I2C with incorrect
>>> sda-hold-time may cause lost arbitration error. Now, the driver is
>>> able to get sda-hold-time for all the speed supported.
>>>
>>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Couple of nitpicks below.
>>
>>> Signed-off-by: Tan Chin Yew <chin.yew.tan@intel.com>
>>> ---
>>>  drivers/i2c/busses/i2c-designware-platdrv.c | 27
>>> ++++++++++++++++++++-------
>>>  1 file changed, 20 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
>>> b/drivers/i2c/busses/i2c-designware-platdrv.c
>>> index 6ce4313..aa33088 100644
>>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>>> @@ -101,15 +101,28 @@ static int dw_i2c_acpi_configure(struct
>>> platform_device *pdev)
>>>  	dev->rx_fifo_depth = 32;
>>>
>>>  	/*
>>> -	 * Try to get SDA hold time and *CNT values from an ACPI
>>> method if
>>> -	 * it exists for both supported speed modes.
>>> +	 * Try to get SDA hold time and *CNT values from an ACPI
>>> method for
>>> +	 * selected speed modes.
>>>  	 */
>>> -	dw_i2c_acpi_params(pdev, "SSCN", &dev->ss_hcnt, &dev-
>>>> ss_lcnt, NULL);
>>> -	dw_i2c_acpi_params(pdev, "FMCN", &dev->fs_hcnt, &dev-
>>>> fs_lcnt,
>>> +	switch (dev->clk_freq) {
>>> +	case 100000:
>>> +		dw_i2c_acpi_params(pdev, "SSCN", &dev->ss_hcnt, &dev-
>>>> ss_lcnt,
>>
>>>  			   &dev->sda_hold_time);
>>
>> This indentation should go in a way that & character in the same column as p
>> (in "p(s" context above).
> I will realign the code according to suggestion.
>
>>
>>> -	dw_i2c_acpi_params(pdev, "FPCN", &dev->fp_hcnt, &dev-
>>>> fp_lcnt, NULL);
>>> -	dw_i2c_acpi_params(pdev, "HSCN", &dev->hs_hcnt, &dev-
>>>> hs_lcnt, NULL);
>>> -
>>> +		break;
>>> +	case 1000000:
>>> +		dw_i2c_acpi_params(pdev, "FPCN", &dev->fp_hcnt, &dev-
>>>> fp_lcnt,
>>> +			   &dev->sda_hold_time);
>>> +		break;
>>> +	case 3400000:
>>> +		dw_i2c_acpi_params(pdev, "HSCN", &dev->hs_hcnt, &dev-
>>>> hs_lcnt,
>>> +			   &dev->sda_hold_time);
>>> +		break;
>>
>> Can we prepend default with
>>
>> case 400000:
>>
>> here?
>>
> Yes, you are right, it is best not to load settings for speed mode that is
> not supported.
>
Andy: I guess you were looking for adding "case 400000:" for readability 
rather than removing the default case?

I think it's best to keep fall back to 400 kHz speed that has been the 
default in this driver in case we get some not supported speed from ACPI.

-- 
Jarkko
