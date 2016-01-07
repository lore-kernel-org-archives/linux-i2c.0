From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH v4] i2c: designware: Do not require clock when SSCN and
 FFCN are provided
Date: Wed, 6 Jan 2016 23:05:14 -0600
Message-ID: <568DF20A.3060504@amd.com>
References: <1451920655-10798-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20160104161525.GC1599@katana>
 <CAPw-ZTkkjaWNUmYfB-Wgh6tp6vb9NxzuDSzKROn8xXkxNf31Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAPw-ZTkkjaWNUmYfB-Wgh6tp6vb9NxzuDSzKROn8xXkxNf31Sg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Loc Ho <lho@apm.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, Ken Xue <Ken.Xue@amd.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On 01/06/2016 06:31 PM, Loc Ho wrote:
> Hi All,
>
>>> The current driver uses input clock source frequency to calculate
>>> values for [SS|FS]_[HC|LC] registers. However, when booting ACPI, we do not
>>> currently have a good way to provide the frequency information.
>>> Instead, we can leverage the SSCN and FFCN ACPI methods, which can be used
>>> to directly provide these values. So, the clock information should
>>> no longer be required during probing.
>>>
>>> However, since clk can be invalid, additional checks must be done where
>>> we are making use of it.
>>>
>>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>> Tested-by: Loc Ho <lho@apm.com>
>>> ---
>>>
>>> Note: This has been tested on AMD Seattle RevB for both DT and ACPI.
>>>
>>> Changes from V3 (https://lkml.org/lkml/2015/12/22/596):
>>>      * Add i2c_dw_plat_prepare_clk() per Andy's suggestion
>>>      * Add tested-by Loc Ho.
>>
>> The changes from V3 are big enough that I'd appreciate a new Tested-by
>> tag.
>
> I had tested this via this mixes of test cases:
>
> a. NO APD driver + this patch ==> HCNT/LCNT as expected
> b. with APD driver + this patch ==> HCNT/LCNT as expected
> c. with APD driver + this patch + double the frequency APD driver ==>
> HCNT/LCNT as expected
> d. with APD driver + this patch + double the frequency APD driver +
> comment out the ACPI parameter retrieve ==> HCNT/LCNT changed as
> expected
>
> Therefore, you can add my - Tested-by: Loc Ho <lho@apm.com>
>
> -Loc
>

Thanks Loc,

Suravee
