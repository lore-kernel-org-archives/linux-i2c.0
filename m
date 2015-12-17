From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v2] i2c: designware: Do not require clock when SSCN and
 FFCN are provided
Date: Wed, 16 Dec 2015 21:01:53 -0600
Message-ID: <567225A1.7020001@amd.com>
References: <1450319025-19120-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <CAPw-ZTkMm1c6tLkEMiDrE=TENeUe3bm+U+CFHw231ngzWMqPuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAPw-ZTkMm1c6tLkEMiDrE=TENeUe3bm+U+CFHw231ngzWMqPuQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Loc Ho <lho@apm.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, wsa@the-dreams.de, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, Ken Xue <Ken.Xue@amd.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 12/16/2015 8:56 PM, Loc Ho wrote:
> Hi,
>
>> The current driver uses input clock source frequency to calculate
>> values for [SS|FS]_[HC|LC] registers. However, when booting ACPI, we do not
>> currently have a good way to provide the frequency information.
>> Instead, we can leverage the SSCN and FFCN ACPI methods, which can be used
>> to directly provide these values. So, the clock information should
>> no longer be required during probing.
>>
>> However, since clk can be invalid, additional checks must be done where
>> we are making use of it.
>>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> ---
>>
>> Note: This has been tested on AMD Seattle RevB for both DT and ACPI.
>
> Tested on X-Gene hardware also.
>
> -Loc
>

Thanks for quick response.
Suravee
