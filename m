From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 1/2] i2c: designware: Re-init controllers with pm_disabled
 set on resume
Date: Thu, 30 Aug 2018 16:55:04 +0300
Message-ID: <413b4279-fc24-7334-4290-82ec7bd6e7e7@linux.intel.com>
References: <20180829130632.31111-1-hdegoede@redhat.com>
 <20180829160846.GA8462@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180829160846.GA8462@smile.fi.intel.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, "4 . 15+" <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 08/29/2018 07:08 PM, Andy Shevchenko wrote:
> On Wed, Aug 29, 2018 at 03:06:31PM +0200, Hans de Goede wrote:
>> On Bay Trail and Cherry Trail devices we set the pm_disabled flag for I2C
>> busses which the OS shares with the PUNIT as these need special handling.
>> Until now we called dev_pm_syscore_device(dev, true) for I2C controllers
>> with this flag set to keep these I2C controllers always on.
>>
>> After commit 12864ff8545f ("ACPI / LPSS: Avoid PM quirks on suspend and
>> resume from hibernation"), this no longer works. This commit modifies
>> lpss_iosf_exit_d3_state() to only run if lpss_iosf_enter_d3_state() has ran
>> before it, so that it does not run on a resume from hibernate (or from S3).
>>
>> On these systems the conditions for lpss_iosf_enter_d3_state() to run
>> never become true, so lpss_iosf_exit_d3_state() never gets called and
>> the 2 LPSS DMA controllers never get forced into D0 mode, instead they
>> are left in their default automatic power-on when needed mode.
>>
>> The not forcing of D0 mode for the DMA controllers enables these systems
>> to properly enter S0ix modes, which is a good thing.
>>
>> But after entering S0ix modes the I2C controller connected to the PMIC
>> no longer works, leading to e.g. broken battery monitoring.
>>
>> The _PS3 method for this I2C controller looks like this:
>>
>>              Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
>>              {
>>                  If ((((PMID == 0x04) || (PMID == 0x05)) || (PMID == 0x06)))
>>                  {
>>                      Return (Zero)
>>                  }
>>
>>                  PSAT |= 0x03
>>                  Local0 = PSAT /* \_SB_.I2C5.PSAT */
>>              }
>>
>> Where PMID = 0x05, so we enter the Return (Zero) path on these systems.
>>
>> So even if we were to not call dev_pm_syscore_device(dev, true) the
>> I2C controller will be left in D0 rather then be switched to D3.
>>
>> Yet on other Bay and Cherry Trail devices S0ix is not entered unless *all*
>> I2C controllers are in D3 mode. This combined with the I2C controller no
>> longer working now that we reach S0ix states on these systems leads to me
>> believing that the PUNIT itself puts the I2C controller in D3 when all
>> other conditions for entering S0ix states are true.
>>
>> Since now the I2C controller is put in D3 over a suspend/resume we must
>> re-initialize it afterwards and that does indeed fix it no longer working.
>>
>> This commit implements this fix by:
>>
>> 1) Making the suspend_late callback a no-op if pm_disabled is set and
>> making the resume_early callback skip the clock re-enable (since it now was
>> not disabled) while still doing the necessary I2C controller re-init.
>>
>> 2) Removing the dev_pm_syscore_device(dev, true) call, so that the suspend
>> and resume callbacks are actually called. Normally this would cause the
>> ACPI pm code to call _PS3 putting the I2C controller in D3, wreaking havoc
>> since it is shared with the PUNIT, but in this special case the _PS3 method
>> is a no-op so we can safely allow a "fake" suspend / resume.
>>
> 
> Oh, this hardware platform design in a real PITA.
> Thank you for so good analysis!
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> for both patches.
> 
I tried to see does our Bay Trail and Cherry Trail devices show any 
issue before this patch but didn't see. They are without the battery and 
maybe I didn't manage to trigger PUNIT. Anyway for this patch,

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
