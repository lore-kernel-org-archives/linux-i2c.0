From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [RFC PATCH 7/7] i2c: core: hand over reserved devices when
 requesting ancillary addresses
Date: Fri, 21 Feb 2020 11:13:48 +0100
Message-ID: <CAMuHMdV-dfjukuSKiFg4vb4Ntn+XWU0XwHPxyoaWs1vtQVg4cw@mail.gmail.com>
References: <20200220172403.26062-1-wsa+renesas@sang-engineering.com> <20200220172403.26062-8-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200220172403.26062-8-wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i3c-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kieran Bingham <kieran-7hKh/agyDeatmTQ+vhA3Yw@public.gmane.org>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>, Luca Ceresoli <luca-ep08DiM7hqZH3+C6az13tg@public.gmane.org>, Jacopo Mondi <jacopo-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thu, Feb 20, 2020 at 6:26 PM Wolfram Sang
<wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org> wrote:
> With i2c_new_ancillary_address, we can check if the intended driver is
> requesting a reserved address. Update the function to do these checks.
> If the check passes, the "reserved" device will become a regular "dummy"
> device.
>
> Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

Thanks for your patch!

> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -975,6 +975,8 @@ struct i2c_client *i2c_new_ancillary_device(struct i2c_client *client,
>                                                 u16 default_addr)
>  {
>         struct device_node *np = client->dev.of_node;
> +       struct device *reserved_dev, *adapter_dev = &client->adapter->dev;
> +       struct i2c_client *reserved_client;
>         u32 addr = default_addr;
>         int i;
>
> @@ -984,7 +986,21 @@ struct i2c_client *i2c_new_ancillary_device(struct i2c_client *client,
>                         of_property_read_u32_index(np, "reg", i, &addr);
>         }
>
> -       dev_dbg(&client->adapter->dev, "Address for %s : 0x%x\n", name, addr);
> +       dev_info(adapter_dev, "Address for %s : 0x%x\n", name, addr);
> +
> +       /* No need to scan muxes, siblings must sit on the same adapter */
> +       reserved_dev = device_find_child(adapter_dev, &addr, __i2c_check_addr_busy);
> +       reserved_client = i2c_verify_client(reserved_dev);
> +
> +       if (reserved_client) {
> +               if (reserved_client->dev.of_node != np ||
> +                   strcmp(reserved_client->name, I2C_RESERVED_DRV_NAME) != 0)
> +                       return ERR_PTR(-EBUSY);

Missing put_device(reserved_dev).

> +
> +               strlcpy(reserved_client->name, I2C_DUMMY_DRV_NAME, sizeof(client->name));
> +               return reserved_client;
> +       }

else put_device(reserved_dev)

(perhaps i2c_verify_client() checking dev was not such a great idea, as
 callers need to act on dev && !verified anyway?)

> +
>         return i2c_new_dummy_device(client->adapter, addr);
>  }
>  EXPORT_SYMBOL_GPL(i2c_new_ancillary_device);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
