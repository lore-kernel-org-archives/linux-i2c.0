From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] i2c: designware: don't infer timings described by ACPI
 from clock rate
Date: Fri, 19 May 2017 11:48:07 +0100
Message-ID: <CAKv+Gu8q23ucv_HmqQmXtDC2q7-=o0h_+Fi4c5vbp5E_Or7ssg@mail.gmail.com>
References: <20170519085640.15111-1-ard.biesheuvel@linaro.org>
 <ab57959e-7c00-7f92-8631-5204685c719c@linux.intel.com> <CAKv+Gu-wRmxWnT+5mb19h2Ggq5kS8qU9dMbEgoPK=0b06P0bFw@mail.gmail.com>
 <24ea1db0-e352-6a4e-ab67-41b537351c1f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:33526 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbdESKsJ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 19 May 2017 06:48:09 -0400
Received: by mail-it0-f49.google.com with SMTP id w68so23141341itc.0
        for <linux-i2c@vger.kernel.org>; Fri, 19 May 2017 03:48:08 -0700 (PDT)
In-Reply-To: <24ea1db0-e352-6a4e-ab67-41b537351c1f@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 19 May 2017 at 11:37, Jarkko Nikula <jarkko.nikula@linux.intel.com> wrote:
> On 05/19/2017 01:06 PM, Ard Biesheuvel wrote:
>>
>> On 19 May 2017 at 11:01, Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> wrote:
>>>
>>> On 05/19/2017 11:56 AM, Ard Biesheuvel wrote:
>>>>
>>>>
>>>> Commit bd698d24b1b57 ("i2c: designware: Get selected speed mode
>>>> sda-hold-time via ACPI") updated the logic that reads the timing
>>>> parameters for various I2C bus rates from the DSDT, to only read
>>>> the timing parameters for the currently selected mode.
>>>>
>>>> This causes a WARN_ON() splat on platforms that legally omit the clock
>>>> frequency from the ACPI description, because in the new situation, the
>>>> core I2C designware driver still accesses the fields in the driver
>>>> struct that we no longer populate, and proceeds to calculate them from
>>>> the clock frequency. Since the clock frequency is unspecified, the
>>>> driver complains loudly using a WARN_ON().
>>>>
>>>> So revert back to the old situation, where the struct fields for all
>>>> timings are populated, but retain the new logic which chooses the SDA
>>>> hold time from the timing mode that is currently in use.
>>>>
>>>> Fixes: bd698d24b1b57 ("i2c: designware: Get selected speed mode ...")
>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>> ---
>>>>  drivers/i2c/busses/i2c-designware-platdrv.c | 18 ++++++++++--------
>>>>  1 file changed, 10 insertions(+), 8 deletions(-)
>>>>
>>> Thanks, this is ok to me. Let's add also kudos to Lorenzo:
>>>
>>> Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>>
>>
>> Thanks. I suppose this is going in as a fix? If not, please cc to -stable
>>
> That's not needed as the bd698d24b1b57 came during pre 4.12-rc1 cycle. But
> good to get this into 4.12 due probable regression in high-speed transfers
> and to get rid of log spamming.
>

Agreed. Thanks.
