From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH resubmit 1/2] i2c: core: add device-managed version of i2c_new_dummy
Date: Wed, 6 Dec 2017 11:36:35 +0100
Message-ID: <CAMRc=McxO1AZy_bNyuzof2=s8zuzjJ=TO-rxvdKSNhT8R_aNgQ@mail.gmail.com>
References: <e70df557-3f71-9de2-6b1a-de566b47eb33@gmail.com> <19d37e48-0b64-b33c-993a-a1cae39efb54@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40576 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752084AbdLFKgg (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 6 Dec 2017 05:36:36 -0500
Received: by mail-oi0-f65.google.com with SMTP id w125so2235755oie.7
        for <linux-i2c@vger.kernel.org>; Wed, 06 Dec 2017 02:36:36 -0800 (PST)
In-Reply-To: <19d37e48-0b64-b33c-993a-a1cae39efb54@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

2017-12-05 20:44 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
> i2c_new_dummy is typically called from the probe function of the
> driver for the primary i2c client. It requires calls to
> i2c_unregister_device in the error path of the probe function and
> in the remove function.
> This can be simplified by introducing a device-managed version.
>
> Note the changed error case return value type:
> i2c_new_dummy returns NULL whilst devm_new_i2c_dummy returns an ERR_PTR.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Reviewed-by: Peter Rosin <peda@axentia.se>
> ---
>  Documentation/driver-model/devres.txt |  3 +++
>  drivers/i2c/i2c-core-base.c           | 39 +++++++++++++++++++++++++++++++++++
>  include/linux/i2c.h                   |  3 +++
>  3 files changed, 45 insertions(+)
>
> diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
> index c180045eb..6e2bccf85 100644
> --- a/Documentation/driver-model/devres.txt
> +++ b/Documentation/driver-model/devres.txt
> @@ -259,6 +259,9 @@ GPIO
>    devm_gpio_request_one()
>    devm_gpio_free()
>
> +I2C
> +  devm_i2c_new_dummy
> +
>  IIO
>    devm_iio_device_alloc()
>    devm_iio_device_free()
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index bf52cca87..c1db67f9a 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -820,6 +820,45 @@ struct i2c_client *i2c_new_dummy(struct i2c_adapter *adapter, u16 address)
>  }
>  EXPORT_SYMBOL_GPL(i2c_new_dummy);
>
> +static void devm_i2c_release_dummy(struct device *dev, void *res)
> +{
> +       i2c_unregister_device(*(struct i2c_client **)res);
> +}
> +

Wolfram will have the last word here, but I would really prefer that
you wrap struct i2c_client in a separate devres (e.g. struct
i2c_dummy_devres) structure and avoid the cast. I find it a lot more
readable even if it only has a single member.

> +/**
> + * devm_i2c_new_dummy - return a new i2c device bound to a dummy driver
> + * @dev: device the managed resource is bound to
> + * @adapter: the adapter managing the device
> + * @address: seven bit address to be used
> + * Context: can sleep
> + *
> + * This is the device-managed version of i2c_new_dummy.
> + * Note the changed return value type: It returns the new i2c client
> + * or an ERR_PTR in case of an error.
> + */
> +struct i2c_client *devm_i2c_new_dummy(struct device *dev,
> +                                     struct i2c_adapter *adapter,
> +                                     u16 address)
> +{
> +       struct i2c_client *ret, **dr;
> +
> +       dr = devres_alloc(devm_i2c_release_dummy, sizeof(*dr), GFP_KERNEL);
> +       if (!dr)
> +               return ERR_PTR(-ENOMEM);
> +
> +       ret = i2c_new_dummy(adapter, address);
> +       if (!ret) {
> +               devres_free(dr);
> +               return ERR_PTR(-EBUSY);

This is misleading as EBUSY is not necessarily the error that cased
i2c_new_device() to fail. Return NULL here and document that users
need to use IS_ERR_OR_NULL() to check for errors.

> +       }
> +
> +       *dr = ret;
> +       devres_add(dev, dr);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(devm_i2c_new_dummy);
> +
>  /**
>   * i2c_new_secondary_device - Helper to get the instantiated secondary address
>   * and create the associated device
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index a556db976..c27eac1e1 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -383,6 +383,9 @@ extern int i2c_probe_func_quick_read(struct i2c_adapter *, unsigned short addr);
>  extern struct i2c_client *
>  i2c_new_dummy(struct i2c_adapter *adap, u16 address);
>
> +extern struct i2c_client *
> +devm_i2c_new_dummy(struct device *dev, struct i2c_adapter *adap, u16 address);
> +
>  extern struct i2c_client *
>  i2c_new_secondary_device(struct i2c_client *client,
>                                 const char *name,
> --
> 2.15.1
>
>

Thanks,
Bartosz
