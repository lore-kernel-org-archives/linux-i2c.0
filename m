From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/5] i2c: Drop I2C_CLIENT_INSMOD_1
Date: Thu, 10 Dec 2009 18:55:18 +0100
Message-ID: <20091210185518.3ecbde69@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This macros simply declares an enum, so drivers might as well declare
it themselves.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/hwmon/adm1026.c      |    5 +----
 drivers/hwmon/adm1029.c      |    8 +-------
 drivers/hwmon/ads7828.c      |    7 ++-----
 drivers/hwmon/adt7462.c      |    5 +----
 drivers/hwmon/adt7470.c      |    5 +----
 drivers/hwmon/adt7473.c      |    5 +----
 drivers/hwmon/asb100.c       |    5 +----
 drivers/hwmon/atxp1.c        |    4 +---
 drivers/hwmon/ds1621.c       |    5 ++---
 drivers/hwmon/gl520sm.c      |    5 +----
 drivers/hwmon/lm63.c         |    8 +-------
 drivers/hwmon/lm73.c         |    5 +----
 drivers/hwmon/lm75.c         |   10 ++--------
 drivers/hwmon/lm77.c         |    5 +----
 drivers/hwmon/lm80.c         |    5 +----
 drivers/hwmon/lm92.c         |    5 +----
 drivers/hwmon/lm93.c         |    3 +--
 drivers/hwmon/lm95241.c      |    5 +----
 drivers/hwmon/max1619.c      |    8 +-------
 drivers/hwmon/max6650.c      |    4 +---
 drivers/hwmon/pcf8591.c      |    1 -
 drivers/hwmon/smsc47m192.c   |    5 +----
 drivers/hwmon/w83791d.c      |    3 +--
 drivers/hwmon/w83792d.c      |    3 +--
 drivers/hwmon/w83793.c       |    3 +--
 drivers/hwmon/w83l785ts.c    |    8 +-------
 drivers/hwmon/w83l786ng.c    |    3 +--
 drivers/misc/eeprom/eeprom.c |    3 ---
 drivers/misc/ics932s401.c    |    5 +----
 include/linux/i2c.h          |    5 -----
 30 files changed, 30 insertions(+), 121 deletions(-)

