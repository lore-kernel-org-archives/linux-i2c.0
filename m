From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] eeprom: at24: don't use the default regmap locking
Date: Sun, 10 Dec 2017 19:57:06 +0100
Message-ID: <CAMRc=Mcnnq-9=uZp5s5fjKJVTqMbdcmXNZtsZHTAqH5uk_Ha1g@mail.gmail.com>
References: <20171203214743.15970-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:44396 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752431AbdLJS5I (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 10 Dec 2017 13:57:08 -0500
Received: by mail-ot0-f196.google.com with SMTP id d27so13040153ote.11
        for <linux-i2c@vger.kernel.org>; Sun, 10 Dec 2017 10:57:07 -0800 (PST)
In-Reply-To: <20171203214743.15970-1-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>

2017-12-03 22:47 GMT+01:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> We need to always wait for the last write to complete and we want the
> regmap to be protected from concurrent access during that wait. That
> makes using the regmap's default locking impossible and we're
> protecting it with an external mutex.
>
> Set an empty function as the callback for regmap's lock and unlock
> routines so that it doesn't allocate any internal resources for
> unnecessary locking.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
> This is a temporary solution - I'm working on a patch extending the
> regmap framework with locking policy options, which will allow users
> to manually lock & unlock regmaps if needed or disable locking at all.
>
>  drivers/misc/eeprom/at24.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 625b00166117..34bc394a9c14 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -498,14 +498,23 @@ static unsigned int at24_get_offset_adj(u8 flags, unsigned int byte_len)
>         }
>  }
>
> +static void at24_regmap_lock_unlock_none(void *map)
> +{
> +
> +}
> +
>  static const struct regmap_config regmap_config_8 = {
>         .reg_bits = 8,
>         .val_bits = 8,
> +       .lock = at24_regmap_lock_unlock_none,
> +       .unlock = at24_regmap_lock_unlock_none,
>  };
>
>  static const struct regmap_config regmap_config_16 = {
>         .reg_bits = 16,
>         .val_bits = 8,
> +       .lock = at24_regmap_lock_unlock_none,
> +       .unlock = at24_regmap_lock_unlock_none,
>  };
>
>  static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
> --
> 2.15.1
>

There were no comments. I applied this patch. These changes will be
removed in 4.17 when we'll enable the newly added disable_locking
variable in regmap config.

Bartosz
