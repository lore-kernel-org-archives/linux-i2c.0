From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 3/4] hwmon/ltc2990: Add platform_data support
Date: Tue, 13 Aug 2019 01:02:37 -0700
Message-ID: <20190813080237.GA29986@roeck-us.net>
References: <20190812235237.21797-1-max@enpas.org>
 <20190812235237.21797-3-max@enpas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190812235237.21797-3-max@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Staudt <max@enpas.org>
Cc: linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 13, 2019 at 01:52:36AM +0200, Max Staudt wrote:
> This allows code using i2c_new_device() to specify a measurement mode.
> 
> Signed-off-by: Max Staudt <max@enpas.org>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/hwmon/ltc2990.c               |  9 +++++++++
>  include/linux/platform_data/ltc2990.h | 11 +++++++++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 include/linux/platform_data/ltc2990.h
> 
> diff --git a/drivers/hwmon/ltc2990.c b/drivers/hwmon/ltc2990.c
> index f9431ad43..f19b9c50c 100644
> --- a/drivers/hwmon/ltc2990.c
> +++ b/drivers/hwmon/ltc2990.c
> @@ -14,6 +14,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/platform_data/ltc2990.h>
>  
>  #define LTC2990_STATUS	0x00
>  #define LTC2990_CONTROL	0x01
> @@ -206,6 +207,7 @@ static int ltc2990_i2c_probe(struct i2c_client *i2c,
>  	int ret;
>  	struct device *hwmon_dev;
>  	struct ltc2990_data *data;
> +	struct ltc2990_platform_data *pdata = dev_get_platdata(&i2c->dev);
>  	struct device_node *of_node = i2c->dev.of_node;
>  
>  	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> @@ -227,6 +229,13 @@ static int ltc2990_i2c_probe(struct i2c_client *i2c,
>  		if (data->mode[0] & ~LTC2990_MODE0_MASK ||
>  		    data->mode[1] & ~LTC2990_MODE1_MASK)
>  			return -EINVAL;
> +	} else if (pdata) {
> +		data->mode[0] = pdata->meas_mode[0];
> +		data->mode[1] = pdata->meas_mode[1];
> +
> +		if (data->mode[0] & ~LTC2990_MODE0_MASK ||
> +		    data->mode[1] & ~LTC2990_MODE1_MASK)
> +			return -EINVAL;

I would prefer if the driver was modified to accept device
properties, and if those were set using the appropriate
fwnode function. Any reason for not doing that ?

Thanks,
Guenter
