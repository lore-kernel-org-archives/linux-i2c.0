From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v4 1/2] eeprom: at24: fix coding style issues
Date: Mon, 18 Dec 2017 18:44:45 +0100
Message-ID: <CAMRc=Mf__zx6EQvF55m7nKF5axOhGHYRMMBrFzzju-CwPUwwew@mail.gmail.com>
References: <20171213105624.27058-1-brgl@bgdev.pl> <20171213105624.27058-2-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171213105624.27058-2-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Peter Rosin <peda@axentia.se>, linux-i2c <linux-i2c@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

2017-12-13 11:56 GMT+01:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> Fix issues reported by checkpatch for at24.c.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/misc/eeprom/at24.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 625b00166117..87b68ef07dfc 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -70,8 +70,8 @@ struct at24_data {
>          */
>         struct mutex lock;
>
> -       unsigned write_max;
> -       unsigned num_addresses;
> +       unsigned int write_max;
> +       unsigned int num_addresses;
>         unsigned int offset_adj;
>
>         struct nvmem_config nvmem_config;
> @@ -93,7 +93,7 @@ struct at24_data {
>   *
>   * This value is forced to be a power of two so that writes align on pages.
>   */
> -static unsigned io_limit = 128;
> +static unsigned int io_limit = 128;
>  module_param(io_limit, uint, 0);
>  MODULE_PARM_DESC(io_limit, "Maximum bytes per I/O (default 128)");
>
> @@ -101,7 +101,7 @@ MODULE_PARM_DESC(io_limit, "Maximum bytes per I/O (default 128)");
>   * Specs often allow 5 msec for a page write, sometimes 20 msec;
>   * it's important to recover from write timeouts.
>   */
> -static unsigned write_timeout = 25;
> +static unsigned int write_timeout = 25;
>  module_param(write_timeout, uint, 0);
>  MODULE_PARM_DESC(write_timeout, "Time (in ms) to try writes (default 25)");
>
> @@ -111,8 +111,8 @@ MODULE_PARM_DESC(write_timeout, "Time (in ms) to try writes (default 25)");
>  #define AT24_BITMASK(x) (BIT(x) - 1)
>
>  /* create non-zero magic value for given eeprom parameters */
> -#define AT24_DEVICE_MAGIC(_len, _flags)                \
> -       ((1 << AT24_SIZE_FLAGS | (_flags))              \
> +#define AT24_DEVICE_MAGIC(_len, _flags)                        \
> +       ((1 << AT24_SIZE_FLAGS | (_flags))              \
>             << AT24_SIZE_BYTELEN | ilog2(_len))
>
>  /*
> @@ -264,7 +264,7 @@ MODULE_DEVICE_TABLE(acpi, at24_acpi_ids);
>  static struct at24_client *at24_translate_offset(struct at24_data *at24,
>                                                  unsigned int *offset)
>  {
> -       unsigned i;
> +       unsigned int i;
>
>         if (at24->chip.flags & AT24_FLAG_ADDR16) {
>                 i = *offset >> 16;
> @@ -319,7 +319,7 @@ static ssize_t at24_regmap_read(struct at24_data *at24, char *buf,
>  static size_t at24_adjust_write_count(struct at24_data *at24,
>                                       unsigned int offset, size_t count)
>  {
> -       unsigned next_page;
> +       unsigned int next_page;
>
>         /* write_max is at most a page */
>         if (count > at24->write_max)
> @@ -515,7 +515,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>         bool writable;
>         struct at24_data *at24;
>         int err;
> -       unsigned i, num_addresses;
> +       unsigned int i, num_addresses;
>         const struct regmap_config *config;
>         u8 test_byte;
>
> --
> 2.15.1
>

There were no more comments, so patch applied.
