From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v5 0/7] eeprom: at24: switch driver to regmap_i2c
Date: Wed, 29 Nov 2017 15:58:44 +0100
Message-ID: <CAMRc=McZ+94EMve0_3U=SwaZcEPfPMffjTW49wW-TdvQVf5KbQ@mail.gmail.com>
References: <2c379f45-d5e3-71af-eb20-ca51e09d9257@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41416 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753396AbdK2O6p (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 29 Nov 2017 09:58:45 -0500
Received: by mail-ot0-f196.google.com with SMTP id b54so3222851otd.8
        for <linux-i2c@vger.kernel.org>; Wed, 29 Nov 2017 06:58:45 -0800 (PST)
In-Reply-To: <2c379f45-d5e3-71af-eb20-ca51e09d9257@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

2017-11-27 21:10 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
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
> Changes in v3:
> - Small changes based on review comments
> - Introduce at24_adjust_read_offset to avoid some overhead
> Changes in v4:
> - Small improvement in patch 5
> Changes in v5:
> - Small improvement in patch 5
>   I still add offset_adj in at24_regmap_read, because we may
>   have values like 0x9a for offset_adj, and the or-ing to offset
>   may be inappropriate.
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
>  drivers/misc/eeprom/at24.c  | 428 +++++++++++---------------------------------
>  2 files changed, 106 insertions(+), 323 deletions(-)
>
> --
> 2.15.0
>

Applied all to at24/devel, thanks for the patience!
