From: rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Subject: [PATCH v2] power supply: add driver for TI BQ20Z75 gas gauge IC
Date: Thu,  2 Sep 2010 10:29:46 -0700
Message-ID: <1283448586-14613-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46rom: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

this driver depends on I2C and uses SMBUS for communication with the ho=
st.

Addressed comments from reviews by Mark Brown and Jean Delvare.
  * Cleaned up whitespace and alignment issues
  * changed return codes to more appropriate values
  * change Kconfig option name to be consistent with existing devices
  * removed global struct and moved to device specific data
  * changed printk to dev_dbg

Signed-off-by: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/power/Kconfig   |    7 +
 drivers/power/Makefile  |    1 +
 drivers/power/bq20z75.c |  387 +++++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 395 insertions(+), 0 deletions(-)
 create mode 100644 drivers/power/bq20z75.c

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 8e9ba17..53d9cbf 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -142,4 +142,11 @@ config CHARGER_PCF50633
 	help
 	 Say Y to include support for NXP PCF50633 Main Battery Charger.
=20
+config BATTERY_BQ20Z75
+        tristate "TI BQ20z75 gas gauge"
+        depends on I2C
+        help
+         Say Y to include support for TI bq20z75 SBS-compliant
+         gas gauge and protection IC.
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index 0005080..cdc403d 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -34,3 +34,4 @@ obj-$(CONFIG_BATTERY_DA9030)	+=3D da9030_battery.o
 obj-$(CONFIG_BATTERY_MAX17040)	+=3D max17040_battery.o
 obj-$(CONFIG_BATTERY_Z2)	+=3D z2_battery.o
 obj-$(CONFIG_CHARGER_PCF50633)	+=3D pcf50633-charger.o
