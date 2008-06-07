From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Add detection capability to new-style
 drivers
Date: Sat, 7 Jun 2008 12:05:48 +0200
Message-ID: <20080607120548.679aa14e@hyperion.delvare>
References: <20080606145212.76f95d52@hyperion.delvare>
	<Pine.LNX.4.58.0806061550510.10290@shell4.speakeasy.net>
	<20080607093515.3eecca4c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080607093515.3eecca4c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 7 Jun 2008 09:35:15 +0200, Jean Delvare wrote:
> None of these solutions make me totally happy, but I guess that the
> most reasonable one is the second one (have i2c-core allocate
> i2c_client and pass it to detect callbacks.) Maybe if we document
> properly that the only thing one is allowed to do with this i2c_client
> is call i2c_smbus_read_byte_data() and i2c_smbus_read_word_data(), it's
> acceptable. I welcome comments and ideas on this problem.

Here's what it would look like (patch applies on top of the last series
I posted, for the moment.) That's probably better than my original
proposal. The diffstat clearly shows how it simplifies the detect
callback of each chip driver.

---
 drivers/hwmon/f75375s.c |   24 +++++-----------------
 drivers/hwmon/lm75.c    |   35 ++++++++------------------------
 drivers/hwmon/lm90.c    |   34 +++++++++----------------------
 drivers/i2c/i2c-core.c  |   50 +++++++++++++++++++++++++++++------------------
 include/linux/i2c.h     |    3 --
 5 files changed, 57 insertions(+), 89 deletions(-)

--- linux-2.6.26-rc5.orig/drivers/hwmon/f75375s.c	2008-06-07 10:52:59.000000000 +0200
+++ linux-2.6.26-rc5/drivers/hwmon/f75375s.c	2008-06-07 11:14:47.000000000 +0200
@@ -114,7 +114,7 @@ struct f75375_data {
 	s8 temp_max_hyst[2];
 };
 
