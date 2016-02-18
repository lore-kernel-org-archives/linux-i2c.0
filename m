From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: Re: [PATCH V3] i2c: i801: Adding Intel Lewisburg support for iTCO
Date: Wed, 17 Feb 2016 17:21:27 -0800
Message-ID: <56C51C97.8030206@linux.intel.com>
References: <[PATCH V3] i2c: i801: Adding Intel Lewisburg support for iTCO>
 <1454714564-8632-1-git-send-email-alexandra.yates@linux.intel.com>
 <20160210104231.3fa07523@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:50243 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424201AbcBRBRW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 17 Feb 2016 20:17:22 -0500
In-Reply-To: <20160210104231.3fa07523@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jean,

On 02/10/2016 01:42 AM, Jean Delvare wrote:
> Hi Alexandra,
>
> On Fri,  5 Feb 2016 15:22:44 -0800, Alexandra Yates wrote:
>> Changes log v2 to v3: Clarified commit message. No changes in code.
>>
>> Starting from Intel Sunrisepoint (Skylake PCH) the iTCO watchdog
>> resources have been moved to reside under the i801 SMBus host
>> controller whereas previously they were under the LPC device.
>>
>> This patch adds Intel lewisburg SMBus support for iTCO device.
>> It allows to load watchdog dynamically when the hardware is
>> present.  This patch is an addition
>> to cdc5a3110e7c3ae793f367285789a6bc39c962dc i2c: i801: "add
>> Intel Lewisburg device IDs".
>>
>> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
>> ---
>>   drivers/i2c/busses/i2c-i801.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
>> index f62d697..27fa0cb 100644
>> --- a/drivers/i2c/busses/i2c-i801.c
>> +++ b/drivers/i2c/busses/i2c-i801.c
>> @@ -1271,6 +1271,8 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>   	switch (dev->device) {
>>   	case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS:
>>   	case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS:
>> +	case PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS:
>> +	case PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS:
>>   	case PCI_DEVICE_ID_INTEL_DNV_SMBUS:
>>   		priv->features |= FEATURE_I2C_BLOCK_READ;
>>   		priv->features |= FEATURE_IRQ;
>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>
> Note this checkpatch warning though:
>
> ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 0123456789ab ("commit description")'
> #40:
> to cdc5a3110e7c3ae793f367285789a6bc39c962dc i2c: i801: "add
>
> It is also common to add a "Fixes:" line with that information so that

I'm adding all your recommendations.  However, Can you help me 
understand what do you mean by tagging the patch for stable?  I've been 
looking online but I can't find such tag name.

Do you mean CCing the patch to stable mailing list?

> patch backporting can be automated. And as I said before I would tag
> the patch for stable as well.
>

-- 
Thank you,
<Alexandra>
