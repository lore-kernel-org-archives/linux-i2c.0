From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/1] power supply: add driver for TI BQ20Z75 gas gauge
 IC
Date: Tue, 31 Aug 2010 10:24:21 +0200
Message-ID: <20100831102421.17e73b5d@hyperion.delvare>
References: <1282949443-8052-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1282949443-8052-1-git-send-email-rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Rhyland,

On Fri, 27 Aug 2010 15:50:43 -0700, rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org wrote:
> From: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> this driver depends on I2C and uses SMBUS for communication with the =
host.

Quick review (I am not familiar with the power supply API):

> Signed-off-by: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/power/Kconfig   |    7 +
>  drivers/power/Makefile  |    1 +
>  drivers/power/bq20z75.c |  403 +++++++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 411 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/power/bq20z75.c
>=20
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 8e9ba17..c72e628 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -142,4 +142,11 @@ config CHARGER_PCF50633
>  	help
>  	 Say Y to include support for NXP PCF50633 Main Battery Charger.
> =20
> +config BQ20Z75_GASGAUGE

=46ollowing the naming used for other options in this menu, this would =
be
BATTERY_BQ20Z75.

> +        tristate "TI BQ20Z75 GAS GAUGE"

Not all capitals, please.

> +        depends on I2C
> +        help
> +         Say Y to include support for TI BQ20Z75 SBS-compliant
> +         gas gauge and protection IC.
> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index 0005080..98abc31 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -34,3 +34,4 @@ obj-$(CONFIG_BATTERY_DA9030)	+=3D da9030_battery.o
>  obj-$(CONFIG_BATTERY_MAX17040)	+=3D max17040_battery.o
>  obj-$(CONFIG_BATTERY_Z2)	+=3D z2_battery.o
>  obj-$(CONFIG_CHARGER_PCF50633)	+=3D pcf50633-charger.o
> +obj-$(CONFIG_BQ20Z75_GASGAUGE)  +=3D bq20z75.o
> diff --git a/drivers/power/bq20z75.c b/drivers/power/bq20z75.c
> new file mode 100644
> index 0000000..4eb6638
> --- /dev/null
> +++ b/drivers/power/bq20z75.c
> @@ -0,0 +1,403 @@
> +/*
> + * drivers/power/bq20z75.c

Please remove, this doesn't add much value and is likely to get
outdated at some point.

> + *
> + * Gas Gauge driver for TI's BQ20Z75
> + *
> + * Copyright (c) 2010, NVIDIA Corporation.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Lic=
ense for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License=
 along
> + * with this program; if not, write to the Free Software Foundation,=
 Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/debugfs.h>

I don't think you need this one?

> +#include <linux/power_supply.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +
> +enum {
> +	REG_MANUFACTURER_DATA,
> +	REG_TEMPERATURE,
> +	REG_VOLTAGE,
> +	REG_CURRENT,
> +	REG_CAPACITY,
> +	REG_TIME_TO_EMPTY,
> +	REG_TIME_TO_FULL,
> +	REG_STATUS,
> +	REG_CYCLE_COUNT,
> +	REG_SERIAL_NUMBER,
> +	REG_MAX
> +};
> +
> +#define BATTERY_MANUFACTURER_SIZE	12
> +#define BATTERY_NAME_SIZE		8

You don't use these anywhere?

> +
> +/* manufacturer access defines */
> +#define MANUFACTURER_ACCESS_STATUS	0x0006
> +#define MANUFACTURER_ACCESS_SLEEP	0x0011
> +
> +/* battery status value bits */
> +#define BATTERY_CHARGING		0x40
> +#define BATTERY_FULL_CHARGED		0x20
> +#define BATTERY_FULL_DISCHARGED		0x10
> +
> +#define BQ20Z75_DATA(_psp, _addr, _min_value, _max_value) { \
> +	.psp =3D _psp, \
> +	.addr =3D _addr, \
> +	.min_value =3D _min_value, \
> +	.max_value =3D _max_value, \
> +}
> +
> +static struct bq20z75_device_data {

This could be const.

> +	enum power_supply_property psp;
> +	u8 addr;
> +	int min_value;
> +	int max_value;
> +} bq20z75_data[] =3D {
> +	[REG_MANUFACTURER_DATA] =3D
> +		BQ20Z75_DATA(POWER_SUPPLY_PROP_PRESENT, 0x00, 0, 65535),
> +	[REG_TEMPERATURE] =3D
> +		BQ20Z75_DATA(POWER_SUPPLY_PROP_TEMP, 0x08, 0, 65535),
> +	[REG_VOLTAGE] =3D
> +		BQ20Z75_DATA(POWER_SUPPLY_PROP_VOLTAGE_NOW, 0x09, 0, 20000),
> +	[REG_CURRENT] =3D
> +		BQ20Z75_DATA(POWER_SUPPLY_PROP_CURRENT_NOW, 0x0A, -32768, \
> +			32767),

You don't need the backslash at the end of the line.

> +	[REG_CAPACITY] =3D
> +		BQ20Z75_DATA(POWER_SUPPLY_PROP_CAPACITY, 0x0e, 0, 100),

Please be consistent with case in hexadecimal numbers.

> +	[REG_TIME_TO_EMPTY] =3D
> +		BQ20Z75_DATA(POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG, 0x12, 0, \
> +			65535),
> +	[REG_TIME_TO_FULL] =3D
> +		BQ20Z75_DATA(POWER_SUPPLY_PROP_TIME_TO_FULL_AVG, 0x13, 0, \
> +			65535),
> +	[REG_STATUS] =3D
> +		BQ20Z75_DATA(POWER_SUPPLY_PROP_STATUS, 0x16, 0, 65535),
> +	[REG_CYCLE_COUNT] =3D
> +		BQ20Z75_DATA(POWER_SUPPLY_PROP_CYCLE_COUNT, 0x17, 0, 65535),
> +	[REG_SERIAL_NUMBER] =3D
> +		BQ20Z75_DATA(POWER_SUPPLY_PROP_SERIAL_NUMBER, 0x1C, 0, 65535),
> +};
> +
> +static enum power_supply_property bq20z75_properties[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_CYCLE_COUNT,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
> +	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
> +	POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +};
> +
> +static int bq20z75_get_property(struct power_supply *psy,
> +	enum power_supply_property psp, union power_supply_propval *val);
> +
> +static struct power_supply bq20z75_supply =3D {
> +	.name =3D "battery",
> +	.type =3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties =3D bq20z75_properties,
> +	.num_properties =3D ARRAY_SIZE(bq20z75_properties),
> +	.get_property =3D bq20z75_get_property,
> +};
> +
> +struct bq20z75_device_info {
> +	struct i2c_client	*client;
> +} *bq20z75_device;

