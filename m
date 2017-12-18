From: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Subject: Re: [PATCH v2 1/2] eeprom: at24: convert magic numbers to structs.
Date: Mon, 18 Dec 2017 15:29:05 +0100
Message-ID: <CAMRc=Mdx9HiLp=81cyCiYZArks8C7MS+DgxMyr47U4mD3cXgpw@mail.gmail.com>
References: <1512768306-14816-1-git-send-email-svendev@arcx.com> <1512768306-14816-2-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512768306-14816-2-git-send-email-svendev-fuHqz3Nb1YI@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2017-12-08 22:25 GMT+01:00 Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>:
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
> This patch replaces the magic numbers with 'struct at24_chip_data'.
>
> Signed-off-by: Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>
> ---
>  drivers/misc/eeprom/at24.c | 230 ++++++++++++++++++++++-----------------------
>  1 file changed, 110 insertions(+), 120 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 06ffa11..c3759cb 100644
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
> @@ -131,113 +121,119 @@ struct at24_data {
>              op_time ? time_before(op_time, tout) : true;               \
>              usleep_range(1000, 1500), op_time = jiffies)
>
> +struct at24_chip_data {
> +       /*
> +        * these fields mirror their equivalents in
> +        * struct at24_platform_data
> +        */
> +       u32 byte_len;
> +       u8 flags;
> +};
> +
> +#define AT24_CHIP_DATA(_name, _len, _flags) \
> +       static const struct at24_chip_data at24_data_##_name = { \
> +               .byte_len = _len, .flags = _flags, \
> +       }
> +
> +#define AT24_I2C_DEVICE_ID(_name) \
> +       { #_name, (kernel_ulong_t)&at24_data_##_name }
> +
> +#define AT24_ACPI_DEVICE_ID(_name) \
> +       { #_name, (kernel_ulong_t)&at24_data_##_name }
> +
> +#define AT24_OF_DEVICE_ID(_of_compat, _name) \
> +       { .compatible = _of_compat, .data = &at24_data_##_name }
> +
> +/* needs 8 addresses as A0-A2 are ignored */
> +AT24_CHIP_DATA(24c00, 128 / 8, AT24_FLAG_TAKE8ADDR);
> +/* old variants can't be handled with this generic entry! */
> +AT24_CHIP_DATA(24c01, 1024 / 8, 0);
> +AT24_CHIP_DATA(24cs01, 16, AT24_FLAG_SERIAL | AT24_FLAG_READONLY);
> +AT24_CHIP_DATA(24c02, 2048 / 8,        0);
> +AT24_CHIP_DATA(24cs02, 16, AT24_FLAG_SERIAL | AT24_FLAG_READONLY);
> +AT24_CHIP_DATA(24mac402, 48 / 8,
> +       AT24_FLAG_MAC | AT24_FLAG_READONLY);
> +AT24_CHIP_DATA(24mac602, 64 / 8,
> +       AT24_FLAG_MAC | AT24_FLAG_READONLY);
> +/* spd is a 24c02 in memory DIMMs */
> +AT24_CHIP_DATA(spd, 2048 / 8,
> +       AT24_FLAG_READONLY | AT24_FLAG_IRUGO);
> +AT24_CHIP_DATA(24c04, 4096 / 8,        0);
> +AT24_CHIP_DATA(24cs04, 16,
> +       AT24_FLAG_SERIAL | AT24_FLAG_READONLY);
> +/* 24rf08 quirk is handled at i2c-core */
> +AT24_CHIP_DATA(24c08, 8192 / 8,        0);
> +AT24_CHIP_DATA(24cs08, 16,
> +       AT24_FLAG_SERIAL | AT24_FLAG_READONLY);
> +AT24_CHIP_DATA(24c16, 16384 / 8, 0);
> +AT24_CHIP_DATA(24cs16, 16,
> +       AT24_FLAG_SERIAL | AT24_FLAG_READONLY);
> +AT24_CHIP_DATA(24c32, 32768 / 8,       AT24_FLAG_ADDR16);
> +AT24_CHIP_DATA(24cs32, 16,
> +       AT24_FLAG_ADDR16 |
> +       AT24_FLAG_SERIAL |
> +       AT24_FLAG_READONLY);
> +AT24_CHIP_DATA(24c64, 65536 / 8,       AT24_FLAG_ADDR16);
> +AT24_CHIP_DATA(24cs64, 16,
> +       AT24_FLAG_ADDR16 |
> +       AT24_FLAG_SERIAL |
> +       AT24_FLAG_READONLY);
> +AT24_CHIP_DATA(24c128, 131072 / 8,     AT24_FLAG_ADDR16);
> +AT24_CHIP_DATA(24c256, 262144 / 8,     AT24_FLAG_ADDR16);
> +AT24_CHIP_DATA(24c512, 524288 / 8,     AT24_FLAG_ADDR16);
> +AT24_CHIP_DATA(24c1024, 1048576 / 8,   AT24_FLAG_ADDR16);
> +/* identical to 24c08 ? */
> +AT24_CHIP_DATA(INT3499, 8192 / 8, 0);
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
> +       AT24_OF_DEVICE_ID("atmel,24c00", 24c00),
> +       AT24_OF_DEVICE_ID("atmel,24c01", 24c01),
> +       AT24_OF_DEVICE_ID("atmel,24c02", 24c02),
> +       AT24_OF_DEVICE_ID("atmel,spd", spd),
> +       AT24_OF_DEVICE_ID("atmel,24c04", 24c04),
> +       AT24_OF_DEVICE_ID("atmel,24c08", 24c08),
> +       AT24_OF_DEVICE_ID("atmel,24c16", 24c16),
> +       AT24_OF_DEVICE_ID("atmel,24c32", 24c32),
> +       AT24_OF_DEVICE_ID("atmel,24c64", 24c64),
> +       AT24_OF_DEVICE_ID("atmel,24c128", 24c128),
> +       AT24_OF_DEVICE_ID("atmel,24c256", 24c256),
> +       AT24_OF_DEVICE_ID("atmel,24c512", 24c512),
> +       AT24_OF_DEVICE_ID("atmel,24c1024", 24c1024),
> +       { /* END OF LIST */ },
>  };
>  MODULE_DEVICE_TABLE(of, at24_of_match);

Hi Sven,

I have given this patch a thought over the weekend and decided that we
should not hide everything behind macros. We're decreasing the
readability while not winning anything.

Let's leave the macros defining the chip data in place (for code
brevity), but for everything else let's just use designated struct
initializers ( .compatible = "vendor,device" etc.), so drop the
AT24_OF_DEVICE_ID macros etc. in the next version.

Thanks,
Bartosz
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
