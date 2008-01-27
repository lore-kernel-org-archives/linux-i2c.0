From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH 3/8] Philips PCA9536 4 bit I2C GPIO extender
 driver
Date: Sun, 27 Jan 2008 22:45:59 +0100
Message-ID: <20080127224559.4eed7cea@hyperion.delvare>
References: <Pine.LNX.4.64.0801231646090.4932@axis700.grange>
	<Pine.LNX.4.64.0801231820060.4932@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0801231820060.4932-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Guennadi,

On Wed, 23 Jan 2008 18:41:39 +0100 (CET), Guennadi Liakhovetski wrote:
> This driver will be used by the mt9m001 and the mt9v022 camera drivers,
> that can use a pca9536 to switch between 8 and 10 bit modes.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/i2c/chips/Kconfig   |   10 +++
>  drivers/i2c/chips/Makefile  |    1 +
>  drivers/i2c/chips/pca9536.c |  153 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 164 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/chips/pca9536.c

There is a new GPIO subsystem (under driver/gpio), that's where you
should add this driver.

> 
> diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
> index 2e1c24f..6f492f1 100644
> --- a/drivers/i2c/chips/Kconfig
> +++ b/drivers/i2c/chips/Kconfig
> @@ -65,6 +65,16 @@ config SENSORS_PCF8574
>  	  These devices are hard to detect and rarely found on mainstream
>  	  hardware.  If unsure, say N.
>  
> +config SENSORS_PCA9536
> +	tristate "Philips PCA9536 4-bit I/O port"
> +	depends on EXPERIMENTAL
> +	help
> +	  If you say yes here you get support for the Philips PCA9539
> +	  4-bit I/O port.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called pca9536.
> +
>  config SENSORS_PCA9539
>  	tristate "Philips PCA9539 16-bit I/O port"
>  	depends on EXPERIMENTAL
> diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
> index ca924e1..e24c582 100644
> --- a/drivers/i2c/chips/Makefile
> +++ b/drivers/i2c/chips/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_DS1682)		+= ds1682.o
>  obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
>  obj-$(CONFIG_SENSORS_MAX6875)	+= max6875.o
>  obj-$(CONFIG_SENSORS_M41T00)	+= m41t00.o
> +obj-$(CONFIG_SENSORS_PCA9536)	+= pca9536.o
>  obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
>  obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
>  obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
> diff --git a/drivers/i2c/chips/pca9536.c b/drivers/i2c/chips/pca9536.c
> new file mode 100644
> index 0000000..08e5d8b
> --- /dev/null
> +++ b/drivers/i2c/chips/pca9536.c
> @@ -0,0 +1,152 @@
> +/*
> + * Driver for PCA9536 I/O Expander
> + *
> + * Copyright (C) 2008, Guennadi Liakhovetski <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/videodev.h>
> +#include <linux/slab.h>

I don't think you need slab.h.

> +#include <linux/i2c.h>
> +#include <linux/hwmon-sysfs.h>
> +
> +#include <media/v4l2-common.h>
> +#include <media/v4l2-chip-ident.h>

A GPIO driver shouldn't include video-specific header files.

> +
> +#define PCA9536_INPUT 0
> +#define PCA9536_OUTPUT 1
> +#define PCA9536_INVERT 2
> +#define PCA9536_DIRECTION 3
> +
> +/* following are the sysfs callback functions */
> +static ssize_t pca9536_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct sensor_device_attribute *psa = to_sensor_dev_attr(attr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	return sprintf(buf, "%d\n", i2c_smbus_read_byte_data(client,
> +							     psa->index));
> +}
> +
> +static ssize_t pca9536_store(struct device *dev, struct device_attribute *attr,
> +			     const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *psa = to_sensor_dev_attr(attr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	unsigned long val = simple_strtoul(buf, NULL, 0);
> +
> +	if (val > 0xff)
> +		return -EINVAL;
> +
> +	i2c_smbus_write_byte_data(client, psa->index, val);
> +	return count;
> +}
> +
> +int pca9536_set_level(struct i2c_client *client, u8 pin, u8 level)
> +{
> +	s32 data;
> +
> +	if (pin > 3)
> +		return -EINVAL;
> +
> +	/* Switch to output */
> +	data = i2c_smbus_read_byte_data(client, PCA9536_DIRECTION);
> +	if (data < 0)
> +		return data;
> +	data = i2c_smbus_write_byte_data(client, PCA9536_DIRECTION,
> +					 data & ~(1 << pin));
> +	if (data < 0)
> +		return data;
> +
> +	/* Set level */
> +	data = i2c_smbus_read_byte_data(client, PCA9536_OUTPUT);
> +	if (data < 0)
> +		return data;
> +	if (level)
> +		data |= (1 << pin);
> +	else
> +		data &= ~(1 << pin);
> +	data = i2c_smbus_write_byte_data(client, PCA9536_OUTPUT, data);
> +
> +	return data;
> +}
> +EXPORT_SYMBOL(pca9536_set_level);
> +
> +/* Define the device attributes */
> +
> +#define PCA9536_ENTRY_RO(name, reg) \
> +	static SENSOR_DEVICE_ATTR(name, S_IRUGO, pca9536_show, NULL, reg)
> +
> +#define PCA9536_ENTRY_RW(name, reg) \
> +	static SENSOR_DEVICE_ATTR(name, S_IRUGO | S_IWUSR, pca9536_show, \
> +				  pca9536_store, reg)
> +
> +PCA9536_ENTRY_RO(input, PCA9536_INPUT);
> +PCA9536_ENTRY_RW(output, PCA9536_OUTPUT);
> +PCA9536_ENTRY_RW(invert, PCA9536_INVERT);
> +PCA9536_ENTRY_RW(direction, PCA9536_DIRECTION);
> +
> +static struct attribute *pca9536_attributes[] = {
> +	&sensor_dev_attr_input.dev_attr.attr,
> +	&sensor_dev_attr_output.dev_attr.attr,
> +	&sensor_dev_attr_invert.dev_attr.attr,
> +	&sensor_dev_attr_direction.dev_attr.attr,
> +	NULL
> +};
> +
> +static struct attribute_group pca9536_defattr_group = {
> +	.attrs = pca9536_attributes,
> +};

I'm not sure what this sysfs interface is good for given the use case
of this driver. It might even be dangerous to have, users may damage
their hardware?

> +
> +static int pca9536_probe(struct i2c_client *client)
> +{
> +	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> +		pr_debug("%s: I2C-Adapter doesn't support I2C_FUNC_SMBUS_BYTE\n", __FUNCTION__);

Please use dev_dbg().

> +		return -EIO;
> +	}
> +
> +	if (client->dev.platform_data)
> +		/* This chip is going to be used from the kernel */
> +		*(struct i2c_client **)client->dev.platform_data = client;

This doesn't make any sense to me - what are you doing?

> +
> +	/* Register sysfs hooks */
> +	return sysfs_create_group(&client->dev.kobj,
> +				  &pca9536_defattr_group);
> +}
> +
> +static int pca9536_remove(struct i2c_client *client)
> +{
> +	sysfs_remove_group(&client->dev.kobj, &pca9536_defattr_group);
> +	return 0;
> +}
> +
> +static struct i2c_driver pca9536_i2c_driver = {
> +	.driver = {
> +		.name = "pca9536",
> +	},
> +	.probe		= pca9536_probe,
> +	.remove		= pca9536_remove,
> +};
> +
> +static int __init pca9536_mod_init(void)
> +{
> +	return i2c_add_driver(&pca9536_i2c_driver);
> +}
> +
> +static void __exit pca9536_mod_exit(void)
> +{
> +	i2c_del_driver(&pca9536_i2c_driver);
> +}
> +
> +module_init(pca9536_mod_init);
> +module_exit(pca9536_mod_exit);
> +
> +MODULE_DESCRIPTION("PCA9536 driver");
> +MODULE_AUTHOR("Guennadi Liakhovetski <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
> +MODULE_LICENSE("GPL");


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
