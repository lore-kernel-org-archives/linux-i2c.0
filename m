From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 1/3] ACPI: add module autoloading support for ACPI enumerated
 devices
Date: Mon, 14 Oct 2013 15:44:53 +0300
Message-ID: <525BE745.6000305@linux.intel.com>
References: <1381741834-7334-1-git-send-email-rui.zhang@intel.com>  <20131014101423.GE3521@intel.com> <1381749388.2034.28.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381749388.2034.28.camel@rzhang1-mobl4>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi

On 10/14/2013 02:16 PM, Zhang Rui wrote:
> On Mon, 2013-10-14 at 13:14 +0300, Mika Westerberg wrote:
>> For the three patches.
>>
>> I wonder if we should do the same for SPI bus as well?
>>
> yes, you are right.
> Actually, I should check for buses that supports
> acpi_driver_match_device() and fix them all.
> Will add it in next version.
>
You could have my pre- "Tested-by: Jarkko Nikula 
<jarkko.nikula@linux.intel.com>".

With your set I see bunch of failing modprobe calls from udev for 
i2c:INTABCD:xy and platform:INTDCBA:xy modaliases gone.

-- 
Jarkko
