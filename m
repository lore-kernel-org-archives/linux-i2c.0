From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: Regression: bd698d24b1b57: i2c: designware: Get selected speed
 mode sda-hold-time via ACPI
Date: Thu, 18 May 2017 16:05:00 +0300
Message-ID: <25ff2580-d461-87f2-f61d-2ede10ea4c01@linux.intel.com>
References: <20170509140720.GA21122@red-moon>
 <1494341651.30052.82.camel@linux.intel.com> <20170509155253.GA21475@red-moon>
 <1494346848.30052.84.camel@linux.intel.com> <20170510092450.GA26012@red-moon>
 <1105edd1-8649-66f2-8df8-79aeae61af3a@linux.intel.com>
 <CAKv+Gu-DPNUy=ODRqqVrvO-b04FxkEg8bz=dHzwspU5FqBRnNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAKv+Gu-DPNUy=ODRqqVrvO-b04FxkEg8bz=dHzwspU5FqBRnNg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, chin.yew.tan@intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-i2c@vger.kernel.org, ken.xue@amd.com, jeff.wu@amd.com
List-Id: linux-i2c@vger.kernel.org

On 05/18/2017 03:24 PM, Ard Biesheuvel wrote:
> On 10 May 2017 at 14:55, Jarkko Nikula <jarkko.nikula@linux.intel.com> wrote:
>> On 05/10/2017 12:24 PM, Lorenzo Pieralisi wrote:
>>>
>>> On Tue, May 09, 2017 at 07:20:48PM +0300, Andy Shevchenko wrote:
>>>>>>
>>>>>> It means either ID is not added to drivers/acpi/acpi_apd.c or
>>>>
>>>>
>>>> Just one question, did you look at all into above driver?
>>>> I suppose it missed ID and properties for the device.
>>>
>>>
>>> I looked into it yes. I have also looked at ACPI tables and they
>>> contain the SSCN and FMCN methods and AFAIK the set-up was working
>>> fine before the commit in $SUBJECT - AMD guys - please correct me
>>> if I am wrong, I found this thread which explains things a bit:
>>>
>>>
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/395983.html
>>>
>>> If we have to patch drivers/acpi/acpi_apd.c to restore the previous
>>> behaviour that's fine by me but this is a regression nonetheless unless
>>> someone explains to me why the current firmware set-up (with SSCN and
>>> FMCN) is unreliable/deprecated, it is not clear to me at all and it
>>> may affect other platforms too.
>>>
>> I guess best would be to fix the i2c_dw_init(). Maybe by moving timing
>> parameters settings out to another function, do setting only for selected
>> speed and calculate only once in case parameters are not set.
>>
>> I don't think timing parameters for standard or fast speeds are not needed
>> unless operating at those speeds but have to check that first. At least
>> that's what we are doing for high speed.
>>
>
> Commit bd698d24b1b57 is broken and should be reverted: the splat on
> AMD Seattle is the most visible symptom, but the logic change results
> in DW_IC_SS_SCL_HCNT/DW_IC_SS_SCL_LCNT possibly being set to different
> values than specified by the ACPI methods. The missing clock splat is
> only a symptom of this: the driver tries to calculate values from the
> clock frequency that should have been read from the DSDT.
>
> For reference, this is the description we have on the platform in question:
>
>             Method (SSCN, 0, NotSerialized)
>             {
>                 Return (Package (0x03)
>                 {
>                     0x0430,
>                     0x04E1,
>                     0x00
>                 })
>             }
>
>             Method (FMCN, 0, NotSerialized)
>             {
>                 Return (Package (0x03)
>                 {
>                     0x00DE,
>                     0x018F,
>                     0x00
>                 })
>             }
>
> Whether it hurts to program different standard mode values here is
> irrelevant. It is simply wrong.
>
I have a fix for this. Could you try does it fix the issue for you?

http://www.spinics.net/lists/linux-i2c/msg29509.html

-- 
Jarkko
