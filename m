From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v2] i2c: Allow ACPI_I2C_OPREGION if I2C is built as a
 module
Date: Wed, 24 Jan 2018 09:49:52 -0500
Message-ID: <21abc5e6-4afa-bab8-ad87-fafedee6555d@codeaurora.org>
References: <1514988151-12248-1-git-send-email-eric.auger@redhat.com>
 <20180124055615.c3qwhwnj7spmcr3w@ninjato>
 <20180124062725.GK27654@lahna.fi.intel.com>
 <CAHp75VdW6nr3NkDVkqY=XQwfPf4Joov3Sw2EkLg6B+WuTZVkVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58420 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933688AbeAXOtz (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 24 Jan 2018 09:49:55 -0500
In-Reply-To: <CAHp75VdW6nr3NkDVkqY=XQwfPf4Joov3Sw2EkLg6B+WuTZVkVA@mail.gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 1/24/2018 9:46 AM, Andy Shevchenko wrote:
> On Wed, Jan 24, 2018 at 8:27 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
>> On Wed, Jan 24, 2018 at 06:56:16AM +0100, Wolfram Sang wrote:
>>> On Wed, Jan 03, 2018 at 03:02:31PM +0100, Eric Auger wrote:
>>>> If I2C is built as a module, ACPI_I2C_OPREGION cannot be set
>>>> and any ACPI opregion calls targeting I2C fail with no opregion found.
>>>>
>>>> This patch allows ACPI_I2C_OPREGION to be enabled both if I2C is
>>>> built into the kernel or built as a module.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>
>>> I recall that we had some discussion until ending up with the current
>>> solution. And I finally found it again:
>>>
>>> http://www.serverphorums.com/read.php?12,1001402
>>>
>>> In any case, I surely want Mika's ack on any change to ACPI related
>>> Kconfig symbols. Adding him to CC...
>>
>> So the problem is/was that what happens if you are in a middle of BIOS
>> AML code touching the opregion and someone unloads the opregion handler?
>> If you can quarantee nothing bad happens, then I'm fine with the patch :)
> 
> I don't think anyone can guarantee this.
> 
> I would be fine with patch if and only if it has been tested on
> problematic hardware, such as Intel CherryTrail based tablets /
> laptops.
> 

Need some details on what the actual issue is/was.

One would think that ACPI operating region removal would be serialized with
respect to AML execution from 10000 foot view. 

I'm hoping one of you guys would chime into Mika's message.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
