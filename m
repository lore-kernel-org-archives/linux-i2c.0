From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 3/7] eeprom: at24: add regmap-based write function
Date: Tue, 21 Nov 2017 11:07:26 +0100
Message-ID: <CAMRc=MfJ2n57kH5nJrUxSBPPea2s2T1uDkCK5jFhFvkRW0d-JQ@mail.gmail.com>
References: <f8f2ce63-f533-6529-1639-34e3500e5845@gmail.com> <a4c705cc-69e8-35f8-2131-f7c610111d77@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36324 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbdKUKH1 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 21 Nov 2017 05:07:27 -0500
Received: by mail-oi0-f68.google.com with SMTP id n16so8160542oig.3
        for <linux-i2c@vger.kernel.org>; Tue, 21 Nov 2017 02:07:27 -0800 (PST)
In-Reply-To: <a4c705cc-69e8-35f8-2131-f7c610111d77@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

2017-11-16 21:26 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
> Add a regmap-based write function.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - rebased
> ---
>  drivers/misc/eeprom/at24.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 1411fa029..c0c59575e 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -525,6 +525,22 @@ static ssize_t at24_eeprom_write_smbus_byte(struct at24_data *at24,
>         return -ETIMEDOUT;
>  }
>
> +static ssize_t at24_regmap_write(struct at24_data *at24, const char *buf,
> +                                unsigned int offset, size_t count)
> +{
> +       unsigned long timeout, write_time;
> +       struct regmap *regmap;
> +
> +       regmap = at24_translate_offset(at24, &offset)->regmap;
> +       count = at24_adjust_write_count(at24, offset, count);
> +
> +       loop_until_timeout(timeout, write_time)
> +               if (!regmap_bulk_write(regmap, offset, buf, count))
> +                       return count;
> +

Please do this:

int rv;

rv = regmap_bulk_write(...);
if (rv == 0)
    return count;

I'd like to stay as readable as possible and making the return value
type visible is always good.

Also: it would be nice if you could keep the dev_dbg() call from the
original write function.

Thanks,
Bartosz
