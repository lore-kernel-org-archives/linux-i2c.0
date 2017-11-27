From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] eeprom: at24: check at24_read/write arguments
Date: Mon, 27 Nov 2017 13:33:47 +0100
Message-ID: <CAMRc=Me__y_vT0=-ZND=b4+H6gx+rX=h4eO9cb8Ugdx+dQEx_w@mail.gmail.com>
References: <a519bea7-9c68-caf1-7b1a-100c2562a2d7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:37726 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751590AbdK0Mds (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 27 Nov 2017 07:33:48 -0500
Received: by mail-ot0-f193.google.com with SMTP id s4so24014652ote.4
        for <linux-i2c@vger.kernel.org>; Mon, 27 Nov 2017 04:33:48 -0800 (PST)
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

Out of curiosity: have you tried what happens currently if we try to
read past the size of the nvmem device size?

Thanks,
Bartosz
