From: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Subject: Re: [PATCH v1 1/2] eeprom: at24: convert magic numbers to structs.
Date: Fri, 8 Dec 2017 14:32:35 +0100
Message-ID: <CAMRc=MeQUavcxejmTO5G7w2GBBY-7KKQ649qW_GhEZ9bV755nw@mail.gmail.com>
References: <1512576272-25563-1-git-send-email-svendev@arcx.com> <1512576272-25563-2-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512576272-25563-2-git-send-email-svendev-fuHqz3Nb1YI@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2017-12-06 17:04 GMT+01:00 Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>:
> Fundamental properties such as capacity and page size differ
> among at24-type chips. But these chips do not have an id register,
> so this can't be discovered at runtime.
>
> Traditionally, at24-type eeprom properties were determined in two ways:
> - by passing a 'struct at24_platform_data' via platform_data, or
> - by naming the chip type in the devicetree, which passes a
>         'magic number' to probe(), which is then converted to
>         a 'struct at24_platform_data'.
>
> Recently a bug was discovered because the magic number rounds down
> all chip sizes to the lowest power of two. This was addressed by
> a work-around, with the wish that magic numbers should over time
> be converted to structs.
>
> This patch replaces the magic numbers by 'struct at24_platform_data',
> which eliminates the need for magic number -> platform_data conversion.
>
> Signed-off-by: Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>
> ---

Hi Sven,

I think this series will be a good first step in improving the device
tree support. Comments below.

