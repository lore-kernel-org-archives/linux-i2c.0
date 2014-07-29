From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: i2c-davinci.c: CPU FREQ causes lock up due to xfr_complete
Date: Tue, 29 Jul 2014 20:30:44 +0300
Message-ID: <53D7DA44.2070108@ti.com>
References: <CADL8D3YchqfT+ikKTCkLNLmwm2HYKDzZy-g4T+mJLYBJ1rC72Q@mail.gmail.com> <2588C357BB271A4CA8E86BCFF043FA920C4ACE9D@EFJDFWMB01.EFJDFW.local> <CADL8D3aQ4idMNYZn-sK=8x9+NrVj=4p58C+ir8ZAngDavGB3-A@mail.gmail.com> <CADL8D3a2gjbGZibENYNfvWrvGun82ZDm7A+i8NJRBKdRvMvgdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CADL8D3a2gjbGZibENYNfvWrvGun82ZDm7A+i8NJRBKdRvMvgdQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Cormier <jcormier-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>, Brian Niebuhr <BNiebuhr-0skhLfht8co@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Tim Iskander <tim.iskander-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>, Mike Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >> linux-i2c" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jon,

On 07/29/2014 06:53 PM, Jon Cormier wrote:
> A slimmer patch suggested by Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>


Ok. The problem seems to be deeper than at first look.
You have sequence (in Mainline kernel):
cpufreq:
 |- notify CPUFREQ_PRECHANGE
    |- i2c-davinci will lock & put I2C in reset
 |- cpufreq_driver->target_index
    |- davinci_target()
       |- pdata->set_voltage() - It will try to use I2C to set new voltage,
       while I2C is in reset or locked! Bug!
 |- notify CPUFREQ_POSTCHANGE
    |- i2c-davinci will re-enable I2C and adjust I2C clock

I see few possible ways to solve it:
1) use CLK notifier instead of CPUfreq notifiers
2) do smth similar to "61c7cff8 i2c: S3C24XX I2C frequency scaling support"
  + "9bcd04bf i2c: s3c2410: grab adapter lock while changing i2c clock"
3) update I2C clock in CPUFREQ_POSTCHANGE - may be unsafe

Regards,
-grygorii

