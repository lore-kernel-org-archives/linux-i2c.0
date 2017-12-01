From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 1/7] eeprom: at24: don't explicitely include header files
 which are implicitely included
Date: Fri, 1 Dec 2017 11:09:02 +0100
Message-ID: <CAMRc=MeWBw40y0L+S8o9w5MBxc84+-eLOMprY785MZiFp8RT6A@mail.gmail.com>
References: <c0855fe6-09b4-aed1-774d-5417c78faa8b@gmail.com>
 <5fd1ad39-db94-e774-b77c-8081bfed7817@gmail.com> <b058a205-8ea9-cc3c-9153-c428f31eee48@axentia.se>
 <172da7fb-40a5-ef36-cbc7-ee6aa5d62e5f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46945 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751089AbdLAKJD (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 1 Dec 2017 05:09:03 -0500
Received: by mail-oi0-f66.google.com with SMTP id t81so6796374oih.13
        for <linux-i2c@vger.kernel.org>; Fri, 01 Dec 2017 02:09:02 -0800 (PST)
In-Reply-To: <172da7fb-40a5-ef36-cbc7-ee6aa5d62e5f@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Peter Rosin <peda@axentia.se>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

2017-11-30 20:32 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
> Am 30.11.2017 um 16:56 schrieb Peter Rosin:
>> On 2017-11-30 07:48, Heiner Kallweit wrote:
>>> Don't explicitely include header files which are implicitely included.
>>
>> That's backwards. It hinders future header rearrangement. Things that
>> are used directly (e.g. the BIT macro) should have its respective
>> include specified (bitops.h in that case).
>>
>> It's not a competition for the shortest file, the goal is easy
>> maintenance.
>>
> Understood ..
>
> @Bartosz: then you can ignore this one.
>
> Rgds, Heiner
>
>
>> Cheers,
>> Peter
>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>>  drivers/misc/eeprom/at24.c | 5 -----
>>>  1 file changed, 5 deletions(-)
>>>
>>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>>> index cd87f1b21..c75bb9b45 100644
>>> --- a/drivers/misc/eeprom/at24.c
>>> +++ b/drivers/misc/eeprom/at24.c
>>> @@ -10,15 +10,10 @@
>>>   * (at your option) any later version.
>>>   */
>>>  #include <linux/kernel.h>
>>> -#include <linux/init.h>
>>>  #include <linux/module.h>
>>>  #include <linux/of_device.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/delay.h>
>>> -#include <linux/mutex.h>
>>> -#include <linux/mod_devicetable.h>
>>> -#include <linux/log2.h>
>>> -#include <linux/bitops.h>
>>>  #include <linux/jiffies.h>
>>>  #include <linux/property.h>
>>>  #include <linux/acpi.h>
>>>
>>
>>
>

Yep, whenever we use anything from some header, we want to have it
included directly. Otherwise any rearrangement would cause us pain.

Thanks,
Bartosz
