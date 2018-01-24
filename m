From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] i2c: Allow ACPI_I2C_OPREGION if I2C is built as a
 module
Date: Wed, 24 Jan 2018 15:59:13 +0100
Message-ID: <54ef10bd-6209-6983-1d3a-ddf7d7fea252@redhat.com>
References: <1514988151-12248-1-git-send-email-eric.auger@redhat.com>
 <20180124055615.c3qwhwnj7spmcr3w@ninjato>
 <20180124062725.GK27654@lahna.fi.intel.com>
 <f498c1ef-0e15-3956-8e70-bca53ec2cac4@codeaurora.org>
 <CAHp75VexHQS20azPFO5uv+sBQ4QYVXL+yhT56EhT+QmNZfzMFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAHp75VexHQS20azPFO5uv+sBQ4QYVXL+yhT56EhT+QmNZfzMFg@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Sinan Kaya <okaya@codeaurora.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On 24-01-18 15:44, Andy Shevchenko wrote:
> On Wed, Jan 24, 2018 at 3:29 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> +linux-acpi
> 
> +Cc: Hans

Thank you.

>> On 1/24/2018 1:27 AM, Mika Westerberg wrote:
>>> On Wed, Jan 24, 2018 at 06:56:16AM +0100, Wolfram Sang wrote:
>>>> On Wed, Jan 03, 2018 at 03:02:31PM +0100, Eric Auger wrote:
>>>>> If I2C is built as a module, ACPI_I2C_OPREGION cannot be set
>>>>> and any ACPI opregion calls targeting I2C fail with no opregion found.
>>>>>
>>>>> This patch allows ACPI_I2C_OPREGION to be enabled both if I2C is
>>>>> built into the kernel or built as a module.
>>>>>
>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>
>>>> I recall that we had some discussion until ending up with the current
>>>> solution. And I finally found it again:
>>>>
>>>> http://www.serverphorums.com/read.php?12,1001402
>>>>
>>>> In any case, I surely want Mika's ack on any change to ACPI related
>>>> Kconfig symbols. Adding him to CC...
>>>
>>> So the problem is/was that what happens if you are in a middle of BIOS
>>> AML code touching the opregion and someone unloads the opregion handler?
>>> If you can quarantee nothing bad happens, then I'm fine with the patch :)
>>>
>>
>> Rafael to correct me if I got this right.
>>
>> The behavior of the operating system is well defined in the ACPI specification.
>>
>> Here is what I tested recently:
>>
>> ACPI defines _REG method to inform firmware of presence/removal of an operating
>> region.
>>
>> When driver gets loaded, ACPI calls the _REG method with 1 argument. When driver
>> gets unloaded, ACPI call the _REG method with 0 argument.
>>
>> Firmware can use this notification to its advantage to determine when an I2C
>> related functionality should be accessed or not.
>>
>> If firmware doesn't use the _REG method, ACPI defines that AML statements
>> accessing the operating region are ignored.
>>
>> You'll also see a warning from ACPICA saying the OperatingRegion 9 is no longer
>> accessible and AML code execution failed.
>>

There is the ACPI specification, and then there is reality. In reality many
DSTDs do not use the typically named AVB? counter-part of _REG to check before
accessing OpRegions.

Also OpRegion availability vs probe ordering is a nightmare.

Lets pretend that all DSTDs are perfect and that some device described in ACPI
has a _PS0 method which uses an opregion to turn on some regulator powering
the device through i2c, but only if the _REG method for that opregion has
been called. So now lets say that the driver for this device loads and
tries to bind before the i2c-module has loaded. Before the driver's probe
method gets called the driver-core will call _PS0 to power-up the device,
which is a nop (*). Then the drivers probe function tries to talk to the
device, but fails as the device is not powered, so it returns with -ENODEV.

And then later the i2c-module loads, which is to late to get things working,
unless the user rmmods and modprobes the driver for the device manually.

TL;DR: I have to NAK this, I'm sorry but with the current state of ACPI we
must simply have some stuff builtin to help with probe-ordering issues. Now
if the ACPI code where ever to honor the _DEP method everywhere instead of
only for battery devices this might change, but even then things will still
be tricky.

Regards,

Hans

*) Typically while logging errors about unavailable OpRegions, but as said
lets pretend DSTDs actually check the flags set by _REG everywhere.
