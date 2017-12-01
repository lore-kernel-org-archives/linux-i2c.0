From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 3/7] eeprom: at24: simplify probe a little by replacing &client->dev
Date: Fri, 1 Dec 2017 11:14:03 +0100
Message-ID: <CAMRc=McunmN+Ac0QgtXimnAzXuCOGJgLU5DXX3xjWn5WC-cHew@mail.gmail.com>
References: <c0855fe6-09b4-aed1-774d-5417c78faa8b@gmail.com> <c0d642ed-6c52-b373-f9d9-c3946c04ab59@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:37787 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbdLAKOE (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 1 Dec 2017 05:14:04 -0500
Received: by mail-ot0-f194.google.com with SMTP id s4so8627171ote.4
        for <linux-i2c@vger.kernel.org>; Fri, 01 Dec 2017 02:14:04 -0800 (PST)
In-Reply-To: <c0d642ed-6c52-b373-f9d9-c3946c04ab59@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

2017-11-30 7:49 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
> We have lots of places in probe where &client->dev is used, replace it
> with a variable to simplify code a little.
>
> In addition remove redundant check for client->dev.of_node when using
> of_match_device, this function can deal with a NULL of_node.

This belongs in a separate patch. Please split it for v2.

>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/misc/eeprom/at24.c | 48 +++++++++++++++++++++-------------------------
>  1 file changed, 22 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 90fefd1cf..d56be71f1 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -511,26 +511,25 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>         int err;
>         unsigned i, num_addresses;
>         const struct regmap_config *config;
> +       struct device *dev = &client->dev;
>         u8 test_byte;
>
> -       if (client->dev.platform_data) {
> -               chip = *(struct at24_platform_data *)client->dev.platform_data;
> +       if (dev->platform_data) {
> +               chip = *(struct at24_platform_data *)dev->platform_data;
>         } else {
>                 /*
>                  * The I2C core allows OF nodes compatibles to match against the
>                  * I2C device ID table as a fallback, so check not only if an OF
>                  * node is present but also if it matches an OF device ID entry.
>                  */
> -               if (client->dev.of_node &&
> -                   of_match_device(at24_of_match, &client->dev)) {
> -                       magic = (kernel_ulong_t)
> -                               of_device_get_match_data(&client->dev);
> +               if (of_match_device(at24_of_match, dev)) {
> +                       magic = (kernel_ulong_t) of_device_get_match_data(dev);
>                 } else if (id) {
>                         magic = id->driver_data;
>                 } else {
>                         const struct acpi_device_id *aid;
>
> -                       aid = acpi_match_device(at24_acpi_ids, &client->dev);
> +                       aid = acpi_match_device(at24_acpi_ids, dev);
>                         if (aid)
>                                 magic = aid->driver_data;
>                 }
> @@ -541,7 +540,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>                 magic >>= AT24_SIZE_BYTELEN;
>                 chip.flags = magic & AT24_BITMASK(AT24_SIZE_FLAGS);
>
> -               at24_get_pdata(&client->dev, &chip);
> +               at24_get_pdata(dev, &chip);
>
>                 chip.setup = NULL;
>                 chip.context = NULL;
> @@ -552,15 +551,13 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>                 chip.flags |= AT24_FLAG_READONLY;
>
>         if (!is_power_of_2(chip.byte_len))
> -               dev_warn(&client->dev,
> -                       "byte_len looks suspicious (no power of 2)!\n");
> +               dev_warn(dev, "byte_len looks suspicious (no power of 2)!\n");
>         if (!chip.page_size) {
> -               dev_err(&client->dev, "page_size must not be 0!\n");
> +               dev_err(dev, "page_size must not be 0!\n");
>                 return -EINVAL;
>         }
>         if (!is_power_of_2(chip.page_size))
> -               dev_warn(&client->dev,
> -                       "page_size looks suspicious (no power of 2)!\n");
> +               dev_warn(dev, "page_size looks suspicious (no power of 2)!\n");
>
>         /*
>          * REVISIT: the size of the EUI-48 byte array is 6 in at24mac402, while
> @@ -588,7 +585,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>         else
>                 config = &regmap_config_8;
>
> -       at24 = devm_kzalloc(&client->dev, sizeof(struct at24_data) +
> +       at24 = devm_kzalloc(dev, sizeof(struct at24_data) +
>                 num_addresses * sizeof(struct at24_client), GFP_KERNEL);
>         if (!at24)
>                 return -ENOMEM;
> @@ -604,8 +601,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>                 return PTR_ERR(at24->client[0].regmap);
>
>         if ((chip.flags & AT24_FLAG_SERIAL) && (chip.flags & AT24_FLAG_MAC)) {
> -               dev_err(&client->dev,
> -                       "invalid device data - cannot have both AT24_FLAG_SERIAL & AT24_FLAG_MAC.");
> +               dev_err(dev, "invalid device data - cannot have both AT24_FLAG_SERIAL & AT24_FLAG_MAC.");
>                 return -EINVAL;
>         }
>
> @@ -622,8 +618,8 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>                 at24->client[i].client = i2c_new_dummy(client->adapter,
>                                                        client->addr + i);
>                 if (!at24->client[i].client) {
> -                       dev_err(&client->dev, "address 0x%02x unavailable\n",
> -                                       client->addr + i);
> +                       dev_err(dev, "address 0x%02x unavailable\n",
> +                               client->addr + i);
>                         err = -EADDRINUSE;
>                         goto err_clients;
>                 }
> @@ -638,27 +634,27 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>         i2c_set_clientdata(client, at24);
>
>         /* enable runtime pm */
> -       pm_runtime_set_active(&client->dev);
> -       pm_runtime_enable(&client->dev);
> +       pm_runtime_set_active(dev);
> +       pm_runtime_enable(dev);
>
>         /*
>          * Perform a one-byte test read to verify that the
>          * chip is functional.
>          */
>         err = at24_read(at24, 0, &test_byte, 1);
> -       pm_runtime_idle(&client->dev);
> +       pm_runtime_idle(dev);
>         if (err) {
>                 err = -ENODEV;
>                 goto err_clients;
>         }
>
> -       at24->nvmem_config.name = dev_name(&client->dev);
> -       at24->nvmem_config.dev = &client->dev;
> +       at24->nvmem_config.name = dev_name(dev);
> +       at24->nvmem_config.dev = dev;
>         at24->nvmem_config.read_only = !writable;
>         at24->nvmem_config.root_only = true;
>         at24->nvmem_config.owner = THIS_MODULE;
>         at24->nvmem_config.compat = true;
> -       at24->nvmem_config.base_dev = &client->dev;
> +       at24->nvmem_config.base_dev = dev;
>         at24->nvmem_config.reg_read = at24_read;
>         at24->nvmem_config.reg_write = at24_write;
>         at24->nvmem_config.priv = at24;
> @@ -673,7 +669,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>                 goto err_clients;
>         }
>
> -       dev_info(&client->dev, "%u byte %s EEPROM, %s, %u bytes/write\n",
> +       dev_info(dev, "%u byte %s EEPROM, %s, %u bytes/write\n",
>                 chip.byte_len, client->name,
>                 writable ? "writable" : "read-only", at24->write_max);
>
> @@ -688,7 +684,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>                 if (at24->client[i].client)
>                         i2c_unregister_device(at24->client[i].client);
>
> -       pm_runtime_disable(&client->dev);
> +       pm_runtime_disable(dev);
>
>         return err;
>  }
> --
> 2.15.0
>
>
