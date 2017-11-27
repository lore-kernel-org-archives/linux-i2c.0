From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] eeprom: at24: check at24_read/write arguments
Date: Mon, 27 Nov 2017 20:44:01 +0100
Message-ID: <CAMRc=Md69zW=YDwyKP9TpoqEBmTd8pyW7heJYBQtKF4CvQSpwQ@mail.gmail.com>
References: <a519bea7-9c68-caf1-7b1a-100c2562a2d7@gmail.com>
 <CAMRc=Me__y_vT0=-ZND=b4+H6gx+rX=h4eO9cb8Ugdx+dQEx_w@mail.gmail.com> <e2b228a3-0dc9-3c47-91e0-e28d12f3da2d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:38796 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753100AbdK0ToD (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 27 Nov 2017 14:44:03 -0500
Received: by mail-ot0-f196.google.com with SMTP id b49so25269802otj.5
        for <linux-i2c@vger.kernel.org>; Mon, 27 Nov 2017 11:44:02 -0800 (PST)
In-Reply-To: <e2b228a3-0dc9-3c47-91e0-e28d12f3da2d@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

2017-11-27 20:40 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
> Am 27.11.2017 um 13:33 schrieb Bartosz Golaszewski:
>> 2017-11-24 7:47 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
>>> So far we completely rely on the caller to provide valid arguments.
>>> To be on the safe side perform an own sanity check.
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>>  drivers/misc/eeprom/at24.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>>> index 00d602be7..52cbaeb6f 100644
>>> --- a/drivers/misc/eeprom/at24.c
>>> +++ b/drivers/misc/eeprom/at24.c
>>> @@ -569,6 +569,9 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
>>>         if (unlikely(!count))
>>>                 return count;
>>>
>>> +       if (off + count > at24->chip.byte_len)
>>> +               return -EINVAL;
>>> +
>>>         client = at24_translate_offset(at24, &off);
>>>
>>>         ret = pm_runtime_get_sync(&client->dev);
>>> @@ -614,6 +617,9 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
>>>         if (unlikely(!count))
>>>                 return -EINVAL;
>>>
>>> +       if (off + count > at24->chip.byte_len)
>>> +               return -EINVAL;
>>> +
>>>         client = at24_translate_offset(at24, &off);
>>>
>>>         ret = pm_runtime_get_sync(&client->dev);
>>> --
>>> 2.15.0
>>>
>>>
>>
>> Out of curiosity: have you tried what happens currently if we try to
>> read past the size of the nvmem device size?
>>
> When reading moderately past the end on most chips nothing bad happens.
> But if you look at at24_translate_offset: if the offset is big enough
> then i becomes too big and at24->client[i] accesses invalid memory.
>
> at24_read/write are used by the nvmem core only. And the nvmem sysfs
> interface checks the parameters good enough. However thare are few
> nvmem API functions not doing any parameter check,
> e.g. nvmem_device_read.
>
> Best solution would be if nvmem core guarantees that all calls to
> the nvmem provider read/write callbacks are done with valid
> parameters only. At least as long as this is not the case I'd suggest
> to check on our side too.
>
> The decision to apply this patch or not has an impact on my other
> patch series due to needed rebasing.
> For now I'll send the next version of my series assuming that this
> patch will be applied.
>

Oh, it will be applied alright, I was just wondering if it has any
actual impact with current kernel. I mostly worried about user space
accesses, but I see we'd hit EOF anyway before reading past the
eeprom.

Feel free to rebase on top of this commit.

Thanks,
Bartosz
