From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: Regression: bd698d24b1b57: i2c: designware: Get selected speed
 mode sda-hold-time via ACPI
Date: Fri, 19 May 2017 10:11:29 +0300
Message-ID: <2b97458f-245c-b914-bdff-8805b5b7ccbb@linux.intel.com>
References: <20170509140720.GA21122@red-moon>
 <1494341651.30052.82.camel@linux.intel.com> <20170509155253.GA21475@red-moon>
 <1494346848.30052.84.camel@linux.intel.com> <20170510092450.GA26012@red-moon>
 <1105edd1-8649-66f2-8df8-79aeae61af3a@linux.intel.com>
 <CAKv+Gu-DPNUy=ODRqqVrvO-b04FxkEg8bz=dHzwspU5FqBRnNg@mail.gmail.com>
 <25ff2580-d461-87f2-f61d-2ede10ea4c01@linux.intel.com>
 <CAKv+Gu-=4YXovPTjWWOkN4BTFQt9qYyU781s1Qwx1vvrAMZsyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAKv+Gu-=4YXovPTjWWOkN4BTFQt9qYyU781s1Qwx1vvrAMZsyQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, chin.yew.tan@intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-i2c@vger.kernel.org, ken.xue@amd.com, jeff.wu@amd.com
List-Id: linux-i2c@vger.kernel.org

On 05/18/2017 04:44 PM, Ard Biesheuvel wrote:
> On 18 May 2017 at 14:05, Jarkko Nikula <jarkko.nikula@linux.intel.com> wrote:
>> I have a fix for this. Could you try does it fix the issue for you?
>>
>> http://www.spinics.net/lists/linux-i2c/msg29509.html
>>
>
> Thanks. But the question is really whether we want to change the
> driver so that the DW_IC_SS_SCL_HCNT/DW_IC_SS_SCL_LCNT registers are
> no longer programmed at all when running at a higher speed. Can you
> guarantee that this will not cause any change in behavior in all
> instances of this hardware that are supported currently, no matter how
> they are synthesized and described to the OS? The previous commit only
> affected the platdrv variety AFAIR
>
Obviously I cannot guarantee are there any side effects as I don't know 
the IP. However I forgot one important point: high-speed transfers 
always starts in fast-mode so those timing parameters too are needed 
when bus is configured for high-speed. So best is to write all of them.

-- 
Jarkko
