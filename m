From: Loc Ho <lho@apm.com>
Subject: Re: [PATCH v4] i2c: designware: Do not require clock when SSCN and
 FFCN are provided
Date: Tue, 5 Jan 2016 11:58:01 -0800
Message-ID: <CAPw-ZTkE-K0HXK4Aivm6GMS7CYcN7CZUgk-yjY6_V+uN7+qKHw@mail.gmail.com>
References: <1451920655-10798-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20160104161525.GC1599@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160104161525.GC1599@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, Ken Xue <Ken.Xue@amd.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

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
>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Tested-by: Loc Ho <lho@apm.com>
>> ---
>>
>> Note: This has been tested on AMD Seattle RevB for both DT and ACPI.
>>
>> Changes from V3 (https://lkml.org/lkml/2015/12/22/596):
>>     * Add i2c_dw_plat_prepare_clk() per Andy's suggestion
>>     * Add tested-by Loc Ho.
>
> The changes from V3 are big enough that I'd appreciate a new Tested-by
> tag.
>

Will let you know when I have moment to give this a try on X-Gene.

-Loc
