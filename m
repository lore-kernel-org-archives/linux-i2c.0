From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH V3] eeprom: at24: support second page of ST M24M01-D*
Date: Wed, 14 Feb 2018 11:04:12 +0100
Message-ID: <CAMRc=MdEdXTEf0T8=RKkOK4ACZD1fA4qE=7OC_PGjEuvNLh3Hg@mail.gmail.com>
References: <20180212111812.nsiy6rpkbpwuckc6@pp184.izt.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37915 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966929AbeBNKEN (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 14 Feb 2018 05:04:13 -0500
Received: by mail-oi0-f66.google.com with SMTP id j15so16100510oii.5
        for <linux-i2c@vger.kernel.org>; Wed, 14 Feb 2018 02:04:13 -0800 (PST)
In-Reply-To: <20180212111812.nsiy6rpkbpwuckc6@pp184.izt.loc>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Johannes Poehlmann <johannes.poehlmann@izt-labs.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>

2018-02-12 12:18 GMT+01:00 Johannes Poehlmann <johannes.poehlmann@izt-labs.de>:
> The M24M01-D* eeproms are in effect 2 eeproms under 2 I2C addresses:
>
> 1. a standard 1Mbit eeprom (driver model 24c1024 is working)
>
> 2. a 256 Byte write lockable "ID page".
>    As the ID page demands 2 byte addresses, the 24c02 driver model
>    can not be used.
>
> So a new model 24cm02 is introduced.
>
> In the device tree, refer to the ID page of the eeprom as
>
>         compatible = "st,m24m01-d", "atmel,24cm02";

This would need an additional patch updating the DT bindings.

>
> Signed-off-by: Johannes Poehlmann <Johannes.Poehlmann@izt-labs.de>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 1 +
>  drivers/misc/eeprom/at24.c                        | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
> index 1812c84..c62c960 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
> @@ -10,6 +10,7 @@ Required properties:
>                  "atmel,24cs01",
>                  "atmel,24c02",
>                  "atmel,24cs02",
> +                "atmel,24cm02",

I now noticed that this chip is not really compatible with your ST
variant. I think we need to start allowing non-atmel compatibles then.
Please update the DT bindings: add this chip and add a section (below
the renesas example) that we also allow non-atmel chips (which don't
require a fallback) listed below. The compatible for this one should
be "st,m24m01".

>                  "atmel,24mac402",
>                  "atmel,24mac602",
>                  "atmel,spd",
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 01f9c49..5afeb1a 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -146,6 +146,7 @@ AT24_CHIP_DATA(at24_data_24c01, 1024 / 8, 0);
>  AT24_CHIP_DATA(at24_data_24cs01, 16,
>         AT24_FLAG_SERIAL | AT24_FLAG_READONLY);
>  AT24_CHIP_DATA(at24_data_24c02, 2048 / 8, 0);
> +AT24_CHIP_DATA(at24_data_24cm02, 2048 / 8, AT24_FLAG_ADDR16);
>  AT24_CHIP_DATA(at24_data_24cs02, 16,
>         AT24_FLAG_SERIAL | AT24_FLAG_READONLY);
>  AT24_CHIP_DATA(at24_data_24mac402, 48 / 8,
> @@ -184,6 +185,7 @@ static const struct i2c_device_id at24_ids[] = {
>         { "24cs01",     (kernel_ulong_t)&at24_data_24cs01 },
>         { "24c02",      (kernel_ulong_t)&at24_data_24c02 },
>         { "24cs02",     (kernel_ulong_t)&at24_data_24cs02 },
> +       { "24cm02",     (kernel_ulong_t)&at24_data_24cm02 },
>         { "24mac402",   (kernel_ulong_t)&at24_data_24mac402 },
>         { "24mac602",   (kernel_ulong_t)&at24_data_24mac602 },
>         { "spd",        (kernel_ulong_t)&at24_data_spd },
> @@ -212,6 +214,7 @@ static const struct of_device_id at24_of_match[] = {
>         { .compatible = "atmel,24cs01",         .data = &at24_data_24cs01 },
>         { .compatible = "atmel,24c02",          .data = &at24_data_24c02 },
>         { .compatible = "atmel,24cs02",         .data = &at24_data_24cs02 },
> +       { .compatible = "atmel,24cm02",         .data = &at24_data_24cm02 },
>         { .compatible = "atmel,24mac402",       .data = &at24_data_24mac402 },
>         { .compatible = "atmel,24mac602",       .data = &at24_data_24mac602 },
>         { .compatible = "atmel,spd",            .data = &at24_data_spd },
> --
> 2.1.4
>

Thanks,
Bartosz
