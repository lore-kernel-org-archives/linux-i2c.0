From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 4/5] i2c: designware-baytrail: Force the CPU to C1
 state while holding the punit semaphore
Date: Sun, 25 Dec 2016 13:31:20 -0500
Message-ID: <CAJvTdKnqdhYo1hTp33z-dUCO3H5sROZQtDdSaGiL_EwW3DbbqQ@mail.gmail.com>
References: <20161210141908.16470-1-hdegoede@redhat.com> <20161210141908.16470-4-hdegoede@redhat.com>
 <1481381595.7188.6.camel@linux.intel.com> <a1e46965-9cef-1ec0-ddb4-3a527cd71045@redhat.com>
 <5425712f-550e-cc30-3b52-5bd25eabc5d9@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33759 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932268AbcLYSbV (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 25 Dec 2016 13:31:21 -0500
Received: by mail-qt0-f194.google.com with SMTP id 41so11015749qtn.0
        for <linux-i2c@vger.kernel.org>; Sun, 25 Dec 2016 10:31:21 -0800 (PST)
In-Reply-To: <5425712f-550e-cc30-3b52-5bd25eabc5d9@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Vincent Gerris <vgerris@gmail.com>, linux-i2c@vger.kernel.org

Is there a simple way to run a test to keep deep C-states
and instead disable part or all of i2c on this platform,
to see how much stability separating the two will buy us?

A lot of people are struggling w/ the stability of this platform,
and it would be great to make some progress on that.

thanks,
-Len



On Sat, Dec 10, 2016 at 2:59 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 10-12-16 20:33, Hans de Goede wrote:
>>
>> Hi,
>>
>> On 10-12-16 15:53, Andy Shevchenko wrote:
>>>
>>> +Cc: Len
>>> Len, I think you would be interested by this.
>>>
>>> Hans, thanks for the change!
>>
>>
>> You're welcome I ended up comparing the code in
>> i2c-dw_i2c-Ported-punit-locking-patch-from-MCG-kerne.patch from:
>>
>>
>> https://github.com/01org/ProductionKernelQuilts/tree/master/uefi/cht-m1stable/patches
>>
>> against the mainline code while I was trying to fix the maddening
>> problem of the entire SoC hanging more or less as soon
>> as I tried to use the pmic i2c bus and there I found
>> some fiddling with pm_qos which let to this patch.
>>
>>> Most probably we will anticipate Len's ACK
>>> on this one.
>>>
>>> On Sat, 2016-12-10 at 15:19 +0100, Hans de Goede wrote:
>>>>
>>>> On my cherrytrail tablet with axp288 pmic, just doing a bunch of
>>>> repeated
>>>> reads from the pmic, e.g. "i2cdump -y 14 0x34" would lookup the tablet
>>>> in
>>>> 1 - 3 runs guaranteed.
>>>>
>>>> This seems to be causes by the cpuidle / intel_idle driver trying to
>>>> change the C-state while we hold the punit bus semaphore, at which
>>>> point
>>>> everything just hangs.
>>>>
>>>> Avoid this by forcing the CPU to C1 before acquiring the punit bus
>>>> semaphore.
>>>
>>>
>>> Isn't it C0? C1 as far as I remember is halted state.
>>
>>
>> You're right, I will fix it.
>
>
> Correction, upon closer reading of the docs, we cannot disallow
> the CPU to enter C1 / force it to either C0 or C1, what we can
> disallow is for it to enter C6/C7. Which also makes sense wrt
> this bug, since entering C6/C7 involves turning of the
> CPU-core power-plane, which requires the punit to access the pmic.
>
> So I've changes the text in both the commit msg and the comment
> to: "Disallow the CPU to enter C6 or C7"
>
> I still need to re-test (just to make sure I did not cause
> any regressions) and then I'll send a v3.
>
> Regards,
>
> Hans
>
>
>
>
>>>> @@ -33,6 +34,13 @@ static int get_sem(struct dw_i2c_dev *dev, u32
>>>> *sem)
>>>>      u32 data;
>>>>      int ret;
>>>>
>>>> +    /*
>>>> +     * Force CPU to C1 state, otherwise if the cpuidle /
>>>> intel_idle
>>>> +     * driver tries to change the C state while we're holding the
>>>> +     * semaphore, the SoC hangs.
>>>
>>>
>>> C0?
>>>
>>>> +     */
>>>> +    pm_qos_update_request(&dev->pm_qos, 0);
>>>
>>>
>>> C1 is when you set 1 here, right?
>>
>>
>> I believe so, yes.
>>
>>>
>>>> platform_device *pdev)
>>>>      if (!dev->pm_runtime_disabled)
>>>>          pm_runtime_disable(&pdev->dev);
>>>
>>>
>>>> +    if (dev->acquire_lock)
>>>> +        pm_qos_remove_request(&dev->pm_qos);
>>>> +
>>>
>>>
>>> Perhaps you need to do this in -core.c. Otherwise you missed PCI case.
>>> (Even with PCI enumerated host with ACPI-enabled firmware you may get
>>> _SEM object present)
>>
>>
>> Currently only i2c-designware-plardrv.c calls i2c_dw_eval_lock_support()
>> which does the pm_qos_add_request, so I put it here to keep things
>> balanced.
>>
>> Regards,
>>
>> Hans



-- 
Len Brown, Intel Open Source Technology Center
