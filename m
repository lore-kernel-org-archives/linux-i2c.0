From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] hwmon/ltc2990: Generalise DT to fwnode support
Date: Fri, 16 Aug 2019 13:07:18 +0200
Message-ID: <CAMuHMdUE_3UEzOv3pmryMwuMRF7RC9-xTG8sXUbpR=r5fKUjrg@mail.gmail.com>
References: <5b9b4383-c1e9-91a6-8ab6-8f831b362dca@enpas.org> <20190816090731.12809-1-max@enpas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816090731.12809-1-max@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Staudt <max@enpas.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
List-Id: linux-i2c@vger.kernel.org

Hi Max,

On Fri, Aug 16, 2019 at 11:09 AM Max Staudt <max@enpas.org> wrote:
> ltc2990 will now use device_property_read_u32_array() instead of
> of_property_read_u32_array() - allowing the use of software nodes
> via fwnode_create_software_node().
>
> This allows code using i2c_new_device() to specify a default
> measurement mode for the LTC2990 via fwnode_create_software_node().
>
> Signed-off-by: Max Staudt <max@enpas.org>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

One minor nit: as the driver no longer uses any of_*() symbols, you can replace
#include <linux/of.h> by #include <linux/property.h>.

> --- a/drivers/hwmon/ltc2990.c
> +++ b/drivers/hwmon/ltc2990.c
> @@ -206,7 +206,6 @@ static int ltc2990_i2c_probe(struct i2c_client *i2c,
>         int ret;
>         struct device *hwmon_dev;
>         struct ltc2990_data *data;
> -       struct device_node *of_node = i2c->dev.of_node;
>
>         if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
>                                      I2C_FUNC_SMBUS_WORD_DATA))
> @@ -218,9 +217,10 @@ static int ltc2990_i2c_probe(struct i2c_client *i2c,
>
>         data->i2c = i2c;
>
> -       if (of_node) {
> -               ret = of_property_read_u32_array(of_node, "lltc,meas-mode",
> -                                                data->mode, 2);
> +       if (dev_fwnode(&i2c->dev)) {
> +               ret = device_property_read_u32_array(&i2c->dev,
> +                                                    "lltc,meas-mode",
> +                                                    data->mode, 2);
>                 if (ret < 0)
>                         return ret;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
