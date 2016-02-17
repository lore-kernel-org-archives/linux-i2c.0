From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: Re: [PATCH V3] i2c: i801: Adding Intel Lewisburg support for iTCO
Date: Wed, 17 Feb 2016 11:10:56 -0800
Message-ID: <56C4C5C0.3090308@linux.intel.com>
References: <1454714564-8632-1-git-send-email-alexandra.yates@linux.intel.com>
 <20160210104231.3fa07523@endymion> <20160212190956.GL1520@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4914 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030437AbcBQTGr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 17 Feb 2016 14:06:47 -0500
In-Reply-To: <20160212190956.GL1520@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 02/12/2016 11:09 AM, Wolfram Sang wrote:
> On Wed, Feb 10, 2016 at 10:42:31AM +0100, Jean Delvare wrote:
>> Hi Alexandra,
>>
>> On Fri,  5 Feb 2016 15:22:44 -0800, Alexandra Yates wrote:
>>> Changes log v2 to v3: Clarified commit message. No changes in code.
>
> This line should be below the "---".
>
>>>
>>> Starting from Intel Sunrisepoint (Skylake PCH) the iTCO watchdog
>>> resources have been moved to reside under the i801 SMBus host
>>> controller whereas previously they were under the LPC device.
>>>
>>> This patch adds Intel lewisburg SMBus support for iTCO device.
>>> It allows to load watchdog dynamically when the hardware is
>>> present.  This patch is an addition
>>> to cdc5a3110e7c3ae793f367285789a6bc39c962dc i2c: i801: "add
>>> Intel Lewisburg device IDs".
>>>
>>> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
>>> ---
>>>   drivers/i2c/busses/i2c-i801.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
>>> index f62d697..27fa0cb 100644
>>> --- a/drivers/i2c/busses/i2c-i801.c
>>> +++ b/drivers/i2c/busses/i2c-i801.c
>>> @@ -1271,6 +1271,8 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>>   	switch (dev->device) {
>>>   	case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS:
>>>   	case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS:
>>> +	case PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS:
>>> +	case PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS:
>>>   	case PCI_DEVICE_ID_INTEL_DNV_SMBUS:
>>>   		priv->features |= FEATURE_I2C_BLOCK_READ;
>>>   		priv->features |= FEATURE_IRQ;
>>
>> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>>
>> Note this checkpatch warning though:
>>
>> ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 0123456789ab ("commit description")'
>> #40:
>> to cdc5a3110e7c3ae793f367285789a6bc39c962dc i2c: i801: "add
>>
>> It is also common to add a "Fixes:" line with that information so that
>> patch backporting can be automated. And as I said before I would tag
>> the patch for stable as well.
>
> Can you do this and resend?
>

Thank you guys for the very constructive feedback.  I'll be resending 
the patches today.

-- 
Thank you,
<Alexandra>
