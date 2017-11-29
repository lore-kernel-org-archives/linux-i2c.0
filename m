From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] eeprom: at24: check at24_read/write arguments
Date: Wed, 29 Nov 2017 15:58:01 +0100
Message-ID: <CAMRc=Md4s30veywtpRPa+phZS4rZ3EaL2eBr4yNxuau9x_sLrA@mail.gmail.com>
References: <a519bea7-9c68-caf1-7b1a-100c2562a2d7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33488 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754995AbdK2O6C (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 29 Nov 2017 09:58:02 -0500
Received: by mail-oi0-f65.google.com with SMTP id w131so2571393oiw.0
        for <linux-i2c@vger.kernel.org>; Wed, 29 Nov 2017 06:58:02 -0800 (PST)
In-Reply-To: <a519bea7-9c68-caf1-7b1a-100c2562a2d7@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

2017-11-24 7:47 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
> So far we completely rely on the caller to provide valid arguments.
> To be on the safe side perform an own sanity check.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/misc/eeprom/at24.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 00d602be7..52cbaeb6f 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -569,6 +569,9 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
>         if (unlikely(!count))
>                 return count;
>
> +       if (off + count > at24->chip.byte_len)
> +               return -EINVAL;
> +
>         client = at24_translate_offset(at24, &off);
>
>         ret = pm_runtime_get_sync(&client->dev);
> @@ -614,6 +617,9 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
>         if (unlikely(!count))
>                 return -EINVAL;
>
> +       if (off + count > at24->chip.byte_len)
> +               return -EINVAL;
> +
>         client = at24_translate_offset(at24, &off);
>
>         ret = pm_runtime_get_sync(&client->dev);
> --
> 2.15.0
>
>

Applied to at24/fixes, thanks!
