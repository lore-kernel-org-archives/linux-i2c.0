From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Clean up old chip drivers
Date: Mon, 16 Jun 2008 20:36:06 +0200
Message-ID: <20080616203606.3379b192@hyperion.delvare>
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
List-Id: linux-i2c@vger.kernel.org

Clean up old i2c chip drivers:
* Name the i2c_client "client" instead of "new_client".
* Drop useless initializations to 0.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/chips/eeprom.c  |   32 +++++++++++++++-----------------
 drivers/i2c/chips/max6875.c |    4 +---
 drivers/i2c/chips/pca9539.c |   25 ++++++++++++-------------
 drivers/i2c/chips/pcf8574.c |   23 +++++++++++------------
 drivers/i2c/chips/pcf8591.c |   31 +++++++++++++++----------------
 5 files changed, 54 insertions(+), 61 deletions(-)

--- linux-2.6.26-rc6.orig/drivers/i2c/chips/eeprom.c	2008-06-16 20:28:22.000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/chips/eeprom.c	2008-06-16 20:28:46.000000000 +0200
@@ -162,7 +162,7 @@ static int eeprom_attach_adapter(struct 
 /* This function is called by i2c_probe */
 static int eeprom_detect(struct i2c_adapter *adapter, int address, int kind)
 {
-	struct i2c_client *new_client;
+	struct i2c_client *client;
 	struct eeprom_data *data;
 	int err = 0;
 
@@ -188,22 +188,20 @@ static int eeprom_detect(struct i2c_adap
 		goto exit;
 	}
 
-	new_client = &data->client;
+	client = &data->client;
 	memset(data->data, 0xff, EEPROM_SIZE);
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &eeprom_driver;
-	new_client->flags = 0;
+	i2c_set_clientdata(client, data);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &eeprom_driver;
 
 	/* Fill in the remaining client fields */
-	strlcpy(new_client->name, "eeprom", I2C_NAME_SIZE);
-	data->valid = 0;
+	strlcpy(client->name, "eeprom", I2C_NAME_SIZE);
 	mutex_init(&data->update_lock);
 	data->nature = UNKNOWN;
 
 	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
+	if ((err = i2c_attach_client(client)))
 		goto exit_kfree;
 
 	/* Detect the Vaio nature of EEPROMs.
@@ -212,27 +210,27 @@ static int eeprom_detect(struct i2c_adap
 	 && i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
 		char name[4];
 
-		name[0] = i2c_smbus_read_byte_data(new_client, 0x80);
-		name[1] = i2c_smbus_read_byte_data(new_client, 0x81);
-		name[2] = i2c_smbus_read_byte_data(new_client, 0x82);
-		name[3] = i2c_smbus_read_byte_data(new_client, 0x83);
+		name[0] = i2c_smbus_read_byte_data(client, 0x80);
+		name[1] = i2c_smbus_read_byte_data(client, 0x81);
+		name[2] = i2c_smbus_read_byte_data(client, 0x82);
+		name[3] = i2c_smbus_read_byte_data(client, 0x83);
 
 		if (!memcmp(name, "PCG-", 4) || !memcmp(name, "VGN-", 4)) {
-			dev_info(&new_client->dev, "Vaio EEPROM detected, "
+			dev_info(&client->dev, "Vaio EEPROM detected, "
 				 "enabling privacy protection\n");
 			data->nature = VAIO;
 		}
 	}
 
 	/* create the sysfs eeprom file */
-	err = sysfs_create_bin_file(&new_client->dev.kobj, &eeprom_attr);
+	err = sysfs_create_bin_file(&client->dev.kobj, &eeprom_attr);
 	if (err)
 		goto exit_detach;
 
 	return 0;
 
 exit_detach:
-	i2c_detach_client(new_client);
+	i2c_detach_client(client);
 exit_kfree:
 	kfree(data);
 exit:
--- linux-2.6.26-rc6.orig/drivers/i2c/chips/max6875.c	2008-06-16 20:28:22.000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/chips/max6875.c	2008-06-16 20:28:46.000000000 +0200
@@ -170,7 +170,7 @@ static int max6875_detect(struct i2c_ada
 	struct i2c_client *real_client;
 	struct i2c_client *fake_client;
 	struct max6875_data *data;
-	int err = 0;
+	int err;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WRITE_BYTE_DATA
 				     | I2C_FUNC_SMBUS_READ_BYTE))
@@ -195,7 +195,6 @@ static int max6875_detect(struct i2c_ada
 	real_client->addr = address;
 	real_client->adapter = adapter;
 	real_client->driver = &max6875_driver;
-	real_client->flags = 0;
 	strlcpy(real_client->name, "max6875", I2C_NAME_SIZE);
 	mutex_init(&data->update_lock);
 
@@ -204,7 +203,6 @@ static int max6875_detect(struct i2c_ada
 	fake_client->addr = address | 1;
 	fake_client->adapter = adapter;
 	fake_client->driver = &max6875_driver;
-	fake_client->flags = 0;
 	strlcpy(fake_client->name, "max6875 subclient", I2C_NAME_SIZE);
 
 	if ((err = i2c_attach_client(real_client)) != 0)
--- linux-2.6.26-rc6.orig/drivers/i2c/chips/pca9539.c	2008-06-16 20:28:22.000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/chips/pca9539.c	2008-06-16 20:28:46.000000000 +0200
@@ -113,7 +113,7 @@ static int pca9539_attach_adapter(struct
 /* This function is called by i2c_probe */
 static int pca9539_detect(struct i2c_adapter *adapter, int address, int kind)
 {
-	struct i2c_client *new_client;
+	struct i2c_client *client;
 	struct pca9539_data *data;
 	int err = 0;
 
@@ -127,29 +127,28 @@ static int pca9539_detect(struct i2c_ada
 		goto exit;
 	}
 
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &pca9539_driver;
-	new_client->flags = 0;
+	client = &data->client;
+	i2c_set_clientdata(client, data);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &pca9539_driver;
 
 	if (kind < 0) {
 		/* Detection: the pca9539 only has 8 registers (0-7).
 		   A read of 7 should succeed, but a read of 8 should fail. */
-		if ((i2c_smbus_read_byte_data(new_client, 7) < 0) ||
-		    (i2c_smbus_read_byte_data(new_client, 8) >= 0))
+		if ((i2c_smbus_read_byte_data(client, 7) < 0) ||
+		    (i2c_smbus_read_byte_data(client, 8) >= 0))
 			goto exit_kfree;
 	}
 
-	strlcpy(new_client->name, "pca9539", I2C_NAME_SIZE);
+	strlcpy(client->name, "pca9539", I2C_NAME_SIZE);
 
 	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
+	if ((err = i2c_attach_client(client)))
 		goto exit_kfree;
 
 	/* Register sysfs hooks */
-	err = sysfs_create_group(&new_client->dev.kobj,
+	err = sysfs_create_group(&client->dev.kobj,
 				 &pca9539_defattr_group);
 	if (err)
 		goto exit_detach;
@@ -157,7 +156,7 @@ static int pca9539_detect(struct i2c_ada
 	return 0;
 
 exit_detach:
-	i2c_detach_client(new_client);
+	i2c_detach_client(client);
 exit_kfree:
 	kfree(data);
 exit:
--- linux-2.6.26-rc6.orig/drivers/i2c/chips/pcf8574.c	2008-06-16 20:28:22.000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/chips/pcf8574.c	2008-06-16 20:28:46.000000000 +0200
@@ -127,7 +127,7 @@ static int pcf8574_attach_adapter(struct
 /* This function is called by i2c_probe */
 static int pcf8574_detect(struct i2c_adapter *adapter, int address, int kind)
 {
-	struct i2c_client *new_client;
+	struct i2c_client *client;
 	struct pcf8574_data *data;
 	int err = 0;
 	const char *client_name = "";
@@ -142,12 +142,11 @@ static int pcf8574_detect(struct i2c_ada
 		goto exit;
 	}
 
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &pcf8574_driver;
-	new_client->flags = 0;
+	client = &data->client;
+	i2c_set_clientdata(client, data);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &pcf8574_driver;
 
 	/* Now, we would do the remaining detection. But the PCF8574 is plainly
 	   impossible to detect! Stupid chip. */
@@ -166,23 +165,23 @@ static int pcf8574_detect(struct i2c_ada
 		client_name = "pcf8574";
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
+	strlcpy(client->name, client_name, I2C_NAME_SIZE);
 
 	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
+	if ((err = i2c_attach_client(client)))
 		goto exit_free;
 	
 	/* Initialize the PCF8574 chip */
-	pcf8574_init_client(new_client);
+	pcf8574_init_client(client);
 
 	/* Register sysfs hooks */
-	err = sysfs_create_group(&new_client->dev.kobj, &pcf8574_attr_group);
+	err = sysfs_create_group(&client->dev.kobj, &pcf8574_attr_group);
 	if (err)
 		goto exit_detach;
 	return 0;
 
       exit_detach:
-	i2c_detach_client(new_client);
+	i2c_detach_client(client);
       exit_free:
 	kfree(data);
       exit:
--- linux-2.6.26-rc6.orig/drivers/i2c/chips/pcf8591.c	2008-06-16 20:28:22.000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/chips/pcf8591.c	2008-06-16 20:28:46.000000000 +0200
@@ -188,7 +188,7 @@ static int pcf8591_attach_adapter(struct
 /* This function is called by i2c_probe */
 static int pcf8591_detect(struct i2c_adapter *adapter, int address, int kind)
 {
-	struct i2c_client *new_client;
+	struct i2c_client *client;
 	struct pcf8591_data *data;
 	int err = 0;
 
@@ -203,12 +203,11 @@ static int pcf8591_detect(struct i2c_ada
 		goto exit;
 	}
 	
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &pcf8591_driver;
-	new_client->flags = 0;
+	client = &data->client;
+	i2c_set_clientdata(client, data);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &pcf8591_driver;
 
 	/* Now, we would do the remaining detection. But the PCF8591 is plainly
 	   impossible to detect! Stupid chip. */
@@ -219,31 +218,31 @@ static int pcf8591_detect(struct i2c_ada
 
 	/* Fill in the remaining client fields and put it into the global 
 	   list */
-	strlcpy(new_client->name, "pcf8591", I2C_NAME_SIZE);
+	strlcpy(client->name, "pcf8591", I2C_NAME_SIZE);
 	mutex_init(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
+	if ((err = i2c_attach_client(client)))
 		goto exit_kfree;
 
 	/* Initialize the PCF8591 chip */
-	pcf8591_init_client(new_client);
+	pcf8591_init_client(client);
 
 	/* Register sysfs hooks */
-	err = sysfs_create_group(&new_client->dev.kobj, &pcf8591_attr_group);
+	err = sysfs_create_group(&client->dev.kobj, &pcf8591_attr_group);
 	if (err)
 		goto exit_detach;
 
 	/* Register input2 if not in "two differential inputs" mode */
 	if (input_mode != 3) {
-		if ((err = device_create_file(&new_client->dev,
+		if ((err = device_create_file(&client->dev,
 					      &dev_attr_in2_input)))
 			goto exit_sysfs_remove;
 	}
 
 	/* Register input3 only in "four single ended inputs" mode */
 	if (input_mode == 0) {
-		if ((err = device_create_file(&new_client->dev,
+		if ((err = device_create_file(&client->dev,
 					      &dev_attr_in3_input)))
 			goto exit_sysfs_remove;
 	}
@@ -251,10 +250,10 @@ static int pcf8591_detect(struct i2c_ada
 	return 0;
 
 exit_sysfs_remove:
-	sysfs_remove_group(&new_client->dev.kobj, &pcf8591_attr_group_opt);
-	sysfs_remove_group(&new_client->dev.kobj, &pcf8591_attr_group);
+	sysfs_remove_group(&client->dev.kobj, &pcf8591_attr_group_opt);
+	sysfs_remove_group(&client->dev.kobj, &pcf8591_attr_group);
 exit_detach:
-	i2c_detach_client(new_client);
+	i2c_detach_client(client);
 exit_kfree:
 	kfree(data);
 exit:


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
