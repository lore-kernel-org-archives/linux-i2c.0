From: rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Subject: [PATCH 1/1] power: bq20z75: Adding Devicekit Power support
Date: Tue, 21 Sep 2010 15:33:55 -0700
Message-ID: <1285108435-30044-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46rom: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Adding properties to support devicekit power.
Also create io wrapper functions and fixed some issues found while
testing, including unit conversions to match the power_supply types.

Signed-off-by: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/power/bq20z75.c |  204 ++++++++++++++++++++++++++++++++++++---=
--------
 1 files changed, 156 insertions(+), 48 deletions(-)

diff --git a/drivers/power/bq20z75.c b/drivers/power/bq20z75.c
index a1c7ae2..492da27 100644
--- a/drivers/power/bq20z75.c
+++ b/drivers/power/bq20z75.c
@@ -36,7 +36,11 @@ enum {
 	REG_TIME_TO_FULL,
 	REG_STATUS,
 	REG_CYCLE_COUNT,
-	REG_SERIAL_NUMBER
+	REG_SERIAL_NUMBER,
+	REG_REMAINING_CAPACITY,
+	REG_FULL_CHARGE_CAPACITY,
+	REG_DESIGN_CAPACITY,
+	REG_DESIGN_VOLTAGE,
 };
=20
 /* manufacturer access defines */
@@ -44,7 +48,7 @@ enum {
 #define MANUFACTURER_ACCESS_SLEEP	0x0011
=20
 /* battery status value bits */
-#define BATTERY_CHARGING		0x40
+#define BATTERY_DISCHARGING		0x40
 #define BATTERY_FULL_CHARGED		0x20
 #define BATTERY_FULL_DISCHARGED		0x10
=20
@@ -72,6 +76,10 @@ static const struct bq20z75_device_data {
 			32767),
 	[REG_CAPACITY] =3D
 		BQ20Z75_DATA(POWER_SUPPLY_PROP_CAPACITY, 0x0E, 0, 100),
+	[REG_REMAINING_CAPACITY] =3D
+		BQ20Z75_DATA(POWER_SUPPLY_PROP_ENERGY_NOW, 0x0F, 0, 65535),
+	[REG_FULL_CHARGE_CAPACITY] =3D
+		BQ20Z75_DATA(POWER_SUPPLY_PROP_ENERGY_FULL, 0x10, 0, 65535),
 	[REG_TIME_TO_EMPTY] =3D
 		BQ20Z75_DATA(POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG, 0x12, 0,
 			65535),
@@ -82,6 +90,12 @@ static const struct bq20z75_device_data {
 		BQ20Z75_DATA(POWER_SUPPLY_PROP_STATUS, 0x16, 0, 65535),
 	[REG_CYCLE_COUNT] =3D
 		BQ20Z75_DATA(POWER_SUPPLY_PROP_CYCLE_COUNT, 0x17, 0, 65535),
+	[REG_DESIGN_CAPACITY] =3D
+		BQ20Z75_DATA(POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN, 0x18, 0,
+			65535),
+	[REG_DESIGN_VOLTAGE] =3D
+		BQ20Z75_DATA(POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN, 0x19, 0,
+			65535),
 	[REG_SERIAL_NUMBER] =3D
 		BQ20Z75_DATA(POWER_SUPPLY_PROP_SERIAL_NUMBER, 0x1C, 0, 65535),
 };
@@ -99,6 +113,10 @@ static enum power_supply_property bq20z75_propertie=
s[] =3D {
 	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
 	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
+	POWER_SUPPLY_PROP_ENERGY_NOW,
+	POWER_SUPPLY_PROP_ENERGY_FULL,
+	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
 };
=20
 struct bq20z75_info {
@@ -106,6 +124,35 @@ struct bq20z75_info {
 	struct power_supply	power_supply;
 };
=20
+static int bq20z75_read_word_data(struct i2c_client *client, u8 addres=
s)
+{
+	s32 ret;
+
+	ret =3D i2c_smbus_read_word_data(client, address);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"%s: i2c read at address 0x%x failed\n",
+			__func__, address);
+		return ret;
+	}
+	return le16_to_cpu(ret);
+}
+
+static int bq20z75_write_word_data(struct i2c_client *client, u8 addre=
ss,
+	u16 value)
+{
+	s32 ret;
+
+	ret =3D i2c_smbus_write_word_data(client, address, le16_to_cpu(value)=
);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"%s: i2c write to address 0x%x failed\n",
+			__func__, address);
+		return ret;
+	}
+	return 0;
+}
+
 static int bq20z75_get_battery_presence_and_health(
 	struct i2c_client *client, enum power_supply_property psp,
 	union power_supply_propval *val)
