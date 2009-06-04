From: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] add MAX17040 Fuel Gauge driver
Date: Thu, 4 Jun 2009 14:46:45 +0530
Message-ID: <5d5443650906040216h2314b7bbt1ae2e89c709b566e@mail.gmail.com>
References: <4A278C08.5000206@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A278C08.5000206-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Minkyu Kang,

Adding linux-i2c mailing list, so not deleting any code.

On Thu, Jun 4, 2009 at 2:25 PM, Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrot=
e:
> The MAX17040 is a I2C interfaced Fuel Gauge systems for lithium-ion b=
atteries
> This patch adds support the MAX17040 Fuel Gauge
>
> Cc: Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>
> Signed-off-by: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
> =A0drivers/power/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A08 +
> =A0drivers/power/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +-
> =A0drivers/power/max17040_battery.c | =A0306 ++++++++++++++++++++++++=
++++++++++++++
> =A0include/linux/max17040_battery.h | =A0 19 +++
> =A04 files changed, 335 insertions(+), 1 deletions(-)
> =A0create mode 100644 drivers/power/max17040_battery.c
> =A0create mode 100644 include/linux/max17040_battery.h
>
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 33da112..6af5798 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -88,4 +88,12 @@ config CHARGER_PCF50633
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 Say Y to include support for NXP PCF50633 Main Batter=
y Charger.
>
> +config BATTERY_MAX17040
> + =A0 =A0 =A0 tristate "Maxim MAX17040 Fuel Gauge"
> + =A0 =A0 =A0 depends on I2C
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 MAX17040 is fuel-gauge systems for lithium-ion (Li+=
) batteries
> + =A0 =A0 =A0 =A0 in handheld and portable equipment. The MAX17040 is=
 configured
> + =A0 =A0 =A0 =A0 to operate with a single lithium cell
> +
> =A0endif # POWER_SUPPLY
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index 2fcf41d..9c48995 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -25,4 +25,5 @@ obj-$(CONFIG_BATTERY_TOSA) =A0 =A0+=3D tosa_battery=
=2Eo
> =A0obj-$(CONFIG_BATTERY_WM97XX) =A0 +=3D wm97xx_battery.o
> =A0obj-$(CONFIG_BATTERY_BQ27x00) =A0+=3D bq27x00_battery.o
> =A0obj-$(CONFIG_BATTERY_DA9030) =A0 +=3D da9030_battery.o
> -obj-$(CONFIG_CHARGER_PCF50633) +=3D pcf50633-charger.o
> \ No newline at end of file
> +obj-$(CONFIG_BATTERY_MAX17040)) =A0 =A0 =A0 =A0+=3D max17040_battery=
=2Eo
> +obj-$(CONFIG_CHARGER_PCF50633) +=3D pcf50633-charger.o
> diff --git a/drivers/power/max17040_battery.c b/drivers/power/max1704=
0_battery.c
> new file mode 100644
> index 0000000..25303ba
> --- /dev/null
> +++ b/drivers/power/max17040_battery.c
> @@ -0,0 +1,306 @@
> +/*
> + * =A0max17040_battery.c
> + * =A0fuel-gauge systems for lithium-ion (Li+) batteries
> + *
> + * =A0Copyright (C) 2009 Samsung Electronics
> + * =A0Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/mutex.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/power_supply.h>
> +#include <linux/max17040_battery.h>
> +
> +#define MAX17040_VCELL_MSB =A0 =A0 0x02
> +#define MAX17040_VCELL_LSB =A0 =A0 0x03
> +#define MAX17040_SOC_MSB =A0 =A0 =A0 0x04
> +#define MAX17040_SOC_LSB =A0 =A0 =A0 0x05
> +#define MAX17040_MODE_MSB =A0 =A0 =A00x06
> +#define MAX17040_MODE_LSB =A0 =A0 =A00x07
> +#define MAX17040_VER_MSB =A0 =A0 =A0 0x08
> +#define MAX17040_VER_LSB =A0 =A0 =A0 0x09
> +#define MAX17040_RCOMP_MSB =A0 =A0 0x0C
> +#define MAX17040_RCOMP_LSB =A0 =A0 0x0D
> +#define MAX17040_CMD_MSB =A0 =A0 =A0 0xFE
> +#define MAX17040_CMD_LSB =A0 =A0 =A0 0xFF
> +
> +#define MAX17040_DELAY =A0 =A0 =A0 =A0 1000
> +#define MAX17040_BATTERY_FULL =A095
> +
> +struct max17040_chip {
> + =A0 =A0 =A0 struct i2c_client =A0 =A0 =A0 *client;
> + =A0 =A0 =A0 struct delayed_work =A0 =A0 work;
> +
> + =A0 =A0 =A0 /* State Of Connect */
> + =A0 =A0 =A0 int online;
> + =A0 =A0 =A0 /* battery voltage */
> + =A0 =A0 =A0 int vcell;
> + =A0 =A0 =A0 /* battery capacity */
> + =A0 =A0 =A0 int soc;
> + =A0 =A0 =A0 /* State Of Charge */
> + =A0 =A0 =A0 int status;
> +};
> +
> +static struct max17040_chip *max17040;
> +static struct max17040_platform_data *pdata;

