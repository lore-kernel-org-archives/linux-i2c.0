From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 3/3] i2c/busses/i2c-icy: Add LTC2990 present on 2019
 board revision
Date: Tue, 20 Aug 2019 11:18:36 +0200
Message-ID: <CAMuHMdV1r5LphqNHyM9z8QXbqhAb6skH4wpPq=ZH6XRBHnxwuw@mail.gmail.com>
References: <20190819121618.16557-1-max@enpas.org> <20190819121618.16557-3-max@enpas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190819121618.16557-3-max@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Staudt <max@enpas.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, Aug 19, 2019 at 2:17 PM Max Staudt <max@enpas.org> wrote:
> Since the 2019 a1k.org community re-print of these PCBs sports an
> LTC2990 hwmon chip as an example use case, let this driver autoprobe
> for that as well. If it is present, modprobing ltc2990 is sufficient.
>
> The property_entry enables the three additional inputs available on
> this particular board:
>
>   in1 will be the voltage of the 5V rail, divided by 2.
>   in2 will be the voltage of the 12V rail, divided by 4.
>   temp3 will be measured using a PCB loop next the chip.
>
> v5: Style
>
> v4: Style
>     Added other possible addresses for LTC2990.
>
> v3: Merged with initial LTC2990 support on ICY.
>     Moved defaults from platform_data to swnode.
>     Added note to Kconfig.
>
> Signed-off-by: Max Staudt <max@enpas.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

One comment below...

> --- a/drivers/i2c/busses/i2c-icy.c
> +++ b/drivers/i2c/busses/i2c-icy.c

> @@ -141,6 +166,35 @@ static int icy_probe(struct zorro_dev *z,
>         dev_info(&z->dev, "ICY I2C controller at %pa, IRQ not implemented\n",
>                  &z->resource.start);
>
> +       /*
> +        * The 2019 a1k.org PCBs have an LTC2990 at 0x4c, so start
> +        * it automatically once ltc2990 is modprobed.
> +        *
> +        * in0 is the voltage of the internal 5V power supply.
> +        * temp1 is the temperature inside the chip.
> +        *
> +        * See property_entry above for in1, in2, temp3.
> +        */
> +       new_fwnode = fwnode_create_software_node(icy_ltc2990_props, NULL);
> +       if (IS_ERR(new_fwnode)) {
> +               dev_info(&z->dev, "Failed to create fwnode for LTC2990, error: %ld\n",
> +                        PTR_ERR(new_fwnode));
> +       } else {
> +               /*
> +                * Store the fwnode so we can destroy it on .remove().
> +                * Only store it on success, as fwnode_remove_software_node()
> +                * is NULL safe, but not PTR_ERR safe.
> +                */
> +               i2c->ltc2990_fwnode = new_fwnode;
> +               ltc2990_info.fwnode = new_fwnode;
> +
> +               i2c->ltc2990_client =
> +                       i2c_new_probed_device(&i2c->adapter,
> +                                             &ltc2990_info,
> +                                             icy_ltc2990_addresses,
> +                                             NULL);
> +       }
> +
>         return 0;
>  }

Since commit d3e1b617ae20c459 ("i2c: allow specify device properties in
i2c_board_info"), the properties could be provided by info->properties, too.
However, according to the comments for device_add_properties(), this is
valid only if there is a real firmware node present.

If that is true, Max' use is correct, while e.g. commit 6a7836ba7fb4abf6
("ARM: imx: pca100: use device properties for at24 eeprom") isn't?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