>  drivers/misc/eeprom/at24.c | 219 +++++++++++++++++++++------------------------
>  1 file changed, 100 insertions(+), 119 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 625b001..d990c5d 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -105,16 +105,6 @@ struct at24_data {
>  module_param(write_timeout, uint, 0);
>  MODULE_PARM_DESC(write_timeout, "Time (in ms) to try writes (default 25)");
>
> -#define AT24_SIZE_BYTELEN 5
> -#define AT24_SIZE_FLAGS 8
> -
> -#define AT24_BITMASK(x) (BIT(x) - 1)
> -
> -/* create non-zero magic value for given eeprom parameters */
> -#define AT24_DEVICE_MAGIC(_len, _flags)                \
> -       ((1 << AT24_SIZE_FLAGS | (_flags))              \
> -           << AT24_SIZE_BYTELEN | ilog2(_len))
> -
>  /*
>   * Both reads and writes fail if the previous write didn't complete yet. This
>   * macro loops a few times waiting at least long enough for one entire page
> @@ -131,113 +121,111 @@ struct at24_data {
>              op_time ? time_before(op_time, tout) : true;               \
>              usleep_range(1000, 1500), op_time = jiffies)
>
> +#define DECLARE_AT24_PLATDATA(_name, _len, _flags) \
> +       static const struct at24_platform_data platdata_##_name = { \
> +               .byte_len = _len, .flags = _flags, \
> +       }
> +

Using platform data here will increase the code size significantly.
Let's create a separate structure with only the necessary fields.
Also: please have the AT24/at24 prefix for symbols in the driver. I'd
go for simple AT24_CHIP_DATA() here. Also: platdata_##_name should
become at24_data_##_name.

> +#define AT24_I2C_DEVICE_ID(_name) \
> +       { #_name, (kernel_ulong_t)&platdata_##_name }
> +
> +#define AT24_ACPI_DEVICE_ID(_name) \
> +       { #_name, (kernel_ulong_t)&platdata_##_name }
> +
> +#define AT24_OF_DEVICE_ID(_mfg, _name) \
> +       { .compatible = #_mfg "," #_name, .data = &platdata_##_name }

I don't like hiding the way the compatible is created here from the
user. It doesn't save any code neither. Please make the macro accept
the whole compatible string.

> +
> +/* needs 8 addresses as A0-A2 are ignored */
> +DECLARE_AT24_PLATDATA(24c00, 128 / 8, AT24_FLAG_TAKE8ADDR);
> +/* old variants can't be handled with this generic entry! */
> +DECLARE_AT24_PLATDATA(24c01, 1024 / 8, 0);
> +DECLARE_AT24_PLATDATA(24cs01, 16, AT24_FLAG_SERIAL | AT24_FLAG_READONLY);
> +DECLARE_AT24_PLATDATA(24c02, 2048 / 8, 0);
> +DECLARE_AT24_PLATDATA(24cs02, 16, AT24_FLAG_SERIAL | AT24_FLAG_READONLY);
> +DECLARE_AT24_PLATDATA(24mac402, 48 / 8,
> +       AT24_FLAG_MAC | AT24_FLAG_READONLY);
> +DECLARE_AT24_PLATDATA(24mac602, 64 / 8,
> +       AT24_FLAG_MAC | AT24_FLAG_READONLY);
> +/* spd is a 24c02 in memory DIMMs */
> +DECLARE_AT24_PLATDATA(spd, 2048 / 8,
> +       AT24_FLAG_READONLY | AT24_FLAG_IRUGO);
> +DECLARE_AT24_PLATDATA(24c04, 4096 / 8, 0);
> +DECLARE_AT24_PLATDATA(24cs04, 16,
> +       AT24_FLAG_SERIAL | AT24_FLAG_READONLY);
> +/* 24rf08 quirk is handled at i2c-core */
> +DECLARE_AT24_PLATDATA(24c08, 8192 / 8, 0);
> +DECLARE_AT24_PLATDATA(24cs08, 16,
> +       AT24_FLAG_SERIAL | AT24_FLAG_READONLY);
> +DECLARE_AT24_PLATDATA(24c16, 16384 / 8, 0);
> +DECLARE_AT24_PLATDATA(24cs16, 16,
> +       AT24_FLAG_SERIAL | AT24_FLAG_READONLY);
> +DECLARE_AT24_PLATDATA(24c32, 32768 / 8,        AT24_FLAG_ADDR16);
> +DECLARE_AT24_PLATDATA(24cs32, 16,
> +       AT24_FLAG_ADDR16 |
> +       AT24_FLAG_SERIAL |
> +       AT24_FLAG_READONLY);
> +DECLARE_AT24_PLATDATA(24c64, 65536 / 8,        AT24_FLAG_ADDR16);
> +DECLARE_AT24_PLATDATA(24cs64, 16,
> +       AT24_FLAG_ADDR16 |
> +       AT24_FLAG_SERIAL |
> +       AT24_FLAG_READONLY);
> +DECLARE_AT24_PLATDATA(24c128, 131072 / 8,      AT24_FLAG_ADDR16);
> +DECLARE_AT24_PLATDATA(24c256, 262144 / 8,      AT24_FLAG_ADDR16);
> +DECLARE_AT24_PLATDATA(24c512, 524288 / 8,      AT24_FLAG_ADDR16);
> +DECLARE_AT24_PLATDATA(24c1024, 1048576 / 8,    AT24_FLAG_ADDR16);
> +
>  static const struct i2c_device_id at24_ids[] = {
> -       /* needs 8 addresses as A0-A2 are ignored */
> -       { "24c00",      AT24_DEVICE_MAGIC(128 / 8,      AT24_FLAG_TAKE8ADDR) },
> -       /* old variants can't be handled with this generic entry! */
> -       { "24c01",      AT24_DEVICE_MAGIC(1024 / 8,     0) },
> -       { "24cs01",     AT24_DEVICE_MAGIC(16,
> -                               AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
> -       { "24c02",      AT24_DEVICE_MAGIC(2048 / 8,     0) },
> -       { "24cs02",     AT24_DEVICE_MAGIC(16,
> -                               AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
> -       { "24mac402",   AT24_DEVICE_MAGIC(48 / 8,
> -                               AT24_FLAG_MAC | AT24_FLAG_READONLY) },
> -       { "24mac602",   AT24_DEVICE_MAGIC(64 / 8,
> -                               AT24_FLAG_MAC | AT24_FLAG_READONLY) },
> -       /* spd is a 24c02 in memory DIMMs */
> -       { "spd",        AT24_DEVICE_MAGIC(2048 / 8,
> -                               AT24_FLAG_READONLY | AT24_FLAG_IRUGO) },
> -       { "24c04",      AT24_DEVICE_MAGIC(4096 / 8,     0) },
> -       { "24cs04",     AT24_DEVICE_MAGIC(16,
> -                               AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
> -       /* 24rf08 quirk is handled at i2c-core */
> -       { "24c08",      AT24_DEVICE_MAGIC(8192 / 8,     0) },
> -       { "24cs08",     AT24_DEVICE_MAGIC(16,
> -                               AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
> -       { "24c16",      AT24_DEVICE_MAGIC(16384 / 8,    0) },
> -       { "24cs16",     AT24_DEVICE_MAGIC(16,
> -                               AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
> -       { "24c32",      AT24_DEVICE_MAGIC(32768 / 8,    AT24_FLAG_ADDR16) },
> -       { "24cs32",     AT24_DEVICE_MAGIC(16,
> -                               AT24_FLAG_ADDR16 |
> -                               AT24_FLAG_SERIAL |
> -                               AT24_FLAG_READONLY) },
> -       { "24c64",      AT24_DEVICE_MAGIC(65536 / 8,    AT24_FLAG_ADDR16) },
> -       { "24cs64",     AT24_DEVICE_MAGIC(16,
> -                               AT24_FLAG_ADDR16 |
> -                               AT24_FLAG_SERIAL |
> -                               AT24_FLAG_READONLY) },
> -       { "24c128",     AT24_DEVICE_MAGIC(131072 / 8,   AT24_FLAG_ADDR16) },
> -       { "24c256",     AT24_DEVICE_MAGIC(262144 / 8,   AT24_FLAG_ADDR16) },
> -       { "24c512",     AT24_DEVICE_MAGIC(524288 / 8,   AT24_FLAG_ADDR16) },
> -       { "24c1024",    AT24_DEVICE_MAGIC(1048576 / 8,  AT24_FLAG_ADDR16) },
> +       AT24_I2C_DEVICE_ID(24c00),
> +       AT24_I2C_DEVICE_ID(24c01),
> +       AT24_I2C_DEVICE_ID(24cs01),
> +       AT24_I2C_DEVICE_ID(24c02),
> +       AT24_I2C_DEVICE_ID(24cs02),
> +       AT24_I2C_DEVICE_ID(24mac402),
> +       AT24_I2C_DEVICE_ID(24mac602),
> +       AT24_I2C_DEVICE_ID(spd),
> +       AT24_I2C_DEVICE_ID(24c04),
> +       AT24_I2C_DEVICE_ID(24cs04),
> +       AT24_I2C_DEVICE_ID(24c08),
> +       AT24_I2C_DEVICE_ID(24cs08),
> +       AT24_I2C_DEVICE_ID(24c16),
> +       AT24_I2C_DEVICE_ID(24cs16),
> +       AT24_I2C_DEVICE_ID(24c32),
> +       AT24_I2C_DEVICE_ID(24cs32),
> +       AT24_I2C_DEVICE_ID(24c64),
> +       AT24_I2C_DEVICE_ID(24cs64),
> +       AT24_I2C_DEVICE_ID(24c128),
> +       AT24_I2C_DEVICE_ID(24c256),
> +       AT24_I2C_DEVICE_ID(24c512),
> +       AT24_I2C_DEVICE_ID(24c1024),
>         { "at24", 0 },
>         { /* END OF LIST */ }
>  };
>  MODULE_DEVICE_TABLE(i2c, at24_ids);
>
>  static const struct of_device_id at24_of_match[] = {
> -       {
> -               .compatible = "atmel,24c00",
> -               .data = (void *)AT24_DEVICE_MAGIC(128 / 8, AT24_FLAG_TAKE8ADDR)
> -       },
> -       {
> -               .compatible = "atmel,24c01",
> -               .data = (void *)AT24_DEVICE_MAGIC(1024 / 8, 0)
> -       },
> -       {
> -               .compatible = "atmel,24c02",
> -               .data = (void *)AT24_DEVICE_MAGIC(2048 / 8, 0)
> -       },
> -       {
> -               .compatible = "atmel,spd",
> -               .data = (void *)AT24_DEVICE_MAGIC(2048 / 8,
> -                               AT24_FLAG_READONLY | AT24_FLAG_IRUGO)
> -       },
> -       {
> -               .compatible = "atmel,24c04",
> -               .data = (void *)AT24_DEVICE_MAGIC(4096 / 8, 0)
> -       },
> -       {
> -               .compatible = "atmel,24c08",
> -               .data = (void *)AT24_DEVICE_MAGIC(8192 / 8, 0)
> -       },
> -       {
> -               .compatible = "atmel,24c16",
> -               .data = (void *)AT24_DEVICE_MAGIC(16384 / 8, 0)
> -       },
> -       {
> -               .compatible = "atmel,24c32",
> -               .data = (void *)AT24_DEVICE_MAGIC(32768 / 8, AT24_FLAG_ADDR16)
> -       },
> -       {
> -               .compatible = "atmel,24c64",
> -               .data = (void *)AT24_DEVICE_MAGIC(65536 / 8, AT24_FLAG_ADDR16)
> -       },
> -       {
> -               .compatible = "atmel,24c128",
> -               .data = (void *)AT24_DEVICE_MAGIC(131072 / 8, AT24_FLAG_ADDR16)
> -       },
> -       {
> -               .compatible = "atmel,24c256",
> -               .data = (void *)AT24_DEVICE_MAGIC(262144 / 8, AT24_FLAG_ADDR16)
> -       },
> -       {
> -               .compatible = "atmel,24c512",
> -               .data = (void *)AT24_DEVICE_MAGIC(524288 / 8, AT24_FLAG_ADDR16)
> -       },
> -       {
> -               .compatible = "atmel,24c1024",
> -               .data = (void *)AT24_DEVICE_MAGIC(1048576 / 8, AT24_FLAG_ADDR16)
> -       },
> -       { },
> +       AT24_OF_DEVICE_ID(atmel, 24c00),
> +       AT24_OF_DEVICE_ID(atmel, 24c01),
> +       AT24_OF_DEVICE_ID(atmel, 24c02),
> +       AT24_OF_DEVICE_ID(atmel, spd),
> +       AT24_OF_DEVICE_ID(atmel, 24c04),
> +       AT24_OF_DEVICE_ID(atmel, 24c08),
> +       AT24_OF_DEVICE_ID(atmel, 24c16),
> +       AT24_OF_DEVICE_ID(atmel, 24c32),
> +       AT24_OF_DEVICE_ID(atmel, 24c64),
> +       AT24_OF_DEVICE_ID(atmel, 24c128),
> +       AT24_OF_DEVICE_ID(atmel, 24c256),
> +       AT24_OF_DEVICE_ID(atmel, 24c512),
> +       AT24_OF_DEVICE_ID(atmel, 24c1024),
> +       { /* END OF LIST */ },
>  };
>  MODULE_DEVICE_TABLE(of, at24_of_match);
>
> +/* identical to 24c08 ? */
> +DECLARE_AT24_PLATDATA(INT3499, 8192 / 8, 0);

Keep all these defines grouped together above.

> +
>  static const struct acpi_device_id at24_acpi_ids[] = {
> -       { "INT3499", AT24_DEVICE_MAGIC(8192 / 8, 0) },
> -       { }
> +       AT24_ACPI_DEVICE_ID(INT3499),
> +       { /* END OF LIST */ }
>  };
>  MODULE_DEVICE_TABLE(acpi, at24_acpi_ids);
>
> @@ -511,7 +499,7 @@ static unsigned int at24_get_offset_adj(u8 flags, unsigned int byte_len)
>  static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  {
>         struct at24_platform_data chip;
> -       kernel_ulong_t magic = 0;
> +       const struct at24_platform_data *pd = NULL;
>         bool writable;
>         struct at24_data *at24;
>         int err;
> @@ -529,28 +517,21 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>                  */
>                 if (client->dev.of_node &&
>                     of_match_device(at24_of_match, &client->dev)) {
> -                       magic = (kernel_ulong_t)
> -                               of_device_get_match_data(&client->dev);
> +                       pd = of_device_get_match_data(&client->dev);
>                 } else if (id) {
> -                       magic = id->driver_data;
> +                       pd = (void *)id->driver_data;
>                 } else {
>                         const struct acpi_device_id *aid;
>
>                         aid = acpi_match_device(at24_acpi_ids, &client->dev);
>                         if (aid)
> -                               magic = aid->driver_data;
> +                               pd = (void *)aid->driver_data;
>                 }
> -               if (!magic)
> +               if (!pd)
>                         return -ENODEV;
>
> -               chip.byte_len = BIT(magic & AT24_BITMASK(AT24_SIZE_BYTELEN));
> -               magic >>= AT24_SIZE_BYTELEN;
> -               chip.flags = magic & AT24_BITMASK(AT24_SIZE_FLAGS);
> -
> +               chip = *pd;
>                 at24_get_pdata(&client->dev, &chip);
> -
> -               chip.setup = NULL;
> -               chip.context = NULL;
>         }
>
>         if (!is_power_of_2(chip.byte_len))
> --
> 1.9.1
>

Thanks,
Bartosz
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
