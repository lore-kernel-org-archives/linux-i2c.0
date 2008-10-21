From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c driver for Maxim max9485 audio clock
 generator chip
Date: Tue, 21 Oct 2008 10:36:07 +0200
Message-ID: <20081021103607.78ffb4da@hyperion.delvare>
References: <20081021030205.2494.55081.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081021030205.2494.55081.stgit@terra>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jon,

On Mon, 20 Oct 2008 23:02:05 -0400, Jon Smirl wrote:
> Signed-off-by: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/chips/Kconfig   |    9 ++++
>  drivers/i2c/chips/Makefile  |    1 
>  drivers/i2c/chips/max9485.c |  106 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c/max9485.h |   38 +++++++++++++++
>  4 files changed, 154 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/chips/max9485.c
>  create mode 100644 include/linux/i2c/max9485.h

Nack. No new drivers in drivers/i2c/chips please, I'm trying hard to
get rid of this directory. If you can't find a better place
(drivers/clocksource? sound?) please put this new driver under
drivers/misc.

> 
> diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
> index 1735682..bc2a6d3 100644
> --- a/drivers/i2c/chips/Kconfig
> +++ b/drivers/i2c/chips/Kconfig
> @@ -40,6 +40,15 @@ config AT24
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called at24.
>  
> +config MAX9485
> +	tristate "Maxim MAX9485 Programmable Audio Clock Generator"
> +	help
> +	  If you say yes here you get support for Maxim MAX9485 
> +	  Programmable Audio Clock Generator.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called max9485.
> +
>  config SENSORS_EEPROM
>  	tristate "EEPROM reader"
>  	depends on EXPERIMENTAL
> diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
> index ca520fa..1560baf 100644
> --- a/drivers/i2c/chips/Makefile
> +++ b/drivers/i2c/chips/Makefile
> @@ -11,6 +11,7 @@
>  
>  obj-$(CONFIG_DS1682)		+= ds1682.o
>  obj-$(CONFIG_AT24)		+= at24.o
> +obj-$(CONFIG_MAX9485)		+= max9485.o
>  obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
>  obj-$(CONFIG_SENSORS_MAX6875)	+= max6875.o
>  obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
> diff --git a/drivers/i2c/chips/max9485.c b/drivers/i2c/chips/max9485.c
> new file mode 100644
> index 0000000..65058b4
> --- /dev/null
> +++ b/drivers/i2c/chips/max9485.c
> @@ -0,0 +1,106 @@
> +/*
> + * Maxim max9485 Programmable Audio Clock Generator driver
> + *
> + * Written by: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> + *
> + * Copyright (C) Digispeaker.com
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/*
> + * This device is under the control of ALSA and can not be changed from
> + * userspace. The main purpose of this driver is to locate the i2c address
> + * of where the chip is located.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/sysfs.h>
> +#include <linux/i2c/max9485.h>
> +
> +int max9485_set(struct i2c_client *max9485, u8 value)
> +{
> +	int rc;
> +
> +	if (!max9485)
> +		return -ENODEV;
> +
> +	rc = i2c_smbus_write_byte(max9485, value);
> +	if (rc < 0)
> +		return -EIO;

Please return rc instead of hard-cording an error value.

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(max9485_set);

I don't quite get the point of exporting this function. It's hardly any
better than i2c_smbus_write_byte() itself, which is already exported.
In fact I wonder why you wrote this function in the first place.

> +
> +/*
> + * Display the only register
> + */
> +static ssize_t max9485_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int rc;
> +
> +	rc = i2c_smbus_read_byte(client);
> +	if (rc < 0)
> +		return -EIO;

Please return rc instead of hard-cording an error value.

> +
> +	return sprintf(buf, "0x%02X\n", rc);
> +}
> +static DEVICE_ATTR(max9485, S_IRUGO, max9485_show, NULL);

