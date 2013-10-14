From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: Fix modalias for ACPI enumerated I2C devices
Date: Mon, 14 Oct 2013 14:18:44 +0300
Message-ID: <525BD314.5010802@linux.intel.com>
References: <1381414669-26115-1-git-send-email-jarkko.nikula@linux.intel.com> <1381742625.2034.25.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1381742625.2034.25.camel@rzhang1-mobl4>
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On 10/14/2013 12:23 PM, Zhang Rui wrote:
> Hi,
>
> On Thu, 2013-10-10 at 17:17 +0300, Jarkko Nikula wrote:
>> There is a minor fault about ACPI enumerated I2C devices with their modalias
>> attribute. Now modalias is set by device instance not by hardware ID.
>> For example "i2c:INTABCD:00", "i2c:INTABCD:01" etc.
>>
>> This means each device instance gets different modalias which does match
>> with generated modules.alias. Currently this is not problem as matching can
>> happen also with "acpi:INTABCD" modalias.
>>
> IMO, this is not the proper fix for the modalias problem because ACPI
> enumerated I2C device may have compatible ids.
> Instead, we should export all the compatible ids as the modules alias of
> the ACPI enumerated I2C device.
>
> can you please take a look at the patch I sent out earlier?
> https://patchwork.kernel.org/patch/3034991/
> https://patchwork.kernel.org/patch/3035041/
> https://patchwork.kernel.org/patch/3035021/
I see. This makes sense as it avoids that same device has two different 
modaliases from both acpi and other subsystem.

How about modalias nodes in sysfs, should they also reflect what is 
matching uvent?

-- 
Jarkko