May be you want to move this pdata under chip structure.

> +
> +static int max17040_get_property(struct power_supply *bat_ps,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum power_supp=
ly_property psp,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 union power_sup=
ply_propval *val)
> +{
> + =A0 =A0 =A0 switch (psp) {
> + =A0 =A0 =A0 case POWER_SUPPLY_PROP_STATUS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val->intval =3D max17040->status;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case POWER_SUPPLY_PROP_ONLINE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val->intval =3D max17040->online;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val->intval =3D max17040->vcell;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case POWER_SUPPLY_PROP_CAPACITY:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val->intval =3D max17040->soc;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct power_supply bat_ps =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "battery",
> + =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D POWER_SUPPLY_TYPE_BATTERY=
,
> + =A0 =A0 =A0 .get_property =A0 =3D max17040_get_property,
> +};
> +
> +static int max17040_write_reg(int reg, u8 value)
> +{
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ret =3D i2c_smbus_write_byte_data(max17040->client, reg=
, value);
> +
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&max17040->client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s: re=
g 0x%x, val 0x%x, err %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func_=
_, reg, value, ret);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static u8 max17040_read_reg(int reg)
> +{
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ret =3D i2c_smbus_read_byte_data(max17040->client, reg)=
;
> +
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&max17040->client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s: re=
g 0x%x, err %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func_=
_, reg, ret);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static void max17040_reset(void)
> +{
> + =A0 =A0 =A0 max17040_write_reg(MAX17040_CMD_MSB, 0x54);
> + =A0 =A0 =A0 max17040_write_reg(MAX17040_CMD_LSB, 0x00);
> +}
> +
> +static void max17040_set_rcomp(u16 val)
> +{
> + =A0 =A0 =A0 max17040_write_reg(MAX17040_RCOMP_MSB, val >> 8);
> + =A0 =A0 =A0 max17040_write_reg(MAX17040_RCOMP_LSB, (val << 8) >> 8)=
;
> +}
> +
> +static void max17040_get_vcell(void)
> +{
> + =A0 =A0 =A0 u8 msb;
> + =A0 =A0 =A0 u8 lsb;
> +
> + =A0 =A0 =A0 msb =3D max17040_read_reg(MAX17040_VCELL_MSB);
> + =A0 =A0 =A0 lsb =3D max17040_read_reg(MAX17040_VCELL_LSB);
> +
> + =A0 =A0 =A0 max17040->vcell =3D (msb << 4) + (lsb >> 4);
> +}
> +
> +static void max17040_get_soc(void)
> +{
> + =A0 =A0 =A0 u8 msb;
> + =A0 =A0 =A0 u8 lsb;
> +
> + =A0 =A0 =A0 msb =3D max17040_read_reg(MAX17040_SOC_MSB);
> + =A0 =A0 =A0 lsb =3D max17040_read_reg(MAX17040_SOC_LSB);
> +
> + =A0 =A0 =A0 max17040->soc =3D msb;
> +}
> +
> +static void max17040_get_version(void)
> +{
> + =A0 =A0 =A0 u8 msb;
> + =A0 =A0 =A0 u8 lsb;
> +
> + =A0 =A0 =A0 msb =3D max17040_read_reg(MAX17040_VER_MSB);
> + =A0 =A0 =A0 lsb =3D max17040_read_reg(MAX17040_VER_LSB);
> +
> + =A0 =A0 =A0 dev_info(&max17040->client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "MAX17040 Fuel-Gauge Ve=
r %d%d\n", msb, lsb);
> +}
> +
> +static void max17040_get_online(void)
> +{
> + =A0 =A0 =A0 if (pdata->battery_online)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max17040->online =3D pdata->battery_onl=
ine();
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max17040->online =3D 1;
> +}
> +
> +static void max17040_get_status(void)
> +{
> + =A0 =A0 =A0 if (!pdata->charger_online || !pdata->charger_enable) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max17040->status =3D POWER_SUPPLY_STATU=
S_UNKNOWN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (pdata->charger_online()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->charger_enable())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max17040->status =3D PO=
WER_SUPPLY_STATUS_CHARGING;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max17040->status =3D PO=
WER_SUPPLY_STATUS_NOT_CHARGING;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max17040->status =3D POWER_SUPPLY_STATU=
S_DISCHARGING;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (max17040->soc > MAX17040_BATTERY_FULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max17040->status =3D POWER_SUPPLY_STATU=
S_FULL;
> +}
> +
> +static void max17040_work(struct work_struct *work)
> +{
> + =A0 =A0 =A0 max17040_get_vcell();
> + =A0 =A0 =A0 max17040_get_soc();
> + =A0 =A0 =A0 max17040_get_online();
> + =A0 =A0 =A0 max17040_get_status();
> +
> + =A0 =A0 =A0 schedule_delayed_work(&max17040->work, MAX17040_DELAY);
> +}
> +
> +static enum power_supply_property max17040_battery_props[] =3D {
> + =A0 =A0 =A0 POWER_SUPPLY_PROP_STATUS,
> + =A0 =A0 =A0 POWER_SUPPLY_PROP_ONLINE,
> + =A0 =A0 =A0 POWER_SUPPLY_PROP_VOLTAGE_NOW,
> + =A0 =A0 =A0 POWER_SUPPLY_PROP_CAPACITY,
> +};
> +
> +static int __devinit max17040_probe(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct i2c_device=
_id *id)
> +{
> + =A0 =A0 =A0 struct max17040_chip *chip;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 chip =3D kzalloc(sizeof(struct max17040_chip), GFP_KERN=
EL);
> + =A0 =A0 =A0 if (!chip)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 chip->client =3D client;
> + =A0 =A0 =A0 pdata =3D client->dev.platform_data;
> +
> + =A0 =A0 =A0 i2c_set_clientdata(client, chip);

Please add i2c_check_functionality check before doing any smbus
read/write operations.

> + =A0 =A0 =A0 max17040 =3D chip;

This means that we support only one instance of this chip, right?

> +
> + =A0 =A0 =A0 max17040_reset();
> +
> + =A0 =A0 =A0 max17040_get_version();
> +
> + =A0 =A0 =A0 INIT_DELAYED_WORK_DEFERRABLE(&chip->work, max17040_work=
);
> + =A0 =A0 =A0 schedule_delayed_work(&chip->work, MAX17040_DELAY);
> +
> + =A0 =A0 =A0 bat_ps.properties =3D max17040_battery_props;
> + =A0 =A0 =A0 bat_ps.num_properties =3D ARRAY_SIZE(max17040_battery_p=
rops);
> +
> + =A0 =A0 =A0 ret =3D power_supply_register(&client->dev, &bat_ps);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&max17040->client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed=
: power supply register\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work(&chip->work);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_set_clientdata(client, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(chip);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max17040 =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int __devexit max17040_remove(struct i2c_client *client)
> +{
> + =A0 =A0 =A0 struct max17040_chip *chip =3D i2c_get_clientdata(clien=
t);
> +
> + =A0 =A0 =A0 power_supply_unregister(&bat_ps);
> + =A0 =A0 =A0 cancel_delayed_work(&chip->work);
> + =A0 =A0 =A0 i2c_set_clientdata(client, NULL);
> + =A0 =A0 =A0 kfree(chip);
> + =A0 =A0 =A0 max17040 =3D NULL;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int max17040_suspend(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_message_t state)
> +{
> + =A0 =A0 =A0 struct max17040_chip *chip =3D i2c_get_clientdata(clien=
t);
> +
> + =A0 =A0 =A0 cancel_delayed_work(&chip->work);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int max17040_resume(struct i2c_client *client)
> +{
> + =A0 =A0 =A0 struct max17040_chip *chip =3D i2c_get_clientdata(clien=
t);
> +
> + =A0 =A0 =A0 schedule_delayed_work(&chip->work, MAX17040_DELAY);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static const struct i2c_device_id max17040_id[] =3D {
> + =A0 =A0 =A0 { "max17040", 0 },
> + =A0 =A0 =A0 { }
> +};
> +MODULE_DEVICE_TABLE(i2c, max17040_id);
> +
> +static struct i2c_driver max17040_i2c_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "max17040",
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D max17040_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(max17040_remove=
),
> + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D max17040_suspend,
> + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D max17040_resume,
> + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D max17040_id,
> +};
> +
> +static int __init max17040_init(void)
> +{
> + =A0 =A0 =A0 return i2c_add_driver(&max17040_i2c_driver);
> +}
> +module_init(max17040_init);
> +
> +static void __exit max17040_exit(void)
> +{
> + =A0 =A0 =A0 i2c_del_driver(&max17040_i2c_driver);
> +}
> +module_exit(max17040_exit);
> +
> +MODULE_AUTHOR("Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>");
> +MODULE_DESCRIPTION("MAX17040 Fuel Gauge");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/max17040_battery.h b/include/linux/max1704=
0_battery.h
> new file mode 100644
> index 0000000..ad97b06
> --- /dev/null
> +++ b/include/linux/max17040_battery.h
> @@ -0,0 +1,19 @@
> +/*
> + * =A0Copyright (C) 2009 Samsung Electronics
> + * =A0Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __MAX17040_BATTERY_H_
> +#define __MAX17040_BATTERY_H_
> +
> +struct max17040_platform_data {
> + =A0 =A0 =A0 int (*battery_online)(void);
> + =A0 =A0 =A0 int (*charger_online)(void);
> + =A0 =A0 =A0 int (*charger_enable)(void);
> +};
> +
> +#endif
> --
> 1.5.4.3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
