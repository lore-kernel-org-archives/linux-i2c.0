From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 5/5] i2c: Convert the eeprom driver to a new-style i2c
 driver
Date: Mon, 16 Jun 2008 22:23:28 +0200
Message-ID: <20080616222328.526402b8@hyperion.delvare>
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

The new-style eeprom driver implements the optional detect() callback
to cover the use cases of the legacy driver.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
Depends on at least the following patches:
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-03-eeprom-should-not-probe-all-adapters.patch
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-eeprom-use-word-read-transactions.patch
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-clean-up-old-chip-drivers.patch

 drivers/i2c/chips/eeprom.c |   82 ++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 44 deletions(-)

--- linux-2.6.26-rc6.orig/drivers/i2c/chips/eeprom.c	2008-06-16 20:28:46.000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/chips/eeprom.c	2008-06-16 21:02:13.000000000 +0200
@@ -51,7 +51,6 @@ enum eeprom_nature {
 
 /* Each client has this additional data */
 struct eeprom_data {
-	struct i2c_client client;
 	struct mutex update_lock;
 	u8 valid;			/* bitfield, bit!=0 if slice is valid */
 	unsigned long last_updated[8];	/* In jiffies, 8 slices */
@@ -60,17 +59,28 @@ struct eeprom_data {
 };
 
 
-static int eeprom_attach_adapter(struct i2c_adapter *adapter);
-static int eeprom_detect(struct i2c_adapter *adapter, int address, int kind);
-static int eeprom_detach_client(struct i2c_client *client);
+static int eeprom_probe(struct i2c_client *client,
+			const struct i2c_device_id *id);
+static int eeprom_detect(struct i2c_client *client, int kind,
+			 struct i2c_board_info *info);
+static int eeprom_remove(struct i2c_client *client);
+
+static struct i2c_device_id eeprom_id[] = {
+	{ "eeprom", 0 },
+	{ }
+};
 
 /* This is the driver that will be inserted */
 static struct i2c_driver eeprom_driver = {
+	.class		= I2C_CLASS_DDC | I2C_CLASS_SPD,
 	.driver = {
 		.name	= "eeprom",
 	},
-	.attach_adapter	= eeprom_attach_adapter,
-	.detach_client	= eeprom_detach_client,
+	.probe		= eeprom_probe,
+	.remove		= eeprom_remove,
+	.detect		= eeprom_detect,
+	.id_table	= eeprom_id,
+	.address_data	= &addr_data,
 };
 
 static void eeprom_update_client(struct i2c_client *client, u8 slice)
@@ -152,25 +162,17 @@ static struct bin_attribute eeprom_attr 
 	.read = eeprom_read,
 };
 
-static int eeprom_attach_adapter(struct i2c_adapter *adapter)
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int eeprom_detect(struct i2c_client *client, int kind,
+			 struct i2c_board_info *info)
 {
-	if (!(adapter->class & (I2C_CLASS_DDC | I2C_CLASS_SPD)))
-		return 0;
-	return i2c_probe(adapter, &addr_data, eeprom_detect);
-}
-
-/* This function is called by i2c_probe */
-static int eeprom_detect(struct i2c_adapter *adapter, int address, int kind)
-{
-	struct i2c_client *client;
-	struct eeprom_data *data;
-	int err = 0;
+	struct i2c_adapter *adapter = client->adapter;
 
 	/* EDID EEPROMs are often 24C00 EEPROMs, which answer to all
 	   addresses 0x50-0x57, but we only care about 0x50. So decline
 	   attaching to addresses >= 0x51 on DDC buses */
-	if (!(adapter->class & I2C_CLASS_SPD) && address >= 0x51)
-		goto exit;
+	if (!(adapter->class & I2C_CLASS_SPD) && client->addr >= 0x51)
+		return -ENODEV;
 
 	/* There are four ways we can read the EEPROM data:
 	   (1) I2C block reads (faster, but unsupported by most adapters)
@@ -181,32 +183,33 @@ static int eeprom_detect(struct i2c_adap
 	   because all known adapters support one of the first two. */
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_WORD_DATA)
 	 && !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK))
-		goto exit;
+		return -ENODEV;
+
+	strlcpy(info->type, "eeprom", I2C_NAME_SIZE);
+
+	return 0;
+}
+
+static int eeprom_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	struct eeprom_data *data;
+	int err;
 
 	if (!(data = kzalloc(sizeof(struct eeprom_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
 
-	client = &data->client;
 	memset(data->data, 0xff, EEPROM_SIZE);
 	i2c_set_clientdata(client, data);
-	client->addr = address;
-	client->adapter = adapter;
-	client->driver = &eeprom_driver;
-
-	/* Fill in the remaining client fields */
-	strlcpy(client->name, "eeprom", I2C_NAME_SIZE);
 	mutex_init(&data->update_lock);
 	data->nature = UNKNOWN;
 
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(client)))
-		goto exit_kfree;
-
 	/* Detect the Vaio nature of EEPROMs.
 	   We use the "PCG-" or "VGN-" prefix as the signature. */
-	if (address == 0x57
+	if (client->addr == 0x57
 	 && i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
 		char name[4];
 
@@ -225,28 +228,19 @@ static int eeprom_detect(struct i2c_adap
 	/* create the sysfs eeprom file */
 	err = sysfs_create_bin_file(&client->dev.kobj, &eeprom_attr);
 	if (err)
-		goto exit_detach;
+		goto exit_kfree;
 
 	return 0;
 
-exit_detach:
-	i2c_detach_client(client);
 exit_kfree:
 	kfree(data);
 exit:
 	return err;
 }
 
-static int eeprom_detach_client(struct i2c_client *client)
+static int eeprom_remove(struct i2c_client *client)
 {
-	int err;
-
 	sysfs_remove_bin_file(&client->dev.kobj, &eeprom_attr);
-
-	err = i2c_detach_client(client);
-	if (err)
-		return err;
-
 	kfree(i2c_get_clientdata(client));
 
 	return 0;

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
