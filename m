From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/2] i2c: Convert all new-style drivers to use module
 aliasing
Date: Wed, 14 May 2008 22:10:29 +0200
Message-ID: <20080514221029.63c526d8@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Update all the remaining new-style i2c drivers to use standard module
aliasing instead of the old driver_name/type driver matching scheme.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
Testers are welcome.

 drivers/media/video/cs5345.c               |    7 ++++
 drivers/media/video/cs53l32a.c             |   10 ++++++-
 drivers/media/video/cx18/cx18-i2c.c        |    9 ++----
 drivers/media/video/cx25840/cx25840-core.c |    7 ++++
 drivers/media/video/ivtv/ivtv-i2c.c        |   13 ++++-----
 drivers/media/video/m52790.c               |    9 ++++--
 drivers/media/video/msp3400-driver.c       |   17 ++++++++---
 drivers/media/video/saa7115.c              |   40 +++++++++++++++++++---------
 drivers/media/video/saa7127.c              |    9 ++++--
 drivers/media/video/saa717x.c              |    9 ++++--
 drivers/media/video/tuner-core.c           |   17 +++++++++++
 drivers/media/video/upd64031a.c            |    6 ++++
 drivers/media/video/upd64083.c             |    6 ++++
 drivers/media/video/vp27smpx.c             |    9 ++++--
 drivers/media/video/wm8739.c               |    7 ++++
 drivers/media/video/wm8775.c               |    7 ++++
 16 files changed, 143 insertions(+), 39 deletions(-)