+obj-$(CONFIG_BATTERY_BQ20Z75)	+=3D bq20z75.o
diff --git a/drivers/power/bq20z75.c b/drivers/power/bq20z75.c
new file mode 100644
index 0000000..a7eeedf
--- /dev/null
+++ b/drivers/power/bq20z75.c
@@ -0,0 +1,387 @@
+/*
+ * Gas Gauge driver for TI's BQ20Z75
+ *
+ * Copyright (c) 2010, NVIDIA Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but=
 WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License a=
long
+ * with this program; if not, write to the Free Software Foundation, I=
nc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/power_supply.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+
+enum {
+	REG_MANUFACTURER_DATA,
+	REG_TEMPERATURE,
+	REG_VOLTAGE,
+	REG_CURRENT,
+	REG_CAPACITY,
+	REG_TIME_TO_EMPTY,
+	REG_TIME_TO_FULL,
+	REG_STATUS,
+	REG_CYCLE_COUNT,
+	REG_SERIAL_NUMBER
+};
+
+/* manufacturer access defines */
+#define MANUFACTURER_ACCESS_STATUS	0x0006
+#define MANUFACTURER_ACCESS_SLEEP	0x0011
+
+/* battery status value bits */
+#define BATTERY_CHARGING		0x40
+#define BATTERY_FULL_CHARGED		0x20
+#define BATTERY_FULL_DISCHARGED		0x10
+
+#define BQ20Z75_DATA(_psp, _addr, _min_value, _max_value) { \
+	.psp =3D _psp, \
+	.addr =3D _addr, \
+	.min_value =3D _min_value, \
+	.max_value =3D _max_value, \
+}
+
+static const struct bq20z75_device_data {
+	enum power_supply_property psp;
+	u8 addr;
+	int min_value;
+	int max_value;
+} bq20z75_data[] =3D {
+	[REG_MANUFACTURER_DATA] =3D
+		BQ20Z75_DATA(POWER_SUPPLY_PROP_PRESENT, 0x00, 0, 65535),
+	[REG_TEMPERATURE] =3D
+		BQ20Z75_DATA(POWER_SUPPLY_PROP_TEMP, 0x08, 0, 65535),
+	[REG_VOLTAGE] =3D
+		BQ20Z75_DATA(POWER_SUPPLY_PROP_VOLTAGE_NOW, 0x09, 0, 20000),
+	[REG_CURRENT] =3D
+		BQ20Z75_DATA(POWER_SUPPLY_PROP_CURRENT_NOW, 0x0A, -32768,
+			32767),
+	[REG_CAPACITY] =3D
+		BQ20Z75_DATA(POWER_SUPPLY_PROP_CAPACITY, 0x0E, 0, 100),
+	[REG_TIME_TO_EMPTY] =3D
+		BQ20Z75_DATA(POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG, 0x12, 0,
+			65535),
+	[REG_TIME_TO_FULL] =3D
+		BQ20Z75_DATA(POWER_SUPPLY_PROP_TIME_TO_FULL_AVG, 0x13, 0,
+			65535),
+	[REG_STATUS] =3D
+		BQ20Z75_DATA(POWER_SUPPLY_PROP_STATUS, 0x16, 0, 65535),
+	[REG_CYCLE_COUNT] =3D
+		BQ20Z75_DATA(POWER_SUPPLY_PROP_CYCLE_COUNT, 0x17, 0, 65535),
+	[REG_SERIAL_NUMBER] =3D
+		BQ20Z75_DATA(POWER_SUPPLY_PROP_SERIAL_NUMBER, 0x1C, 0, 65535),
+};
+
+static enum power_supply_property bq20z75_properties[] =3D {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
+	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
+	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+};
+
+static int bq20z75_get_property(struct power_supply *psy,
+	enum power_supply_property psp, union power_supply_propval *val);
+
+struct bq20z75_info {
+	struct i2c_client	*client;
+	struct power_supply	power_supply;
+};
+
+static int bq20z75_get_battery_presence_and_health(
+	struct i2c_client *client, enum power_supply_property psp,
+	union power_supply_propval *val)
+{
+	s32 ret;
+
+	/* Write to ManufacturerAccess with
+	 * ManufacturerAccess command and then
+	 * read the status */
+	ret =3D i2c_smbus_write_word_data(client,
+		bq20z75_data[REG_MANUFACTURER_DATA].addr,
+		MANUFACTURER_ACCESS_STATUS);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"%s: i2c write for battery presence failed\n",
+			__func__);
+		return -ENODEV;
+	}
+
+	ret =3D i2c_smbus_read_word_data(client,
+		bq20z75_data[REG_MANUFACTURER_DATA].addr);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"%s: i2c read for battery presence failed\n",
+			__func__);
+		return -EIO;
+	}
+
+	if (ret < bq20z75_data[REG_MANUFACTURER_DATA].min_value ||
+	    ret > bq20z75_data[REG_MANUFACTURER_DATA].max_value) {
+		val->intval =3D 0;
+		return 0;
+	}
+
+	/* Mask the upper nibble of 2nd byte and
+	 * lower byte of response then
+	 * shift the result by 8 to get status*/
+	ret &=3D 0x0F00;
+	ret >>=3D 8;
+	if (psp =3D=3D POWER_SUPPLY_PROP_PRESENT) {
+		if (ret =3D=3D 0x0F)
+			/* battery removed */
+			val->intval =3D 0;
+		else
+			val->intval =3D 1;
+	} else if (psp =3D=3D POWER_SUPPLY_PROP_HEALTH) {
+		if (ret =3D=3D 0x09)
+			val->intval =3D POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+		else if (ret =3D=3D 0x0B)
+			val->intval =3D POWER_SUPPLY_HEALTH_OVERHEAT;
+		else if (ret =3D=3D 0x0C)
+			val->intval =3D POWER_SUPPLY_HEALTH_DEAD;
+		else
+			val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
+	}
+
+	return 0;
+}
+
+static int bq20z75_get_battery_property(struct i2c_client *client,=20
+	int reg_offset, enum power_supply_property psp,=20
+	union power_supply_propval *val)
+{
+	s32 ret;
+
+	ret =3D i2c_smbus_read_word_data(client,
+		bq20z75_data[reg_offset].addr);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"%s: i2c read for %d failed\n", __func__, reg_offset);
+		return -EIO;
+	}
+
+	if (ret >=3D bq20z75_data[reg_offset].min_value &&
+	    ret <=3D bq20z75_data[reg_offset].max_value) {
+		val->intval =3D ret;
+		if (psp =3D=3D POWER_SUPPLY_PROP_STATUS) {
+			if (ret & BATTERY_CHARGING)
+				val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
+			else if (ret & BATTERY_FULL_CHARGED)
+				val->intval =3D POWER_SUPPLY_STATUS_FULL;
+			else if (ret & BATTERY_FULL_DISCHARGED)
+				val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
+			else
+				val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
+		}
+		/* bq20z75 provides battery tempreture in 0.1=C2=B0K
+		 * so convert it to =C2=B0C */
+		else if (psp =3D=3D POWER_SUPPLY_PROP_TEMP)
+			val->intval =3D ret - 2731;
+	} else {
+		if (psp =3D=3D POWER_SUPPLY_PROP_STATUS)
+			val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
+		else
+			val->intval =3D 0;
+	}
+
+	return 0;
+}
+
+static int bq20z75_get_battery_capacity(struct i2c_client *client,
+	union power_supply_propval *val)
+{
+	s32 ret;
+
+	ret =3D i2c_smbus_read_byte_data(client, bq20z75_data[REG_CAPACITY].a=
ddr);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"%s: i2c read for %d failed\n", __func__, REG_CAPACITY);
+		return -EIO;
+	}
+
+	/* bq20z75 spec says that this can be >100 %
+	 * even if max value is 100 % */
+	val->intval =3D min(ret, 100);
+
+	return 0;
+}
+
+static int bq20z75_get_property(struct power_supply *psy,
+	enum power_supply_property psp,
+	union power_supply_propval *val)
+{
+	int count;
+	int ret;
+	struct bq20z75_info *bq20z75_device =3D container_of(psy,
+				struct bq20z75_info, power_supply);
+	struct i2c_client *client =3D bq20z75_device->client;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+	case POWER_SUPPLY_PROP_HEALTH:
+		ret =3D bq20z75_get_battery_presence_and_health(client, psp, val);
+		if (ret)
+			return ret;
+		break;
+
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
+		break;
+
+	case POWER_SUPPLY_PROP_CAPACITY:
+		ret =3D bq20z75_get_battery_capacity(client, val);
+		if (ret)
+			return ret;
+		break;
+
+	case POWER_SUPPLY_PROP_STATUS:
+	case POWER_SUPPLY_PROP_CYCLE_COUNT:
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+	case POWER_SUPPLY_PROP_TEMP:
+	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
+	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
+	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
+		for (count =3D 0; count < ARRAY_SIZE(bq20z75_data); count++) {
+			if (psp =3D=3D bq20z75_data[count].psp)
+				break;
+		}
+
+		ret =3D bq20z75_get_battery_property(client, count, psp, val);
+		if (ret)
+			return ret;
+		break;
+
+	default:
+		dev_err(&client->dev,
+			"%s: INVALID property\n", __func__);
+		return -EINVAL;
+	}
+
+	dev_dbg(&client->dev,
+		"%s: property =3D %d, value =3D %d\n", __func__, psp, val->intval);
+
+	return 0;
+}
+
+static int bq20z75_probe(struct i2c_client *client,
+	const struct i2c_device_id *id)
+{
+	struct bq20z75_info *bq20z75_device;
+	int rc;
+
+	bq20z75_device =3D kzalloc(sizeof(struct bq20z75_info), GFP_KERNEL);
+	if (!bq20z75_device)
+		return -ENOMEM;
+
+	bq20z75_device->client =3D client;
+	bq20z75_device->power_supply.name =3D "battery";
+	bq20z75_device->power_supply.type =3D POWER_SUPPLY_TYPE_BATTERY;
+	bq20z75_device->power_supply.properties =3D bq20z75_properties;
+	bq20z75_device->power_supply.num_properties =3D ARRAY_SIZE(bq20z75_pr=
operties);
+	bq20z75_device->power_supply.get_property =3D bq20z75_get_property;
+
+	i2c_set_clientdata(client, bq20z75_device);
+
+	rc =3D power_supply_register(&client->dev, &bq20z75_device->power_sup=
ply);
+	if (rc) {
+		dev_err(&client->dev,
+			"%s: Failed to register power supply\n", __func__);
+		kfree(bq20z75_device);
+		return rc;
+	}
+
+	dev_info(&client->dev,
+		"%s: battery gas gauge device registered\n", client->name);
+
+	return 0;
+}
+
+static int bq20z75_remove(struct i2c_client *client)
+{
+	struct bq20z75_info *bq20z75_device =3D i2c_get_clientdata(client);
+
+	power_supply_unregister(&bq20z75_device->power_supply);
+	kfree(bq20z75_device);
+	bq20z75_device =3D NULL;
+
+	return 0;
+}
+
+#if defined CONFIG_PM
+static int bq20z75_suspend(struct i2c_client *client,
+	pm_message_t state)
+{
+	s32 ret;
+
+	/* write to manufacturer access with sleep command */
+	ret =3D i2c_smbus_write_word_data(client,
+		bq20z75_data[REG_MANUFACTURER_DATA].addr,
+		MANUFACTURER_ACCESS_SLEEP);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"%s: i2c write for %d failed\n",
+			__func__, MANUFACTURER_ACCESS_SLEEP);
+		return -EIO;
+	}
+
+	return 0;
+}
+#else
+#define bq20z75_suspend		NULL
+#endif
+/* any smbus transaction will wake up bq20z75 */
+#define bq20z75_resume		NULL
+
+static const struct i2c_device_id bq20z75_id[] =3D {
+	{ "bq20z75", 0 },
+	{}
+};
+
+static struct i2c_driver bq20z75_battery_driver =3D {
+	.probe		=3D bq20z75_probe,
+	.remove		=3D bq20z75_remove,
+	.suspend	=3D bq20z75_suspend,
+	.resume		=3D bq20z75_resume,
+	.id_table	=3D bq20z75_id,
+	.driver =3D {
+		.name	=3D "bq20z75-battery",
+	},
+};
+
+static int __init bq20z75_battery_init(void)
+{
+	return i2c_add_driver(&bq20z75_battery_driver);
+}
+module_init(bq20z75_battery_init);
+
+static void __exit bq20z75_battery_exit(void)
+{
+	i2c_del_driver(&bq20z75_battery_driver);
+}
+module_exit(bq20z75_battery_exit);
+
+MODULE_DESCRIPTION("BQ20z75 battery monitor driver");
+MODULE_LICENSE("GPL");
--=20
1.7.0.4
