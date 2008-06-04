From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/4] i2c: Use i2c_listener in driver f75375s
Date: Wed, 4 Jun 2008 20:33:22 +0200
Message-ID: <20080604203322.472f8653@hyperion.delvare>
References: <20080604201334.19636f30@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080604201334.19636f30-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

Replace the legacy f75375s i2c_driver by an i2c_listener.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
Riku, any chance you could test this one? Thanks.

 drivers/hwmon/f75375s.c |   67 +++++++++--------------------------------------
 1 file changed, 14 insertions(+), 53 deletions(-)

--- linux-2.6.26-rc4.orig/drivers/hwmon/f75375s.c	2008-05-04 09:49:47.000000000 +0200
+++ linux-2.6.26-rc4/drivers/hwmon/f75375s.c	2008-06-04 11:32:22.000000000 +0200
@@ -114,19 +114,16 @@ struct f75375_data {
 	s8 temp_max_hyst[2];
 };
 
-static int f75375_attach_adapter(struct i2c_adapter *adapter);
-static int f75375_detect(struct i2c_adapter *adapter, int address, int kind);
-static int f75375_detach_client(struct i2c_client *client);
+static int f75375_detect(struct i2c_adapter *adapter, int address, int kind,
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
+static struct i2c_listener f75375_listener = {
+	.class		= I2C_CLASS_HWMON,
+	.address_data	= &addr_data,
+	.detect		= f75375_detect,
 };
 
 static const struct i2c_device_id f75375_id[] = {
@@ -607,22 +604,6 @@ static const struct attribute_group f753
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
@@ -700,21 +681,14 @@ static int f75375_remove(struct i2c_clie
 	return 0;
 }
 
-static int f75375_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, f75375_detect);
-}
-
 /* This function is called by i2c_probe */
-static int f75375_detect(struct i2c_adapter *adapter, int address, int kind)
+static int f75375_detect(struct i2c_adapter *adapter, int address, int kind,
+			 struct i2c_board_info *info)
 {
 	struct i2c_client *client;
 	u8 version = 0;
-	int err = 0;
+	int err = -ENODEV;
 	const char *name = "";
-	struct i2c_device_id id;
 
 	if (!(client = kzalloc(sizeof(*client), GFP_KERNEL))) {
 		err = -ENOMEM;
@@ -722,7 +696,6 @@ static int f75375_detect(struct i2c_adap
 	}
 	client->addr = address;
 	client->adapter = adapter;
-	client->driver = &f75375_legacy_driver;
 
 	if (kind < 0) {
 		u16 vendid = f75375_read16(client, F75375_REG_VENDOR);
@@ -739,6 +712,7 @@ static int f75375_detect(struct i2c_adap
 			goto exit_free;
 		}
 	}
+	err = 0;	/* detection OK */
 
 	if (kind == f75375) {
 		name = "f75375";
@@ -746,20 +720,9 @@ static int f75375_detect(struct i2c_adap
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
+	info->addr = address;
 
-	return 0;
-
-exit_detach:
-	i2c_detach_client(client);
 exit_free:
 	kfree(client);
 exit:
@@ -773,16 +736,14 @@ static int __init sensors_f75375_init(vo
 	if (status)
 		return status;
 
-	status = i2c_add_driver(&f75375_legacy_driver);
-	if (status)
-		i2c_del_driver(&f75375_driver);
+	i2c_add_listener(&f75375_listener);
 
 	return status;
 }
 
 static void __exit sensors_f75375_exit(void)
 {
-	i2c_del_driver(&f75375_legacy_driver);
+	i2c_del_listener(&f75375_listener);
 	i2c_del_driver(&f75375_driver);
 }
 

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
