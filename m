From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v2] i2c: Allow ACPI_I2C_OPREGION if I2C is built as a
 module
Date: Wed, 24 Jan 2018 08:29:44 -0500
Message-ID: <f498c1ef-0e15-3956-8e70-bca53ec2cac4@codeaurora.org>
References: <1514988151-12248-1-git-send-email-eric.auger@redhat.com>
 <20180124055615.c3qwhwnj7spmcr3w@ninjato>
 <20180124062725.GK27654@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180124062725.GK27654@lahna.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

+linux-acpi

On 1/24/2018 1:27 AM, Mika Westerberg wrote:
> On Wed, Jan 24, 2018 at 06:56:16AM +0100, Wolfram Sang wrote:
>> On Wed, Jan 03, 2018 at 03:02:31PM +0100, Eric Auger wrote:
>>> If I2C is built as a module, ACPI_I2C_OPREGION cannot be set
>>> and any ACPI opregion calls targeting I2C fail with no opregion found.
>>>
>>> This patch allows ACPI_I2C_OPREGION to be enabled both if I2C is
>>> built into the kernel or built as a module.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> I recall that we had some discussion until ending up with the current
>> solution. And I finally found it again:
>>
>> http://www.serverphorums.com/read.php?12,1001402
>>
>> In any case, I surely want Mika's ack on any change to ACPI related
>> Kconfig symbols. Adding him to CC...
> 
> So the problem is/was that what happens if you are in a middle of BIOS
> AML code touching the opregion and someone unloads the opregion handler?
> If you can quarantee nothing bad happens, then I'm fine with the patch :)
> 

Rafael to correct me if I got this right.

The behavior of the operating system is well defined in the ACPI specification.

Here is what I tested recently:

ACPI defines _REG method to inform firmware of presence/removal of an operating
region.

When driver gets loaded, ACPI calls the _REG method with 1 argument. When driver
gets unloaded, ACPI call the _REG method with 0 argument. 

Firmware can use this notification to its advantage to determine when an I2C
related functionality should be accessed or not.

If firmware doesn't use the _REG method, ACPI defines that AML statements
accessing the operating region are ignored.

You'll also see a warning from ACPICA saying the OperatingRegion 9 is no longer
accessible and AML code execution failed.

Also note that someone can always unbind an I2C driver from ACPI even with built-in
module.

I think we are talking about an orthogonal issue here.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
