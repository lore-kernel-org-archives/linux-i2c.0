From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH RFC] eeprom: at24: extend driver to plug into the NVMEM
 framework
Date: Sun, 16 Aug 2015 10:28:06 +0200 (CEST)
Message-ID: <2080648987.23864.1439713686409.JavaMail.open-xchange@oxbsltgw04.schlund.de>
References: <1439693649-10809-1-git-send-email-andrew@lunn.ch>
Reply-To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439693649-10809-1-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Andrew,

> Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org> hat am 16. August 2015 um 04:54 geschrieben:
>
>
> Add a read only regmap for accessing the EEPROM, and then use that
> with the NVMEM framework.
>
> Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> ---
> drivers/misc/eeprom/at24.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 65 insertions(+)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 2d3db81be099..0e80c0c09d4e 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -22,6 +22,8 @@
> #include <linux/jiffies.h>
> #include <linux/of.h>
> #include <linux/i2c.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/regmap.h>

shouldn't the dependancies in Kconfig updated (depends on REGMAP) too?

> #include <linux/platform_data/at24.h>
>
> /*
> @@ -69,6 +71,10 @@ struct at24_data {
> unsigned write_max;
> unsigned num_addresses;
>
> + struct regmap_config regmap_config;
> + struct nvmem_config nvmem_config;
> + struct nvmem_device *nvmem;
> +
> /*
> * Some chips tie up multiple I2C addresses; dummy devices reserve
> * them for us, and we'll use them with SMBus calls.
> @@ -471,6 +477,34 @@ static ssize_t at24_macc_write(struct memory_accessor
> *macc, const char *buf,
>
> /*-------------------------------------------------------------------------*/
>
> +/*
> + * Provide a regmap interface, which is registered with the NVMEM
> + * framework
> +*/
> +static int at24_regmap_read(void *context, const void *reg, size_t reg_size,
> + void *val, size_t val_size)
> +{
> + struct at24_data *at24 = context;
> + off_t offset = *(u32 *)reg;
> +
> + return at24_read(at24, val, offset, val_size);
> +}
> +
> +static int at24_regmap_write(void *context, const void *data, size_t count)
> +{
> + struct at24_data *at24 = context;
> +
> + return at24_write(at24, data, 0, count);

Since the patch only provides read only support this function could return 0.

Regards
Stefan
