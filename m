From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3] ACPI: Force I2C to be selected as a built-in module
Date: Thu, 25 Jan 2018 09:36:47 -0800
Message-ID: <30a108bc-c85f-55d9-67c5-586534a987c0@infradead.org>
References: <1516895011-17588-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0h2TOvoNGx5nYU0yVp_GJCxLTStSY=mp2YMbazhfq3x9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0h2TOvoNGx5nYU0yVp_GJCxLTStSY=mp2YMbazhfq3x9g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Sinan Kaya <okaya@codeaurora.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, Eric Auger <eric.auger@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 01/25/2018 08:25 AM, Rafael J. Wysocki wrote:
> On Thu, Jan 25, 2018 at 4:43 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> From: Auger Eric <eric.auger@redhat.com>
>>
>> If I2C is built as a module, ACPI_I2C_OPREGION cannot be set
>> and any ACPI opregion calls targeting I2C fail with no opregion found.
>>
>> Commit da3c6647ee08 ("I2C/ACPI: Clean up I2C ACPI code and Add
>> CONFIG_I2C_ACPI config") says following:
>>
>> "Current there is a race between removing I2C ACPI operation region
>> and ACPI AML code accessing."
>>
>> This patch forces core I2C support to be compiled as a built-in
>> module if ACPI is selected as code is not ready for dynamic module
>> removal.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  drivers/acpi/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 4650539..5b48098 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -9,6 +9,8 @@ menuconfig ACPI
>>         depends on IA64 || X86 || ARM64
>>         depends on PCI
>>         select PNP
>> +       # force building I2C in on ACPI systems, for opregion availability
>> +       imply I2C
>>         default y if (IA64 || X86)
>>         help
>>           Advanced Configuration and Power Interface (ACPI) support for
>> --
> 
> I'm not sure how much this helps.
> 
> I2C opregions will only work if the requisite I2C controller driver is
> present anyway and this change doesn't guarantee that AFAICS.
> 
> OTOH, there are systems using ACPI without I2C opregions, so are we
> really better off by forcing everybody using ACPI to also build I2C?

Definitely not.

-- 
~Randy
