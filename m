From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/2] platform/mellanox: mlxreg-hotplug: convert to use i2c_new_client_device()
Date: Fri, 27 Mar 2020 09:38:21 +0200
Message-ID: <CAHp75Vfw4_0ttE2F-WxdULf7hRGsQvqzCLdCNVy7RBaFdEsCGA@mail.gmail.com>
References: <20200326210952.12857-1-wsa+renesas@sang-engineering.com> <20200326210952.12857-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45890 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgC0Hie (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 27 Mar 2020 03:38:34 -0400
In-Reply-To: <20200326210952.12857-3-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, Vadim Pasternak <vadimp@mellanox.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Mar 26, 2020 at 11:10 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Move away from the deprecated API and return the shiny new ERRPTR where
> useful.
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/platform/mellanox/mlxreg-hotplug.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
> index 77be37a1fbcf..ed48917af162 100644
> --- a/drivers/platform/mellanox/mlxreg-hotplug.c
> +++ b/drivers/platform/mellanox/mlxreg-hotplug.c
> @@ -101,6 +101,7 @@ static int mlxreg_hotplug_device_create(struct mlxreg_hotplug_priv_data *priv,
>                                         struct mlxreg_core_data *data)
>  {
>         struct mlxreg_core_hotplug_platform_data *pdata;
> +       struct i2c_client *client;
>
>         /* Notify user by sending hwmon uevent. */
>         kobject_uevent(&priv->hwmon->kobj, KOBJ_CHANGE);
> @@ -121,18 +122,20 @@ static int mlxreg_hotplug_device_create(struct mlxreg_hotplug_priv_data *priv,
>                 return -EFAULT;
>         }
>
> -       data->hpdev.client = i2c_new_device(data->hpdev.adapter,
> -                                           data->hpdev.brdinfo);
> -       if (!data->hpdev.client) {
> +       client = i2c_new_client_device(data->hpdev.adapter,
> +                                      data->hpdev.brdinfo);
> +       if (IS_ERR(client)) {
>                 dev_err(priv->dev, "Failed to create client %s at bus %d at addr 0x%02x\n",
>                         data->hpdev.brdinfo->type, data->hpdev.nr +
>                         pdata->shift_nr, data->hpdev.brdinfo->addr);
>
>                 i2c_put_adapter(data->hpdev.adapter);
>                 data->hpdev.adapter = NULL;
> -               return -EFAULT;
> +               return PTR_ERR(client);
>         }
>
> +       data->hpdev.client = client;
> +
>         return 0;
>  }
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
