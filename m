From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/5] i2c: Get rid of struct i2c_client_address_data
Date: Thu, 10 Dec 2009 18:53:20 +0100
Message-ID: <20091210185320.12419877@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Struct i2c_client_address_data only contains one field at this point,
which makes its usefulness questionable. Get rid of it and pass simple
address lists around instead.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 Documentation/i2c/writing-clients |    2 -
 drivers/hwmon/adm1021.c           |    2 -
 drivers/hwmon/adm1025.c           |    2 -
 drivers/hwmon/adm1026.c           |    2 -
 drivers/hwmon/adm1029.c           |    2 -
 drivers/hwmon/adm1031.c           |    2 -
 drivers/hwmon/adm9240.c           |    2 -
 drivers/hwmon/ads7828.c           |    2 -
 drivers/hwmon/adt7462.c           |    2 -
 drivers/hwmon/adt7470.c           |    2 -
 drivers/hwmon/adt7473.c           |    2 -
 drivers/hwmon/adt7475.c           |    2 -
 drivers/hwmon/asb100.c            |    2 -
 drivers/hwmon/atxp1.c             |    2 -
 drivers/hwmon/dme1737.c           |    2 -
 drivers/hwmon/ds1621.c            |    2 -
 drivers/hwmon/f75375s.c           |    2 -
 drivers/hwmon/fschmd.c            |    2 -
 drivers/hwmon/gl518sm.c           |    2 -
 drivers/hwmon/gl520sm.c           |    2 -
 drivers/hwmon/lm63.c              |    2 -
 drivers/hwmon/lm73.c              |    2 -
 drivers/hwmon/lm75.c              |    2 -
 drivers/hwmon/lm77.c              |    2 -
 drivers/hwmon/lm78.c              |    2 -
 drivers/hwmon/lm80.c              |    2 -
 drivers/hwmon/lm83.c              |    2 -
 drivers/hwmon/lm85.c              |    2 -
 drivers/hwmon/lm87.c              |    2 -
 drivers/hwmon/lm90.c              |    2 -
 drivers/hwmon/lm92.c              |    2 -
 drivers/hwmon/lm93.c              |    2 -
 drivers/hwmon/lm95241.c           |    2 -
 drivers/hwmon/max1619.c           |    2 -
 drivers/hwmon/max6650.c           |    2 -
 drivers/hwmon/pcf8591.c           |    2 -
 drivers/hwmon/smsc47m192.c        |    2 -
 drivers/hwmon/thmc50.c            |    2 -
 drivers/hwmon/tmp401.c            |    2 -
 drivers/hwmon/tmp421.c            |    2 -
 drivers/hwmon/w83781d.c           |    2 -
 drivers/hwmon/w83791d.c           |    2 -
 drivers/hwmon/w83792d.c           |    2 -
 drivers/hwmon/w83793.c            |    2 -
 drivers/hwmon/w83l785ts.c         |    2 -
 drivers/hwmon/w83l786ng.c         |    2 -
 drivers/i2c/i2c-core.c            |   15 +++++-------
 drivers/misc/eeprom/eeprom.c      |    2 -
 drivers/misc/ics932s401.c         |    2 -
 include/linux/i2c.h               |   44 +++++++++----------------------------
 50 files changed, 66 insertions(+), 89 deletions(-)