> 
> Author: Cormier, Jonathan <jcormier-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
> Date:   Tue Jul 29 11:50:04 2014 -0400
> 
>      i2c: davinci: Change xfr_complete completion to use i2c_lock_adapter
> 
>      There are several problems with the use of a completion for this task:
> 
>      1. If no I2C transfer has occurred, a cpufreq transition will block forever.
>      2. Once an I2C transfer has occurred the cpufreq transition will
> never block since the completion is never reinitialized.
>      3. Even if you do reinitialize the completion for every I2C
> transfer, (1) is not solved and there is still a race condition where
> the cpufreq transition could start just before an I2C transfer starts
> and the I2C transfer occurs during the cpufreq transition.
> 
>      Author: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
>      Author: Cormier, Jonathan <jcormier-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
>      Signed-off-by: Cormier, Jonathan <jcormier-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
> 
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index a76d85f..f8e7b7f 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -111,7 +111,6 @@ struct davinci_i2c_dev {
>       u8            terminate;
>       struct i2c_adapter    adapter;
>   #ifdef CONFIG_CPU_FREQ
> -    struct completion    xfr_complete;
>       struct notifier_block    freq_transition;
>   #endif
>   };
> @@ -452,10 +451,6 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct
> i2c_msg msgs[], int num)
>               return ret;
>       }
> 
> -#ifdef CONFIG_CPU_FREQ
> -    complete(&dev->xfr_complete);
> -#endif
> -
>       return num;
>   }
> 
> @@ -596,11 +591,12 @@ static int i2c_davinci_cpufreq_transition(struct
> notifier_block *nb,
> 
>       dev = container_of(nb, struct davinci_i2c_dev, freq_transition);
>       if (val == CPUFREQ_PRECHANGE) {
> -        wait_for_completion(&dev->xfr_complete);
> +        i2c_lock_adapter(&dev->adapter);
>           davinci_i2c_reset_ctrl(dev, 0);
>       } else if (val == CPUFREQ_POSTCHANGE) {
>           i2c_davinci_calc_clk_dividers(dev);
>           davinci_i2c_reset_ctrl(dev, 1);
> +        i2c_unlock_adapter(&dev->adapter);
>       }
> 
>       return 0;
> @@ -669,9 +665,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>       }
> 
>       init_completion(&dev->cmd_complete);
> -#ifdef CONFIG_CPU_FREQ
> -    init_completion(&dev->xfr_complete);
> -#endif
> +
>       dev->dev = get_device(&pdev->dev);
>       dev->irq = irq->start;
>       platform_set_drvdata(pdev, dev);
> 
> On Tue, Jul 29, 2014 at 11:36 AM, Jon Cormier <jcormier-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org> wrote:
>> Okay here is my attempt.
>>
>> Author: Cormier, Jonathan <jcormier-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
>> Date:   Tue Jul 29 11:26:22 2014 -0400
>>
>>      i2c: davinci: Change xfr_complete completion to a mutex
>>
>>      There are several problems with the use of a completion for this task:
>>
>>      1. If no I2C transfer has occurred, a cpufreq transition will block forever.
>>      2. Once an I2C transfer has occurred the cpufreq transition will
>> never block since the completion is never reinitialized.
>>      3. Even if you do reinitialize the completion for every I2C
>> transfer, (1) is not solved and there is still a race condition where
>> the cpufreq transition could start just before an I2C transfer starts
>> and the I2C transfer occurs during the cpufreq transition.
>>
>>      Signed-off-by: Cormier, Jonathan <jcormier-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
>>
>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
>> index a76d85f..9eac1c1 100644
>> --- a/drivers/i2c/busses/i2c-davinci.c
>> +++ b/drivers/i2c/busses/i2c-davinci.c
>> @@ -111,7 +111,7 @@ struct davinci_i2c_dev {
>>       u8            terminate;
>>       struct i2c_adapter    adapter;
>>   #ifdef CONFIG_CPU_FREQ
>> -    struct completion    xfr_complete;
>> +    struct mutex        xfr_lock;
>>       struct notifier_block    freq_transition;
>>   #endif
>>   };
>> @@ -438,10 +438,14 @@ i2c_davinci_xfer(struct i2c_adapter *adap,
>> struct i2c_msg msgs[], int num)
>>
>>       dev_dbg(dev->dev, "%s: msgs: %d\n", __func__, num);
>>
>> +#ifdef CONFIG_CPU_FREQ
>> +    mutex_lock(&dev->xfr_lock);
>> +#endif
>> +
>>       ret = i2c_davinci_wait_bus_not_busy(dev, 1);
>>       if (ret < 0) {
>>           dev_warn(dev->dev, "timeout waiting for bus ready\n");
>> -        return ret;
>> +        goto exit;
>>       }
>>
>>       for (i = 0; i < num; i++) {
>> @@ -449,14 +453,17 @@ i2c_davinci_xfer(struct i2c_adapter *adap,
>> struct i2c_msg msgs[], int num)
>>           dev_dbg(dev->dev, "%s [%d/%d] ret: %d\n", __func__, i + 1, num,
>>               ret);
>>           if (ret < 0)
>> -            return ret;
>> +            goto exit;
>>       }
>> +    ret = num;
>> +
>> +exit:
>>
>>   #ifdef CONFIG_CPU_FREQ
>> -    complete(&dev->xfr_complete);
>> +    mutex_unlock(&dev->xfr_lock);
>>   #endif
>>
>> -    return num;
>> +    return ret;
>>   }
>>
>>   static u32 i2c_davinci_func(struct i2c_adapter *adap)
>> @@ -596,11 +603,16 @@ static int i2c_davinci_cpufreq_transition(struct
>> notifier_block *nb,
>>
>>       dev = container_of(nb, struct davinci_i2c_dev, freq_transition);
>>       if (val == CPUFREQ_PRECHANGE) {
>> -        wait_for_completion(&dev->xfr_complete);
>> +#ifdef CONFIG_CPU_FREQ
>> +        mutex_lock(&dev->xfr_lock);
>> +#endif
>>           davinci_i2c_reset_ctrl(dev, 0);
>>       } else if (val == CPUFREQ_POSTCHANGE) {
>>           i2c_davinci_calc_clk_dividers(dev);
>>           davinci_i2c_reset_ctrl(dev, 1);
>> +#ifdef CONFIG_CPU_FREQ
>> +        mutex_unlock(&dev->xfr_lock);
>> +#endif
>>       }
>>
>>       return 0;
>> @@ -670,7 +682,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>>
>>       init_completion(&dev->cmd_complete);
>>   #ifdef CONFIG_CPU_FREQ
>> -    init_completion(&dev->xfr_complete);
>> +    mutex_init(&dev->xfr_lock);
>>   #endif
>>       dev->dev = get_device(&pdev->dev);
>>       dev->irq = irq->start;
>>
>>
>>
>> I'm using the 3.2 branch and the above patch revealed another bug.
>>
>>
>> INFO: task sh:2144 blocked for more than 120 seconds.
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> sh              D c03262f0     0  2144   1383 0x00000000
>> [<c03262f0>] (__schedule+0x350/0x3b0) from [<c03270f4>]
>> (__mutex_lock_slowpath+0
>> x90/0x100)
>> [<c03270f4>] (__mutex_lock_slowpath+0x90/0x100) from [<c021dde4>]
>> (i2c_davinci_x
>> fer+0x30/0x30c)
>> [<c021dde4>] (i2c_davinci_xfer+0x30/0x30c) from [<c021c310>]
>> (i2c_transfer+0xbc/                                             0x110)
>> [<c021c310>] (i2c_transfer+0xbc/0x110) from [<c021c3e8>]
>> (i2c_master_send+0x38/0
>> x48)
>> [<c021c3e8>] (i2c_master_send+0x38/0x48) from [<c01a06f0>]
>> (regmap_i2c_write+0x1
>> 0/0x2c)
>> [<c01a06f0>] (regmap_i2c_write+0x10/0x2c) from [<c019e584>]
>> (_regmap_raw_write+0
>> xa4/0x144)
>> [<c019e584>] (_regmap_raw_write+0xa4/0x144) from [<c019ed44>]
>> (regmap_write+0x24                                             /0x38)
>> [<c019ed44>] (regmap_write+0x24/0x38) from [<c01728e0>]
>> (tps65023_dcdc_set_volta
>> ge+0xc0/0xe8)
>> [<c01728e0>] (tps65023_dcdc_set_voltage+0xc0/0xe8) from [<c0170efc>]
>> (_regulator
>> _do_set_voltage+0x3c/0x1d0)
>> [<c0170efc>] (_regulator_do_set_voltage+0x3c/0x1d0) from [<c0171f74>]
>> (regulator
>> _set_voltage+0xb8/0xcc)
>> [<c0171f74>] (regulator_set_voltage+0xb8/0xcc) from [<c0014360>]
>> (davinci_target
>> +0xcc/0x14c)
>> [<c0014360>] (davinci_target+0xcc/0x14c) from [<c021e5b8>]
>> (__cpufreq_driver_tar
>> get+0x2c/0x3c)
>> [<c021e5b8>] (__cpufreq_driver_target+0x2c/0x3c) from [<c0220328>]
>> (cpufreq_set+                                             0x54/0x70)
>> [<c0220328>] (cpufreq_set+0x54/0x70) from [<c021e9f8>]
>> (store_scaling_setspeed+0
>> x58/0x6c)
>> [<c021e9f8>] (store_scaling_setspeed+0x58/0x6c) from [<c021f954>]
>> (store+0x58/0x                                             70)
>> [<c021f954>] (store+0x58/0x70) from [<c00cea58>] (sysfs_write_file+0x108/0x140)
>> [<c00cea58>] (sysfs_write_file+0x108/0x140) from [<c0081eb0>]
>> (vfs_write+0xb0/0x                                             138)
>> [<c0081eb0>] (vfs_write+0xb0/0x138) from [<c0082110>] (sys_write+0x3c/0x68)
>> [<c0082110>] (sys_write+0x3c/0x68) from [<c00093a0>] (ret_fast_syscall+0x0/0x2c)
>>
>> davinci_target was notifying CPUFREQ_PRECHANGE before calling
>> set_voltage which relied tried talking to the pmic over i2c causing a
>> hang.
>>
>> @@ -101,17 +101,17 @@ static int davinci_target(struct cpufreq_policy *policy,
>>
>>          cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
>>
>>          /* if moving to higher frequency, up the voltage beforehand */
>>          if (pdata->set_voltage && freqs.new > freqs.old) {
>>                  ret = pdata->set_voltage(idx);
>>                  if (ret)
>>                          goto out;
>>          }
>>
>> I fixed this by moving the cpufreq_notifiy.  This doesn't apply to the
>> later kernels as the davinci cpufreq driver has changed quite a bit.
>> Unfortunately I don't have the setup to test a patch against a newer
>> kernel right now.
>>
>> Author: Cormier, Jonathan <jcormier-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
>> Date:   Tue Jul 29 11:22:50 2014 -0400
>>
>>      ARM: DAVINCI: Reorder cpufreq_nofity_transistion so that
>> set_voltage happens first.
>>
>>      set_voltage may make use of the i2c bus to communicate with the
>> PMIC.  In this case we dont want the i2c to reset until after we set
>> the voltage.
>>
>>      Signed-off-by: Cormier, Jonathan <jcormier-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
>>
>> diff --git a/arch/arm/mach-davinci/cpufreq.c b/arch/arm/mach-davinci/cpufreq.c
>> index 5bba707..cbaee6c 100644
>> --- a/arch/arm/mach-davinci/cpufreq.c
>> +++ b/arch/arm/mach-davinci/cpufreq.c
>> @@ -102,8 +102,6 @@ static int davinci_target(struct cpufreq_policy *policy,
>>       if (ret)
>>           return -EINVAL;
>>
>> -    cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
>> -
>>       /* if moving to higher frequency, up the voltage beforehand */
>>       if (pdata->set_voltage && freqs.new > freqs.old) {
>>           ret = pdata->set_voltage(idx);
>> @@ -111,6 +109,8 @@ static int davinci_target(struct cpufreq_policy *policy,
>>               goto out;
>>       }
>>
>> +    cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
>> +
>>       ret = clk_set_rate(armclk, idx);
>>       if (ret)
>>           goto out;
>>
>> On Tue, Jul 29, 2014 at 10:38 AM, Brian Niebuhr <BNiebuhr-0skhLfht8co@public.gmane.org> wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
>>>> [mailto:davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org] On
>>>> Behalf Of Jon Cormier
>>>> Sent: Tuesday, July 29, 2014 9:20 AM
>>>> To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
>>>> Cc: Tim Iskander
>>>> Subject: i2c-davinci.c: CPU FREQ causes lock up due to xfr_complete
>>>>
>>>> Reported issue:
>>>>
>>>> 1. Enable I2C1, flash the new kernel and reboot
>>>> 2. Immediately after reboot, attempt to change the processor clock: "echo
>>>> 456000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed"
>>>> 3. Process blocks
>>>>
>>>> However, if we do the following:
>>>> 1. Enable I2C1, flash the new kernel and reboot
>>>> 2. Immediately after reboot, run: "i2cdetect -y 2 0x08 0x08" or just "i2cdetect
>>>> -y 2"
>>>> 3. Then run: "echo 456000 >
>>>> /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed"
>>>> 4. Command succeeds
>>>
>>> I found this problem as well, and I haven't had time to put together a proper patch.  Right now we're just working around it.  There are several problems with the use of a completion for this task:
>>>
>>> 1. If no I2C transfer has occurred, a cpufreq transition will block forever (which is the bug you found)
>>> 2. Once an I2C transfer has occurred the cpufreq transition will never block since the completion is never reinitialized.
>>> 3. Even if you do reinitialize the completion for every I2C transfer, (1) is not solved and there is still a race condition where the cpufreq transition could start just before an I2C transfer starts and the I2C transfer occurs during the cpufreq transition.
>>>
>>> Personally I think the correct solution is to use a mutex instead of a completion.  The cpufreq code would take the mutex during the prechange callback and release it during the postchange callback.  Likewise the I2C transfer function would hold the mutex while an I2C transfer is ongoing.  That way an I2C transfer cannot occur during a cpufreq transition and vice-versa.  As I mentioned, I have not had time to put together a proper patch, but I would be happy to see this issue addressed if someone else can do it.
>>>
>>>
>>>> Here's the kernel hung task stack trace:
>>>>
>>>> INFO: task sh:1428 blocked for more than 120 seconds.
>>>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>> sh D c026dc74 0 1428 1426 0x00000000
>>>> [<c026dc74>] (schedule+0x2a8/0x334) from [<c026e2e0>]
>>>> (schedule_timeout+0x1c/0x218)
>>>> [<c026e2e0>] (schedule_timeout+0x1c/0x218) from [<c026e164>]
>>>> (wait_for_common+0xf0/0x1b8)
>>>> [<c026e164>] (wait_for_common+0xf0/0x1b8) from [<c019ca1c>]
>>>> (i2c_davinci_cpufreq_transition+0x18/0x50)
>>>> [<c019ca1c>] (i2c_davinci_cpufreq_transition+0x18/0x50) from [<c00599a4>]
>>>> (notifier_call_chain+0x38/0x68)
>>>> [<c00599a4>] (notifier_call_chain+0x38/0x68) from [<c0059a80>]
>>>> (__srcu_notifier_call_chain+0x40/0x58)
>>>> [<c0059a80>] (__srcu_notifier_call_chain+0x40/0x58) from [<c0059aac>]
>>>> (srcu_notifier_call_chain+0x14/0x18)
>>>> [<c0059aac>] (srcu_notifier_call_chain+0x14/0x18) from [<c019dd78>]
>>>> (cpufreq_notify_transition+0xc8/0xfc)
>>>> [<c019dd78>] (cpufreq_notify_transition+0xc8/0xfc) from [<c00373ac>]
>>>> (davinci_target+0x144/0x154)
>>>> [<c00373ac>] (davinci_target+0x144/0x154) from [<c019d404>]
>>>> (__cpufreq_driver_target+0x28/0x38)
>>>> [<c019d404>] (__cpufreq_driver_target+0x28/0x38) from [<c019f260>]
>>>> (cpufreq_set+0x54/0x70)
>>>> [<c019f260>] (cpufreq_set+0x54/0x70) from [<c019d698>]
>>>> (store_scaling_setspeed+0x58/0x6c)
>>>> [<c019d698>] (store_scaling_setspeed+0x58/0x6c) from [<c019e3d0>]
>>>> (store+0x58/0x74)
>>>> [<c019e3d0>] (store+0x58/0x74) from [<c00d8854>]
>>>> (sysfs_write_file+0x108/0x140)
>>>> [<c00d8854>] (sysfs_write_file+0x108/0x140) from [<c009512c>]
>>>> (vfs_write+0xb0/0x118)
>>>> [<c009512c>] (vfs_write+0xb0/0x118) from [<c0095244>]
>>>> (sys_write+0x3c/0x68)
>>>> [<c0095244>] (sys_write+0x3c/0x68) from [<c002bea0>]
>>>> (ret_fast_syscall+0x0/0x28)
>>>> Kernel panic - not syncing: hung_task: blocked tasks
>>>> [<c003069c>] (unwind_backtrace+0x0/0xd0) from [<c026d810>]
>>>> (panic+0x44/0xc8)
>>>> [<c026d810>] (panic+0x44/0xc8) from [<c006aa7c>] (watchdog+0x1d4/0x21c)
>>>> [<c006aa7c>] (watchdog+0x1d4/0x21c) from [<c0054670>]
>>>> (kthread+0x78/0x80)
>>>> [<c0054670>] (kthread+0x78/0x80) from [<c002c8dc>]
>>>> (kernel_thread_exit+0x0/0x8)
>>>> According to the stack trace the kernel gets stuck in the
>>>> "i2c_davinci_cpufreq_transition" function when it calls
>>>> "wait_for_completion(&dev->xfr_complete);"  The two other places this
>>>> xfr_complete variable is referenced is the init_completion in the probe and
>>>> the complete at the end of the i2c_davinci_xfer function. My understanding
>>>> as to what this was intended for was to ensure that a transfer in progress
>>>> completed before changing the clock frequency.  But as its currently done
>>>> the only thing it does is make sure there has been a completed i2c transfer
>>>> on this device ever.  Is my understanding correct?
>>>> Currently the workaround is to simply disable the wait_for_completion as
>>>> seen below.  How would you fix this to ensure a transfer in progress
>>>> completes before changing clocks without hanging if no transfer was ever
>>>> attempted?
>>>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
>>>> index a76d85f..564247f 100644
>>>> --- a/drivers/i2c/busses/i2c-davinci.c
>>>> +++ b/drivers/i2c/busses/i2c-davinci.c
>>>> @@ -596,7 +596,7 @@ static int i2c_davinci_cpufreq_transition(struct
>>>> notifier_block *nb,
>>>>
>>>>          dev = container_of(nb, struct davinci_i2c_dev, freq_transition);
>>>>          if (val == CPUFREQ_PRECHANGE) {
>>>> -               wait_for_completion(&dev->xfr_complete);
>>>> +               //wait_for_completion(&dev->xfr_complete);
>>>>                  davinci_i2c_reset_ctrl(dev, 0);
>>>>          } else if (val == CPUFREQ_POSTCHANGE) {
>>>>                  i2c_davinci_calc_clk_dividers(dev);
>>>> Patch were this was introduced:
>>>> sha: 82c0de11b734c5acec13c0f6007466da81cd16d9  i2c:davinci:Add cpufreq
>>>> support
>>>>
>>>> --
>>>> Jonathan Cormier
>>>> CriticalLink
>>> This e-mail transmission, and any documents, files or previous e-mail messages attached to it, may contain confidential information. If you are not the intended recipient, or a person responsible for delivering it to the intended recipient, you are hereby notified that any disclosure, distribution, review, copy or use of any of the information contained in or attached to this message is STRICTLY PROHIBITED. If you have received this transmission in error, please immediately notify us by reply e-mail, and destroy the original transmission and its attachments without reading them or saving them to disk. Thank you.
>>
>>
>>
>> --
>> Jonathan Cormier
>> CriticalLink
> 
> 
> 
