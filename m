From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 0/7] eeprom: at24: switch driver to regmap_i2c
Date: Tue, 21 Nov 2017 11:14:30 +0100
Message-ID: <CAMRc=MctKG4TNz_jiAYZ5oyPJwDRiWwhDXt8Yohr3deHE4qjBw@mail.gmail.com>
References: <f8f2ce63-f533-6529-1639-34e3500e5845@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:46212 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbdKUKOb (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 21 Nov 2017 05:14:31 -0500
Received: by mail-oi0-f53.google.com with SMTP id a81so8151234oii.13
        for <linux-i2c@vger.kernel.org>; Tue, 21 Nov 2017 02:14:30 -0800 (PST)
In-Reply-To: <f8f2ce63-f533-6529-1639-34e3500e5845@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

2017-11-16 21:16 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
> Using regmap_i2c allows us to get rid of dealing with the low-level
> differences between I2C and SMBUS. As a result the code can be
> simplified a lot.
>
> This patchset was successfully tested with a 24C32 on a I2C adapter.
>
> The patchset was submitted first in Aug 2017 and was sitting in
> the review queue until now. Resubmitted version is rebased due to
> recent changes to at24.
>
> Heiner Kallweit (7):
>   eeprom: at24: add basic regmap_i2c support
>   eeprom: at24: change at24_translate_offset return type
>   eeprom: at24: add regmap-based write function
>   eeprom: at24: remove old write functions
>   eeprom: at24: add regmap-based read functions
>   eeprom: at24: remove old read functions
>   eeprom: at24: remove now unneeded smbus-related code
>
>  drivers/misc/eeprom/Kconfig |   1 +
>  drivers/misc/eeprom/at24.c  | 385 +++++++++-----------------------------------
>  2 files changed, 79 insertions(+), 307 deletions(-)
>
> --
> 2.15.0
>

Hi Heiner,

These changes are a very good idea, but if I'm not mistaken, the
support for reading the MAC address in at24mac* eeprom series is
missing. Unfortunately I don't have access to one of those ATM to make
sure.

I've tested the series on a couple of chips and it works fine -
including the serial number read on at24cs32 and at24cs02. I'll test
it again on top of 4.15-rc1.

The patches look good code-wise - just a couple nits here and there.

Best regards,
Bartosz Golaszewski