--- linux-2.6.33-rc0.orig/drivers/hwmon/adm1026.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adm1026.c	2009-12-10 16:36:53.000000000 +0100
@@ -37,9 +37,6 @@
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(adm1026);
-
 static int gpio_input[17] = { -1, -1, -1, -1, -1, -1, -1, -1, -1,
 				-1, -1, -1, -1, -1, -1, -1, -1 };
 static int gpio_output[17] = { -1, -1, -1, -1, -1, -1, -1, -1, -1,
@@ -305,7 +302,7 @@ static void adm1026_init_client(struct i
 
 
 static const struct i2c_device_id adm1026_id[] = {
-	{ "adm1026", adm1026 },
+	{ "adm1026", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adm1026_id);
--- linux-2.6.33-rc0.orig/drivers/hwmon/adm1029.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adm1029.c	2009-12-10 16:36:53.000000000 +0100
@@ -44,12 +44,6 @@ static const unsigned short normal_i2c[]
 };
 
 /*
- * Insmod parameters
- */
-
-I2C_CLIENT_INSMOD_1(adm1029);
-
-/*
  * The ADM1029 registers
  * Manufacturer ID is 0x41 for Analog Devices
  */
@@ -128,7 +122,7 @@ static int adm1029_init_client(struct i2
  */
 
 static const struct i2c_device_id adm1029_id[] = {
-	{ "adm1029", adm1029 },
+	{ "adm1029", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adm1029_id);
--- linux-2.6.33-rc0.orig/drivers/hwmon/ads7828.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/ads7828.c	2009-12-10 16:36:53.000000000 +0100
@@ -47,10 +47,7 @@
 static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
 	I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(ads7828);
-
-/* Other module parameters */
+/* Module parameters */
 static int se_input = 1; /* Default is SE, 0 == diff */
 static int int_vref = 1; /* Default is internal ref ON */
 static int vref_mv = ADS7828_INT_VREF_MV; /* set if vref != 2.5V */
@@ -168,7 +165,7 @@ static int ads7828_remove(struct i2c_cli
 }
 
 static const struct i2c_device_id ads7828_id[] = {
-	{ "ads7828", ads7828 },
+	{ "ads7828", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ads7828_id);
--- linux-2.6.33-rc0.orig/drivers/hwmon/adt7462.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adt7462.c	2009-12-10 16:36:53.000000000 +0100
@@ -32,9 +32,6 @@
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x58, 0x5C, I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(adt7462);
-
 /* ADT7462 registers */
 #define ADT7462_REG_DEVICE			0x3D
 #define ADT7462_REG_VENDOR			0x3E
@@ -242,7 +239,7 @@ static int adt7462_detect(struct i2c_cli
 static int adt7462_remove(struct i2c_client *client);
 
 static const struct i2c_device_id adt7462_id[] = {
-	{ "adt7462", adt7462 },
+	{ "adt7462", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adt7462_id);
--- linux-2.6.33-rc0.orig/drivers/hwmon/adt7470.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adt7470.c	2009-12-10 16:36:53.000000000 +0100
@@ -33,9 +33,6 @@
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(adt7470);
-
 /* ADT7470 registers */
 #define ADT7470_REG_BASE_ADDR			0x20
 #define ADT7470_REG_TEMP_BASE_ADDR		0x20
@@ -182,7 +179,7 @@ static int adt7470_detect(struct i2c_cli
 static int adt7470_remove(struct i2c_client *client);
 
 static const struct i2c_device_id adt7470_id[] = {
-	{ "adt7470", adt7470 },
+	{ "adt7470", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adt7470_id);
--- linux-2.6.33-rc0.orig/drivers/hwmon/adt7473.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adt7473.c	2009-12-10 16:36:53.000000000 +0100
@@ -32,9 +32,6 @@
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2C, 0x2D, 0x2E, I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(adt7473);
-
 /* ADT7473 registers */
 #define ADT7473_REG_BASE_ADDR			0x20
 
@@ -171,7 +168,7 @@ static int adt7473_detect(struct i2c_cli
 static int adt7473_remove(struct i2c_client *client);
 
 static const struct i2c_device_id adt7473_id[] = {
-	{ "adt7473", adt7473 },
+	{ "adt7473", 0 },
 	{ }
 };
 
--- linux-2.6.33-rc0.orig/drivers/hwmon/asb100.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/asb100.c	2009-12-10 16:36:53.000000000 +0100
@@ -51,9 +51,6 @@
 /* I2C addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2d, I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(asb100);
-
 static unsigned short force_subclients[4];
 module_param_array(force_subclients, short, NULL, 0);
 MODULE_PARM_DESC(force_subclients, "List of subclient addresses: "
@@ -216,7 +213,7 @@ static struct asb100_data *asb100_update
 static void asb100_init_client(struct i2c_client *client);
 
 static const struct i2c_device_id asb100_id[] = {
-	{ "asb100", asb100 },
+	{ "asb100", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, asb100_id);
--- linux-2.6.33-rc0.orig/drivers/hwmon/atxp1.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/atxp1.c	2009-12-10 16:36:53.000000000 +0100
@@ -44,8 +44,6 @@ MODULE_AUTHOR("Sebastian Witt <se.witt@g
 
 static const unsigned short normal_i2c[] = { 0x37, 0x4e, I2C_CLIENT_END };
 
-I2C_CLIENT_INSMOD_1(atxp1);
-
 static int atxp1_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id);
 static int atxp1_remove(struct i2c_client *client);
@@ -53,7 +51,7 @@ static struct atxp1_data * atxp1_update_
 static int atxp1_detect(struct i2c_client *client, struct i2c_board_info *info);
 
 static const struct i2c_device_id atxp1_id[] = {
-	{ "atxp1", atxp1 },
+	{ "atxp1", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, atxp1_id);
--- linux-2.6.33-rc0.orig/drivers/hwmon/ds1621.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/ds1621.c	2009-12-10 16:36:53.000000000 +0100
@@ -38,7 +38,6 @@ static const unsigned short normal_i2c[]
 					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
 /* Insmod parameters */
-I2C_CLIENT_INSMOD_1(ds1621);
 static int polarity = -1;
 module_param(polarity, int, 0);
 MODULE_PARM_DESC(polarity, "Output's polarity: 0 = active high, 1 = active low");
@@ -305,8 +304,8 @@ static int ds1621_remove(struct i2c_clie
 }
 
 static const struct i2c_device_id ds1621_id[] = {
-	{ "ds1621", ds1621 },
-	{ "ds1625", ds1621 },
+	{ "ds1621", 0 },
+	{ "ds1625", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ds1621_id);
--- linux-2.6.33-rc0.orig/drivers/hwmon/gl520sm.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/gl520sm.c	2009-12-10 16:36:53.000000000 +0100
@@ -41,9 +41,6 @@ MODULE_PARM_DESC(extra_sensor_type, "Typ
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(gl520sm);
-
 /* Many GL520 constants specified below
 One of the inputs can be configured as either temp or voltage.
 That's why _TEMP2 and _IN4 access the same register
@@ -90,7 +87,7 @@ static struct gl520_data *gl520_update_d
 
 /* Driver data */
 static const struct i2c_device_id gl520_id[] = {
-	{ "gl520sm", gl520sm },
+	{ "gl520sm", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, gl520_id);
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm63.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm63.c	2009-12-10 16:36:53.000000000 +0100
@@ -56,12 +56,6 @@
 static const unsigned short normal_i2c[] = { 0x4c, I2C_CLIENT_END };
 
 /*
- * Insmod parameters
- */
-
-I2C_CLIENT_INSMOD_1(lm63);
-
-/*
  * The LM63 registers
  */
 
@@ -142,7 +136,7 @@ static void lm63_init_client(struct i2c_
  */
 
 static const struct i2c_device_id lm63_id[] = {
-	{ "lm63", lm63 },
+	{ "lm63", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm63_id);
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm73.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm73.c	2009-12-10 16:36:53.000000000 +0100
@@ -27,9 +27,6 @@
 static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4c,
 					0x4d, 0x4e, I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(lm73);
-
 /* LM73 registers */
 #define LM73_REG_INPUT		0x00
 #define LM73_REG_CONF		0x01
@@ -145,7 +142,7 @@ static int lm73_remove(struct i2c_client
 }
 
 static const struct i2c_device_id lm73_ids[] = {
-	{ "lm73", lm73 },
+	{ "lm73", 0 },
 	{ /* LIST END */ }
 };
 MODULE_DEVICE_TABLE(i2c, lm73_ids);
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm75.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm75.c	2009-12-10 17:26:43.000000000 +0100
@@ -32,15 +32,12 @@
 
 /*
  * This driver handles the LM75 and compatible digital temperature sensors.
- * Only types which are _not_ listed in I2C_CLIENT_INSMOD_*() need to be
- * listed here.  We start at 9 since I2C_CLIENT_INSMOD_*() currently allow
- * definition of up to 8 chip types (plus zero).
  */
 
 enum lm75_type {		/* keep sorted in alphabetical order */
-	ds1775 = 9,
+	ds1775,
 	ds75,
-	/* lm75 -- in I2C_CLIENT_INSMOD_1() */
+	lm75,
 	lm75a,
 	max6625,
 	max6626,
@@ -58,9 +55,6 @@ enum lm75_type {		/* keep sorted in alph
 static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
 					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(lm75);
-
 
 /* The LM75 registers */
 #define LM75_REG_CONF		0x01
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm77.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm77.c	2009-12-10 16:36:53.000000000 +0100
@@ -39,9 +39,6 @@
 static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
 						I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(lm77);
-
 /* The LM77 registers */
 #define LM77_REG_TEMP		0x00
 #define LM77_REG_CONF		0x01
@@ -76,7 +73,7 @@ static struct lm77_data *lm77_update_dev
 
 
 static const struct i2c_device_id lm77_id[] = {
-	{ "lm77", lm77 },
+	{ "lm77", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm77_id);
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm80.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm80.c	2009-12-10 16:36:53.000000000 +0100
@@ -35,9 +35,6 @@
 static const unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
 						0x2e, 0x2f, I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(lm80);
-
 /* Many LM80 constants specified below */
 
 /* The LM80 registers */
@@ -145,7 +142,7 @@ static int lm80_write_value(struct i2c_c
  */
 
 static const struct i2c_device_id lm80_id[] = {
-	{ "lm80", lm80 },
+	{ "lm80", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm80_id);
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm92.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm92.c	2009-12-10 16:36:53.000000000 +0100
@@ -54,9 +54,6 @@
 static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
 						I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(lm92);
-
 /* The LM92 registers */
 #define LM92_REG_CONFIG			0x01 /* 8-bit, RW */
 #define LM92_REG_TEMP			0x00 /* 16-bit, RO */
@@ -401,7 +398,7 @@ static int lm92_remove(struct i2c_client
  */
 
 static const struct i2c_device_id lm92_id[] = {
-	{ "lm92", lm92 },
+	{ "lm92", 0 },
 	/* max6635 could be added here */
 	{ }
 };
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm93.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm93.c	2009-12-10 16:36:53.000000000 +0100
@@ -145,7 +145,6 @@
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
 /* Insmod parameters */
-I2C_CLIENT_INSMOD_1(lm93);
 
 static int disable_block;
 module_param(disable_block, bool, 0);
@@ -2602,7 +2601,7 @@ static int lm93_remove(struct i2c_client
 }
 
 static const struct i2c_device_id lm93_id[] = {
-	{ "lm93", lm93 },
+	{ "lm93", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm93_id);
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm95241.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm95241.c	2009-12-10 16:36:53.000000000 +0100
@@ -39,9 +39,6 @@
 static const unsigned short normal_i2c[] = {
 	0x19, 0x2a, 0x2b, I2C_CLIENT_END};
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(lm95241);
-
 /* LM95241 registers */
 #define LM95241_REG_R_MAN_ID		0xFE
 #define LM95241_REG_R_CHIP_ID		0xFF
@@ -446,7 +443,7 @@ static struct lm95241_data *lm95241_upda
 
 /* Driver data (common to all clients) */
 static const struct i2c_device_id lm95241_id[] = {
-	{ "lm95241", lm95241 },
+	{ "lm95241", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm95241_id);
--- linux-2.6.33-rc0.orig/drivers/hwmon/max1619.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/max1619.c	2009-12-10 16:36:53.000000000 +0100
@@ -41,12 +41,6 @@ static const unsigned short normal_i2c[]
 	0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, 0x4e, I2C_CLIENT_END };
 
 /*
- * Insmod parameters
- */
-
-I2C_CLIENT_INSMOD_1(max1619);
-
-/*
  * The MAX1619 registers
  */
 
@@ -99,7 +93,7 @@ static struct max1619_data *max1619_upda
  */
 
 static const struct i2c_device_id max1619_id[] = {
-	{ "max1619", max1619 },
+	{ "max1619", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max1619_id);
--- linux-2.6.33-rc0.orig/drivers/hwmon/max6650.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/max6650.c	2009-12-10 16:36:53.000000000 +0100
@@ -62,8 +62,6 @@ module_param(fan_voltage, int, S_IRUGO);
 module_param(prescaler, int, S_IRUGO);
 module_param(clock, int, S_IRUGO);
 
-I2C_CLIENT_INSMOD_1(max6650);
-
 /*
  * MAX 6650/6651 registers
  */
@@ -127,7 +125,7 @@ static struct max6650_data *max6650_upda
  */
 
 static const struct i2c_device_id max6650_id[] = {
-	{ "max6650", max6650 },
+	{ "max6650", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max6650_id);
--- linux-2.6.33-rc0.orig/drivers/hwmon/pcf8591.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/pcf8591.c	2009-12-10 16:36:53.000000000 +0100
@@ -29,7 +29,6 @@ static const unsigned short normal_i2c[]
 					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
 /* Insmod parameters */
-I2C_CLIENT_INSMOD_1(pcf8591);
 
 static int input_mode;
 module_param(input_mode, int, 0);
--- linux-2.6.33-rc0.orig/drivers/hwmon/smsc47m192.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/smsc47m192.c	2009-12-10 16:36:53.000000000 +0100
@@ -36,9 +36,6 @@
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(smsc47m192);
-
 /* SMSC47M192 registers */
 #define SMSC47M192_REG_IN(nr)		((nr)<6 ? (0x20 + (nr)) : \
 					(0x50 + (nr) - 6))
@@ -121,7 +118,7 @@ static int smsc47m192_remove(struct i2c_
 static struct smsc47m192_data *smsc47m192_update_device(struct device *dev);
 
 static const struct i2c_device_id smsc47m192_id[] = {
-	{ "smsc47m192", smsc47m192 },
+	{ "smsc47m192", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, smsc47m192_id);
--- linux-2.6.33-rc0.orig/drivers/hwmon/w83791d.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/w83791d.c	2009-12-10 16:36:53.000000000 +0100
@@ -52,7 +52,6 @@ static const unsigned short normal_i2c[]
 						I2C_CLIENT_END };
 
 /* Insmod parameters */
-I2C_CLIENT_INSMOD_1(w83791d);
 
 static unsigned short force_subclients[4];
 module_param_array(force_subclients, short, NULL, 0);
@@ -341,7 +340,7 @@ static void w83791d_print_debug(struct w
 static void w83791d_init_client(struct i2c_client *client);
 
 static const struct i2c_device_id w83791d_id[] = {
-	{ "w83791d", w83791d },
+	{ "w83791d", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, w83791d_id);
--- linux-2.6.33-rc0.orig/drivers/hwmon/w83792d.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/w83792d.c	2009-12-10 16:36:53.000000000 +0100
@@ -50,7 +50,6 @@ static const unsigned short normal_i2c[]
 						I2C_CLIENT_END };
 
 /* Insmod parameters */
-I2C_CLIENT_INSMOD_1(w83792d);
 
 static unsigned short force_subclients[4];
 module_param_array(force_subclients, short, NULL, 0);
@@ -314,7 +313,7 @@ static void w83792d_print_debug(struct w
 static void w83792d_init_client(struct i2c_client *client);
 
 static const struct i2c_device_id w83792d_id[] = {
-	{ "w83792d", w83792d },
+	{ "w83792d", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, w83792d_id);
--- linux-2.6.33-rc0.orig/drivers/hwmon/w83793.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/w83793.c	2009-12-10 16:36:53.000000000 +0100
@@ -41,7 +41,6 @@ static const unsigned short normal_i2c[]
 						I2C_CLIENT_END };
 
 /* Insmod parameters */
-I2C_CLIENT_INSMOD_1(w83793);
 
 static unsigned short force_subclients[4];
 module_param_array(force_subclients, short, NULL, 0);
@@ -238,7 +237,7 @@ static void w83793_update_nonvolatile(st
 static struct w83793_data *w83793_update_device(struct device *dev);
 
 static const struct i2c_device_id w83793_id[] = {
-	{ "w83793", w83793 },
+	{ "w83793", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, w83793_id);
--- linux-2.6.33-rc0.orig/drivers/hwmon/w83l785ts.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/w83l785ts.c	2009-12-10 16:36:53.000000000 +0100
@@ -52,12 +52,6 @@
 static const unsigned short normal_i2c[] = { 0x2e, I2C_CLIENT_END };
 
 /*
- * Insmod parameters
- */
-
-I2C_CLIENT_INSMOD_1(w83l785ts);
-
-/*
  * The W83L785TS-S registers
  * Manufacturer ID is 0x5CA3 for Winbond.
  */
@@ -94,7 +88,7 @@ static struct w83l785ts_data *w83l785ts_
  */
  
 static const struct i2c_device_id w83l785ts_id[] = {
-	{ "w83l785ts", w83l785ts },
+	{ "w83l785ts", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, w83l785ts_id);
--- linux-2.6.33-rc0.orig/drivers/hwmon/w83l786ng.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/w83l786ng.c	2009-12-10 16:36:53.000000000 +0100
@@ -38,7 +38,6 @@
 static const unsigned short normal_i2c[] = { 0x2e, 0x2f, I2C_CLIENT_END };
 
 /* Insmod parameters */
-I2C_CLIENT_INSMOD_1(w83l786ng);
 
 static int reset;
 module_param(reset, bool, 0);
@@ -154,7 +153,7 @@ static void w83l786ng_init_client(struct
 static struct w83l786ng_data *w83l786ng_update_device(struct device *dev);
 
 static const struct i2c_device_id w83l786ng_id[] = {
-	{ "w83l786ng", w83l786ng },
+	{ "w83l786ng", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, w83l786ng_id);
--- linux-2.6.33-rc0.orig/drivers/misc/eeprom/eeprom.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/misc/eeprom/eeprom.c	2009-12-10 16:36:53.000000000 +0100
@@ -32,9 +32,6 @@
 static const unsigned short normal_i2c[] = { 0x50, 0x51, 0x52, 0x53, 0x54,
 					0x55, 0x56, 0x57, I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(eeprom);
-
 
 /* Size of EEPROM in bytes */
 #define EEPROM_SIZE		256
--- linux-2.6.33-rc0.orig/drivers/misc/ics932s401.c	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/misc/ics932s401.c	2009-12-10 16:36:53.000000000 +0100
@@ -30,9 +30,6 @@
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x69, I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(ics932s401);
-
 /* ICS932S401 registers */
 #define ICS932S401_REG_CFG2			0x01
 #define 	ICS932S401_CFG1_SPREAD		0x01
@@ -111,7 +108,7 @@ static int ics932s401_detect(struct i2c_
 static int ics932s401_remove(struct i2c_client *client);
 
 static const struct i2c_device_id ics932s401_id[] = {
-	{ "ics932s401", ics932s401 },
+	{ "ics932s401", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ics932s401_id);
--- linux-2.6.33-rc0.orig/include/linux/i2c.h	2009-12-10 16:16:56.000000000 +0100
+++ linux-2.6.33-rc0/include/linux/i2c.h	2009-12-10 18:49:56.000000000 +0100
@@ -604,11 +604,6 @@ union i2c_smbus_data {
 
 /* These are the ones you want to use in your own drivers. Pick the one
    which matches the number of devices the driver differenciates between. */
-#define I2C_CLIENT_INSMOD
-
-#define I2C_CLIENT_INSMOD_1(chip1)					\
-enum chips { any_chip, chip1 }
-
 #define I2C_CLIENT_INSMOD_2(chip1, chip2)				\
 enum chips { any_chip, chip1, chip2 }
 


-- 
Jean Delvare
