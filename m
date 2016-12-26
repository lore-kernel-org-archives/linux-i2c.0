From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 4/5] i2c: designware-baytrail: Force the CPU to C1
 state while holding the punit semaphore
Date: Mon, 26 Dec 2016 12:07:25 +0100
Message-ID: <e415e26c-8781-6ce1-c0f9-a68249e542d3@redhat.com>
References: <20161210141908.16470-1-hdegoede@redhat.com>
 <20161210141908.16470-4-hdegoede@redhat.com>
 <1481381595.7188.6.camel@linux.intel.com>
 <a1e46965-9cef-1ec0-ddb4-3a527cd71045@redhat.com>
 <5425712f-550e-cc30-3b52-5bd25eabc5d9@redhat.com>
 <CAJvTdKnqdhYo1hTp33z-dUCO3H5sROZQtDdSaGiL_EwW3DbbqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932554AbcLZLHa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 26 Dec 2016 06:07:30 -0500
In-Reply-To: <CAJvTdKnqdhYo1hTp33z-dUCO3H5sROZQtDdSaGiL_EwW3DbbqQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Vincent Gerris <vgerris@gmail.com>, linux-i2c@vger.kernel.org

Hi,

On 25-12-16 19:31, Len Brown wrote:
> Is there a simple way to run a test to keep deep C-states
> and instead disable part or all of i2c on this platform,
> to see how much stability separating the two will buy us?

This should do the trick to completely disable i2c from the kernel
to the pmic, leaving the bus fully free for the punit:

diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
index 1590ad0..fe73271 100644
--- a/drivers/i2c/busses/i2c-designware-baytrail.c
+++ b/drivers/i2c/busses/i2c-designware-baytrail.c
@@ -140,6 +140,7 @@ int i2c_dw_eval_lock_support(struct dw_i2c_dev *dev)

  	if (shared_host) {
  		dev_info(dev->dev, "I2C bus managed by PUNIT\n");
+		return -ENODEV;
  		dev->acquire_lock = baytrail_i2c_acquire;
  		dev->release_lock = baytrail_i2c_release;
  		dev->pm_runtime_disabled = true;

Note that my patch only disabled deep C-states while the kernel
is accessing the pmic i2c bus, not all the time as most other
workarounds are doing.

> A lot of people are struggling w/ the stability of this platform,
> and it would be great to make some progress on that.

I know that many people are seeing these instabilities related
to deep C-states on Baytrail, but the platform I wrote this patch
on is Cherrytrail, which is actually reasonably stable.

Currently on Cherrytrail we effectively do the above -ENODEV,
because the punit semaphore code is using a wrong register offset
on cherrytrail, causing any attempts by the kernel to acquire
the semaphore to always fail. Once the wrong register offset is
fixed I can very reliably freeze my cherrytrail tablet in
seconds by reading *and only reading* from the pmic, e.g. doing:

i2cdump -y -f 6 0x34

Will usually freeze the system on the second attempt, sometimes
on the first / third and that is repeating it manually, so with
long (100-s ms) pauses between runs.

Debugging that lead me to:

https://github.com/01org/ProductionKernelQuilts/blob/master/uefi/cht-m1stable/patches/i2c-dw_i2c-Ported-punit-locking-patch-from-MCG-kerne.patch

Which does the same pm_qos cpu latency tricks as my patch is
doing, any that makes the problem completely go away.

TL;DR: yes there still is a lot to investigate wrt stability
issues on Baytrail, but this patch is needed for Cherrytrail
too, fixes a 100% reproducable problem there and the same
workaround is used in Android x86 too, so I believe it would
be good to merge this regardless of the ongoing Baytrail
investigation.

Regardsm

Hans


> thanks,
> -Len
>
>
>
> On Sat, Dec 10, 2016 at 2:59 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>>
>> On 10-12-16 20:33, Hans de Goede wrote:
>>>
>>> Hi,
>>>
>>> On 10-12-16 15:53, Andy Shevchenko wrote:
>>>>
>>>> +Cc: Len
>>>> Len, I think you would be interested by this.
>>>>
>>>> Hans, thanks for the change!
>>>
>>>
>>> You're welcome I ended up comparing the code in
>>> i2c-dw_i2c-Ported-punit-locking-patch-from-MCG-kerne.patch from:
>>>
>>>
>>> https://github.com/01org/ProductionKernelQuilts/tree/master/uefi/cht-m1stable/patches
>>>
>>> against the mainline code while I was trying to fix the maddening
>>> problem of the entire SoC hanging more or less as soon
>>> as I tried to use the pmic i2c bus and there I found
>>> some fiddling with pm_qos which let to this patch.
>>>
>>>> Most probably we will anticipate Len's ACK
>>>> on this one.
>>>>
>>>> On Sat, 2016-12-10 at 15:19 +0100, Hans de Goede wrote:
>>>>>
>>>>> On my cherrytrail tablet with axp288 pmic, just doing a bunch of
>>>>> repeated
>>>>> reads from the pmic, e.g. "i2cdump -y 14 0x34" would lookup the tablet
>>>>> in
>>>>> 1 - 3 runs guaranteed.
>>>>>
>>>>> This seems to be causes by the cpuidle / intel_idle driver trying to
>>>>> change the C-state while we hold the punit bus semaphore, at which
>>>>> point
>>>>> everything just hangs.
>>>>>
>>>>> Avoid this by forcing the CPU to C1 before acquiring the punit bus
>>>>> semaphore.
>>>>
>>>>
>>>> Isn't it C0? C1 as far as I remember is halted state.
>>>
>>>
>>> You're right, I will fix it.
>>
>>
>> Correction, upon closer reading of the docs, we cannot disallow
>> the CPU to enter C1 / force it to either C0 or C1, what we can
>> disallow is for it to enter C6/C7. Which also makes sense wrt
>> this bug, since entering C6/C7 involves turning of the
>> CPU-core power-plane, which requires the punit to access the pmic.
>>
>> So I've changes the text in both the commit msg and the comment
>> to: "Disallow the CPU to enter C6 or C7"
>>
>> I still need to re-test (just to make sure I did not cause
>> any regressions) and then I'll send a v3.
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>>
>>>>> @@ -33,6 +34,13 @@ static int get_sem(struct dw_i2c_dev *dev, u32
>>>>> *sem)
>>>>>      u32 data;
>>>>>      int ret;
>>>>>
>>>>> +    /*
>>>>> +     * Force CPU to C1 state, otherwise if the cpuidle /
>>>>> intel_idle
>>>>> +     * driver tries to change the C state while we're holding the
>>>>> +     * semaphore, the SoC hangs.
>>>>
>>>>
>>>> C0?
>>>>
>>>>> +     */
>>>>> +    pm_qos_update_request(&dev->pm_qos, 0);
>>>>
>>>>
>>>> C1 is when you set 1 here, right?
>>>
>>>
>>> I believe so, yes.
>>>
>>>>
>>>>> platform_device *pdev)
>>>>>      if (!dev->pm_runtime_disabled)
>>>>>          pm_runtime_disable(&pdev->dev);
>>>>
>>>>
>>>>> +    if (dev->acquire_lock)
>>>>> +        pm_qos_remove_request(&dev->pm_qos);
>>>>> +
>>>>
>>>>
>>>> Perhaps you need to do this in -core.c. Otherwise you missed PCI case.
>>>> (Even with PCI enumerated host with ACPI-enabled firmware you may get
>>>> _SEM object present)
>>>
>>>
>>> Currently only i2c-designware-plardrv.c calls i2c_dw_eval_lock_support()
>>> which does the pm_qos_add_request, so I put it here to keep things
>>> balanced.
>>>
>>> Regards,
>>>
>>> Hans
>
>
>