This structure doesn't seem terribly useful. You typically need the
client to get to this information... And storing the device pointer as
a global is evil anyway, please don't do that.

> +
> +static int bq20z75_get_battery_presence_and_health(
> +	enum power_supply_property psp,	union power_supply_propval *val)
> +{
> +	s32 ret;
> +
> +	/* Write to ManufacturerAccess with
> +	 * ManufacturerAccess command and then
> +	 * read the status */
> +	ret =3D i2c_smbus_write_word_data(bq20z75_device->client,
> +		bq20z75_data[REG_MANUFACTURER_DATA].addr,
> +		MANUFACTURER_ACCESS_STATUS);
> +	if (ret < 0) {
> +		dev_err(&bq20z75_device->client->dev,
> +			"%s: i2c write for battery presence failed\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	ret =3D i2c_smbus_read_word_data(bq20z75_device->client,
> +		bq20z75_data[REG_MANUFACTURER_DATA].addr);
> +	if (ret < 0) {
> +		dev_err(&bq20z75_device->client->dev,
> +			"%s: i2c read for battery presence failed\n",
> +			__func__);
> +		return -EINVAL;
> +	}

-EINVAL doesn't look like the right error code. -ENODEV or -EIO would
seem more appropriate. Same issue several times, please address them
all.

> +
> +	if (ret < bq20z75_data[REG_MANUFACTURER_DATA].min_value ||
> +	    ret > bq20z75_data[REG_MANUFACTURER_DATA].max_value) {
> +		val->intval =3D 0;
> +		return 0;
> +	}
> +
> +	/* Mask the upper nibble of 2nd byte and
> +	 * lower byte of response then
> +	 * shift the result by 8 to get status*/
> +	ret &=3D 0x0F00;
> +	ret >>=3D 8;
> +	if (psp =3D=3D POWER_SUPPLY_PROP_PRESENT) {
> +		if (ret =3D=3D 0x0F)
> +			/* battery removed */
> +			val->intval =3D 0;
> +		else
> +			val->intval =3D 1;
> +	} else if (psp =3D=3D POWER_SUPPLY_PROP_HEALTH) {
> +		if (ret =3D=3D 0x09)
> +			val->intval =3D POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
> +		else if (ret =3D=3D 0x0B)
> +			val->intval =3D POWER_SUPPLY_HEALTH_OVERHEAT;
> +		else if (ret =3D=3D 0x0C)
> +			val->intval =3D POWER_SUPPLY_HEALTH_DEAD;
> +		else
> +			val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bq20z75_get_battery_property(int reg_offset,
> +	enum power_supply_property psp,
> +	union power_supply_propval *val)
> +{
> +	s32 ret;
> +
> +	ret =3D i2c_smbus_read_word_data(bq20z75_device->client,
> +		bq20z75_data[reg_offset].addr);
> +	if (ret < 0) {
> +		dev_err(&bq20z75_device->client->dev,
> +			"%s: i2c read for %d failed\n", __func__, reg_offset);
> +		return -EINVAL;
> +	}
> +
> +	if (ret >=3D bq20z75_data[reg_offset].min_value &&
> +	    ret <=3D bq20z75_data[reg_offset].max_value) {
> +		val->intval =3D ret;
> +		if (psp =3D=3D POWER_SUPPLY_PROP_STATUS) {
> +			/* mask the upper byte and then find the
> +			 * actual status */
> +			ret &=3D 0x00FF;

As far as I can see, this masking is a no-op.

> +			if (ret & BATTERY_CHARGING)
> +				val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +			else if (ret & BATTERY_FULL_CHARGED)
> +				val->intval =3D POWER_SUPPLY_STATUS_FULL;
> +			else if (ret & BATTERY_FULL_DISCHARGED)
> +				val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +			else
> +				val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		}
> +		/* bq20z75 provides battery tempreture in 0.1=C3=82=C2=B0K
> +		 * so convert it to =C3=82=C2=B0C */
> +		else if (psp =3D=3D POWER_SUPPLY_PROP_TEMP)
> +			val->intval =3D ret - 2731;
> +	} else {
> +		val->intval =3D 0;

This should be moved...

> +		if (psp =3D=3D POWER_SUPPLY_PROP_STATUS)
> +			val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;

=2E.. here, with a else.

> +	}
> +
> +	return 0;
> +}
> +
> +static int bq20z75_get_battery_capacity(union power_supply_propval *=
val)
> +{
> +	s32 ret;
> +
> +	ret =3D i2c_smbus_read_byte_data(bq20z75_device->client,
> +		bq20z75_data[REG_CAPACITY].addr);
> +	if (ret < 0) {
> +		dev_err(&bq20z75_device->client->dev,
> +			"%s: i2c read for %d failed\n", __func__, REG_CAPACITY);
> +		return -EINVAL;
> +	}
> +
> +	/* bq20z75 spec says that this can be >100 %
> +	 * even if max value is 100 % */
> +	val->intval =3D ((ret >=3D 100) ? 100 : ret);

Can also be written min(ret, 100).

> +
> +	return 0;
> +}
> +
> +static int bq20z75_get_property(struct power_supply *psy,
> +	enum power_supply_property psp,
> +	union power_supply_propval *val)
> +{
> +	u8 count;

=46or loops like int better.

> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_PRESENT:
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		if (bq20z75_get_battery_presence_and_health(psp, val))
> +			return -EINVAL;

You should pass down the exact error value returned by the function,
instead of hardcoding it. Same below.

> +		break;
> +
> +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> +		val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		if (bq20z75_get_battery_capacity(val))
> +			return -EINVAL;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_STATUS:
> +	case POWER_SUPPLY_PROP_CYCLE_COUNT:
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +	case POWER_SUPPLY_PROP_TEMP:
> +	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
> +	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
> +	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
> +		for (count =3D 0; count < REG_MAX; count++) {
> +			if (psp =3D=3D bq20z75_data[count].psp)
> +				break;
> +		}
> +
> +		if (bq20z75_get_battery_property(count, psp, val))
> +			return -EINVAL;
> +			break;

Wrong indentation.

> +
> +	default:
> +		dev_err(&bq20z75_device->client->dev,
> +			"%s: INVALID property\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	printk(KERN_INFO "%s: property =3D %d, value =3D %d\n", __func__,
> +		psp, val->intval);

Should be turned into dev_dbg().

> +
> +	return 0;
> +}
> +
> +static int bq20z75_probe(struct i2c_client *client,
> +	const struct i2c_device_id *id)
> +{
> +	int rc;
> +
> +	bq20z75_device =3D kzalloc(sizeof(*bq20z75_device), GFP_KERNEL);
> +	if (!bq20z75_device)
> +		return -ENOMEM;
> +
> +memset(bq20z75_device, 0, sizeof(*bq20z75_device));

Wrong indentation, and useless code, as kzalloc did it for you already.

> +
> +	bq20z75_device->client =3D client;
> +	i2c_set_clientdata(client, bq20z75_device);
> +
> +	rc =3D power_supply_register(&client->dev, &bq20z75_supply);
> +	if (rc) {
> +		dev_err(&bq20z75_device->client->dev,
> +			"%s: Failed to register power supply\n", __func__);
> +		kfree(bq20z75_device);
> +		return rc;
> +	}
> +
> +	dev_info(&bq20z75_device->client->dev,
> +		"%s: battery driver registered\n", client->name);

What you did here is register a device, not a driver.

> +
> +	return 0;
> +}
> +
> +static int bq20z75_remove(struct i2c_client *client)
> +{
> +	struct bq20z75_device_info *bq20z75_device =3D i2c_get_clientdata(c=
lient);
> +
> +	power_supply_unregister(&bq20z75_supply);
> +	kfree(bq20z75_device);
> +	bq20z75_device =3D NULL;
> +
> +	return 0;
> +}
> +
> +#if defined CONFIG_PM
> +static int bq20z75_suspend(struct i2c_client *client,
> +	pm_message_t state)
> +{
> +	s32 ret;
> +	struct bq20z75_device_info *bq20z75_device =3D i2c_get_clientdata(c=
lient);

You get the data from the client...

> +
> +	/* write to manufacture access with sleep command */

(typo: manufacturer)

> +	ret =3D i2c_smbus_write_word_data(bq20z75_device->client,

=2E.. just to get the client from the data. Terribly efficient ;)

> +		bq20z75_data[REG_MANUFACTURER_DATA].addr,
> +		MANUFACTURER_ACCESS_SLEEP);
> +	if (ret < 0) {
> +		dev_err(&bq20z75_device->client->dev,
> +			"%s: i2c write for %d failed\n",
> +			__func__, MANUFACTURER_ACCESS_SLEEP);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/* any smbus transaction will wake up bq20z75 */
> +static int bq20z75_resume(struct i2c_client *client)
> +{
> +	return 0;
> +}
> +#endif
> +
> +static const struct i2c_device_id bq20z75_id[] =3D {
> +	{ "bq20z75-battery", 0 },

"-battery" is redundant, just use "bq20z75".

> +	{},

Needless comma.

> +};
> +
> +static struct i2c_driver bq20z75_battery_driver =3D {
> +	.probe		=3D bq20z75_probe,
> +	.remove		=3D bq20z75_remove,
> +#if defined CONFIG_PM
> +	.suspend	=3D bq20z75_suspend,
> +	.resume		=3D bq20z75_resume,
> +#endif
> +	.id_table	=3D bq20z75_id,
> +	.driver =3D {
> +		.name	=3D "bq20z75-battery",
> +	},
> +};
> +
> +static int __init bq20z75_battery_init(void)
> +{
> +	int ret;
> +
> +	ret =3D i2c_add_driver(&bq20z75_battery_driver);
> +	if (ret)
> +		dev_err(&bq20z75_device->client->dev,
> +			"%s: i2c_add_driver failed\n", __func__);

This is essentially needless. The kernel will log the failure already.

> +
> +	return ret;
> +}
> +module_init(bq20z75_battery_init);
> +
> +static void __exit bq20z75_battery_exit(void)
> +{
> +	i2c_del_driver(&bq20z75_battery_driver);
> +}
> +module_exit(bq20z75_battery_exit);
> +
> +MODULE_AUTHOR("NVIDIA Graphics Pvt Ltd");
> +MODULE_DESCRIPTION("BQ20z75 battery monitor driver");
> +MODULE_LICENSE("GPL");


--=20
Jean Delvare
