From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 4/5] i2c: Drop legacy lm75 driver
Date: Mon, 16 Jun 2008 22:20:32 +0200
Message-ID: <20080616222032.5845baff@hyperion.delvare>
References: <20080616221257.446a2145@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080616221257.446a2145-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Drop the legacy lm75 driver, and add a detect callback to the
new-style driver to achieve the same functionality.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
This goes on top of David Brownell's patches:
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022931.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023040.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023041.html

Also available from:
http://jdelvare.pck.nerim.net/sensors/lm75/

 drivers/hwmon/lm75.c |  114 +++++++++-----------------------------------------
 1 file changed, 22 insertions(+), 92 deletions(-)

--- linux-2.6.26-rc6.orig/drivers/hwmon/lm75.c	2008-06-16 20:36:34.000000000 +0200
+++ linux-2.6.26-rc6/drivers/hwmon/lm75.c	2008-06-16 21:15:00.000000000 +0200
@@ -54,11 +54,11 @@ enum lm75_type {		/* keep sorted in alph
 	tmp75,
 };
 
-/* Addresses scanned by legacy style driver binding */
+/* Addresses scanned */
 static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
 					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
-/* Insmod parameters (only for legacy style driver binding) */
+/* Insmod parameters */
 I2C_CLIENT_INSMOD_1(lm75);
 
 
@@ -72,7 +72,6 @@ static const u8 LM75_REG_TEMP[3] = {
 
 /* Each client has this additional data */
 struct lm75_data {
-	struct i2c_client	*client;
 	struct device		*hwmon_dev;
 	struct mutex		update_lock;
 	u8			orig_conf;
@@ -138,7 +137,7 @@ static const struct attribute_group lm75
 
 /*-----------------------------------------------------------------------*/
 
-/* "New style" I2C driver binding -- following the driver model */
+/* device probe and removal */
 
 static int
 lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
@@ -157,8 +156,6 @@ lm75_probe(struct i2c_client *client, co
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
-
-	data->client = client;
 	mutex_init(&data->update_lock);
 
 	/* Set to LM75 resolution (9 bits, 1/2 degree C) and range.
@@ -236,45 +233,16 @@ static const struct i2c_device_id lm75_i
 };
 MODULE_DEVICE_TABLE(i2c, lm75_ids);
 
-static struct i2c_driver lm75_driver = {
-	.driver = {
-		.name	= "lm75",
-	},
-	.probe		= lm75_probe,
-	.remove		= lm75_remove,
-	.id_table	= lm75_ids,
-};
-
-/*-----------------------------------------------------------------------*/
-
-/* "Legacy" I2C driver binding */
-
-static struct i2c_driver lm75_legacy_driver;
-
-/* This function is called by i2c_probe */
-static int lm75_detect(struct i2c_adapter *adapter, int address, int kind)
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int lm75_detect(struct i2c_client *new_client, int kind,
+		       struct i2c_board_info *info)
 {
+	struct i2c_adapter *adapter = new_client->adapter;
 	int i;
-	struct i2c_client *new_client;
-	int err = 0;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 				     I2C_FUNC_SMBUS_WORD_DATA))
-		goto exit;
-
-	/* OK. For now, we presume we have a valid address. We create the
-	   client structure, even though there may be no sensor present.
-	   But it allows us to use i2c_smbus_read_*_data() calls. */
-	new_client = kzalloc(sizeof *new_client, GFP_KERNEL);
-	if (!new_client) {
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &lm75_legacy_driver;
-	new_client->flags = 0;
+		return -ENODEV;
 
 	/* Now, we do the remaining detection. There is no identification-
 	   dedicated register so we have to rely on several tricks:
@@ -294,71 +262,44 @@ static int lm75_detect(struct i2c_adapte
 		 || i2c_smbus_read_word_data(new_client, 5) != hyst
 		 || i2c_smbus_read_word_data(new_client, 6) != hyst
 		 || i2c_smbus_read_word_data(new_client, 7) != hyst)
-			goto exit_free;
+			return -ENODEV;
 		os = i2c_smbus_read_word_data(new_client, 3);
 		if (i2c_smbus_read_word_data(new_client, 4) != os
 		 || i2c_smbus_read_word_data(new_client, 5) != os
 		 || i2c_smbus_read_word_data(new_client, 6) != os
 		 || i2c_smbus_read_word_data(new_client, 7) != os)
-			goto exit_free;
+			return -ENODEV;
 
 		/* Unused bits */
 		if (conf & 0xe0)
-			goto exit_free;
+			return -ENODEV;
 
 		/* Addresses cycling */
 		for (i = 8; i < 0xff; i += 8)
 			if (i2c_smbus_read_byte_data(new_client, i + 1) != conf
 			 || i2c_smbus_read_word_data(new_client, i + 2) != hyst
 			 || i2c_smbus_read_word_data(new_client, i + 3) != os)
-				goto exit_free;
+				return -ENODEV;
 	}
 
 	/* NOTE: we treat "force=..." and "force_lm75=..." the same.
 	 * Only new-style driver binding distinguishes chip types.
 	 */
-	strlcpy(new_client->name, "lm75", I2C_NAME_SIZE);
-
-	/* Tell the I2C layer a new client has arrived */
-	err = i2c_attach_client(new_client);
-	if (err)
-		goto exit_free;
+	strlcpy(info->type, "lm75", I2C_NAME_SIZE);
 
-	err = lm75_probe(new_client, NULL);
-	if (err < 0)
-		goto exit_detach;
-
-	return 0;
-
-exit_detach:
-	i2c_detach_client(new_client);
-exit_free:
-	kfree(new_client);
-exit:
-	return err;
-}
-
-static int lm75_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, lm75_detect);
-}
-
-static int lm75_detach_client(struct i2c_client *client)
-{
-	lm75_remove(client);
-	i2c_detach_client(client);
-	kfree(client);
 	return 0;
 }
 
-static struct i2c_driver lm75_legacy_driver = {
+static struct i2c_driver lm75_driver = {
+	.class		= I2C_CLASS_HWMON,
 	.driver = {
-		.name	= "lm75_legacy",
+		.name	= "lm75",
 	},
-	.attach_adapter	= lm75_attach_adapter,
-	.detach_client	= lm75_detach_client,
+	.probe		= lm75_probe,
+	.remove		= lm75_remove,
+	.id_table	= lm75_ids,
+	.detect		= lm75_detect,
+	.address_data	= &addr_data,
 };
 
 /*-----------------------------------------------------------------------*/
@@ -424,22 +365,11 @@ static struct lm75_data *lm75_update_dev
 
 static int __init sensors_lm75_init(void)
 {
-	int status;
-
-	status = i2c_add_driver(&lm75_driver);
-	if (status < 0)
-		return status;
-
-	status = i2c_add_driver(&lm75_legacy_driver);
-	if (status < 0)
-		i2c_del_driver(&lm75_driver);
-
-	return status;
+	return i2c_add_driver(&lm75_driver);
 }
 
 static void __exit sensors_lm75_exit(void)
 {
-	i2c_del_driver(&lm75_legacy_driver);
 	i2c_del_driver(&lm75_driver);
 }
 

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
