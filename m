From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] of/irq: introduce of_has_named_irqs helper
Date: Wed, 29 Jul 2015 10:03:33 +0530
Message-ID: <55B8579D.90801@ti.com>
References: <20150724182655.GA22007@dtor-ws> <CAL_Jsq+JGpNBwS3HF1fF4HdefRCwhniaYCm5G4_WAnio7t-1og@mail.gmail.com> <20150724192619.GA33241@dtor-ws> <20150724201613.GB33241@dtor-ws> <55B78268.4040603@ti.com> <20150728172336.GC19610@dtor-ws> <55B7C004.9090103@ti.com> <20150728180724.GD19610@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150728180724.GD19610@dtor-ws>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On 07/28/2015 11:37 PM, Dmitry Torokhov wrote:
> On Tue, Jul 28, 2015 at 11:16:44PM +0530, R, Vignesh wrote:
>> Hi,
>>
>> On 7/28/2015 10:53 PM, Dmitry Torokhov wrote:
>>> On Tue, Jul 28, 2015 at 06:53:52PM +0530, Vignesh R wrote:
>>>> Hi Dmitry,
>>>>
>>>> On 07/25/2015 01:46 AM, Dmitry Torokhov wrote:
>>>>> On Fri, Jul 24, 2015 at 12:26:19PM -0700, Dmitry Torokhov wrote:
>>>>>> On Fri, Jul 24, 2015 at 02:14:57PM -0500, Rob Herring wrote:
>>>>>>> On Fri, Jul 24, 2015 at 1:26 PM, Dmitry Torokhov
>>>>>>> <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>>>>>> Sometimes drivers might wish to transition from index-based to named
>>>>>>>> interrupt descriptions. To aid in decision-making when parsing device
>>>>>>>> tree data let's provide a helper that will indicate the scheme that is
>>>>>>>> being used.
>>>>>>>
>>>>>>> Generally, IRQs are retrieved by platform_get_irq or
>>>>>>> platform_get_irq_byname. Drivers should not call the of_irq_*
>>>>>>> functions directly in most cases.
>>>>>>
>>>>>> That would be true for platform drivers, but not all devices are
>>>>>> platform devices.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> The intent is to it like this:
>>>>>>>>
>>>>>>>>         if (of_has_named_irqs(np) {
>>>>>>>>                 /* Wake IRQ is optional */
>>>>>>>>                 dev->wakeirq = of_irq_get_byname(np, "wakeup");
>>>>>>>>                 if (dev->wakeirq < 0 && dev->wakeirq != -ENODATA)
>>>>>>>>                         return dev->wakeirq;
>>>>>>>>         }
>>>>>>>
>>>>>>> of_irq_get_byname will already return an error if the property is not
>>>>>>> present. Use that.
>>>>>>
>>>>>> I do not like that it returns -EINVAL when property is missing, can we
>>>>>> change it to return -ENODATA (so it is the same as when the property is
>>>>>> defined but such name is missing)?
>>>>>
>>>>> So here is what I had in mind.. It is based on recent patch by Vignesh
>>>>> for pixcir touchscreen, but I think it should be made available to all
>>>>> I2C devices. Completely untested at the moment.
>>>>>
>>>>
>>>> Thanks for the patch! I tested this on am437x-gp-evm and the
>>>> suspend/resume worked fine (below patch + $subject patch). I was able to
>>>> wake the system from low power state using touchscreen. Also verified
>>>> module insertion and removal. One comment though, please see below.
>>>>
>>>>> ---
>>>>>  drivers/i2c/i2c-core.c |   43 +++++++++++++++++++++++++++++++++++++------
>>>>>  1 file changed, 37 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>>>>> index e6d4935..3971461 100644
>>>>> --- a/drivers/i2c/i2c-core.c
>>>>> +++ b/drivers/i2c/i2c-core.c
>>>>> @@ -47,6 +47,7 @@
>>>>>  #include <linux/rwsem.h>
>>>>>  #include <linux/pm_runtime.h>
>>>>>  #include <linux/pm_domain.h>
>>>>> +#include <linux/pm_wakeirq.h>
>>>>>  #include <linux/acpi.h>
>>>>>  #include <linux/jump_label.h>
>>>>>  #include <asm/uaccess.h>
>>>>> @@ -631,6 +632,7 @@ static int i2c_device_probe(struct device *dev)
>>>>>  {
>>>>>  	struct i2c_client	*client = i2c_verify_client(dev);
>>>>>  	struct i2c_driver	*driver;
>>>>> +	int wakeirq = 0;
>>>>>  	int status;
>>>>>  
>>>>>  	if (!client)
>>>>> @@ -639,11 +641,13 @@ static int i2c_device_probe(struct device *dev)
>>>>>  	if (!client->irq) {
>>>>>  		int irq = -ENOENT;
>>>>>  
>>>>> -		if (dev->of_node)
>>>>> -			irq = of_irq_get(dev->of_node, 0);
>>>>> -		else if (ACPI_COMPANION(dev))
>>>>> +		if (dev->of_node) {
>>>>> +			irq = of_has_named_irqs(dev->of_node) ?
>>>>> +				of_irq_get_byname(dev->of_node, "irq") :
>>>>> +				of_irq_get(dev->of_node, 0);
>>>>> +		} else if (ACPI_COMPANION(dev)) {
>>>>>  			irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 0);
>>>>> -
>>>>> +		}
>>>>>  		if (irq == -EPROBE_DEFER)
>>>>>  			return irq;
>>>>>  		if (irq < 0)
>>>>> @@ -652,6 +656,15 @@ static int i2c_device_probe(struct device *dev)
>>>>>  		client->irq = irq;
>>>>>  	}
>>>>>  
>>>>> +	if (dev->of_node && of_has_named_irqs(dev->of_node)) {
>>>>> +		wakeirq = of_irq_get_byname(dev->of_node, "wakeup");
>>>>> +		if (wakeirq < 0) {
>>>>> +			if (wakeirq != -ENODATA)
>>>>> +				return wakeirq;
>>>>> +			wakeirq = 0;
>>>>> +		}
>>>>> +	}
>>>>> +
>>>>>  	driver = to_i2c_driver(dev->driver);
>>>>>  	if (!driver->probe || !driver->id_table)
>>>>>  		return -ENODEV;diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
>> index 8f3e243a62bf..6bd1d1ca9883 100644
>> --- a/drivers/input/touchscreen/pixcir_i2c_ts.c
>> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
>> @@ -365,7 +365,6 @@ static int __maybe_unused
>> pixcir_i2c_ts_suspend(struct device *dev)
>>                         }
>>                 }
>>
>> -               enable_irq_wake(client->irq);
>>         } else if (input->users) {
>>                 ret = pixcir_stop(ts);
>>         }
>> @@ -386,7 +385,6 @@ static int __maybe_unused
>> pixcir_i2c_ts_resume(struct device *dev)
>>         mutex_lock(&input->mutex);
>>
>>         if (device_may_wakeup(&client->dev)) {
>> -               disable_irq_wake(client->irq);
>>
>>                 if (!input->users) {
>>                         ret = pixcir_stop(ts);
>> @@ -464,7 +462,7 @@ static int pixcir_i2c_ts_probe(struct i2c_client
>> *client,
>>         struct pixcir_i2c_ts_data *tsdata;
>>         struct input_dev *input;
>>         int error;
>> -
>> +printk("PROBING PIXCIR\n");
>>         if (np && !pdata) {
>>                 pdata = pixcir_parse_dt(dev);
>>                 if (IS_ERR(pdata))
>> @@ -562,14 +560,6 @@ static int pixcir_i2c_ts_probe(struct i2c_client
>> *client,
>>                 return error;
>>
>>         i2c_set_clientdata(client, tsdata);
>> -       device_init_wakeup(&client->dev, 1);
>> -
>> -       return 0;
>> -}
>> -
>> -static int pixcir_i2c_ts_remove(struct i2c_client *client)
>> -{
>> -       device_init_wakeup(&client->dev, 0);
>>
>>         return 0;
>>  }
>> @@ -608,7 +598,6 @@ static struct i2c_driver pixcir_i2c_ts_driver = {
>>                 .of_match_table = of_match_ptr(pixcir_of_match),
>>         },
>>         .probe          = pixcir_i2c_ts_probe,
>> -       .remove         = pixcir_i2c_ts_remove,
>>         .id_table       = pixcir_i2c_ts_id,
>>  };
>>>>> @@ -659,20 +672,34 @@ static int i2c_device_probe(struct device *dev)
>>>>>  	if y i2c(!device_can_wakeup(&client->dev))
>>>>>  		device_init_wakeup(&client->dev,
>>>>>  					client->flags & I2C_CLIENT_WAKE);
>>>>> +
>>>>> +	status = wakeirq > 0 ?
>>>>> +			dev_pm_set_dedicated_wake_irq(dev, wakeirq) :
>>>>> +			(client->irq > 0 ?
>>>>> +				dev_pm_set_wake_irq(dev, client->irq) : 0);
>>>>
>>>> Above code tries to register wakeirq irrespective of whether the device
>>>> is specified as wakeup-source in the dt or not. Hence, I see warn
>>>> messages from every i2c device that has irq line but hasn't declared
>>>> itself as wakeup-source:
>>>> For example tps is on i2c:
>>>> [    1.961613] tps65218 0-0024: forgot to call call device_init_wakeup?
>>>> [    1.968340] tps65218 0-0024: failed to set up wakeup irq
>>>>
>>>> May be you can register wakeup-source only if I2C_CLIENT_WAKE flag is
>>>> set in client->flags?
>>>
>>> Makes sense, I'll prepare a new version.
>>>
>>> Just to confirm: do you see any issues with these 2 patches if you do
>>> not modify the drivers to drop calls enable_irq_wake() from them?
>>
>> No, I didn't test w/o dropping enable_irq_wake() calls. I will do that
>> tomo. Is this to verify that these 2 patches can be added w/o dropping
>> enable_irq_wake() from other i2c drivers currently using them?
> 
> Yes.

Tested these 2 patches with enable/disable_irq_wake() calls in pixcir
driver and I did not see any issues.

-- 
Regards
Vignesh
