From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 2/2] eeprom: at24: remove temporary fix for at24mac402 size.
Date: Wed, 20 Dec 2017 18:18:31 +0100
Message-ID: <CAMRc=McswJwb=0BxkLOg6fVcH4w6SUY7VWgFG33g0J9W_JXm7g@mail.gmail.com>
References: <1512768306-14816-1-git-send-email-svendev@arcx.com> <1512768306-14816-3-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34947 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755532AbdLTRSc (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 20 Dec 2017 12:18:32 -0500
Received: by mail-oi0-f68.google.com with SMTP id 184so15116835oii.2
        for <linux-i2c@vger.kernel.org>; Wed, 20 Dec 2017 09:18:32 -0800 (PST)
In-Reply-To: <1512768306-14816-3-git-send-email-svendev@arcx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sven Van Asbroeck <svendev@arcx.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, nsekhar@ti.com, Sakari Ailus <sakari.ailus@linux.intel.com>, Javier Martinez Canillas <javier@dowhile0.org>, Divagar Mohandass <divagar.mohandass@intel.com>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>

2017-12-08 22:25 GMT+01:00 Sven Van Asbroeck <svendev@arcx.com>:
> The chip size passed via devicetree, i2c, or acpi device ids is
> now no longer limited to a power of two. So the temporary
> fix can be removed.
>
> Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
> ---
>  drivers/misc/eeprom/at24.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index c3759cb..e522350 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -569,16 +569,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>                 dev_warn(&client->dev,
>                         "page_size looks suspicious (no power of 2)!\n");
>
> -       /*
> -        * REVISIT: the size of the EUI-48 byte array is 6 in at24mac402, while
> -        * the call to ilog2() in AT24_DEVICE_MAGIC() rounds it down to 4.
> -        *
> -        * Eventually we'll get rid of the magic values altoghether in favor of
> -        * real structs, but for now just manually set the right size.
> -        */
> -       if (chip.flags & AT24_FLAG_MAC && chip.byte_len == 4)
> -               chip.byte_len = 6;
> -
>         if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
>             !i2c_check_functionality(client->adapter,
>                                      I2C_FUNC_SMBUS_WRITE_I2C_BLOCK))
> --
> 1.9.1
>

Applied, thanks!
