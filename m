From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/5] i2c: Drop legacy f75375s driver
Date: Mon, 16 Jun 2008 22:18:31 +0200
Message-ID: <20080616221831.31a75e0f@hyperion.delvare>
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

Drop the legacy f75375s driver, and add a detect callback to the
new-style driver to achieve the same functionality.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/hwmon/f75375s.c |   89 ++++++-----------------------------------------
 1 file changed, 12 insertions(+), 77 deletions(-)

--- linux-2.6.26-rc6.orig/drivers/hwmon/f75375s.c	2008-06-16 20:28:22.000000000 +0200
+++ linux-2.6.26-rc6/drivers/hwmon/f75375s.c	2008-06-16 21:17:14.000000000 +0200
@@ -87,7 +87,6 @@ I2C_CLIENT_INSMOD_2(f75373, f75375);
 
 struct f75375_data {
 	unsigned short addr;
-	struct i2c_client *client;
 	struct device *hwmon_dev;
 
 	const char *name;
@@ -114,21 +113,12 @@ struct f75375_data {
 	s8 temp_max_hyst[2];
 };
 
-static int f75375_attach_adapter(struct i2c_adapter *adapter);
-static int f75375_detect(struct i2c_adapter *adapter, int address, int kind);
-static int f75375_detach_client(struct i2c_client *client);
+static int f75375_detect(struct i2c_client *client, int kind,
+			 struct i2c_board_info *info);
 static int f75375_probe(struct i2c_client *client,
 			const struct i2c_device_id *id);
 static int f75375_remove(struct i2c_client *client);
 
-static struct i2c_driver f75375_legacy_driver = {
-	.driver = {
-		.name = "f75375_legacy",
-	},
-	.attach_adapter = f75375_attach_adapter,
-	.detach_client = f75375_detach_client,
-};
-
 static const struct i2c_device_id f75375_id[] = {
 	{ "f75373", f75373 },
 	{ "f75375", f75375 },
@@ -137,12 +127,15 @@ static const struct i2c_device_id f75375
 MODULE_DEVICE_TABLE(i2c, f75375_id);
 
 static struct i2c_driver f75375_driver = {
+	.class = I2C_CLASS_HWMON,
 	.driver = {
 		.name = "f75375",
 	},
 	.probe = f75375_probe,
 	.remove = f75375_remove,
 	.id_table = f75375_id,
+	.detect = f75375_detect,
+	.address_data = &addr_data,
 };
 
 static inline int f75375_read8(struct i2c_client *client, u8 reg)
@@ -607,22 +600,6 @@ static const struct attribute_group f753
 	.attrs = f75375_attributes,
 };
 
-static int f75375_detach_client(struct i2c_client *client)
-{
-	int err;
-
-	f75375_remove(client);
-	err = i2c_detach_client(client);
-	if (err) {
-		dev_err(&client->dev,
-			"Client deregistration failed, "
-			"client not detached.\n");
-		return err;
-	}
-	kfree(client);
-	return 0;
-}
-
 static void f75375_init(struct i2c_client *client, struct f75375_data *data,
 		struct f75375s_platform_data *f75375s_pdata)
 {
@@ -651,7 +628,6 @@ static int f75375_probe(struct i2c_clien
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
-	data->client = client;
 	mutex_init(&data->update_lock);
 	data->kind = id->driver_data;
 
@@ -700,29 +676,13 @@ static int f75375_remove(struct i2c_clie
 	return 0;
 }
 
-static int f75375_attach_adapter(struct i2c_adapter *adapter)
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int f75375_detect(struct i2c_client *client, int kind,
+			 struct i2c_board_info *info)
 {
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, f75375_detect);
-}
-
-/* This function is called by i2c_probe */
-static int f75375_detect(struct i2c_adapter *adapter, int address, int kind)
-{
-	struct i2c_client *client;
+	struct i2c_adapter *adapter = client->adapter;
 	u8 version = 0;
-	int err = 0;
 	const char *name = "";
-	struct i2c_device_id id;
-
-	if (!(client = kzalloc(sizeof(*client), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto exit;
-	}
-	client->addr = address;
-	client->adapter = adapter;
-	client->driver = &f75375_legacy_driver;
 
 	if (kind < 0) {
 		u16 vendid = f75375_read16(client, F75375_REG_VENDOR);
@@ -736,7 +696,7 @@ static int f75375_detect(struct i2c_adap
 			dev_err(&adapter->dev,
 				"failed,%02X,%02X,%02X\n",
 				chipid, version, vendid);
-			goto exit_free;
+			return -ENODEV;
 		}
 	}
 
@@ -746,43 +706,18 @@ static int f75375_detect(struct i2c_adap
 		name = "f75373";
 	}
 	dev_info(&adapter->dev, "found %s version: %02X\n", name, version);
-	strlcpy(client->name, name, I2C_NAME_SIZE);
-
-	if ((err = i2c_attach_client(client)))
-		goto exit_free;
-
-	strlcpy(id.name, name, I2C_NAME_SIZE);
-	id.driver_data = kind;
-	if ((err = f75375_probe(client, &id)) < 0)
-		goto exit_detach;
+	strlcpy(info->type, name, I2C_NAME_SIZE);
 
 	return 0;
-
-exit_detach:
-	i2c_detach_client(client);
-exit_free:
-	kfree(client);
-exit:
-	return err;
 }
 
 static int __init sensors_f75375_init(void)
 {
-	int status;
-	status = i2c_add_driver(&f75375_driver);
-	if (status)
-		return status;
-
-	status = i2c_add_driver(&f75375_legacy_driver);
-	if (status)
-		i2c_del_driver(&f75375_driver);
-
-	return status;
+	return i2c_add_driver(&f75375_driver);
 }
 
 static void __exit sensors_f75375_exit(void)
 {
-	i2c_del_driver(&f75375_legacy_driver);
 	i2c_del_driver(&f75375_driver);
 }
 

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