--- linux-2.6.33-rc0.orig/Documentation/i2c/writing-clients	2009-12-03 08:44:47.000000000 +0100
+++ linux-2.6.33-rc0/Documentation/i2c/writing-clients	2009-12-08 10:45:41.000000000 +0100
@@ -44,7 +44,7 @@ static struct i2c_driver foo_driver = {
 	/* if device autodetection is needed: */
 	.class		= I2C_CLASS_SOMETHING,
 	.detect		= foo_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 
 	.shutdown	= foo_shutdown,	/* optional */
 	.suspend	= foo_suspend,	/* optional */
--- linux-2.6.33-rc0.orig/drivers/hwmon/adm1021.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adm1021.c	2009-12-08 10:45:41.000000000 +0100
@@ -130,7 +130,7 @@ static struct i2c_driver adm1021_driver
 	.remove		= adm1021_remove,
 	.id_table	= adm1021_id,
 	.detect		= adm1021_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 static ssize_t show_temp(struct device *dev,
--- linux-2.6.33-rc0.orig/drivers/hwmon/adm1025.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adm1025.c	2009-12-08 10:45:41.000000000 +0100
@@ -137,7 +137,7 @@ static struct i2c_driver adm1025_driver
 	.remove		= adm1025_remove,
 	.id_table	= adm1025_id,
 	.detect		= adm1025_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /*
--- linux-2.6.33-rc0.orig/drivers/hwmon/adm1026.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adm1026.c	2009-12-08 10:45:41.000000000 +0100
@@ -319,7 +319,7 @@ static struct i2c_driver adm1026_driver
 	.remove		= adm1026_remove,
 	.id_table	= adm1026_id,
 	.detect		= adm1026_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 static int adm1026_read_value(struct i2c_client *client, u8 reg)
--- linux-2.6.33-rc0.orig/drivers/hwmon/adm1029.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adm1029.c	2009-12-08 10:45:41.000000000 +0100
@@ -142,7 +142,7 @@ static struct i2c_driver adm1029_driver
 	.remove		= adm1029_remove,
 	.id_table	= adm1029_id,
 	.detect		= adm1029_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /*
--- linux-2.6.33-rc0.orig/drivers/hwmon/adm1031.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adm1031.c	2009-12-08 10:45:41.000000000 +0100
@@ -125,7 +125,7 @@ static struct i2c_driver adm1031_driver
 	.remove		= adm1031_remove,
 	.id_table	= adm1031_id,
 	.detect		= adm1031_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 static inline u8 adm1031_read_value(struct i2c_client *client, u8 reg)
--- linux-2.6.33-rc0.orig/drivers/hwmon/adm9240.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adm9240.c	2009-12-08 10:45:41.000000000 +0100
@@ -156,7 +156,7 @@ static struct i2c_driver adm9240_driver
 	.remove		= adm9240_remove,
 	.id_table	= adm9240_id,
 	.detect		= adm9240_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /* per client data */
--- linux-2.6.33-rc0.orig/drivers/hwmon/ads7828.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/ads7828.c	2009-12-08 10:45:41.000000000 +0100
@@ -183,7 +183,7 @@ static struct i2c_driver ads7828_driver
 	.remove = ads7828_remove,
 	.id_table = ads7828_id,
 	.detect = ads7828_detect,
-	.address_data = &addr_data,
+	.address_list = normal_i2c,
 };
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
--- linux-2.6.33-rc0.orig/drivers/hwmon/adt7462.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adt7462.c	2009-12-08 10:45:41.000000000 +0100
@@ -256,7 +256,7 @@ static struct i2c_driver adt7462_driver
 	.remove		= adt7462_remove,
 	.id_table	= adt7462_id,
 	.detect		= adt7462_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /*
--- linux-2.6.33-rc0.orig/drivers/hwmon/adt7470.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adt7470.c	2009-12-08 10:45:41.000000000 +0100
@@ -196,7 +196,7 @@ static struct i2c_driver adt7470_driver
 	.remove		= adt7470_remove,
 	.id_table	= adt7470_id,
 	.detect		= adt7470_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /*
--- linux-2.6.33-rc0.orig/drivers/hwmon/adt7473.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adt7473.c	2009-12-08 10:45:41.000000000 +0100
@@ -184,7 +184,7 @@ static struct i2c_driver adt7473_driver
 	.remove		= adt7473_remove,
 	.id_table	= adt7473_id,
 	.detect		= adt7473_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /*
--- linux-2.6.33-rc0.orig/drivers/hwmon/adt7475.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adt7475.c	2009-12-08 10:45:41.000000000 +0100
@@ -1412,7 +1412,7 @@ static struct i2c_driver adt7475_driver
 	.remove		= adt7475_remove,
 	.id_table	= adt7475_id,
 	.detect		= adt7475_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 static void adt7475_read_hystersis(struct i2c_client *client)
--- linux-2.6.33-rc0.orig/drivers/hwmon/asb100.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/asb100.c	2009-12-08 10:45:41.000000000 +0100
@@ -230,7 +230,7 @@ static struct i2c_driver asb100_driver =
 	.remove		= asb100_remove,
 	.id_table	= asb100_id,
 	.detect		= asb100_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /* 7 Voltages */
--- linux-2.6.33-rc0.orig/drivers/hwmon/atxp1.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/atxp1.c	2009-12-08 10:45:41.000000000 +0100
@@ -67,7 +67,7 @@ static struct i2c_driver atxp1_driver =
 	.remove		= atxp1_remove,
 	.id_table	= atxp1_id,
 	.detect		= atxp1_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 struct atxp1_data {
--- linux-2.6.33-rc0.orig/drivers/hwmon/dme1737.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/dme1737.c	2009-12-08 10:45:41.000000000 +0100
@@ -2318,7 +2318,7 @@ static struct i2c_driver dme1737_i2c_dri
 	.remove = dme1737_i2c_remove,
 	.id_table = dme1737_id,
 	.detect = dme1737_i2c_detect,
-	.address_data = &addr_data,
+	.address_list = normal_i2c,
 };
 
 /* ---------------------------------------------------------------------
--- linux-2.6.33-rc0.orig/drivers/hwmon/ds1621.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/ds1621.c	2009-12-08 10:45:41.000000000 +0100
@@ -321,7 +321,7 @@ static struct i2c_driver ds1621_driver =
 	.remove		= ds1621_remove,
 	.id_table	= ds1621_id,
 	.detect		= ds1621_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 static int __init ds1621_init(void)
--- linux-2.6.33-rc0.orig/drivers/hwmon/f75375s.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/f75375s.c	2009-12-08 10:45:41.000000000 +0100
@@ -135,7 +135,7 @@ static struct i2c_driver f75375_driver =
 	.remove = f75375_remove,
 	.id_table = f75375_id,
 	.detect = f75375_detect,
-	.address_data = &addr_data,
+	.address_list = normal_i2c,
 };
 
 static inline int f75375_read8(struct i2c_client *client, u8 reg)
--- linux-2.6.33-rc0.orig/drivers/hwmon/fschmd.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/fschmd.c	2009-12-08 10:45:41.000000000 +0100
@@ -251,7 +251,7 @@ static struct i2c_driver fschmd_driver =
 	.remove		= fschmd_remove,
 	.id_table	= fschmd_id,
 	.detect		= fschmd_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /*
--- linux-2.6.33-rc0.orig/drivers/hwmon/gl518sm.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/gl518sm.c	2009-12-08 10:45:41.000000000 +0100
@@ -162,7 +162,7 @@ static struct i2c_driver gl518_driver =
 	.remove		= gl518_remove,
 	.id_table	= gl518_id,
 	.detect		= gl518_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /*
--- linux-2.6.33-rc0.orig/drivers/hwmon/gl520sm.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/gl520sm.c	2009-12-08 10:45:41.000000000 +0100
@@ -104,7 +104,7 @@ static struct i2c_driver gl520_driver =
 	.remove		= gl520_remove,
 	.id_table	= gl520_id,
 	.detect		= gl520_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /* Client data */
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm63.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm63.c	2009-12-08 10:45:41.000000000 +0100
@@ -156,7 +156,7 @@ static struct i2c_driver lm63_driver = {
 	.remove		= lm63_remove,
 	.id_table	= lm63_id,
 	.detect		= lm63_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /*
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm73.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm73.c	2009-12-08 10:45:41.000000000 +0100
@@ -182,7 +182,7 @@ static struct i2c_driver lm73_driver = {
 	.remove		= lm73_remove,
 	.id_table	= lm73_ids,
 	.detect		= lm73_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /* module glue */
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm75.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm75.c	2009-12-08 10:45:41.000000000 +0100
@@ -295,7 +295,7 @@ static struct i2c_driver lm75_driver = {
 	.remove		= lm75_remove,
 	.id_table	= lm75_ids,
 	.detect		= lm75_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /*-----------------------------------------------------------------------*/
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm77.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm77.c	2009-12-08 10:45:41.000000000 +0100
@@ -91,7 +91,7 @@ static struct i2c_driver lm77_driver = {
 	.remove		= lm77_remove,
 	.id_table	= lm77_id,
 	.detect		= lm77_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /* straight from the datasheet */
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm78.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm78.c	2009-12-08 10:45:41.000000000 +0100
@@ -173,7 +173,7 @@ static struct i2c_driver lm78_driver = {
 	.remove		= lm78_i2c_remove,
 	.id_table	= lm78_i2c_id,
 	.detect		= lm78_i2c_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 static struct platform_driver lm78_isa_driver = {
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm80.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm80.c	2009-12-08 10:45:41.000000000 +0100
@@ -159,7 +159,7 @@ static struct i2c_driver lm80_driver = {
 	.remove		= lm80_remove,
 	.id_table	= lm80_id,
 	.detect		= lm80_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /*
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm83.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm83.c	2009-12-08 10:45:41.000000000 +0100
@@ -145,7 +145,7 @@ static struct i2c_driver lm83_driver = {
 	.remove		= lm83_remove,
 	.id_table	= lm83_id,
 	.detect		= lm83_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /*
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm85.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm85.c	2009-12-08 10:45:41.000000000 +0100
@@ -356,7 +356,7 @@ static struct i2c_driver lm85_driver = {
 	.remove		= lm85_remove,
 	.id_table	= lm85_id,
 	.detect		= lm85_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm87.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm87.c	2009-12-08 10:45:41.000000000 +0100
@@ -184,7 +184,7 @@ static struct i2c_driver lm87_driver = {
 	.remove		= lm87_remove,
 	.id_table	= lm87_id,
 	.detect		= lm87_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /*
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm90.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm90.c	2009-12-08 10:45:41.000000000 +0100
@@ -191,7 +191,7 @@ static struct i2c_driver lm90_driver = {
 	.remove		= lm90_remove,
 	.id_table	= lm90_id,
 	.detect		= lm90_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /*
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm92.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm92.c	2009-12-08 10:45:41.000000000 +0100
@@ -416,7 +416,7 @@ static struct i2c_driver lm92_driver = {
 	.remove		= lm92_remove,
 	.id_table	= lm92_id,
 	.detect		= lm92_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 static int __init sensors_lm92_init(void)
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm93.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm93.c	2009-12-08 10:45:41.000000000 +0100
@@ -2616,7 +2616,7 @@ static struct i2c_driver lm93_driver = {
 	.remove		= lm93_remove,
 	.id_table	= lm93_id,
 	.detect		= lm93_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 static int __init lm93_init(void)
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm95241.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm95241.c	2009-12-08 10:45:41.000000000 +0100
@@ -460,7 +460,7 @@ static struct i2c_driver lm95241_driver
 	.remove		= lm95241_remove,
 	.id_table	= lm95241_id,
 	.detect		= lm95241_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 static int __init sensors_lm95241_init(void)
--- linux-2.6.33-rc0.orig/drivers/hwmon/max1619.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/max1619.c	2009-12-08 10:45:41.000000000 +0100
@@ -113,7 +113,7 @@ static struct i2c_driver max1619_driver
 	.remove		= max1619_remove,
 	.id_table	= max1619_id,
 	.detect		= max1619_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /*
--- linux-2.6.33-rc0.orig/drivers/hwmon/max6650.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/max6650.c	2009-12-08 10:45:41.000000000 +0100
@@ -141,7 +141,7 @@ static struct i2c_driver max6650_driver
 	.remove		= max6650_remove,
 	.id_table	= max6650_id,
 	.detect		= max6650_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /*
--- linux-2.6.33-rc0.orig/drivers/hwmon/pcf8591.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/pcf8591.c	2009-12-08 10:45:41.000000000 +0100
@@ -299,7 +299,7 @@ static struct i2c_driver pcf8591_driver
 
 	.class		= I2C_CLASS_HWMON,	/* Nearest choice */
 	.detect		= pcf8591_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 static int __init pcf8591_init(void)
--- linux-2.6.33-rc0.orig/drivers/hwmon/smsc47m192.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/smsc47m192.c	2009-12-08 10:45:41.000000000 +0100
@@ -135,7 +135,7 @@ static struct i2c_driver smsc47m192_driv
 	.remove		= smsc47m192_remove,
 	.id_table	= smsc47m192_id,
 	.detect		= smsc47m192_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /* Voltages */
--- linux-2.6.33-rc0.orig/drivers/hwmon/thmc50.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/thmc50.c	2009-12-08 10:45:41.000000000 +0100
@@ -108,7 +108,7 @@ static struct i2c_driver thmc50_driver =
 	.remove = thmc50_remove,
 	.id_table = thmc50_id,
 	.detect = thmc50_detect,
-	.address_data = &addr_data,
+	.address_list = normal_i2c,
 };
 
 static ssize_t show_analog_out(struct device *dev,
--- linux-2.6.33-rc0.orig/drivers/hwmon/tmp401.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/tmp401.c	2009-12-08 10:45:41.000000000 +0100
@@ -123,7 +123,7 @@ static struct i2c_driver tmp401_driver =
 	.remove		= tmp401_remove,
 	.id_table	= tmp401_id,
 	.detect		= tmp401_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /*
--- linux-2.6.33-rc0.orig/drivers/hwmon/tmp421.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/tmp421.c	2009-12-08 10:45:41.000000000 +0100
@@ -322,7 +322,7 @@ static struct i2c_driver tmp421_driver =
 	.remove = tmp421_remove,
 	.id_table = tmp421_id,
 	.detect = tmp421_detect,
-	.address_data = &addr_data,
+	.address_list = normal_i2c,
 };
 
 static int __init tmp421_init(void)
--- linux-2.6.33-rc0.orig/drivers/hwmon/w83781d.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/w83781d.c	2009-12-08 10:45:41.000000000 +0100
@@ -1536,7 +1536,7 @@ static struct i2c_driver w83781d_driver
 	.remove		= w83781d_remove,
 	.id_table	= w83781d_ids,
 	.detect		= w83781d_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /*
--- linux-2.6.33-rc0.orig/drivers/hwmon/w83791d.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/w83791d.c	2009-12-08 10:45:41.000000000 +0100
@@ -355,7 +355,7 @@ static struct i2c_driver w83791d_driver
 	.remove		= w83791d_remove,
 	.id_table	= w83791d_id,
 	.detect		= w83791d_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /* following are the sysfs callback functions */
--- linux-2.6.33-rc0.orig/drivers/hwmon/w83792d.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/w83792d.c	2009-12-08 10:45:41.000000000 +0100
@@ -328,7 +328,7 @@ static struct i2c_driver w83792d_driver
 	.remove		= w83792d_remove,
 	.id_table	= w83792d_id,
 	.detect		= w83792d_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 static inline long in_count_from_reg(int nr, struct w83792d_data *data)
--- linux-2.6.33-rc0.orig/drivers/hwmon/w83793.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/w83793.c	2009-12-08 10:45:41.000000000 +0100
@@ -252,7 +252,7 @@ static struct i2c_driver w83793_driver =
 	.remove		= w83793_remove,
 	.id_table	= w83793_id,
 	.detect		= w83793_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 static ssize_t
--- linux-2.6.33-rc0.orig/drivers/hwmon/w83l785ts.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/w83l785ts.c	2009-12-08 10:45:41.000000000 +0100
@@ -108,7 +108,7 @@ static struct i2c_driver w83l785ts_drive
 	.remove		= w83l785ts_remove,
 	.id_table	= w83l785ts_id,
 	.detect		= w83l785ts_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 /*
--- linux-2.6.33-rc0.orig/drivers/hwmon/w83l786ng.c	2009-12-08 10:29:03.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/w83l786ng.c	2009-12-08 10:45:41.000000000 +0100
@@ -168,7 +168,7 @@ static struct i2c_driver w83l786ng_drive
 	.remove		= w83l786ng_remove,
 	.id_table	= w83l786ng_id,
 	.detect		= w83l786ng_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 static u8
--- linux-2.6.33-rc0.orig/drivers/i2c/i2c-core.c	2009-12-08 10:29:04.000000000 +0100
+++ linux-2.6.33-rc0/drivers/i2c/i2c-core.c	2009-12-08 10:45:41.000000000 +0100
@@ -1214,13 +1214,13 @@ static int i2c_detect_address(struct i2c
 
 static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver)
 {
-	const struct i2c_client_address_data *address_data;
+	const unsigned short *address_list;
 	struct i2c_client *temp_client;
 	int i, err = 0;
 	int adap_id = i2c_adapter_id(adapter);
 
-	address_data = driver->address_data;
-	if (!driver->detect || !address_data)
+	address_list = driver->address_list;
+	if (!driver->detect || !address_list)
 		return 0;
 
 	/* Set up a temporary client to help detect callback */
@@ -1235,7 +1235,7 @@ static int i2c_detect(struct i2c_adapter
 
 	/* Stop here if we can't use SMBUS_QUICK */
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_QUICK)) {
-		if (address_data->normal_i2c[0] == I2C_CLIENT_END)
+		if (address_list[0] == I2C_CLIENT_END)
 			goto exit_free;
 
 		dev_warn(&adapter->dev, "SMBus Quick command not supported, "
@@ -1244,11 +1244,10 @@ static int i2c_detect(struct i2c_adapter
 		goto exit_free;
 	}
 
-	for (i = 0; address_data->normal_i2c[i] != I2C_CLIENT_END; i += 1) {
+	for (i = 0; address_list[i] != I2C_CLIENT_END; i += 1) {
 		dev_dbg(&adapter->dev, "found normal entry for adapter %d, "
-			"addr 0x%02x\n", adap_id,
-			address_data->normal_i2c[i]);
-		temp_client->addr = address_data->normal_i2c[i];
+			"addr 0x%02x\n", adap_id, address_list[i]);
+		temp_client->addr = address_list[i];
 		err = i2c_detect_address(temp_client, driver);
 		if (err)
 			goto exit_free;
--- linux-2.6.33-rc0.orig/drivers/misc/eeprom/eeprom.c	2009-12-08 10:29:04.000000000 +0100
+++ linux-2.6.33-rc0/drivers/misc/eeprom/eeprom.c	2009-12-08 10:45:41.000000000 +0100
@@ -232,7 +232,7 @@ static struct i2c_driver eeprom_driver =
 
 	.class		= I2C_CLASS_DDC | I2C_CLASS_SPD,
 	.detect		= eeprom_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 static int __init eeprom_init(void)
--- linux-2.6.33-rc0.orig/drivers/misc/ics932s401.c	2009-12-08 10:29:04.000000000 +0100
+++ linux-2.6.33-rc0/drivers/misc/ics932s401.c	2009-12-08 10:45:41.000000000 +0100
@@ -125,7 +125,7 @@ static struct i2c_driver ics932s401_driv
 	.remove		= ics932s401_remove,
 	.id_table	= ics932s401_id,
 	.detect		= ics932s401_detect,
-	.address_data	= &addr_data,
+	.address_list	= normal_i2c,
 };
 
 static struct ics932s401_data *ics932s401_update_device(struct device *dev)
--- linux-2.6.33-rc0.orig/include/linux/i2c.h	2009-12-08 10:29:04.000000000 +0100
+++ linux-2.6.33-rc0/include/linux/i2c.h	2009-12-08 10:45:41.000000000 +0100
@@ -110,7 +110,7 @@ extern s32 i2c_smbus_write_i2c_block_dat
  * @driver: Device driver model driver
  * @id_table: List of I2C devices supported by this driver
  * @detect: Callback for device detection
- * @address_data: The I2C addresses to probe (for detect)
+ * @address_list: The I2C addresses to probe (for detect)
  * @clients: List of detected clients we created (for i2c-core use only)
  *
  * The driver.owner field should be set to the module owner of this driver.
@@ -162,7 +162,7 @@ struct i2c_driver {
 
 	/* Device detection callback for automatic device creation */
 	int (*detect)(struct i2c_client *, struct i2c_board_info *);
-	const struct i2c_client_address_data *address_data;
+	const unsigned short *address_list;
 	struct list_head clients;
 };
 #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)
@@ -391,14 +391,6 @@ static inline void i2c_unlock_adapter(st
 #define I2C_CLASS_DDC		(1<<3)	/* DDC bus on graphics adapters */
 #define I2C_CLASS_SPD		(1<<7)	/* SPD EEPROMs and similar */
 
-/* i2c_client_address_data is the struct for holding default client
- * addresses for a driver and for the parameters supplied on the
- * command line
- */
-struct i2c_client_address_data {
-	const unsigned short *normal_i2c;
-};
-
 /* Internal numbers to terminate lists */
 #define I2C_CLIENT_END		0xfffeU
 
@@ -610,48 +602,34 @@ union i2c_smbus_data {
   module_param_array(var, short, &var##_num, 0); \
   MODULE_PARM_DESC(var, desc)
 
-#define I2C_CLIENT_INSMOD_COMMON					\
-static const struct i2c_client_address_data addr_data = {		\
-	.normal_i2c	= normal_i2c,					\
-}
-
 /* These are the ones you want to use in your own drivers. Pick the one
    which matches the number of devices the driver differenciates between. */
-#define I2C_CLIENT_INSMOD						\
-I2C_CLIENT_INSMOD_COMMON
+#define I2C_CLIENT_INSMOD
 
 #define I2C_CLIENT_INSMOD_1(chip1)					\
-enum chips { any_chip, chip1 };						\
-I2C_CLIENT_INSMOD_COMMON
+enum chips { any_chip, chip1 }
 
 #define I2C_CLIENT_INSMOD_2(chip1, chip2)				\
-enum chips { any_chip, chip1, chip2 };					\
-I2C_CLIENT_INSMOD_COMMON
+enum chips { any_chip, chip1, chip2 }
 
 #define I2C_CLIENT_INSMOD_3(chip1, chip2, chip3)			\
-enum chips { any_chip, chip1, chip2, chip3 };				\
-I2C_CLIENT_INSMOD_COMMON
+enum chips { any_chip, chip1, chip2, chip3 }
 
 #define I2C_CLIENT_INSMOD_4(chip1, chip2, chip3, chip4)			\
-enum chips { any_chip, chip1, chip2, chip3, chip4 };			\
-I2C_CLIENT_INSMOD_COMMON
+enum chips { any_chip, chip1, chip2, chip3, chip4 }
 
 #define I2C_CLIENT_INSMOD_5(chip1, chip2, chip3, chip4, chip5)		\
-enum chips { any_chip, chip1, chip2, chip3, chip4, chip5 };		\
-I2C_CLIENT_INSMOD_COMMON
+enum chips { any_chip, chip1, chip2, chip3, chip4, chip5 }
 
 #define I2C_CLIENT_INSMOD_6(chip1, chip2, chip3, chip4, chip5, chip6)	\
-enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6 };	\
-I2C_CLIENT_INSMOD_COMMON
+enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6 }
 
 #define I2C_CLIENT_INSMOD_7(chip1, chip2, chip3, chip4, chip5, chip6, chip7) \
 enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6,	\
-	     chip7 };							\
-I2C_CLIENT_INSMOD_COMMON
+	     chip7 }
 
 #define I2C_CLIENT_INSMOD_8(chip1, chip2, chip3, chip4, chip5, chip6, chip7, chip8) \
 enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6,	\
-	     chip7, chip8 };						\
-I2C_CLIENT_INSMOD_COMMON
+	     chip7, chip8 }
 #endif /* __KERNEL__ */
 #endif /* _LINUX_I2C_H */


-- 
Jean Delvare
