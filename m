From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: i801: Add support for Intel Broxton
Date: Mon, 26 Oct 2015 10:16:11 +0200
Message-ID: <562DE14B.1080304@linux.intel.com>
References: <1445523418-5166-1-git-send-email-jarkko.nikula@linux.intel.com> <20151025115005.62c834f0@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:18052 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753000AbbJZIQO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 26 Oct 2015 04:16:14 -0400
In-Reply-To: <20151025115005.62c834f0@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi

On 10/25/2015 12:50 PM, Jean Delvare wrote:
>> @@ -204,6 +205,7 @@
>>   #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS	0xa123
>>   #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS	0x9d23
>>   #define PCI_DEVICE_ID_INTEL_DNV_SMBUS			0x19df
>> +#define PCI_DEVICE_ID_INTEL_BROXTON_SMBUS		0x5ad4
>
> Can you please get this added to pci.ids?
>
> http://pci-ids.ucw.cz/read/PC/8086
>
We seems to miss quite many other recent IDs too. I'll take this forward.

>>   struct i801_mux_config {
>>   	char *gpio_chip;
>> @@ -866,6 +868,7 @@ static const struct pci_device_id i801_ids[] = {
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_DNV_SMBUS) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BROXTON_SMBUS) },
>>   	{ 0, }
>>   };
>>
>
> Does this one not have FEATURE_TCO as DNV does? If it does, you'll need
> to add a line for it in the switch block in i801_probe().
>
No, it's specific to sunrisepoint and dnv only at the moment.

> Please also update Documentation/i2c/busses/i2c-i801 and
> drivers/i2c/busses/Kconfig.
>
Ok, will do.

-- 
Jarkko
