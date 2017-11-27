From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] eeprom: at24: fix the magic value for at24mac402
Date: Mon, 27 Nov 2017 20:45:58 +0100
Message-ID: <CAMRc=MebjC81RW6m64+1oi0gTfz2iq6vLjcdnHCqPHGUUERpjQ@mail.gmail.com>
References: <20171127122808.21042-1-brgl@bgdev.pl> <8945ed8b-8a95-04ff-38df-4f1ec9ef9de7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <8945ed8b-8a95-04ff-38df-4f1ec9ef9de7@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Claudiu Beznea <Claudiu.Beznea@microchip.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

2017-11-27 20:15 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
> Am 27.11.2017 um 13:28 schrieb Bartosz Golaszewski:
>> There's an ilog2() expansion in AT24_DEVICE_MAGIC() which rounds down
>> the actual size of EUI-48 byte array in at24mac402 eeproms to 4 from 6,
>> making it impossible to read it all.
>>
>> Fix it by creating the magic value manually with the correct size.
>>
>> This patch contains a temporary fix that is suitable for stable
>> branches. Eventually we'll probably remove the call to ilog2() while
>> converting the magic values to actual structs.
>>
>> This fix will cause a warning message to be emitted by probe() for
>> at24mac402 chips but theys should be initialized correctly anyway.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 0b813658c115 ("eeprom: at24: add support for at24mac series")
>> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>> ---
>>  drivers/misc/eeprom/at24.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>> index e0b4b36ef010..72adf34627f5 100644
>> --- a/drivers/misc/eeprom/at24.c
>> +++ b/drivers/misc/eeprom/at24.c
>> @@ -141,8 +141,17 @@ static const struct i2c_device_id at24_ids[] = {
>>       { "24c02",      AT24_DEVICE_MAGIC(2048 / 8,     0) },
>>       { "24cs02",     AT24_DEVICE_MAGIC(16,
>>                               AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
>> -     { "24mac402",   AT24_DEVICE_MAGIC(48 / 8,
>> -                             AT24_FLAG_MAC | AT24_FLAG_READONLY) },
>> +     /*
>> +      * REVISIT: the size of the EUI-48 byte array is 6 in at24mac402, while
>> +      * the call to ilog2() in AT24_DEVICE_MAGIC() rounds it down to 4. We
>> +      * might want to eventually remove it altogether or maybe even convert
>> +      * the magic values to real structs.
>> +      *
>> +      * For now just create the magic value manually with the right size.
>> +      */
>> +     { "24mac402",   ((1 << AT24_SIZE_FLAGS |
>> +                      (AT24_FLAG_MAC | AT24_FLAG_READONLY))
>> +                      << AT24_SIZE_BYTELEN | (48 / 8)) },
>>       { "24mac602",   AT24_DEVICE_MAGIC(64 / 8,
>>                               AT24_FLAG_MAC | AT24_FLAG_READONLY) },
>>       /* spd is a 24c02 in memory DIMMs */
>>
> I'm afraid this won't work. byte_len = BIT(least 5 bits of magic value)
> Means byte_len for 24mac402 would be BIT(6) = 64 with your patch.
>
> What we could do, although it seems to be quite ugly: round up the ilog2
> value. Instead of ilog2(_len) we could use ilog2((_len) * 2 - 1)
>
> Rgds, Heiner

This is exactly why we should get rid of these magic values. ;) Thanks
for spotting that.

Another (slightly cleaner) solution that comes to mind is checking the
eeprom type in probe and adjusting byte_len manually.

Thanks,
Bartosz
