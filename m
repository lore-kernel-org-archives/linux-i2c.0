From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] eeprom: at24: check the return value of
 nvmem_unregister()
Date: Tue, 2 Jan 2018 11:17:56 +0000
Message-ID: <1dff0754-e5cb-bda3-4ffb-16182752ca62@linaro.org>
References: <20171227141038.31646-1-brgl@bgdev.pl>
 <20171228112845.GB3729@localhost>
 <CAMRc=MfQvQ+PEcQZRcs8baHPgyrXQ_=m6YXCtbqDseYHMGOZtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:43408 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbeABLR7 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 2 Jan 2018 06:17:59 -0500
Received: by mail-wm0-f66.google.com with SMTP id n138so60556690wmg.2
        for <linux-i2c@vger.kernel.org>; Tue, 02 Jan 2018 03:17:58 -0800 (PST)
In-Reply-To: <CAMRc=MfQvQ+PEcQZRcs8baHPgyrXQ_=m6YXCtbqDseYHMGOZtw@mail.gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Johan Hovold <johan@kernel.org>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Thanks Bartosz fo adding me in to the loop!!

On 28/12/17 21:42, Bartosz Golaszewski wrote:
> 2017-12-28 12:28 GMT+01:00 Johan Hovold <johan@kernel.org>:
>> On Wed, Dec 27, 2017 at 03:10:38PM +0100, Bartosz Golaszewski wrote:
>>> This function can fail with -EBUSY, but we don't check its return
>>> value in at24_remove(). Bail-out of remove() if nvmem_unregister()
>>> doesn't succeed.
>>>
>>> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>>> ---
>>>   drivers/misc/eeprom/at24.c | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>>> index e79833d62284..fb21e1c45115 100644
>>> --- a/drivers/misc/eeprom/at24.c
>>> +++ b/drivers/misc/eeprom/at24.c
>>> @@ -684,11 +684,13 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>>>   static int at24_remove(struct i2c_client *client)
>>>   {
>>>        struct at24_data *at24;
>>> -     int i;
>>> +     int i, ret;
>>>
>>>        at24 = i2c_get_clientdata(client);
>>>
>>> -     nvmem_unregister(at24->nvmem);
>>> +     ret = nvmem_unregister(at24->nvmem);
>>> +     if (ret)
>>> +             return ret;
>>
>> I don't this makes much sense as a driver cannot refuse an unbind by
>> returning an errno from remove(). The return value is simply ignored,
>> remove() will never be called again, and you'd leave everything in an
>> inconsistent state.
>>
> 
> Cc: Srinivas
> 
> Hi Johan,
> 
> I blindly assumed that if there's a return value in remove() then
> someone cares about it. In that case all users of nvmem_unregister()
> that check the return value and bail-out of remove() on failure are
> wrong and in the (very unlikely) event that this routine fails, we
> leak all resources.
> 

Yes, you are correct, returning error from driver remove is issue, as 
driver core ignores returns from remove().

Just to make it clear on some assumptions made in 
nvmem_register/unregister(). nvmem providers could be part of the other 
drivers which can dynamically register and unregister nvmem providers, 
so it's not totally necessary for it to be associated with its own 
device driver.


>> It looks like the nvmem code grabs a reference to the owning module
>> in __nvmem_device_get() which would at least prevent a module unload
>> while another driver is using the device. And the (sysfs) userspace
>> interface should be fine as device removal is handled by the kernfs
>> code.
> 
> Indeed. I believe we should remove the -EBUSY return case from
> nvmem_register() and just do what gpiolib does - scream loud

I think you meant nvmem_unregister().

I don't agree with removing -EBUSY from core, it should be rather 
handled by the provider drivers which can do dev_crit or something 
similar to shout loud!

> (dev_crit()) when someone forces a module unload or otherwise
> unregisters the device if some cells are still requested. This would
> also allow us to eventually add a devres variant for nvmem_register().

There is already a patchset [1] from Andrey which seems to be what you need.


[1]: https://lkml.org/lkml/2018/1/1/522

Thanks,
Srini

> 
> What do you think Srinivas?
> 
> Best regards,
> Bartosz Golaszewski
> 
