From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/5] i2c: Convert the lm90 driver to a new-style i2c
	driver
Date: Mon, 16 Jun 2008 22:17:55 +0200
Message-ID: <20080616221755.7dd65c59@hyperion.delvare>
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

The new-style lm90 driver implements the optional detect() callback
to cover the use cases of the legacy driver.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/hwmon/lm90.c |  115 +++++++++++++++++++++++++-------------------------
 1 file changed, 59 insertions(+), 56 deletions(-)

--- linux-2.6.26-rc6.orig/drivers/hwmon/lm90.c	2008-06-16 18:32:35.000000000 +0200
+++ linux-2.6.26-rc6/drivers/hwmon/lm90.c	2008-06-16 19:22:46.000000000 +0200
@@ -187,23 +187,40 @@ I2C_CLIENT_INSMOD_7(lm90, adm1032, lm99,
  * Functions declaration
  */
 
-static int lm90_attach_adapter(struct i2c_adapter *adapter);
-static int lm90_detect(struct i2c_adapter *adapter, int address,
-	int kind);
+static int lm90_detect(struct i2c_client *new_client, int kind,
+		       struct i2c_board_info *info);
+static int lm90_probe(struct i2c_client *client,
+		      const struct i2c_device_id *id);
 static void lm90_init_client(struct i2c_client *client);
-static int lm90_detach_client(struct i2c_client *client);
+static int lm90_remove(struct i2c_client *client);
 static struct lm90_data *lm90_update_device(struct device *dev);
 
 /*
  * Driver data (common to all clients)
  */
 
+static struct i2c_device_id lm90_id[] = {
+	{ "lm90", lm90 },
+	{ "adm1032", adm1032 },
+	{ "lm99", lm99 },
+	{ "lm86", lm86 },
+	{ "max6657", max6657 },
+	{ "adt7461", adt7461 },
+	{ "max6680", max6680 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lm90_id);
+
 static struct i2c_driver lm90_driver = {
+	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		.name	= "lm90",
 	},
-	.attach_adapter	= lm90_attach_adapter,
-	.detach_client	= lm90_detach_client,
+	.probe		= lm90_probe,
+	.remove		= lm90_remove,
+	.id_table	= lm90_id,
+	.detect		= lm90_detect,
+	.address_data	= &addr_data,
 };
 
 /*
@@ -211,7 +228,6 @@ static struct i2c_driver lm90_driver = {
  */
 
 struct lm90_data {
-	struct i2c_client client;
 	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
@@ -477,40 +493,16 @@ static int lm90_read_reg(struct i2c_clie
 	return 0;
 }
 
-static int lm90_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, lm90_detect);
-}
-
-/*
- * The following function does more than just detection. If detection
- * succeeds, it also registers the new chip.
- */
-static int lm90_detect(struct i2c_adapter *adapter, int address, int kind)
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int lm90_detect(struct i2c_client *new_client, int kind,
+		       struct i2c_board_info *info)
 {
-	struct i2c_client *new_client;
-	struct lm90_data *data;
-	int err = 0;
+	struct i2c_adapter *adapter = new_client->adapter;
+	int address = new_client->addr;
 	const char *name = "";
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		goto exit;
-
-	if (!(data = kzalloc(sizeof(struct lm90_data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	/* The common I2C client data is placed right before the
-	   LM90-specific data. */
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &lm90_driver;
-	new_client->flags = 0;
+		return -ENODEV;
 
 	/*
 	 * Now we do the remaining detection. A negative kind means that
@@ -538,7 +530,7 @@ static int lm90_detect(struct i2c_adapte
 						LM90_REG_R_CONFIG1)) < 0
 		 || (reg_convrate = i2c_smbus_read_byte_data(new_client,
 						LM90_REG_R_CONVRATE)) < 0)
-			goto exit_free;
+			return -ENODEV;
 		
 		if ((address == 0x4C || address == 0x4D)
 		 && man_id == 0x01) { /* National Semiconductor */
@@ -546,7 +538,7 @@ static int lm90_detect(struct i2c_adapte
 
 			if ((reg_config2 = i2c_smbus_read_byte_data(new_client,
 						LM90_REG_R_CONFIG2)) < 0)
-				goto exit_free;
+				return -ENODEV;
 
 			if ((reg_config1 & 0x2A) == 0x00
 			 && (reg_config2 & 0xF8) == 0x00
@@ -610,10 +602,11 @@ static int lm90_detect(struct i2c_adapte
 			dev_info(&adapter->dev,
 			    "Unsupported chip (man_id=0x%02X, "
 			    "chip_id=0x%02X).\n", man_id, chip_id);
-			goto exit_free;
+			return -ENODEV;
 		}
 	}
 
+	/* Fill the i2c board info */
 	if (kind == lm90) {
 		name = "lm90";
 	} else if (kind == adm1032) {
@@ -621,7 +614,7 @@ static int lm90_detect(struct i2c_adapte
 		/* The ADM1032 supports PEC, but only if combined
 		   transactions are not used. */
 		if (i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
-			new_client->flags |= I2C_CLIENT_PEC;
+			info->flags |= I2C_CLIENT_PEC;
 	} else if (kind == lm99) {
 		name = "lm99";
 	} else if (kind == lm86) {
@@ -633,23 +626,39 @@ static int lm90_detect(struct i2c_adapte
 	} else if (kind == adt7461) {
 		name = "adt7461";
 	}
+	strlcpy(info->type, name, I2C_NAME_SIZE);
+
+	return 0;
+}
+
+static int lm90_probe(struct i2c_client *new_client,
+		      const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = to_i2c_adapter(new_client->dev.parent);
+	struct lm90_data *data;
+	int err;
 
-	/* We can fill in the remaining client fields */
-	strlcpy(new_client->name, name, I2C_NAME_SIZE);
-	data->valid = 0;
-	data->kind = kind;
+	data = kzalloc(sizeof(struct lm90_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
+	}
+	i2c_set_clientdata(new_client, data);
 	mutex_init(&data->update_lock);
 
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
-		goto exit_free;
+	/* Set the device type */
+	data->kind = id->driver_data;
+	if (data->kind == adm1032) {
+		if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
+			new_client->flags &= ~I2C_CLIENT_PEC;
+	}
 
 	/* Initialize the LM90 chip */
 	lm90_init_client(new_client);
 
 	/* Register sysfs hooks */
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm90_group)))
-		goto exit_detach;
+		goto exit_free;
 	if (new_client->flags & I2C_CLIENT_PEC) {
 		if ((err = device_create_file(&new_client->dev,
 					      &dev_attr_pec)))
@@ -672,8 +681,6 @@ static int lm90_detect(struct i2c_adapte
 exit_remove_files:
 	sysfs_remove_group(&new_client->dev.kobj, &lm90_group);
 	device_remove_file(&new_client->dev, &dev_attr_pec);
-exit_detach:
-	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -710,10 +717,9 @@ static void lm90_init_client(struct i2c_
 		i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1, config);
 }
 
-static int lm90_detach_client(struct i2c_client *client)
+static int lm90_remove(struct i2c_client *client)
 {
 	struct lm90_data *data = i2c_get_clientdata(client);
-	int err;
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm90_group);
@@ -722,9 +728,6 @@ static int lm90_detach_client(struct i2c
 		device_remove_file(&client->dev,
 				   &sensor_dev_attr_temp2_offset.dev_attr);
 
-	if ((err = i2c_detach_client(client)))
-		return err;
-
 	kfree(data);
 	return 0;
 }

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