--- linux-2.6.26-rc2.orig/drivers/media/video/cs5345.c	2008-05-11 20:00:54.000000000 +0200
+++ linux-2.6.26-rc2/drivers/media/video/cs5345.c	2008-05-12 08:59:10.000000000 +0200
@@ -160,10 +160,17 @@ static int cs5345_probe(struct i2c_clien
 
 /* ----------------------------------------------------------------------- */
 
+static const struct i2c_device_id cs5345_id[] = {
+	{ "cs5345", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, cs5345_id);
+
 static struct v4l2_i2c_driver_data v4l2_i2c_data = {
 	.name = "cs5345",
 	.driverid = I2C_DRIVERID_CS5345,
 	.command = cs5345_command,
 	.probe = cs5345_probe,
+	.id_table = cs5345_id,
 };
 
--- linux-2.6.26-rc2.orig/drivers/media/video/cs53l32a.c	2008-05-11 20:00:54.000000000 +0200
+++ linux-2.6.26-rc2/drivers/media/video/cs53l32a.c	2008-05-13 20:06:17.000000000 +0200
@@ -144,7 +144,8 @@ static int cs53l32a_probe(struct i2c_cli
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EIO;
 
-	snprintf(client->name, sizeof(client->name) - 1, "cs53l32a");
+	if (!id)
+		strlcpy(client->name, "cs53l32a", sizeof(client->name));
 
 	v4l_info(client, "chip found @ 0x%x (%s)\n",
 			client->addr << 1, client->adapter->name);
@@ -175,10 +176,17 @@ static int cs53l32a_probe(struct i2c_cli
 	return 0;
 }
 
+static const struct i2c_device_id cs53l32a_id[] = {
+	{ "cs53l32a", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, cs53l32a_id);
+
 static struct v4l2_i2c_driver_data v4l2_i2c_data = {
 	.name = "cs53l32a",
 	.driverid = I2C_DRIVERID_CS53L32A,
 	.command = cs53l32a_command,
 	.probe = cs53l32a_probe,
+	.id_table = cs53l32a_id,
 };
 
--- linux-2.6.26-rc2.orig/drivers/media/video/cx18/cx18-i2c.c	2008-05-11 20:00:54.000000000 +0200
+++ linux-2.6.26-rc2/drivers/media/video/cx18/cx18-i2c.c	2008-05-13 22:29:47.000000000 +0200
@@ -73,7 +73,7 @@ static const u8 hw_bus[] = {
 };
 
 /* This array should match the CX18_HW_ defines */
-static const char * const hw_drivernames[] = {
+static const char * const hw_devicenames[] = {
 	"tuner",
 	"tveeprom",
 	"cs5345",
@@ -94,8 +94,7 @@ int cx18_i2c_register(struct cx18 *cx, u
 	id = hw_driverids[idx];
 	bus = hw_bus[idx];
 	memset(&info, 0, sizeof(info));
-	strlcpy(info.driver_name, hw_drivernames[idx],
-			sizeof(info.driver_name));
+	strlcpy(info.type, hw_devicenames[idx], sizeof(info.type));
 	info.addr = hw_addrs[idx];
 	for (i = 0; i < I2C_CLIENTS_MAX; i++)
 		if (cx->i2c_clients[i] == NULL)
@@ -278,7 +277,7 @@ static const char *cx18_i2c_id_name(u32 
 
 	for (i = 0; i < ARRAY_SIZE(hw_driverids); i++)
 		if (hw_driverids[i] == id)
-			return hw_drivernames[i];
+			return hw_devicenames[i];
 	return "unknown device";
 }
 
@@ -289,7 +288,7 @@ static const char *cx18_i2c_hw_name(u32 
 
 	for (i = 0; i < ARRAY_SIZE(hw_driverids); i++)
 		if (1 << i == hw)
-			return hw_drivernames[i];
+			return hw_devicenames[i];
 	return "unknown device";
 }
 
--- linux-2.6.26-rc2.orig/drivers/media/video/cx25840/cx25840-core.c	2008-05-11 20:00:54.000000000 +0200
+++ linux-2.6.26-rc2/drivers/media/video/cx25840/cx25840-core.c	2008-05-12 08:59:10.000000000 +0200
@@ -1284,10 +1284,17 @@ static int cx25840_remove(struct i2c_cli
 	return 0;
 }
 
+static const struct i2c_device_id cx25840_id[] = {
+	{ "cx25840", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, cx25840_id);
+
 static struct v4l2_i2c_driver_data v4l2_i2c_data = {
 	.name = "cx25840",
 	.driverid = I2C_DRIVERID_CX25840,
 	.command = cx25840_command,
 	.probe = cx25840_probe,
 	.remove = cx25840_remove,
+	.id_table = cx25840_id,
 };
--- linux-2.6.26-rc2.orig/drivers/media/video/ivtv/ivtv-i2c.c	2008-05-11 20:00:54.000000000 +0200
+++ linux-2.6.26-rc2/drivers/media/video/ivtv/ivtv-i2c.c	2008-05-12 08:59:10.000000000 +0200
@@ -136,7 +136,7 @@ static const u8 hw_addrs[] = {
 };
 
 /* This array should match the IVTV_HW_ defines */
-static const char * const hw_drivernames[] = {
+static const char * const hw_devicenames[] = {
 	"cx25840",
 	"saa7115",
 	"saa7127",
@@ -145,7 +145,7 @@ static const char * const hw_drivernames
 	"wm8775",
 	"cs53l32a",
 	"tveeprom",
-	"saa7115",
+	"saa7114",
 	"upd64031a",
 	"upd64083",
 	"saa717x",
@@ -167,8 +167,7 @@ int ivtv_i2c_register(struct ivtv *itv, 
 		return -1;
 	id = hw_driverids[idx];
 	memset(&info, 0, sizeof(info));
-	strlcpy(info.driver_name, hw_drivernames[idx],
-			sizeof(info.driver_name));
+	strlcpy(info.type, hw_devicenames[idx], sizeof(info.type));
 	info.addr = hw_addrs[idx];
 	for (i = 0; itv->i2c_clients[i] && i < I2C_CLIENTS_MAX; i++) {}
 
@@ -657,7 +656,7 @@ static const char *ivtv_i2c_id_name(u32 
 
 	for (i = 0; i < ARRAY_SIZE(hw_driverids); i++)
 		if (hw_driverids[i] == id)
-			return hw_drivernames[i];
+			return hw_devicenames[i];
 	return "unknown device";
 }
 
@@ -668,7 +667,7 @@ static const char *ivtv_i2c_hw_name(u32 
 
 	for (i = 0; i < ARRAY_SIZE(hw_driverids); i++)
 		if (1 << i == hw)
-			return hw_drivernames[i];
+			return hw_devicenames[i];
 	return "unknown device";
 }
 
@@ -770,7 +769,7 @@ int init_ivtv_i2c(struct ivtv *itv)
 	 * same size and GPIO must be the last entry.
 	 */
 	if (ARRAY_SIZE(hw_driverids) != ARRAY_SIZE(hw_addrs) ||
-	    ARRAY_SIZE(hw_drivernames) != ARRAY_SIZE(hw_addrs) ||
+	    ARRAY_SIZE(hw_devicenames) != ARRAY_SIZE(hw_addrs) ||
 	    IVTV_HW_GPIO != (1 << (ARRAY_SIZE(hw_addrs) - 1)) ||
 	    hw_driverids[ARRAY_SIZE(hw_addrs) - 1]) {
 		IVTV_ERR("Mismatched I2C hardware arrays\n");
--- linux-2.6.26-rc2.orig/drivers/media/video/m52790.c	2008-05-11 20:00:54.000000000 +0200
+++ linux-2.6.26-rc2/drivers/media/video/m52790.c	2008-05-12 08:59:10.000000000 +0200
@@ -135,8 +135,6 @@ static int m52790_probe(struct i2c_clien
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EIO;
 
-	snprintf(client->name, sizeof(client->name) - 1, "m52790");
-
 	v4l_info(client, "chip found @ 0x%x (%s)\n",
 			client->addr << 1, client->adapter->name);
 
@@ -159,11 +157,18 @@ static int m52790_remove(struct i2c_clie
 
 /* ----------------------------------------------------------------------- */
 
+static const struct i2c_device_id m52790_id[] = {
+	{ "m52790", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, m52790_id);
+
 static struct v4l2_i2c_driver_data v4l2_i2c_data = {
 	.name = "m52790",
 	.driverid = I2C_DRIVERID_M52790,
 	.command = m52790_command,
 	.probe = m52790_probe,
 	.remove = m52790_remove,
+	.id_table = m52790_id,
 };
 
--- linux-2.6.26-rc2.orig/drivers/media/video/msp3400-driver.c	2008-05-11 20:00:54.000000000 +0200
+++ linux-2.6.26-rc2/drivers/media/video/msp3400-driver.c	2008-05-13 20:11:43.000000000 +0200
@@ -815,7 +815,8 @@ static int msp_probe(struct i2c_client *
 	int msp_product, msp_prod_hi, msp_prod_lo;
 	int msp_rom;
 
-	snprintf(client->name, sizeof(client->name) - 1, "msp3400");
+	if (!id)
+		strlcpy(client->name, "msp3400", sizeof(client->name));
 
 	if (msp_reset(client) == -1) {
 		v4l_dbg(1, msp_debug, client, "msp3400 not found\n");
@@ -864,9 +865,6 @@ static int msp_probe(struct i2c_client *
 	msp_revision = (state->rev1 & 0x0f) + '@';
 	msp_hard = ((state->rev1 >> 8) & 0xff) + '@';
 	msp_rom = state->rev2 & 0x1f;
-	snprintf(client->name, sizeof(client->name), "MSP%d4%02d%c-%c%d",
-			msp_family, msp_product,
-			msp_revision, msp_hard, msp_rom);
 	/* Rev B=2, C=3, D=4, G=7 */
 	state->ident = msp_family * 10000 + 4000 + msp_product * 10 +
 			msp_revision - '@';
@@ -931,7 +929,9 @@ static int msp_probe(struct i2c_client *
 	}
 
 	/* hello world :-) */
-	v4l_info(client, "%s found @ 0x%x (%s)\n", client->name,
+	v4l_info(client, "MSP%d4%02d%c-%c%d found @ 0x%x (%s)\n",
+			msp_family, msp_product,
+			msp_revision, msp_hard, msp_rom,
 			client->addr << 1, client->adapter->name);
 	v4l_info(client, "%s ", client->name);
 	if (state->has_nicam && state->has_radio)
@@ -987,6 +987,12 @@ static int msp_remove(struct i2c_client 
 
 /* ----------------------------------------------------------------------- */
 
+static const struct i2c_device_id msp_id[] = {
+	{ "msp3400", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, msp_id);
+
 static struct v4l2_i2c_driver_data v4l2_i2c_data = {
 	.name = "msp3400",
 	.driverid = I2C_DRIVERID_MSP3400,
@@ -995,6 +1001,7 @@ static struct v4l2_i2c_driver_data v4l2_
 	.remove = msp_remove,
 	.suspend = msp_suspend,
 	.resume = msp_resume,
+	.id_table = msp_id,
 };
 
 
--- linux-2.6.26-rc2.orig/drivers/media/video/saa7115.c	2008-05-11 20:00:54.000000000 +0200
+++ linux-2.6.26-rc2/drivers/media/video/saa7115.c	2008-05-13 20:43:47.000000000 +0200
@@ -1456,14 +1456,13 @@ static int saa7115_probe(struct i2c_clie
 	struct saa711x_state *state;
 	int	i;
 	char	name[17];
-	u8 chip_id;
+	char chip_id;
+	int autodetect = !id || id->driver_data == 1;
 
 	/* Check if the adapter supports the needed features */
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EIO;
 
-	snprintf(client->name, sizeof(client->name) - 1, "saa7115");
-
 	for (i = 0; i < 0x0f; i++) {
 		saa711x_write(client, 0, i);
 		name[i] = (saa711x_read(client, 0) & 0x0f) + '0';
@@ -1472,8 +1471,7 @@ static int saa7115_probe(struct i2c_clie
 	}
 	name[i] = '\0';
 
-	saa711x_write(client, 0, 5);
-	chip_id = saa711x_read(client, 0) & 0x0f;
+	chip_id = name[5];
 
 	/* Check whether this chip is part of the saa711x series */
 	if (memcmp(name, "1f711", 5)) {
@@ -1482,8 +1480,14 @@ static int saa7115_probe(struct i2c_clie
 		return -ENODEV;
 	}
 
-	snprintf(client->name, sizeof(client->name) - 1, "saa711%d",chip_id);
-	v4l_info(client, "saa711%d found (%s) @ 0x%x (%s)\n", chip_id, name, client->addr << 1, client->adapter->name);
+	/* Safety check */
+	if (!autodetect && id->name[6] != chip_id) {
+		v4l_warn(client, "found saa711%c while %s was expected\n",
+			 chip_id, id->name);
+	}
+	snprintf(client->name, sizeof(client->name), "saa711%c", chip_id);
+	v4l_info(client, "saa711%c found (%s) @ 0x%x (%s)\n", chip_id, name,
+		 client->addr << 1, client->adapter->name);
 
 	state = kzalloc(sizeof(struct saa711x_state), GFP_KERNEL);
 	i2c_set_clientdata(client, state);
@@ -1499,19 +1503,19 @@ static int saa7115_probe(struct i2c_clie
 	state->hue = 0;
 	state->sat = 64;
 	switch (chip_id) {
-	case 1:
+	case '1':
 		state->ident = V4L2_IDENT_SAA7111;
 		break;
-	case 3:
+	case '3':
 		state->ident = V4L2_IDENT_SAA7113;
 		break;
-	case 4:
+	case '4':
 		state->ident = V4L2_IDENT_SAA7114;
 		break;
-	case 5:
+	case '5':
 		state->ident = V4L2_IDENT_SAA7115;
 		break;
-	case 8:
+	case '8':
 		state->ident = V4L2_IDENT_SAA7118;
 		break;
 	default:
@@ -1553,6 +1557,17 @@ static int saa7115_remove(struct i2c_cli
 	return 0;
 }
 
+static const struct i2c_device_id saa7115_id[] = {
+	{ "saa711x", 1 }, /* autodetect */
+	{ "saa7111", 0 },
+	{ "saa7113", 0 },
+	{ "saa7114", 0 },
+	{ "saa7115", 0 },
+	{ "saa7118", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, saa7115_id);
+
 static struct v4l2_i2c_driver_data v4l2_i2c_data = {
 	.name = "saa7115",
 	.driverid = I2C_DRIVERID_SAA711X,
@@ -1560,5 +1575,6 @@ static struct v4l2_i2c_driver_data v4l2_
 	.probe = saa7115_probe,
 	.remove = saa7115_remove,
 	.legacy_class = I2C_CLASS_TV_ANALOG | I2C_CLASS_TV_DIGITAL,
+	.id_table = saa7115_id,
 };
 
--- linux-2.6.26-rc2.orig/drivers/media/video/saa7127.c	2008-05-11 20:00:54.000000000 +0200
+++ linux-2.6.26-rc2/drivers/media/video/saa7127.c	2008-05-12 08:59:10.000000000 +0200
@@ -672,8 +672,6 @@ static int saa7127_probe(struct i2c_clie
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EIO;
 
-	snprintf(client->name, sizeof(client->name) - 1, "saa7127");
-
 	v4l_dbg(1, debug, client, "detecting saa7127 client on address 0x%x\n",
 			client->addr << 1);
 
@@ -741,11 +739,18 @@ static int saa7127_remove(struct i2c_cli
 
 /* ----------------------------------------------------------------------- */
 
+static struct i2c_device_id saa7127_id[] = {
+	{ "saa7127", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, saa7127_id);
+
 static struct v4l2_i2c_driver_data v4l2_i2c_data = {
 	.name = "saa7127",
 	.driverid = I2C_DRIVERID_SAA7127,
 	.command = saa7127_command,
 	.probe = saa7127_probe,
 	.remove = saa7127_remove,
+	.id_table = saa7127_id,
 };
 
--- linux-2.6.26-rc2.orig/drivers/media/video/saa717x.c	2008-05-11 20:00:54.000000000 +0200
+++ linux-2.6.26-rc2/drivers/media/video/saa717x.c	2008-05-12 08:59:10.000000000 +0200
@@ -1429,8 +1429,6 @@ static int saa717x_probe(struct i2c_clie
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EIO;
 
-	snprintf(client->name, sizeof(client->name) - 1, "saa717x");
-
 	if (saa717x_write(client, 0x5a4, 0xfe) &&
 			saa717x_write(client, 0x5a5, 0x0f) &&
 			saa717x_write(client, 0x5a6, 0x00) &&
@@ -1507,6 +1505,12 @@ static int saa717x_remove(struct i2c_cli
 
 /* ----------------------------------------------------------------------- */
 
+static const struct i2c_device_id saa717x_id[] = {
+	{ "saa717x", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, saa717x_id);
+
 static struct v4l2_i2c_driver_data v4l2_i2c_data = {
 	.name = "saa717x",
 	.driverid = I2C_DRIVERID_SAA717X,
@@ -1514,4 +1518,5 @@ static struct v4l2_i2c_driver_data v4l2_
 	.probe = saa717x_probe,
 	.remove = saa717x_remove,
 	.legacy_class = I2C_CLASS_TV_ANALOG | I2C_CLASS_TV_DIGITAL,
+	.id_table = saa717x_id,
 };
--- linux-2.6.26-rc2.orig/drivers/media/video/tuner-core.c	2008-05-11 20:00:54.000000000 +0200
+++ linux-2.6.26-rc2/drivers/media/video/tuner-core.c	2008-05-13 21:59:42.000000000 +0200
@@ -1117,7 +1117,6 @@ static int tuner_probe(struct i2c_client
 	if (NULL == t)
 		return -ENOMEM;
 	t->i2c = client;
-	strlcpy(client->name, "(tuner unset)", sizeof(client->name));
 	i2c_set_clientdata(client, t);
 	t->type = UNSET;
 	t->audmode = V4L2_TUNER_MODE_STEREO;
@@ -1275,11 +1274,26 @@ static int tuner_remove(struct i2c_clien
 
 	list_del(&t->list);
 	kfree(t);
+
+	/* The probing code has overwritten the device name, restore it so
+	   that reloading the driver will work. Ideally the device name
+	   should not be overwritten in the first place, but for now that
+	   will do. */
+	strlcpy(client->name, "tuner", I2C_NAME_SIZE);
 	return 0;
 }
 
 /* ----------------------------------------------------------------------- */
 
+/* This driver supports many devices and the idea is to let the driver
+   detect which device is present. So rather than listing all supported
+   devices here, we pretend to support a single, fake device type. */
+static const struct i2c_device_id tuner_id[] = {
+	{ "tuner", }, /* autodetect */
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tuner_id);
+
 static struct v4l2_i2c_driver_data v4l2_i2c_data = {
 	.name = "tuner",
 	.driverid = I2C_DRIVERID_TUNER,
@@ -1289,6 +1303,7 @@ static struct v4l2_i2c_driver_data v4l2_
 	.suspend = tuner_suspend,
 	.resume = tuner_resume,
 	.legacy_probe = tuner_legacy_probe,
+	.id_table = tuner_id,
 };
 
 
--- linux-2.6.26-rc2.orig/drivers/media/video/upd64031a.c	2008-05-11 20:00:54.000000000 +0200
+++ linux-2.6.26-rc2/drivers/media/video/upd64031a.c	2008-05-12 08:59:10.000000000 +0200
@@ -228,6 +228,11 @@ static int upd64031a_remove(struct i2c_c
 
 /* ----------------------------------------------------------------------- */
 
+static const struct i2c_device_id upd64031a_id[] = {
+	{ "upd64031a", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, upd64031a_id);
 
 static struct v4l2_i2c_driver_data v4l2_i2c_data = {
 	.name = "upd64031a",
@@ -235,4 +240,5 @@ static struct v4l2_i2c_driver_data v4l2_
 	.command = upd64031a_command,
 	.probe = upd64031a_probe,
 	.remove = upd64031a_remove,
+	.id_table = upd64031a_id,
 };
--- linux-2.6.26-rc2.orig/drivers/media/video/upd64083.c	2008-05-11 20:00:54.000000000 +0200
+++ linux-2.6.26-rc2/drivers/media/video/upd64083.c	2008-05-12 08:59:10.000000000 +0200
@@ -205,6 +205,11 @@ static int upd64083_remove(struct i2c_cl
 
 /* ----------------------------------------------------------------------- */
 
+static const struct i2c_device_id upd64083_id[] = {
+	{ "upd64083", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, upd64083_id);
 
 static struct v4l2_i2c_driver_data v4l2_i2c_data = {
 	.name = "upd64083",
@@ -212,4 +217,5 @@ static struct v4l2_i2c_driver_data v4l2_
 	.command = upd64083_command,
 	.probe = upd64083_probe,
 	.remove = upd64083_remove,
+	.id_table = upd64083_id,
 };
--- linux-2.6.26-rc2.orig/drivers/media/video/vp27smpx.c	2008-05-11 20:00:54.000000000 +0200
+++ linux-2.6.26-rc2/drivers/media/video/vp27smpx.c	2008-05-12 08:59:10.000000000 +0200
@@ -130,8 +130,6 @@ static int vp27smpx_probe(struct i2c_cli
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EIO;
 
-	snprintf(client->name, sizeof(client->name) - 1, "vp27smpx");
-
 	v4l_info(client, "chip found @ 0x%x (%s)\n",
 			client->addr << 1, client->adapter->name);
 
@@ -154,11 +152,18 @@ static int vp27smpx_remove(struct i2c_cl
 
 /* ----------------------------------------------------------------------- */
 
+static const struct i2c_device_id vp27smpx_id[] = {
+	{ "vp27smpx", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, vp27smpx_id);
+
 static struct v4l2_i2c_driver_data v4l2_i2c_data = {
 	.name = "vp27smpx",
 	.driverid = I2C_DRIVERID_VP27SMPX,
 	.command = vp27smpx_command,
 	.probe = vp27smpx_probe,
 	.remove = vp27smpx_remove,
+	.id_table = vp27smpx_id,
 };
 
--- linux-2.6.26-rc2.orig/drivers/media/video/wm8739.c	2008-05-11 20:00:54.000000000 +0200
+++ linux-2.6.26-rc2/drivers/media/video/wm8739.c	2008-05-12 08:59:10.000000000 +0200
@@ -313,11 +313,18 @@ static int wm8739_remove(struct i2c_clie
 	return 0;
 }
 
+static const struct i2c_device_id wm8739_id[] = {
+	{ "wm8739", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wm8739_id);
+
 static struct v4l2_i2c_driver_data v4l2_i2c_data = {
 	.name = "wm8739",
 	.driverid = I2C_DRIVERID_WM8739,
 	.command = wm8739_command,
 	.probe = wm8739_probe,
 	.remove = wm8739_remove,
+	.id_table = wm8739_id,
 };
 
--- linux-2.6.26-rc2.orig/drivers/media/video/wm8775.c	2008-05-11 20:00:54.000000000 +0200
+++ linux-2.6.26-rc2/drivers/media/video/wm8775.c	2008-05-12 08:59:10.000000000 +0200
@@ -216,11 +216,18 @@ static int wm8775_remove(struct i2c_clie
 	return 0;
 }
 
+static const struct i2c_device_id wm8775_id[] = {
+	{ "wm8775", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wm8775_id);
+
 static struct v4l2_i2c_driver_data v4l2_i2c_data = {
 	.name = "wm8775",
 	.driverid = I2C_DRIVERID_WM8775,
 	.command = wm8775_command,
 	.probe = wm8775_probe,
 	.remove = wm8775_remove,
+	.id_table = wm8775_id,
 };
 


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
