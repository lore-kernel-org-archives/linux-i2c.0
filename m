From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 2/7] eeprom: at24: change at24_translate_offset return type
Date: Tue, 21 Nov 2017 11:00:10 +0100
Message-ID: <CAMRc=MeCr9qVKDc=20HdCe1jbwmuZckE3HyXOLW71bHczHa3mQ@mail.gmail.com>
References: <f8f2ce63-f533-6529-1639-34e3500e5845@gmail.com> <9b0019a9-f272-e345-d814-fcb05f978554@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41832 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbdKUKAM (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 21 Nov 2017 05:00:12 -0500
Received: by mail-ot0-f195.google.com with SMTP id b54so10032381otd.8
        for <linux-i2c@vger.kernel.org>; Tue, 21 Nov 2017 02:00:12 -0800 (PST)
In-Reply-To: <9b0019a9-f272-e345-d814-fcb05f978554@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

2017-11-16 21:26 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
> Change return type of at24_translate_offset to *at24_client to make
> member regmap accessible for subsequent patches of this series.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - rebased
> ---
>  drivers/misc/eeprom/at24.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 911cce8ec..1411fa029 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -267,8 +267,8 @@ MODULE_DEVICE_TABLE(acpi, at24_acpi_ids);
>   * one "eeprom" file not four, but larger reads would fail when
>   * they crossed certain pages.
>   */
> -static struct i2c_client *at24_translate_offset(struct at24_data *at24,
> -                                               unsigned int *offset)
> +static struct at24_client *at24_translate_offset(struct at24_data *at24,
> +                                                unsigned int *offset)
>  {
>         unsigned i;
>
> @@ -280,7 +280,7 @@ static struct i2c_client *at24_translate_offset(struct at24_data *at24,
>                 *offset &= 0xff;
>         }
>
> -       return at24->client[i].client;
> +       return &at24->client[i];
>  }
>
>  static ssize_t at24_eeprom_read_smbus(struct at24_data *at24, char *buf,
> @@ -290,7 +290,7 @@ static ssize_t at24_eeprom_read_smbus(struct at24_data *at24, char *buf,
>         struct i2c_client *client;
>         int status;
>
> -       client = at24_translate_offset(at24, &offset);
> +       client = at24_translate_offset(at24, &offset)->client;

Please do something like:

struct at24_client *at24;
struct i2c_client *client;

at24 = at24_translate_offset(at24, &offset);
client = at24->client;

I find it more readable like that and we don't hide the type of the
return value of at24_translate_offset().

Thanks,
Bartosz