-static int f75375_detect(struct i2c_adapter *adapter, int address, int kind,
+static int f75375_detect(struct i2c_client *client, int kind,
 			 struct i2c_board_info *info);
 static int f75375_probe(struct i2c_client *client,
 			const struct i2c_device_id *id);
@@ -679,21 +679,13 @@ static int f75375_remove(struct i2c_clie
 }
 
 /* This function is called by i2c_probe */
-static int f75375_detect(struct i2c_adapter *adapter, int address, int kind,
+static int f75375_detect(struct i2c_client *client, int kind,
 			 struct i2c_board_info *info)
 {
-	struct i2c_client *client;
+	struct i2c_adapter *adapter = client->adapter;
 	u8 version = 0;
-	int err = -ENODEV;
 	const char *name = "";
 
-	if (!(client = kzalloc(sizeof(*client), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto exit;
-	}
-	client->addr = address;
-	client->adapter = adapter;
-
 	if (kind < 0) {
 		u16 vendid = f75375_read16(client, F75375_REG_VENDOR);
 		u16 chipid = f75375_read16(client, F75375_CHIP_ID);
@@ -706,10 +698,9 @@ static int f75375_detect(struct i2c_adap
 			dev_err(&adapter->dev,
 				"failed,%02X,%02X,%02X\n",
 				chipid, version, vendid);
-			goto exit_free;
+			return -ENODEV;
 		}
 	}
-	err = 0;	/* detection OK */
 
 	if (kind == f75375) {
 		name = "f75375";
@@ -718,12 +709,9 @@ static int f75375_detect(struct i2c_adap
 	}
 	dev_info(&adapter->dev, "found %s version: %02X\n", name, version);
 	strlcpy(info->type, name, I2C_NAME_SIZE);
-	info->addr = address;
+	info->addr = client->addr;
 
-exit_free:
-	kfree(client);
-exit:
-	return err;
+	return 0;
 }
 
 static int __init sensors_f75375_init(void)
--- linux-2.6.26-rc5.orig/drivers/hwmon/lm75.c	2008-06-06 20:25:48.000000000 +0200
+++ linux-2.6.26-rc5/drivers/hwmon/lm75.c	2008-06-07 11:20:37.000000000 +0200
@@ -217,28 +217,15 @@ static int lm75_remove(struct i2c_client
 	return 0;
 }
 
-static int lm75_detect(struct i2c_adapter *adapter, int address, int kind,
+static int lm75_detect(struct i2c_client *new_client, int kind,
 		       struct i2c_board_info *info)
 {
+	struct i2c_adapter *adapter = new_client->adapter;
 	int i;
-	struct i2c_client *new_client;
-	int err = -ENODEV;
 
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
+		return -ENODEV;
 
 	/* Now, we do the remaining detection. There is no identification-
 	   dedicated register so we have to rely on several tricks:
@@ -258,37 +245,33 @@ static int lm75_detect(struct i2c_adapte
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
-	err = 0;	/* detection OK */
 
 	/* NOTE: we treat "force=..." and "force_lm75=..." the same.
 	 * Only new-style driver binding distinguishes chip types.
 	 */
 	strlcpy(info->type, "lm75", I2C_NAME_SIZE);
-	info->addr = address;
+	info->addr = new_client->addr;
 
-exit_free:
-	kfree(new_client);
-exit:
-	return err;
+	return 0;
 }
 
 static const struct i2c_device_id lm75_ids[] = {
--- linux-2.6.26-rc5.orig/drivers/hwmon/lm90.c	2008-06-06 20:25:48.000000000 +0200
+++ linux-2.6.26-rc5/drivers/hwmon/lm90.c	2008-06-07 10:33:03.000000000 +0200
@@ -187,8 +187,8 @@ I2C_CLIENT_INSMOD_7(lm90, adm1032, lm99,
  * Functions declaration
  */
 
-static int lm90_detect(struct i2c_adapter *adapter, int address,
-		       int kind, struct i2c_board_info *info);
+static int lm90_detect(struct i2c_client *new_client, int kind,
+		       struct i2c_board_info *info);
 static int lm90_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id);
 static void lm90_init_client(struct i2c_client *client);
@@ -494,25 +494,15 @@ static int lm90_read_reg(struct i2c_clie
 }
 
 /* Returns -ENODEV if no supported device is detected */
-static int lm90_detect(struct i2c_adapter *adapter, int address, int kind,
+static int lm90_detect(struct i2c_client *new_client, int kind,
 		       struct i2c_board_info *info)
 {
-	struct i2c_client *new_client;
-	int err = -ENODEV;
+	struct i2c_adapter *adapter = new_client->adapter;
+	int address = new_client->addr;
 	const char *name = "";
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		goto exit;
-
-	new_client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
-	if (!new_client) {
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	/* Enough to use smbus calls */
-	new_client->addr = address;
-	new_client->adapter = adapter;
+		return -ENODEV;
 
 	/*
 	 * Now we do the remaining detection. A negative kind means that
@@ -540,7 +530,7 @@ static int lm90_detect(struct i2c_adapte
 						LM90_REG_R_CONFIG1)) < 0
 		 || (reg_convrate = i2c_smbus_read_byte_data(new_client,
 						LM90_REG_R_CONVRATE)) < 0)
-			goto exit_free;
+			return -ENODEV;
 		
 		if ((address == 0x4C || address == 0x4D)
 		 && man_id == 0x01) { /* National Semiconductor */
@@ -548,7 +538,7 @@ static int lm90_detect(struct i2c_adapte
 
 			if ((reg_config2 = i2c_smbus_read_byte_data(new_client,
 						LM90_REG_R_CONFIG2)) < 0)
-				goto exit_free;
+				return -ENODEV;
 
 			if ((reg_config1 & 0x2A) == 0x00
 			 && (reg_config2 & 0xF8) == 0x00
@@ -612,10 +602,9 @@ static int lm90_detect(struct i2c_adapte
 			dev_info(&adapter->dev,
 			    "Unsupported chip (man_id=0x%02X, "
 			    "chip_id=0x%02X).\n", man_id, chip_id);
-			goto exit_free;
+			return -ENODEV;
 		}
 	}
-	err = 0;	/* detection OK */
 
 	/* Fill the i2c board info */
 	info->addr = address;
@@ -640,10 +629,7 @@ static int lm90_detect(struct i2c_adapte
 	}
 	strlcpy(info->type, name, I2C_NAME_SIZE);
 
-exit_free:
-	kfree(new_client);
-exit:
-	return err;
+	return 0;
 }
 
 static int lm90_probe(struct i2c_client *new_client,
--- linux-2.6.26-rc5.orig/drivers/i2c/i2c-core.c	2008-06-06 20:25:48.000000000 +0200
+++ linux-2.6.26-rc5/drivers/i2c/i2c-core.c	2008-06-07 10:48:06.000000000 +0200
@@ -1226,11 +1226,12 @@ int i2c_probe(struct i2c_adapter *adapte
 EXPORT_SYMBOL(i2c_probe);
 
 /* Separate detection function for new-style drivers */
-static int i2c_detect_address(struct i2c_adapter *adapter,
-			      int addr, int kind, struct i2c_driver *driver)
+static int i2c_detect_address(struct i2c_client *temp_client, int kind,
+			      struct i2c_driver *driver)
 {
 	struct i2c_board_info info;
-	struct i2c_client *client;
+	struct i2c_adapter *adapter = temp_client->adapter;
+	int addr = temp_client->addr;
 	int err;
 
 	/* Make sure the address is valid */
@@ -1258,7 +1259,7 @@ static int i2c_detect_address(struct i2c
 
 	/* Finally call the custom detection function */
 	memset(&info, 0, sizeof(struct i2c_board_info));
-	err = driver->detect(adapter, addr, kind, &info);
+	err = driver->detect(temp_client, kind, &info);
 	if (err) {
 		/* -ENODEV can be returned if there is a chip at the given address
 		   but it isn't supported by this chip driver. We catch it here as
@@ -1271,6 +1272,8 @@ static int i2c_detect_address(struct i2c
 		dev_err(&adapter->dev, "Detection function returned "
 			"inconsistent data for 0x%x\n", addr);
 	} else {
+		struct i2c_client *client;
+
 		/* Detection succeeded, instantiate the device */
 		dev_dbg(&adapter->dev, "Creating %s at 0x%x\n",
 			info.type, info.addr);
@@ -1283,13 +1286,20 @@ static int i2c_detect_address(struct i2c
 static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver)
 {
 	const struct i2c_client_address_data *address_data;
-	int i, err;
+	struct i2c_client *temp_client;
+	int i, err = 0;
 	int adap_id = i2c_adapter_id(adapter);
 
 	if (!driver->detect)
 		return 0;
 	address_data = driver->address_data;
 
+	/* Set up a temporary client to help detect callback */
+	temp_client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	if (!temp_client)
+		return -ENOMEM;
+	temp_client->adapter = adapter;
+
 	/* Force entries are done first, and are not affected by ignore
 	   entries */
 	if (address_data->forces) {
@@ -1306,11 +1316,11 @@ static int i2c_detect(struct i2c_adapter
 						"addr 0x%02x, kind %d\n",
 						adap_id, forces[kind][i + 1],
 						kind);
-					err = i2c_detect_address(adapter,
-						forces[kind][i + 1],
+					temp_client->addr = forces[kind][i + 1];
+					err = i2c_detect_address(temp_client,
 						kind, driver);
 					if (err)
-						return err;
+						goto exit_free;
 				}
 			}
 		}
@@ -1320,11 +1330,12 @@ static int i2c_detect(struct i2c_adapter
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_QUICK)) {
 		if (address_data->probe[0] == I2C_CLIENT_END
 		 && address_data->normal_i2c[0] == I2C_CLIENT_END)
-			return 0;
+			goto exit_free;
 
 		dev_warn(&adapter->dev, "SMBus Quick command not supported, "
 			 "can't probe for chips\n");
-		return -EOPNOTSUPP;
+		err = -EOPNOTSUPP;
+		goto exit_free;
 	}
 
 	/* Probe entries are done second, and are not affected by ignore
@@ -1335,17 +1346,16 @@ static int i2c_detect(struct i2c_adapter
 			dev_dbg(&adapter->dev, "found probe parameter for "
 				"adapter %d, addr 0x%02x\n", adap_id,
 				address_data->probe[i + 1]);
-			err = i2c_detect_address(adapter,
-						 address_data->probe[i + 1],
-						 -1, driver);
+			temp_client->addr = address_data->probe[i + 1];
+			err = i2c_detect_address(temp_client, -1, driver);
 			if (err)
-				return err;
+				goto exit_free;
 		}
 	}
 
 	/* Stop here if the classes do not match */
 	if (!(adapter->class & driver->class))
-		return 0;
+		goto exit_free;
 
 	/* Normal entries are done last, unless shadowed by an ignore entry */
 	for (i = 0; address_data->normal_i2c[i] != I2C_CLIENT_END; i += 1) {
@@ -1372,13 +1382,15 @@ static int i2c_detect(struct i2c_adapter
 		dev_dbg(&adapter->dev, "found normal entry for adapter %d, "
 			"addr 0x%02x\n", adap_id,
 			address_data->normal_i2c[i]);
-		err = i2c_detect_address(adapter, address_data->normal_i2c[i],
-					 -1, driver);
+		temp_client->addr = address_data->normal_i2c[i];
+		err = i2c_detect_address(temp_client, -1, driver);
 		if (err)
-			return err;
+			goto exit_free;
 	}
 
-	return 0;
+ exit_free:
+	kfree(temp_client);
+	return err;
 }
 
 struct i2c_client *
--- linux-2.6.26-rc5.orig/include/linux/i2c.h	2008-06-06 20:25:48.000000000 +0200
+++ linux-2.6.26-rc5/include/linux/i2c.h	2008-06-07 09:48:04.000000000 +0200
@@ -148,8 +148,7 @@ struct i2c_driver {
 	const struct i2c_device_id *id_table;
 
 	/* Device detection callback for automatic device creation */
-	int (*detect)(struct i2c_adapter *, int address, int kind,
-		      struct i2c_board_info *);
+	int (*detect)(struct i2c_client *, int kind, struct i2c_board_info *);
 	const struct i2c_client_address_data *address_data;
 	struct list_head clients;
 };


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
