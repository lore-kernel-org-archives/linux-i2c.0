From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 4/7] eeprom: at24: simplify functions at24_read/write a little
Date: Fri, 1 Dec 2017 11:14:51 +0100
Message-ID: <CAMRc=Mf6qmhC5P=UzgRop23W8dibouBARtOxUYhOgeSA4uVPMA@mail.gmail.com>
References: <c0855fe6-09b4-aed1-774d-5417c78faa8b@gmail.com> <1b2f8ac8-02ae-d615-8c23-6d90f52be555@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:44858 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbdLAKOw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 1 Dec 2017 05:14:52 -0500
Received: by mail-ot0-f193.google.com with SMTP id d27so8610663ote.11
        for <linux-i2c@vger.kernel.org>; Fri, 01 Dec 2017 02:14:51 -0800 (PST)
In-Reply-To: <1b2f8ac8-02ae-d615-8c23-6d90f52be555@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

2017-11-30 7:49 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
> Simplify functions at24_read/write a little.
>

Please be more specific in your commit message - it's not obvious at
first glance what you're actually simplifying.

Thanks,
Bartosz

> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/misc/eeprom/at24.c | 40 ++++++++++++++++------------------------
>  1 file changed, 16 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index d56be71f1..837f1d88c 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -374,24 +374,20 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
>         mutex_lock(&at24->lock);
>
>         while (count) {
> -               int     status;
> +               ret = at24_regmap_read(at24, buf, off, count);
> +               if (ret < 0)
> +                       goto out;
>
> -               status = at24_regmap_read(at24, buf, off, count);
> -               if (status < 0) {
> -                       mutex_unlock(&at24->lock);
> -                       pm_runtime_put(&client->dev);
> -                       return status;
> -               }
> -               buf += status;
> -               off += status;
> -               count -= status;
> +               buf += ret;
> +               off += ret;
> +               count -= ret;
>         }
> -
> +out:
>         mutex_unlock(&at24->lock);
>
>         pm_runtime_put(&client->dev);
>
> -       return 0;
> +       return ret < 0 ? ret : 0;
>  }
>
>  static int at24_write(void *priv, unsigned int off, void *val, size_t count)
> @@ -424,24 +420,20 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
>         mutex_lock(&at24->lock);
>
>         while (count) {
> -               int status;
> +               ret = at24_regmap_write(at24, buf, off, count);
> +               if (ret < 0)
> +                       goto out;
>
> -               status = at24_regmap_write(at24, buf, off, count);
> -               if (status < 0) {
> -                       mutex_unlock(&at24->lock);
> -                       pm_runtime_put(&client->dev);
> -                       return status;
> -               }
> -               buf += status;
> -               off += status;
> -               count -= status;
> +               buf += ret;
> +               off += ret;
> +               count -= ret;
>         }
> -
> +out:
>         mutex_unlock(&at24->lock);
>
>         pm_runtime_put(&client->dev);
>
> -       return 0;
> +       return ret < 0 ? ret : 0;
>  }
>
>  static void at24_get_pdata(struct device *dev, struct at24_platform_data *chip)
> --
> 2.15.0
>
>
