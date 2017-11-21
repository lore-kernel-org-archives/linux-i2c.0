From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 0/7] eeprom: at24: switch driver to regmap_i2c
Date: Tue, 21 Nov 2017 20:20:39 +0100
Message-ID: <3d5d444b-07ff-ecfe-96c1-9bbdc0e3a41f@gmail.com>
References: <f8f2ce63-f533-6529-1639-34e3500e5845@gmail.com>
 <CAMRc=MctKG4TNz_jiAYZ5oyPJwDRiWwhDXt8Yohr3deHE4qjBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:41231 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751337AbdKUTUr (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 21 Nov 2017 14:20:47 -0500
Received: by mail-wm0-f50.google.com with SMTP id b189so5700231wmd.0
        for <linux-i2c@vger.kernel.org>; Tue, 21 Nov 2017 11:20:46 -0800 (PST)
In-Reply-To: <CAMRc=MctKG4TNz_jiAYZ5oyPJwDRiWwhDXt8Yohr3deHE4qjBw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Am 21.11.2017 um 11:14 schrieb Bartosz Golaszewski:
> 2017-11-16 21:16 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
>> Using regmap_i2c allows us to get rid of dealing with the low-level
>> differences between I2C and SMBUS. As a result the code can be
>> simplified a lot.
>>
>> This patchset was successfully tested with a 24C32 on a I2C adapter.
>>
>> The patchset was submitted first in Aug 2017 and was sitting in
>> the review queue until now. Resubmitted version is rebased due to
>> recent changes to at24.
>>
>> Heiner Kallweit (7):
>>   eeprom: at24: add basic regmap_i2c support
>>   eeprom: at24: change at24_translate_offset return type
>>   eeprom: at24: add regmap-based write function
>>   eeprom: at24: remove old write functions
>>   eeprom: at24: add regmap-based read functions
>>   eeprom: at24: remove old read functions
>>   eeprom: at24: remove now unneeded smbus-related code
>>
>>  drivers/misc/eeprom/Kconfig |   1 +
>>  drivers/misc/eeprom/at24.c  | 385 +++++++++-----------------------------------
>>  2 files changed, 79 insertions(+), 307 deletions(-)
>>
>> --
>> 2.15.0
>>
> 
> Hi Heiner,
> 
Hi Bartosz,

> These changes are a very good idea, but if I'm not mistaken, the
> support for reading the MAC address in at24mac* eeprom series is
> missing. Unfortunately I don't have access to one of those ATM to make
> sure.
> 
The only difference when reading the MAC is that the offset is relative
to position 0x90. Therefore I merged reading a MAC into the standard
read function. See following part in patch 5:

if (at24->chip.flags & AT24_FLAG_MAC)
	offset += 0x90;

> I've tested the series on a couple of chips and it works fine -
> including the serial number read on at24cs32 and at24cs02. I'll test
> it again on top of 4.15-rc1.
> 
> The patches look good code-wise - just a couple nits here and there.
> 
Will have a look at it.


> Best regards,
> Bartosz Golaszewski
> 
Rgds, Heiner