@@ -115,24 +162,17 @@ static int bq20z75_get_battery_presence_and_healt=
h(
 	/* Write to ManufacturerAccess with
 	 * ManufacturerAccess command and then
 	 * read the status */
-	ret =3D i2c_smbus_write_word_data(client,
+	ret =3D bq20z75_write_word_data(client,
 		bq20z75_data[REG_MANUFACTURER_DATA].addr,
 		MANUFACTURER_ACCESS_STATUS);
-	if (ret < 0) {
-		dev_err(&client->dev,
-			"%s: i2c write for battery presence failed\n",
-			__func__);
-		return -ENODEV;
-	}
+	if (ret < 0)
+		return ret;
=20
-	ret =3D i2c_smbus_read_word_data(client,
+
+	ret =3D bq20z75_read_word_data(client,
 		bq20z75_data[REG_MANUFACTURER_DATA].addr);
-	if (ret < 0) {
-		dev_err(&client->dev,
-			"%s: i2c read for battery presence failed\n",
-			__func__);
-		return -EIO;
-	}
+	if (ret < 0)
+		return ret;
=20
 	if (ret < bq20z75_data[REG_MANUFACTURER_DATA].min_value ||
 	    ret > bq20z75_data[REG_MANUFACTURER_DATA].max_value) {
@@ -171,31 +211,28 @@ static int bq20z75_get_battery_property(struct i2=
c_client *client,
 {
 	s32 ret;
=20
-	ret =3D i2c_smbus_read_word_data(client,
+	ret =3D bq20z75_read_word_data(client,
 		bq20z75_data[reg_offset].addr);
-	if (ret < 0) {
-		dev_err(&client->dev,
-			"%s: i2c read for %d failed\n", __func__, reg_offset);
-		return -EIO;
-	}
+	if (ret < 0)
+		return ret;
+
+	/* returned values are 16 bit */
+	if (bq20z75_data[reg_offset].min_value < 0)
+		ret =3D (s16)ret;
=20
 	if (ret >=3D bq20z75_data[reg_offset].min_value &&
 	    ret <=3D bq20z75_data[reg_offset].max_value) {
 		val->intval =3D ret;
 		if (psp =3D=3D POWER_SUPPLY_PROP_STATUS) {
-			if (ret & BATTERY_CHARGING)
-				val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
-			else if (ret & BATTERY_FULL_CHARGED)
+			if (ret & BATTERY_FULL_CHARGED)
 				val->intval =3D POWER_SUPPLY_STATUS_FULL;
 			else if (ret & BATTERY_FULL_DISCHARGED)
 				val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
-			else
+			else if (ret & BATTERY_DISCHARGING)
 				val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
+			else
+				val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
 		}
-		/* bq20z75 provides battery tempreture in 0.1=C2=B0K
-		 * so convert it to =C2=B0C */
-		else if (psp =3D=3D POWER_SUPPLY_PROP_TEMP)
-			val->intval =3D ret - 2731;
 	} else {
 		if (psp =3D=3D POWER_SUPPLY_PROP_STATUS)
 			val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
@@ -206,21 +243,77 @@ static int bq20z75_get_battery_property(struct i2=
c_client *client,
 	return 0;
 }
=20
+static void  bq20z75_unit_adjustment(struct i2c_client *client,
+	enum power_supply_property psp, union power_supply_propval *val)
+{
+#define BASE_UNIT_CONVERSION		1000
+#define BATTERY_MODE_CAP_MULT_WATT	(10 * BASE_UNIT_CONVERSION)
+#define TIME_UNIT_CONVERSION		600
+#define TEMP_KELVIN_TO_CELCIUS		2731
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ENERGY_NOW:
+	case POWER_SUPPLY_PROP_ENERGY_FULL:
+	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
+		val->intval *=3D BATTERY_MODE_CAP_MULT_WATT;
+		break;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval *=3D BASE_UNIT_CONVERSION;
+		break;
+
+	case POWER_SUPPLY_PROP_TEMP:
+		/* bq20z75 provides battery tempreture in 0.1=C2=B0K
+		 * so convert it to 0.1=C2=B0C */
+		val->intval -=3D TEMP_KELVIN_TO_CELCIUS;
+		val->intval *=3D 10;
+		break;
+
+	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
+	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
+		val->intval *=3D TIME_UNIT_CONVERSION;
+		break;
+
+	default:
+		dev_dbg(&client->dev,
+			"%s: no need for unit conversion %d\n", __func__, psp);
+	}
+}
+
 static int bq20z75_get_battery_capacity(struct i2c_client *client,
+	int reg_offset, enum power_supply_property psp,
 	union power_supply_propval *val)
 {
 	s32 ret;
=20
-	ret =3D i2c_smbus_read_byte_data(client, bq20z75_data[REG_CAPACITY].a=
ddr);
-	if (ret < 0) {
-		dev_err(&client->dev,
-			"%s: i2c read for %d failed\n", __func__, REG_CAPACITY);
-		return -EIO;
-	}
+	ret =3D bq20z75_read_word_data(client, bq20z75_data[reg_offset].addr)=
;
+	if (ret < 0)
+		return ret;
=20
-	/* bq20z75 spec says that this can be >100 %
-	 * even if max value is 100 % */
-	val->intval =3D min(ret, 100);
+	if (psp =3D=3D POWER_SUPPLY_PROP_CAPACITY) {
+		/* bq20z75 spec says that this can be >100 %
+		* even if max value is 100 % */
+		val->intval =3D min(ret, 100);
+	} else
+		val->intval =3D ret;
+
+	return 0;
+}
+
+static char bq20z75_serial[5];
+static int bq20z75_get_battery_serial_number(struct i2c_client *client=
,
+	union power_supply_propval *val)
+{
+	int ret;
+
+	ret =3D bq20z75_read_word_data(client,
+		bq20z75_data[REG_SERIAL_NUMBER].addr);
+	if (ret < 0)
+		return ret;
+
+	ret =3D sprintf(bq20z75_serial, "%04x", ret);
+	val->strval =3D bq20z75_serial;
=20
 	return 0;
 }
@@ -247,8 +340,23 @@ static int bq20z75_get_property(struct power_suppl=
y *psy,
 		val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
 		break;
=20
+	case POWER_SUPPLY_PROP_ENERGY_NOW:
+	case POWER_SUPPLY_PROP_ENERGY_FULL:
+	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
 	case POWER_SUPPLY_PROP_CAPACITY:
-		ret =3D bq20z75_get_battery_capacity(client, val);
+		for (count =3D 0; count < ARRAY_SIZE(bq20z75_data); count++) {
+			if (psp =3D=3D bq20z75_data[count].psp)
+				break;
+		}
+
+		ret =3D bq20z75_get_battery_capacity(client, count, psp, val);
+		if (ret)
+			return ret;
+
+		break;
+
+	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
+		ret =3D bq20z75_get_battery_serial_number(client, val);
 		if (ret)
 			return ret;
 		break;
@@ -260,7 +368,7 @@ static int bq20z75_get_property(struct power_supply=
 *psy,
 	case POWER_SUPPLY_PROP_TEMP:
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
 	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
-	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
 		for (count =3D 0; count < ARRAY_SIZE(bq20z75_data); count++) {
 			if (psp =3D=3D bq20z75_data[count].psp)
 				break;
@@ -269,6 +377,7 @@ static int bq20z75_get_property(struct power_supply=
 *psy,
 		ret =3D bq20z75_get_battery_property(client, count, psp, val);
 		if (ret)
 			return ret;
+
 		break;
=20
 	default:
@@ -277,6 +386,9 @@ static int bq20z75_get_property(struct power_supply=
 *psy,
 		return -EINVAL;
 	}
=20
+	/* Convert units to match requirements for power supply class */
+	bq20z75_unit_adjustment(client, psp, val);
+
 	dev_dbg(&client->dev,
 		"%s: property =3D %d, value =3D %d\n", __func__, psp, val->intval);
=20
@@ -335,15 +447,11 @@ static int bq20z75_suspend(struct i2c_client *cli=
ent,
 	s32 ret;
=20
 	/* write to manufacturer access with sleep command */
-	ret =3D i2c_smbus_write_word_data(client,
+	ret =3D bq20z75_write_word_data(client,
 		bq20z75_data[REG_MANUFACTURER_DATA].addr,
 		MANUFACTURER_ACCESS_SLEEP);
-	if (ret < 0) {
-		dev_err(&client->dev,
-			"%s: i2c write for %d failed\n",
-			__func__, MANUFACTURER_ACCESS_SLEEP);
-		return -EIO;
-	}
+	if (ret < 0)
+		return ret;
=20
 	return 0;
 }
--=20
1.7.0.4
