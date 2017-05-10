From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: Regression: bd698d24b1b57: i2c: designware: Get selected speed
 mode sda-hold-time via ACPI
Date: Wed, 10 May 2017 16:55:32 +0300
Message-ID: <1105edd1-8649-66f2-8df8-79aeae61af3a@linux.intel.com>
References: <20170509140720.GA21122@red-moon>
 <1494341651.30052.82.camel@linux.intel.com> <20170509155253.GA21475@red-moon>
 <1494346848.30052.84.camel@linux.intel.com> <20170510092450.GA26012@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:35592 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbdEJNzh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 10 May 2017 09:55:37 -0400
In-Reply-To: <20170510092450.GA26012@red-moon>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: chin.yew.tan@intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, ken.xue@amd.com, jeff.wu@amd.com

On 05/10/2017 12:24 PM, Lorenzo Pieralisi wrote:
> On Tue, May 09, 2017 at 07:20:48PM +0300, Andy Shevchenko wrote:
>>>> It means either ID is not added to drivers/acpi/acpi_apd.c or
>>
>> Just one question, did you look at all into above driver?
>> I suppose it missed ID and properties for the device.
>
> I looked into it yes. I have also looked at ACPI tables and they
> contain the SSCN and FMCN methods and AFAIK the set-up was working
> fine before the commit in $SUBJECT - AMD guys - please correct me
> if I am wrong, I found this thread which explains things a bit:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/395983.html
>
> If we have to patch drivers/acpi/acpi_apd.c to restore the previous
> behaviour that's fine by me but this is a regression nonetheless unless
> someone explains to me why the current firmware set-up (with SSCN and
> FMCN) is unreliable/deprecated, it is not clear to me at all and it
> may affect other platforms too.
>
I guess best would be to fix the i2c_dw_init(). Maybe by moving timing 
parameters settings out to another function, do setting only for 
selected speed and calculate only once in case parameters are not set.

I don't think timing parameters for standard or fast speeds are not 
needed unless operating at those speeds but have to check that first. At 
least that's what we are doing for high speed.

-- 
Jarkko
