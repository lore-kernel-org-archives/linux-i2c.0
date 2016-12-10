From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 4/5] i2c: designware-baytrail: Force the CPU to C1
 state while holding the punit semaphore
Date: Sat, 10 Dec 2016 20:33:08 +0100
Message-ID: <a1e46965-9cef-1ec0-ddb4-3a527cd71045@redhat.com>
References: <20161210141908.16470-1-hdegoede@redhat.com>
 <20161210141908.16470-4-hdegoede@redhat.com>
 <1481381595.7188.6.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752087AbcLJTdL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 10 Dec 2016 14:33:11 -0500
In-Reply-To: <1481381595.7188.6.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Vincent Gerris <vgerris@gmail.com>, linux-i2c@vger.kernel.org

Hi,

On 10-12-16 15:53, Andy Shevchenko wrote:
> +Cc: Len
> Len, I think you would be interested by this.
>
> Hans, thanks for the change!

You're welcome I ended up comparing the code in
i2c-dw_i2c-Ported-punit-locking-patch-from-MCG-kerne.patch from:

https://github.com/01org/ProductionKernelQuilts/tree/master/uefi/cht-m1stable/patches

against the mainline code while I was trying to fix the maddening
problem of the entire SoC hanging more or less as soon
as I tried to use the pmic i2c bus and there I found
some fiddling with pm_qos which let to this patch.

> Most probably we will anticipate Len's ACK
> on this one.
>
> On Sat, 2016-12-10 at 15:19 +0100, Hans de Goede wrote:
>> On my cherrytrail tablet with axp288 pmic, just doing a bunch of
>> repeated
>> reads from the pmic, e.g. "i2cdump -y 14 0x34" would lookup the tablet
>> in
>> 1 - 3 runs guaranteed.
>>
>> This seems to be causes by the cpuidle / intel_idle driver trying to
>> change the C-state while we hold the punit bus semaphore, at which
>> point
>> everything just hangs.
>>
>> Avoid this by forcing the CPU to C1 before acquiring the punit bus
>> semaphore.
>
> Isn't it C0? C1 as far as I remember is halted state.

You're right, I will fix it.

>> @@ -33,6 +34,13 @@ static int get_sem(struct dw_i2c_dev *dev, u32
>> *sem)
>>  	u32 data;
>>  	int ret;
>>
>> +	/*
>> +	 * Force CPU to C1 state, otherwise if the cpuidle /
>> intel_idle
>> +	 * driver tries to change the C state while we're holding the
>> +	 * semaphore, the SoC hangs.
>
> C0?
>
>> +	 */
>> +	pm_qos_update_request(&dev->pm_qos, 0);
>
> C1 is when you set 1 here, right?

I believe so, yes.

>
>> platform_device *pdev)
>>  	if (!dev->pm_runtime_disabled)
>>  		pm_runtime_disable(&pdev->dev);
>
>> +	if (dev->acquire_lock)
>> +		pm_qos_remove_request(&dev->pm_qos);
>> +
>
> Perhaps you need to do this in -core.c. Otherwise you missed PCI case.
> (Even with PCI enumerated host with ACPI-enabled firmware you may get
> _SEM object present)

Currently only i2c-designware-plardrv.c calls i2c_dw_eval_lock_support()
which does the pm_qos_add_request, so I put it here to keep things
balanced.

Regards,

Hans
