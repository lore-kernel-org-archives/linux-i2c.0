From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 6/6] i2c: designware: Move common probe code into i2c_dw_probe()
Date: Mon, 12 Oct 2015 14:38:07 +0300
Message-ID: <561B9B9F.5070205@linux.intel.com>
References: <1441031493-18938-1-git-send-email-jarkko.nikula@linux.intel.com> <1441031493-18938-7-git-send-email-jarkko.nikula@linux.intel.com> <20151010075725.GF1619@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9702 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751574AbbJLLiJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 12 Oct 2015 07:38:09 -0400
In-Reply-To: <20151010075725.GF1619@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

On 10/10/2015 10:57 AM, Wolfram Sang wrote:
>
>> - I2C Adapter name will be "i2c-designware". Previously adapter name was
>>    "Synopsys DesignWare I2C adapter" for platform and ACPI devices and
>>    "i2c-designware-pci" for PCI devices.
>
> I have a small tendency to make it "Synopsys DesignWare I2C adapter" for
> all cases. Not much, though.
>
Ok, will change.

>> - Interrupt name too will be "i2c-designware". Previous it was platform
>>    device name, ACPI device name or "i2c-designware-pci".
>
> The device name makes them easier to distinguish in case you have
> multiple instantiations.
>
Good point. Bug reports definitely will benefit from it given that we 
have platforms where there are differences between i2c-designware 
instances. Same platform can have different instances enumerated from 
PCI or ACPI and those are registered as platform devices in 
drivers/mfd/intel-lpss.c.

-- 
Jarkko