Attributes in sysfs are supposed to be normalized. Returning raw
register values there makes no sense to me. Users can simply use i2cget
for the same result, no need to write a kernel driver.

> +
> +/*
> + * Called when a max9485 device is matched with this driver
> + */
> +static int max9485_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	if (!i2c_check_functionality(client->adapter,
> +				I2C_FUNC_SMBUS_READ_BYTE | I2C_FUNC_SMBUS_WRITE_BYTE)) {

I2C_FUNC_SMBUS_READ_BYTE | I2C_FUNC_SMBUS_WRITE_BYTE is better written
I2C_FUNC_SMBUS_BYTE.

> +		dev_err(&client->dev, "i2c bus does not support the max9485\n");
> +		return -ENODEV;
> +	}
> +	return sysfs_create_file(&client->dev.kobj, &dev_attr_max9485.attr);
> +}
> +
> +static int max9485_remove(struct i2c_client *client)
> +{
> +	sysfs_remove_file(&client->dev.kobj, &dev_attr_max9485.attr);
> +	return 0;
> +}
> +
> +static const struct i2c_device_id max9485_id[] = {
> +	{ "max9485", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max9485_id);
> +
> +static struct i2c_driver max9485_driver = {
> +	.driver = {
> +		.name = "max9485",
> +	},
> +	.probe = max9485_probe,
> +	.remove = max9485_remove,
> +	.id_table = max9485_id,
> +};
> +
> +static int __init max9485_init(void)
> +{
> +	return i2c_add_driver(&max9485_driver);
> +}
> +
> +static void __exit max9485_exit(void)
> +{
> +	i2c_del_driver(&max9485_driver);
> +}
> +
> +MODULE_AUTHOR("Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org");
> +MODULE_DESCRIPTION("Maxim MAX9485 Programmable Audio Clock Generator driver");
> +MODULE_LICENSE("GPL");
> +
> +module_init(max9485_init);
> +module_exit(max9485_exit);
> diff --git a/include/linux/i2c/max9485.h b/include/linux/i2c/max9485.h
> new file mode 100644
> index 0000000..0c97450
> --- /dev/null
> +++ b/include/linux/i2c/max9485.h
> @@ -0,0 +1,38 @@
> +/*
> + * Maxim max9485 Programmable Audio Clock Generator driver
> + *
> + * Written by: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> + *
> + * Copyright (C) Digispeaker.com
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __LINUX_I2C_MAX9485_H
> +#define __LINUX_I2C_MAX9485_H
> +
> +struct i2c_client;
> +
> +/* Defines for Maxim MAX9485 Audio Clock Generator */
> +
> +#define MAX9485_MCLK 0x80
> +#define MAX9485_CLK_OUT_2 0x40
> +#define MAX9485_CLK_OUT_1 0x20
> +#define MAX9485_DOUBLED 0x10
> +#define MAX9485_SCALE_256 0x0
> +#define MAX9485_SCALE_384 0x2
> +#define MAX9485_SCALE_768 0x6
> +#define MAX9485_FREQUENCY_12 0x0
> +#define MAX9485_FREQUENCY_32 0x1
> +#define MAX9485_FREQUENCY_441 0x2
> +#define MAX9485_FREQUENCY_48 0x3

It's rather suspicious that you have use bit 1 for 2 different purposes
while you don't use bit 3. Didn't you shift some values accidentally?

> +
> +/* Combinations that minimize jitter */
> +#define MAX9485_245760 MAX9485_SCALE_256 | MAX9485_FREQUENCY_48 | MAX9485_DOUBLED
> +#define MAX9485_225792 MAX9485_SCALE_256 | MAX9485_FREQUENCY_441 | MAX9485_DOUBLED

Missing parentheses.

> +
> +int max9485_set(struct i2c_client *max9485, u8 value);
> +
> +#endif /*  __LINUX_I2C_MAX9485_H */

Honestly I don't see any value in this driver. There's nothing you can
do with it that you couldn't already do without it.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
