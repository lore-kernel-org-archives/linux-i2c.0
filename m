From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v6 3/3] eeprom: at24: switch to device-managed version of i2c_new_dummy
Date: Thu, 4 Jan 2018 10:06:22 +0100
Message-ID: <CAMRc=Mdd=rj4vWxoT+Nkpn20a2dZ6yczvKJeTdJt8tg0L9ABWg@mail.gmail.com>
References: <5a66eaa1-9735-4b63-be66-b640f993bd21@gmail.com> <d8a5aeef-cc14-5b80-3434-8991d3f57000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38391 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeADJGX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 4 Jan 2018 04:06:23 -0500
Received: by mail-oi0-f68.google.com with SMTP id r65so622813oie.5
        for <linux-i2c@vger.kernel.org>; Thu, 04 Jan 2018 01:06:23 -0800 (PST)
In-Reply-To: <d8a5aeef-cc14-5b80-3434-8991d3f57000@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

2017-12-20 7:24 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
> Make use of recently introduced device-managed version of
> i2c_new_dummy to simplify the code.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - small improvements regarding code readability
> v3:
> - no changes
> v4:
> - no changes
> v5:
> - no changes
> v6:
> - rebased
> ---
>  drivers/misc/eeprom/at24.c | 32 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index b44a3d2b2..6232765bb 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -626,21 +626,19 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>
>         /* use dummy devices for multiple-address chips */
>         for (i = 1; i < num_addresses; i++) {
> -               at24->client[i].client = i2c_new_dummy(client->adapter,
> -                                                      client->addr + i);
> -               if (!at24->client[i].client) {
> +               struct at24_client *cl;
> +
> +               cl = &at24->client[i];
> +               cl->client = devm_i2c_new_dummy(&client->dev, client->adapter,
> +                                               client->addr + i);
> +               if (IS_ERR(cl->client)) {
>                         dev_err(&client->dev, "address 0x%02x unavailable\n",
> -                                       client->addr + i);
> -                       err = -EADDRINUSE;
> -                       goto err_clients;
> -               }
> -               at24->client[i].regmap = devm_regmap_init_i2c(
> -                                               at24->client[i].client,
> -                                               &regmap_config);
> -               if (IS_ERR(at24->client[i].regmap)) {
> -                       err = PTR_ERR(at24->client[i].regmap);
> -                       goto err_clients;
> +                               client->addr + i);
> +                       return PTR_ERR(cl->client);
>                 }
> +               cl->regmap = devm_regmap_init_i2c(cl->client, &regmap_config);
> +               if (IS_ERR(cl->regmap))
> +                       return PTR_ERR(cl->regmap);
>         }
>
>         i2c_set_clientdata(client, at24);
> @@ -692,10 +690,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>         return 0;
>
>  err_clients:
> -       for (i = 1; i < num_addresses; i++)
> -               if (at24->client[i].client)
> -                       i2c_unregister_device(at24->client[i].client);
> -
>         pm_runtime_disable(&client->dev);
>
>         return err;
> @@ -704,15 +698,11 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  static int at24_remove(struct i2c_client *client)
>  {
>         struct at24_data *at24;
> -       int i;
>
>         at24 = i2c_get_clientdata(client);
>
>         nvmem_unregister(at24->nvmem);
>
> -       for (i = 1; i < at24->num_addresses; i++)
> -               i2c_unregister_device(at24->client[i].client);
> -
>         pm_runtime_disable(&client->dev);
>         pm_runtime_set_suspended(&client->dev);
>
> --
> 2.15.1
>
>

Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
