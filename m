From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH] i2c: designware: Add support for AMD Seattle I2C
Date: Wed, 16 Dec 2015 08:29:38 -0600
Message-ID: <56717552.4060203@amd.com>
References: <1450216553-5641-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <5670C90A.5020305@amd.com> <20151216091652.GN1762@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn1on0064.outbound.protection.outlook.com ([157.56.110.64]:27280
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933796AbbLPO3t (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 16 Dec 2015 09:29:49 -0500
In-Reply-To: <20151216091652.GN1762@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org



On 12/16/2015 03:16 AM, Mika Westerberg wrote:
> On Tue, Dec 15, 2015 at 08:14:34PM -0600, Suravee Suthikulpanit wrote:
>> Hi Mika,
>>
>> On 12/15/15 15:55, Suravee Suthikulpanit wrote:
>>> Add device HID AMDI0510 to match the I2C controlers on AMD Seattle platform
>>>
>>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>> ---
>>>   drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
>>> index 57f623b..a027154 100644
>>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>>> @@ -117,6 +117,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
>>>   	{ "80860F41", 0 },
>>>   	{ "808622C1", 0 },
>>>   	{ "AMD0010", 0 },
>>> +	{ "AMDI0510", 0 },
>>>   	{ }
>>
>> Since this driver seems to be used by several SOCs, and we have been adding
>> the HID from various SOC vendors. Do you think it would be better to assign
>> a CID so that each SOC vendor can specify in their ACPI DSDT and we can
>> match them here?
>
> Sure _CID would work here.

Do you know if Synopsys has already provided a CID that we can use for 
this? If not, who do you think should provide this?  Also, do you think 
the FMCN and SSCN should be documented somewhere in the spec so that FW 
and OSes can agree upon going forward?

>
>> Then, we can also associate the FMCN and SSCN along with the CID, and
>> guarantee compatibility.
>
> Well, the driver checks those everytime it finds that the device has
> ACPI companion regardless of _HID/_CID.

Not sure what you mean by "device has ACPI companion". Do you mean the 
driver check those for every matched devices here?

Thanks,
Suravee

> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
