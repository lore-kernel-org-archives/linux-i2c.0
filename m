From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 2/7] eeprom: at24: consider that SERIAL and MAC flags
 imply read-only
Date: Sun, 3 Dec 2017 22:20:39 +0100
Message-ID: <CAMRc=MftoNhSik9iM6__VXQBzPSmCbcK2VKiS58bK5D6CSqQNA@mail.gmail.com>
References: <c0855fe6-09b4-aed1-774d-5417c78faa8b@gmail.com>
 <a2ff2cad-0901-f0f7-353f-f9dbcd293ce1@gmail.com> <CAMRc=McGsXwd7eYn1j7LeAgYigW-1Da=+jCRXRuyiTicCbgwJg@mail.gmail.com>
 <e598ac1a-443c-4ec4-e92c-b526ac4e6370@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:46171 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752434AbdLCVUk (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 3 Dec 2017 16:20:40 -0500
Received: by mail-ot0-f194.google.com with SMTP id j2so13138628ota.13
        for <linux-i2c@vger.kernel.org>; Sun, 03 Dec 2017 13:20:40 -0800 (PST)
In-Reply-To: <e598ac1a-443c-4ec4-e92c-b526ac4e6370@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

2017-12-02 23:00 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
> Am 01.12.2017 um 11:10 schrieb Bartosz Golaszewski:
>> 2017-11-30 7:49 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
>>> Flags AT24_FLAG_SERIAL and AT24_FLAG_MAC imply read-only.
>>> Therefore handle this in the code instead of specifying
>>> AT24_FLAG_READONLY in the config data in these cases.
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>>  drivers/misc/eeprom/at24.c | 31 +++++++++++++------------------
>>>  1 file changed, 13 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>>> index c75bb9b45..90fefd1cf 100644
>>> --- a/drivers/misc/eeprom/at24.c
>>> +++ b/drivers/misc/eeprom/at24.c
>>> @@ -131,38 +131,29 @@ static const struct i2c_device_id at24_ids[] = {
>>>         { "24c00",      AT24_DEVICE_MAGIC(128 / 8,      AT24_FLAG_TAKE8ADDR) },
>>>         /* old variants can't be handled with this generic entry! */
>>>         { "24c01",      AT24_DEVICE_MAGIC(1024 / 8,     0) },
>>> -       { "24cs01",     AT24_DEVICE_MAGIC(16,
>>> -                               AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
>>> +       { "24cs01",     AT24_DEVICE_MAGIC(16,           AT24_FLAG_SERIAL) },
>>>         { "24c02",      AT24_DEVICE_MAGIC(2048 / 8,     0) },
>>> -       { "24cs02",     AT24_DEVICE_MAGIC(16,
>>> -                               AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
>>> -       { "24mac402",   AT24_DEVICE_MAGIC(48 / 8,
>>> -                               AT24_FLAG_MAC | AT24_FLAG_READONLY) },
>>> -       { "24mac602",   AT24_DEVICE_MAGIC(64 / 8,
>>> -                               AT24_FLAG_MAC | AT24_FLAG_READONLY) },
>>> +       { "24cs02",     AT24_DEVICE_MAGIC(16,           AT24_FLAG_SERIAL) },
>>> +       { "24mac402",   AT24_DEVICE_MAGIC(48 / 8,       AT24_FLAG_MAC) },
>>> +       { "24mac602",   AT24_DEVICE_MAGIC(64 / 8,       AT24_FLAG_MAC) },
>>>         /* spd is a 24c02 in memory DIMMs */
>>>         { "spd",        AT24_DEVICE_MAGIC(2048 / 8,
>>>                                 AT24_FLAG_READONLY | AT24_FLAG_IRUGO) },
>>>         { "24c04",      AT24_DEVICE_MAGIC(4096 / 8,     0) },
>>> -       { "24cs04",     AT24_DEVICE_MAGIC(16,
>>> -                               AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
>>> +       { "24cs04",     AT24_DEVICE_MAGIC(16,   AT24_FLAG_SERIAL) },
>>>         /* 24rf08 quirk is handled at i2c-core */
>>>         { "24c08",      AT24_DEVICE_MAGIC(8192 / 8,     0) },
>>> -       { "24cs08",     AT24_DEVICE_MAGIC(16,
>>> -                               AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
>>> +       { "24cs08",     AT24_DEVICE_MAGIC(16,   AT24_FLAG_SERIAL) },
>>>         { "24c16",      AT24_DEVICE_MAGIC(16384 / 8,    0) },
>>> -       { "24cs16",     AT24_DEVICE_MAGIC(16,
>>> -                               AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
>>> +       { "24cs16",     AT24_DEVICE_MAGIC(16,           AT24_FLAG_SERIAL) },
>>>         { "24c32",      AT24_DEVICE_MAGIC(32768 / 8,    AT24_FLAG_ADDR16) },
>>>         { "24cs32",     AT24_DEVICE_MAGIC(16,
>>>                                 AT24_FLAG_ADDR16 |
>>> -                               AT24_FLAG_SERIAL |
>>> -                               AT24_FLAG_READONLY) },
>>> +                               AT24_FLAG_SERIAL) },
>>>         { "24c64",      AT24_DEVICE_MAGIC(65536 / 8,    AT24_FLAG_ADDR16) },
>>>         { "24cs64",     AT24_DEVICE_MAGIC(16,
>>>                                 AT24_FLAG_ADDR16 |
>>> -                               AT24_FLAG_SERIAL |
>>> -                               AT24_FLAG_READONLY) },
>>> +                               AT24_FLAG_SERIAL) },
>>>         { "24c128",     AT24_DEVICE_MAGIC(131072 / 8,   AT24_FLAG_ADDR16) },
>>>         { "24c256",     AT24_DEVICE_MAGIC(262144 / 8,   AT24_FLAG_ADDR16) },
>>>         { "24c512",     AT24_DEVICE_MAGIC(524288 / 8,   AT24_FLAG_ADDR16) },
>>> @@ -556,6 +547,10 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>>>                 chip.context = NULL;
>>>         }
>>>
>>> +       /* both flags imply read-only */
>>> +       if (chip.flags & AT24_FLAG_SERIAL || chip.flags & AT24_FLAG_MAC)
>>> +               chip.flags |= AT24_FLAG_READONLY;
>>> +
>>>         if (!is_power_of_2(chip.byte_len))
>>>                 dev_warn(&client->dev,
>>>                         "byte_len looks suspicious (no power of 2)!\n");
>>> --
>>> 2.15.0
>>>
>>>
>>
>> Just as with the header patch: this doesn't save us any code other
>> than visual. We want the definition to scream that this chip is
>> read-only. Nacked.
>>
> I see your point. My concern is that so far we may have platform-data-
> configured devices setting flag SERIAL or MAC and not READONLY and we
> have no control over such (IMO) misconfigurations.
>
> So my primary question would be whether we agree on SERIAL and MAC
> implying READONLY. If yes then I think we should reflect this
> relationship in the code.
> Instead of silently setting flag READONLY we could also reject such
> invalid flag configurations. Or print at least a message/warning
> when setting READONLY.
>
> Rgds, Heiner
>
>> Thanks,
>> Bartosz
>>
>

OK, this makes more sense, let's check if READONLY is set for MAC and
CS and if not: let's set it ourselves while also printing a warning.

Thanks,
Bartosz
