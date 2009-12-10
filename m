From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/5] i2c: Drop the kind parameter from detect callbacks
Date: Thu, 10 Dec 2009 18:52:21 +0100
Message-ID: <20091210185221.641bbaab@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The "kind" parameter always has value -1, and nobody is using it any
longer, so we can remove it.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/hwmon/adm1021.c      |    4 ++--
 drivers/hwmon/adm1025.c      |    4 ++--
 drivers/hwmon/adm1026.c      |    4 ++--
 drivers/hwmon/adm1029.c      |    4 ++--
 drivers/hwmon/adm1031.c      |    4 ++--
 drivers/hwmon/adm9240.c      |    4 ++--
 drivers/hwmon/ads7828.c      |    4 ++--
 drivers/hwmon/adt7462.c      |    4 ++--
 drivers/hwmon/adt7470.c      |    4 ++--
 drivers/hwmon/adt7473.c      |    4 ++--
 drivers/hwmon/adt7475.c      |    2 +-
 drivers/hwmon/asb100.c       |    4 ++--
 drivers/hwmon/atxp1.c        |    5 ++---
 drivers/hwmon/dme1737.c      |    2 +-
 drivers/hwmon/ds1621.c       |    2 +-
 drivers/hwmon/f75375s.c      |    4 ++--
 drivers/hwmon/fschmd.c       |    4 ++--
 drivers/hwmon/gl518sm.c      |    6 ++----
 drivers/hwmon/gl520sm.c      |    6 ++----
 drivers/hwmon/lm63.c         |    5 ++---
 drivers/hwmon/lm73.c         |    2 +-
 drivers/hwmon/lm75.c         |    2 +-
 drivers/hwmon/lm77.c         |    5 ++---
 drivers/hwmon/lm78.c         |    4 ++--
 drivers/hwmon/lm80.c         |    6 ++----
 drivers/hwmon/lm83.c         |    4 ++--
 drivers/hwmon/lm85.c         |    6 ++----
 drivers/hwmon/lm87.c         |    4 ++--
 drivers/hwmon/lm90.c         |    5 ++---
 drivers/hwmon/lm92.c         |    2 +-
 drivers/hwmon/lm93.c         |    3 +--
 drivers/hwmon/lm95241.c      |    2 +-
 drivers/hwmon/max1619.c      |    4 ++--
 drivers/hwmon/max6650.c      |    4 ++--
 drivers/hwmon/pcf8591.c      |    2 +-
 drivers/hwmon/smsc47m192.c   |    4 ++--
 drivers/hwmon/thmc50.c       |    4 ++--
 drivers/hwmon/tmp401.c       |    4 ++--
 drivers/hwmon/tmp421.c       |    2 +-
 drivers/hwmon/w83781d.c      |    3 +--
 drivers/hwmon/w83791d.c      |    4 ++--
 drivers/hwmon/w83792d.c      |    4 ++--
 drivers/hwmon/w83793.c       |    4 ++--
 drivers/hwmon/w83l785ts.c    |    4 ++--
 drivers/hwmon/w83l786ng.c    |    5 ++---
 drivers/i2c/i2c-core.c       |    2 +-
 drivers/misc/eeprom/eeprom.c |    3 +--
 drivers/misc/ics932s401.c    |    4 ++--
 include/linux/i2c.h          |    2 +-
 49 files changed, 84 insertions(+), 100 deletions(-)

--- linux-2.6.33-rc0.orig/drivers/hwmon/adm1021.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adm1021.c	2009-12-08 10:29:03.000000000 +0100
@@ -97,7 +97,7 @@ struct adm1021_data {
 
 static int adm1021_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id);
-static int adm1021_detect(struct i2c_client *client, int kind,
+static int adm1021_detect(struct i2c_client *client,
 			  struct i2c_board_info *info);
 static void adm1021_init_client(struct i2c_client *client);
 static int adm1021_remove(struct i2c_client *client);
@@ -284,7 +284,7 @@ static const struct attribute_group adm1
 };
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int adm1021_detect(struct i2c_client *client, int kind,
+static int adm1021_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/adm1025.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adm1025.c	2009-12-08 10:29:03.000000000 +0100
@@ -111,7 +111,7 @@ static const int in_scale[6] = { 2500, 2
 
 static int adm1025_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id);
-static int adm1025_detect(struct i2c_client *client, int kind,
+static int adm1025_detect(struct i2c_client *client,
 			  struct i2c_board_info *info);
 static void adm1025_init_client(struct i2c_client *client);
 static int adm1025_remove(struct i2c_client *client);
@@ -409,7 +409,7 @@ static const struct attribute_group adm1
 };
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int adm1025_detect(struct i2c_client *client, int kind,
+static int adm1025_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/adm1026.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adm1026.c	2009-12-08 10:29:03.000000000 +0100
@@ -293,7 +293,7 @@ struct adm1026_data {
 
 static int adm1026_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id);
-static int adm1026_detect(struct i2c_client *client, int kind,
+static int adm1026_detect(struct i2c_client *client,
 			  struct i2c_board_info *info);
 static int adm1026_remove(struct i2c_client *client);
 static int adm1026_read_value(struct i2c_client *client, u8 reg);
@@ -1650,7 +1650,7 @@ static const struct attribute_group adm1
 };
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int adm1026_detect(struct i2c_client *client, int kind,
+static int adm1026_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/adm1029.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adm1029.c	2009-12-08 10:29:03.000000000 +0100
@@ -117,7 +117,7 @@ static const u8 ADM1029_REG_FAN_DIV[] =
 
 static int adm1029_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id);
-static int adm1029_detect(struct i2c_client *client, int kind,
+static int adm1029_detect(struct i2c_client *client,
 			  struct i2c_board_info *info);
 static int adm1029_remove(struct i2c_client *client);
 static struct adm1029_data *adm1029_update_device(struct device *dev);
@@ -297,7 +297,7 @@ static const struct attribute_group adm1
  */
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int adm1029_detect(struct i2c_client *client, int kind,
+static int adm1029_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/adm1031.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adm1031.c	2009-12-08 10:29:03.000000000 +0100
@@ -102,7 +102,7 @@ struct adm1031_data {
 
 static int adm1031_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id);
-static int adm1031_detect(struct i2c_client *client, int kind,
+static int adm1031_detect(struct i2c_client *client,
 			  struct i2c_board_info *info);
 static void adm1031_init_client(struct i2c_client *client);
 static int adm1031_remove(struct i2c_client *client);
@@ -813,7 +813,7 @@ static const struct attribute_group adm1
 };
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int adm1031_detect(struct i2c_client *client, int kind,
+static int adm1031_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/adm9240.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adm9240.c	2009-12-08 10:29:03.000000000 +0100
@@ -132,7 +132,7 @@ static inline unsigned int AOUT_FROM_REG
 
 static int adm9240_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id);
-static int adm9240_detect(struct i2c_client *client, int kind,
+static int adm9240_detect(struct i2c_client *client,
 			  struct i2c_board_info *info);
 static void adm9240_init_client(struct i2c_client *client);
 static int adm9240_remove(struct i2c_client *client);
@@ -545,7 +545,7 @@ static const struct attribute_group adm9
 /*** sensor chip detect and driver install ***/
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int adm9240_detect(struct i2c_client *new_client, int kind,
+static int adm9240_detect(struct i2c_client *new_client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = new_client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/ads7828.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/ads7828.c	2009-12-08 10:29:03.000000000 +0100
@@ -72,7 +72,7 @@ struct ads7828_data {
 };
 
 /* Function declaration - necessary due to function dependencies */
-static int ads7828_detect(struct i2c_client *client, int kind,
+static int ads7828_detect(struct i2c_client *client,
 			  struct i2c_board_info *info);
 static int ads7828_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id);
@@ -187,7 +187,7 @@ static struct i2c_driver ads7828_driver
 };
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int ads7828_detect(struct i2c_client *client, int kind,
+static int ads7828_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/adt7462.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adt7462.c	2009-12-08 10:29:03.000000000 +0100
@@ -237,7 +237,7 @@ struct adt7462_data {
 
 static int adt7462_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id);
-static int adt7462_detect(struct i2c_client *client, int kind,
+static int adt7462_detect(struct i2c_client *client,
 			  struct i2c_board_info *info);
 static int adt7462_remove(struct i2c_client *client);
 
@@ -1902,7 +1902,7 @@ static struct attribute *adt7462_attr[]
 };
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int adt7462_detect(struct i2c_client *client, int kind,
+static int adt7462_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/adt7470.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adt7470.c	2009-12-08 10:29:03.000000000 +0100
@@ -177,7 +177,7 @@ struct adt7470_data {
 
 static int adt7470_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id);
-static int adt7470_detect(struct i2c_client *client, int kind,
+static int adt7470_detect(struct i2c_client *client,
 			  struct i2c_board_info *info);
 static int adt7470_remove(struct i2c_client *client);
 
@@ -1225,7 +1225,7 @@ static struct attribute *adt7470_attr[]
 };
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int adt7470_detect(struct i2c_client *client, int kind,
+static int adt7470_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/adt7473.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adt7473.c	2009-12-08 10:29:03.000000000 +0100
@@ -166,7 +166,7 @@ struct adt7473_data {
 
 static int adt7473_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id);
-static int adt7473_detect(struct i2c_client *client, int kind,
+static int adt7473_detect(struct i2c_client *client,
 			  struct i2c_board_info *info);
 static int adt7473_remove(struct i2c_client *client);
 
@@ -1085,7 +1085,7 @@ static struct attribute *adt7473_attr[]
 };
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int adt7473_detect(struct i2c_client *client, int kind,
+static int adt7473_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/adt7475.c	2009-12-06 12:54:33.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adt7475.c	2009-12-08 10:29:03.000000000 +0100
@@ -1172,7 +1172,7 @@ static struct attribute_group in4_attr_g
 static struct attribute_group in5_attr_group = { .attrs = in5_attrs };
 static struct attribute_group vid_attr_group = { .attrs = vid_attrs };
 
-static int adt7475_detect(struct i2c_client *client, int kind,
+static int adt7475_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/asb100.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/asb100.c	2009-12-08 10:29:03.000000000 +0100
@@ -209,7 +209,7 @@ static void asb100_write_value(struct i2
 
 static int asb100_probe(struct i2c_client *client,
 			const struct i2c_device_id *id);
-static int asb100_detect(struct i2c_client *client, int kind,
+static int asb100_detect(struct i2c_client *client,
 			 struct i2c_board_info *info);
 static int asb100_remove(struct i2c_client *client);
 static struct asb100_data *asb100_update_device(struct device *dev);
@@ -697,7 +697,7 @@ ERROR_SC_2:
 }
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int asb100_detect(struct i2c_client *client, int kind,
+static int asb100_detect(struct i2c_client *client,
 			 struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/atxp1.c	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.33-rc0/drivers/hwmon/atxp1.c	2009-12-08 10:29:03.000000000 +0100
@@ -50,8 +50,7 @@ static int atxp1_probe(struct i2c_client
 		       const struct i2c_device_id *id);
 static int atxp1_remove(struct i2c_client *client);
 static struct atxp1_data * atxp1_update_device(struct device *dev);
-static int atxp1_detect(struct i2c_client *client, int kind,
-			struct i2c_board_info *info);
+static int atxp1_detect(struct i2c_client *client, struct i2c_board_info *info);
 
 static const struct i2c_device_id atxp1_id[] = {
 	{ "atxp1", atxp1 },
@@ -275,7 +274,7 @@ static const struct attribute_group atxp
 
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int atxp1_detect(struct i2c_client *new_client, int kind,
+static int atxp1_detect(struct i2c_client *new_client,
 			struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = new_client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/dme1737.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/dme1737.c	2009-12-08 10:29:03.000000000 +0100
@@ -2208,7 +2208,7 @@ exit:
 }
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int dme1737_i2c_detect(struct i2c_client *client, int kind,
+static int dme1737_i2c_detect(struct i2c_client *client,
 			      struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/ds1621.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/ds1621.c	2009-12-08 10:29:03.000000000 +0100
@@ -224,7 +224,7 @@ static const struct attribute_group ds16
 
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int ds1621_detect(struct i2c_client *client, int kind,
+static int ds1621_detect(struct i2c_client *client,
 			 struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/f75375s.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/f75375s.c	2009-12-08 10:29:03.000000000 +0100
@@ -113,7 +113,7 @@ struct f75375_data {
 	s8 temp_max_hyst[2];
 };
 
-static int f75375_detect(struct i2c_client *client, int kind,
+static int f75375_detect(struct i2c_client *client,
 			 struct i2c_board_info *info);
 static int f75375_probe(struct i2c_client *client,
 			const struct i2c_device_id *id);
@@ -677,7 +677,7 @@ static int f75375_remove(struct i2c_clie
 }
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int f75375_detect(struct i2c_client *client, int kind,
+static int f75375_detect(struct i2c_client *client,
 			 struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/fschmd.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/fschmd.c	2009-12-08 10:29:03.000000000 +0100
@@ -221,7 +221,7 @@ static const int FSCHMD_NO_TEMP_SENSORS[
 
 static int fschmd_probe(struct i2c_client *client,
 			const struct i2c_device_id *id);
-static int fschmd_detect(struct i2c_client *client, int kind,
+static int fschmd_detect(struct i2c_client *client,
 			 struct i2c_board_info *info);
 static int fschmd_remove(struct i2c_client *client);
 static struct fschmd_data *fschmd_update_device(struct device *dev);
@@ -1000,7 +1000,7 @@ static void fschmd_dmi_decode(const stru
 	}
 }
 
-static int fschmd_detect(struct i2c_client *client, int _kind,
+static int fschmd_detect(struct i2c_client *client,
 			 struct i2c_board_info *info)
 {
 	enum chips kind;
--- linux-2.6.33-rc0.orig/drivers/hwmon/gl518sm.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/gl518sm.c	2009-12-08 10:29:03.000000000 +0100
@@ -139,8 +139,7 @@ struct gl518_data {
 
 static int gl518_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id);
-static int gl518_detect(struct i2c_client *client, int kind,
-			struct i2c_board_info *info);
+static int gl518_detect(struct i2c_client *client, struct i2c_board_info *info);
 static void gl518_init_client(struct i2c_client *client);
 static int gl518_remove(struct i2c_client *client);
 static int gl518_read_value(struct i2c_client *client, u8 reg);
@@ -484,8 +483,7 @@ static const struct attribute_group gl51
  */
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int gl518_detect(struct i2c_client *client, int kind,
-			struct i2c_board_info *info)
+static int gl518_detect(struct i2c_client *client, struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
 	int rev;
--- linux-2.6.33-rc0.orig/drivers/hwmon/gl520sm.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/gl520sm.c	2009-12-08 10:29:03.000000000 +0100
@@ -81,8 +81,7 @@ static const u8 GL520_REG_TEMP_MAX_HYST[
 
 static int gl520_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id);
-static int gl520_detect(struct i2c_client *client, int kind,
-			struct i2c_board_info *info);
+static int gl520_detect(struct i2c_client *client, struct i2c_board_info *info);
 static void gl520_init_client(struct i2c_client *client);
 static int gl520_remove(struct i2c_client *client);
 static int gl520_read_value(struct i2c_client *client, u8 reg);
@@ -681,8 +680,7 @@ static const struct attribute_group gl52
  */
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int gl520_detect(struct i2c_client *client, int kind,
-			struct i2c_board_info *info)
+static int gl520_detect(struct i2c_client *client, struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
 
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm63.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm63.c	2009-12-08 10:29:03.000000000 +0100
@@ -134,8 +134,7 @@ static int lm63_remove(struct i2c_client
 
 static struct lm63_data *lm63_update_device(struct device *dev);
 
-static int lm63_detect(struct i2c_client *client, int kind,
-		       struct i2c_board_info *info);
+static int lm63_detect(struct i2c_client *client, struct i2c_board_info *info);
 static void lm63_init_client(struct i2c_client *client);
 
 /*
@@ -423,7 +422,7 @@ static const struct attribute_group lm63
  */
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int lm63_detect(struct i2c_client *new_client, int kind,
+static int lm63_detect(struct i2c_client *new_client,
 		       struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = new_client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm73.c	2009-12-06 12:42:05.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm73.c	2009-12-08 10:29:03.000000000 +0100
@@ -151,7 +151,7 @@ static const struct i2c_device_id lm73_i
 MODULE_DEVICE_TABLE(i2c, lm73_ids);
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int lm73_detect(struct i2c_client *new_client, int kind,
+static int lm73_detect(struct i2c_client *new_client,
 			struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = new_client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm75.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm75.c	2009-12-08 10:29:03.000000000 +0100
@@ -234,7 +234,7 @@ static const struct i2c_device_id lm75_i
 MODULE_DEVICE_TABLE(i2c, lm75_ids);
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int lm75_detect(struct i2c_client *new_client, int kind,
+static int lm75_detect(struct i2c_client *new_client,
 		       struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = new_client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm77.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm77.c	2009-12-08 10:29:03.000000000 +0100
@@ -66,8 +66,7 @@ struct lm77_data {
 
 static int lm77_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id);
-static int lm77_detect(struct i2c_client *client, int kind,
-		       struct i2c_board_info *info);
+static int lm77_detect(struct i2c_client *client, struct i2c_board_info *info);
 static void lm77_init_client(struct i2c_client *client);
 static int lm77_remove(struct i2c_client *client);
 static u16 lm77_read_value(struct i2c_client *client, u8 reg);
@@ -245,7 +244,7 @@ static const struct attribute_group lm77
 };
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int lm77_detect(struct i2c_client *new_client, int kind,
+static int lm77_detect(struct i2c_client *new_client,
 		       struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = new_client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm78.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm78.c	2009-12-08 10:29:03.000000000 +0100
@@ -142,7 +142,7 @@ struct lm78_data {
 };
 
 
-static int lm78_i2c_detect(struct i2c_client *client, int kind,
+static int lm78_i2c_detect(struct i2c_client *client,
 			   struct i2c_board_info *info);
 static int lm78_i2c_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id);
@@ -558,7 +558,7 @@ static int lm78_alias_detect(struct i2c_
 	return 1;
 }
 
-static int lm78_i2c_detect(struct i2c_client *client, int kind,
+static int lm78_i2c_detect(struct i2c_client *client,
 			   struct i2c_board_info *info)
 {
 	int i;
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm80.c	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.33-rc0/drivers/hwmon/lm80.c	2009-12-08 10:29:03.000000000 +0100
@@ -133,8 +133,7 @@ struct lm80_data {
 
 static int lm80_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id);
-static int lm80_detect(struct i2c_client *client, int kind,
-		       struct i2c_board_info *info);
+static int lm80_detect(struct i2c_client *client, struct i2c_board_info *info);
 static void lm80_init_client(struct i2c_client *client);
 static int lm80_remove(struct i2c_client *client);
 static struct lm80_data *lm80_update_device(struct device *dev);
@@ -447,8 +446,7 @@ static const struct attribute_group lm80
 };
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int lm80_detect(struct i2c_client *client, int kind,
-		       struct i2c_board_info *info)
+static int lm80_detect(struct i2c_client *client, struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
 	int i, cur;
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm83.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm83.c	2009-12-08 10:29:03.000000000 +0100
@@ -118,7 +118,7 @@ static const u8 LM83_REG_W_HIGH[] = {
  * Functions declaration
  */
 
-static int lm83_detect(struct i2c_client *new_client, int kind,
+static int lm83_detect(struct i2c_client *new_client,
 		       struct i2c_board_info *info);
 static int lm83_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id);
@@ -291,7 +291,7 @@ static const struct attribute_group lm83
  */
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int lm83_detect(struct i2c_client *new_client, int kind,
+static int lm83_detect(struct i2c_client *new_client,
 		       struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = new_client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm85.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm85.c	2009-12-08 10:29:03.000000000 +0100
@@ -323,8 +323,7 @@ struct lm85_data {
 	struct lm85_zone zone[3];
 };
 
-static int lm85_detect(struct i2c_client *client, int kind,
-		       struct i2c_board_info *info);
+static int lm85_detect(struct i2c_client *client, struct i2c_board_info *info);
 static int lm85_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id);
 static int lm85_remove(struct i2c_client *client);
@@ -1156,8 +1155,7 @@ static int lm85_is_fake(struct i2c_clien
 }
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int lm85_detect(struct i2c_client *client, int kind,
-		       struct i2c_board_info *info)
+static int lm85_detect(struct i2c_client *client, struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
 	int address = client->addr;
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm87.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm87.c	2009-12-08 10:29:03.000000000 +0100
@@ -158,7 +158,7 @@ static u8 LM87_REG_TEMP_LOW[3] = { 0x3A,
 
 static int lm87_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id);
-static int lm87_detect(struct i2c_client *new_client, int kind,
+static int lm87_detect(struct i2c_client *new_client,
 		       struct i2c_board_info *info);
 static void lm87_init_client(struct i2c_client *client);
 static int lm87_remove(struct i2c_client *client);
@@ -662,7 +662,7 @@ static const struct attribute_group lm87
 };
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int lm87_detect(struct i2c_client *new_client, int kind,
+static int lm87_detect(struct i2c_client *new_client,
 		       struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = new_client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm90.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm90.c	2009-12-08 10:29:03.000000000 +0100
@@ -152,8 +152,7 @@ I2C_CLIENT_INSMOD_8(lm90, adm1032, lm99,
  * Functions declaration
  */
 
-static int lm90_detect(struct i2c_client *client, int kind,
-		       struct i2c_board_info *info);
+static int lm90_detect(struct i2c_client *client, struct i2c_board_info *info);
 static int lm90_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id);
 static void lm90_init_client(struct i2c_client *client);
@@ -656,7 +655,7 @@ static int lm90_read_reg(struct i2c_clie
 }
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int lm90_detect(struct i2c_client *new_client, int kind,
+static int lm90_detect(struct i2c_client *new_client,
 		       struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = new_client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm92.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm92.c	2009-12-08 10:29:03.000000000 +0100
@@ -319,7 +319,7 @@ static const struct attribute_group lm92
 };
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int lm92_detect(struct i2c_client *new_client, int kind,
+static int lm92_detect(struct i2c_client *new_client,
 		       struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = new_client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm93.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm93.c	2009-12-08 10:29:03.000000000 +0100
@@ -2501,8 +2501,7 @@ static void lm93_init_client(struct i2c_
 }
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int lm93_detect(struct i2c_client *client, int kind,
-		       struct i2c_board_info *info)
+static int lm93_detect(struct i2c_client *client, struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
 	int mfr, ver;
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm95241.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm95241.c	2009-12-08 10:29:03.000000000 +0100
@@ -310,7 +310,7 @@ static const struct attribute_group lm95
 };
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int lm95241_detect(struct i2c_client *new_client, int kind,
+static int lm95241_detect(struct i2c_client *new_client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = new_client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/max1619.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/max1619.c	2009-12-08 10:29:03.000000000 +0100
@@ -88,7 +88,7 @@ static int temp_to_reg(int val)
 
 static int max1619_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id);
-static int max1619_detect(struct i2c_client *client, int kind,
+static int max1619_detect(struct i2c_client *client,
 			  struct i2c_board_info *info);
 static void max1619_init_client(struct i2c_client *client);
 static int max1619_remove(struct i2c_client *client);
@@ -226,7 +226,7 @@ static const struct attribute_group max1
  */
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int max1619_detect(struct i2c_client *client, int kind,
+static int max1619_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/max6650.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/max6650.c	2009-12-08 10:29:03.000000000 +0100
@@ -116,7 +116,7 @@ I2C_CLIENT_INSMOD_1(max6650);
 
 static int max6650_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id);
-static int max6650_detect(struct i2c_client *client, int kind,
+static int max6650_detect(struct i2c_client *client,
 			  struct i2c_board_info *info);
 static int max6650_init_client(struct i2c_client *client);
 static int max6650_remove(struct i2c_client *client);
@@ -528,7 +528,7 @@ static struct attribute_group max6650_at
  */
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int max6650_detect(struct i2c_client *client, int kind,
+static int max6650_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/pcf8591.c	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.33-rc0/drivers/hwmon/pcf8591.c	2009-12-08 10:29:03.000000000 +0100
@@ -169,7 +169,7 @@ static const struct attribute_group pcf8
  */
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int pcf8591_detect(struct i2c_client *client, int kind,
+static int pcf8591_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/smsc47m192.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/smsc47m192.c	2009-12-08 10:29:03.000000000 +0100
@@ -115,7 +115,7 @@ struct smsc47m192_data {
 
 static int smsc47m192_probe(struct i2c_client *client,
 			    const struct i2c_device_id *id);
-static int smsc47m192_detect(struct i2c_client *client, int kind,
+static int smsc47m192_detect(struct i2c_client *client,
 			     struct i2c_board_info *info);
 static int smsc47m192_remove(struct i2c_client *client);
 static struct smsc47m192_data *smsc47m192_update_device(struct device *dev);
@@ -481,7 +481,7 @@ static void smsc47m192_init_client(struc
 }
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int smsc47m192_detect(struct i2c_client *client, int kind,
+static int smsc47m192_detect(struct i2c_client *client,
 			     struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/thmc50.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/thmc50.c	2009-12-08 10:29:03.000000000 +0100
@@ -84,7 +84,7 @@ struct thmc50_data {
 	u8 alarms;
 };
 
-static int thmc50_detect(struct i2c_client *client, int kind,
+static int thmc50_detect(struct i2c_client *client,
 			 struct i2c_board_info *info);
 static int thmc50_probe(struct i2c_client *client,
 			const struct i2c_device_id *id);
@@ -286,7 +286,7 @@ static const struct attribute_group temp
 };
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int thmc50_detect(struct i2c_client *client, int kind,
+static int thmc50_detect(struct i2c_client *client,
 			 struct i2c_board_info *info)
 {
 	unsigned company;
--- linux-2.6.33-rc0.orig/drivers/hwmon/tmp401.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/tmp401.c	2009-12-08 10:29:03.000000000 +0100
@@ -98,7 +98,7 @@ static const u8 TMP411_TEMP_HIGHEST_LSB[
 
 static int tmp401_probe(struct i2c_client *client,
 			const struct i2c_device_id *id);
-static int tmp401_detect(struct i2c_client *client, int kind,
+static int tmp401_detect(struct i2c_client *client,
 			 struct i2c_board_info *info);
 static int tmp401_remove(struct i2c_client *client);
 static struct tmp401_data *tmp401_update_device(struct device *dev);
@@ -488,7 +488,7 @@ static void tmp401_init_client(struct i2
 		i2c_smbus_write_byte_data(client, TMP401_CONFIG_WRITE, config);
 }
 
-static int tmp401_detect(struct i2c_client *client, int _kind,
+static int tmp401_detect(struct i2c_client *client,
 			 struct i2c_board_info *info)
 {
 	enum chips kind;
--- linux-2.6.33-rc0.orig/drivers/hwmon/tmp421.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/tmp421.c	2009-12-08 10:29:03.000000000 +0100
@@ -223,7 +223,7 @@ static int tmp421_init_client(struct i2c
 	return 0;
 }
 
-static int tmp421_detect(struct i2c_client *client, int _kind,
+static int tmp421_detect(struct i2c_client *client,
 			 struct i2c_board_info *info)
 {
 	enum chips kind;
--- linux-2.6.33-rc0.orig/drivers/hwmon/w83781d.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/w83781d.c	2009-12-08 10:29:03.000000000 +0100
@@ -1051,8 +1051,7 @@ w83781d_create_files(struct device *dev,
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
 static int
-w83781d_detect(struct i2c_client *client, int kind,
-	       struct i2c_board_info *info)
+w83781d_detect(struct i2c_client *client, struct i2c_board_info *info)
 {
 	int val1, val2;
 	struct w83781d_data *isa = w83781d_data_if_isa();
--- linux-2.6.33-rc0.orig/drivers/hwmon/w83791d.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/w83791d.c	2009-12-08 10:29:03.000000000 +0100
@@ -326,7 +326,7 @@ struct w83791d_data {
 
 static int w83791d_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id);
-static int w83791d_detect(struct i2c_client *client, int kind,
+static int w83791d_detect(struct i2c_client *client,
 			  struct i2c_board_info *info);
 static int w83791d_remove(struct i2c_client *client);
 
@@ -1259,7 +1259,7 @@ error_sc_0:
 
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int w83791d_detect(struct i2c_client *client, int kind,
+static int w83791d_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/w83792d.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/w83792d.c	2009-12-08 10:29:03.000000000 +0100
@@ -302,7 +302,7 @@ struct w83792d_data {
 
 static int w83792d_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id);
-static int w83792d_detect(struct i2c_client *client, int kind,
+static int w83792d_detect(struct i2c_client *client,
 			  struct i2c_board_info *info);
 static int w83792d_remove(struct i2c_client *client);
 static struct w83792d_data *w83792d_update_device(struct device *dev);
@@ -1263,7 +1263,7 @@ static const struct attribute_group w837
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
 static int
-w83792d_detect(struct i2c_client *client, int kind, struct i2c_board_info *info)
+w83792d_detect(struct i2c_client *client, struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
 	int val1, val2;
--- linux-2.6.33-rc0.orig/drivers/hwmon/w83793.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/w83793.c	2009-12-08 10:29:03.000000000 +0100
@@ -230,7 +230,7 @@ static u8 w83793_read_value(struct i2c_c
 static int w83793_write_value(struct i2c_client *client, u16 reg, u8 value);
 static int w83793_probe(struct i2c_client *client,
 			const struct i2c_device_id *id);
-static int w83793_detect(struct i2c_client *client, int kind,
+static int w83793_detect(struct i2c_client *client,
 			 struct i2c_board_info *info);
 static int w83793_remove(struct i2c_client *client);
 static void w83793_init_client(struct i2c_client *client);
@@ -1161,7 +1161,7 @@ ERROR_SC_0:
 }
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int w83793_detect(struct i2c_client *client, int kind,
+static int w83793_detect(struct i2c_client *client,
 			 struct i2c_board_info *info)
 {
 	u8 tmp, bank, chip_id;
--- linux-2.6.33-rc0.orig/drivers/hwmon/w83l785ts.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/w83l785ts.c	2009-12-08 10:29:03.000000000 +0100
@@ -83,7 +83,7 @@ I2C_CLIENT_INSMOD_1(w83l785ts);
 
 static int w83l785ts_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id);
-static int w83l785ts_detect(struct i2c_client *client, int kind,
+static int w83l785ts_detect(struct i2c_client *client,
 			    struct i2c_board_info *info);
 static int w83l785ts_remove(struct i2c_client *client);
 static u8 w83l785ts_read_value(struct i2c_client *client, u8 reg, u8 defval);
@@ -146,7 +146,7 @@ static SENSOR_DEVICE_ATTR(temp1_max, S_I
  */
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int w83l785ts_detect(struct i2c_client *client, int kind,
+static int w83l785ts_detect(struct i2c_client *client,
 			    struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
--- linux-2.6.33-rc0.orig/drivers/hwmon/w83l786ng.c	2009-12-06 12:42:06.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/w83l786ng.c	2009-12-08 10:29:03.000000000 +0100
@@ -147,7 +147,7 @@ struct w83l786ng_data {
 
 static int w83l786ng_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id);
-static int w83l786ng_detect(struct i2c_client *client, int kind,
+static int w83l786ng_detect(struct i2c_client *client,
 			    struct i2c_board_info *info);
 static int w83l786ng_remove(struct i2c_client *client);
 static void w83l786ng_init_client(struct i2c_client *client);
@@ -586,8 +586,7 @@ static const struct attribute_group w83l
 };
 
 static int
-w83l786ng_detect(struct i2c_client *client, int kind,
-		 struct i2c_board_info *info)
+w83l786ng_detect(struct i2c_client *client, struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
 	u16 man_id;
--- linux-2.6.33-rc0.orig/drivers/i2c/i2c-core.c	2009-12-06 10:23:16.000000000 +0100
+++ linux-2.6.33-rc0/drivers/i2c/i2c-core.c	2009-12-08 10:29:04.000000000 +0100
@@ -1184,7 +1184,7 @@ static int i2c_detect_address(struct i2c
 	/* Finally call the custom detection function */
 	memset(&info, 0, sizeof(struct i2c_board_info));
 	info.addr = addr;
-	err = driver->detect(temp_client, -1, &info);
+	err = driver->detect(temp_client, &info);
 	if (err) {
 		/* -ENODEV is returned if the detection fails. We catch it
 		   here as this isn't an error. */
--- linux-2.6.33-rc0.orig/drivers/misc/eeprom/eeprom.c	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.33-rc0/drivers/misc/eeprom/eeprom.c	2009-12-08 10:29:04.000000000 +0100
@@ -135,8 +135,7 @@ static struct bin_attribute eeprom_attr
 };
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int eeprom_detect(struct i2c_client *client, int kind,
-			 struct i2c_board_info *info)
+static int eeprom_detect(struct i2c_client *client, struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
 
--- linux-2.6.33-rc0.orig/drivers/misc/ics932s401.c	2009-12-06 10:23:14.000000000 +0100
+++ linux-2.6.33-rc0/drivers/misc/ics932s401.c	2009-12-08 10:29:04.000000000 +0100
@@ -106,7 +106,7 @@ struct ics932s401_data {
 
 static int ics932s401_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id);
-static int ics932s401_detect(struct i2c_client *client, int kind,
+static int ics932s401_detect(struct i2c_client *client,
 			  struct i2c_board_info *info);
 static int ics932s401_remove(struct i2c_client *client);
 
@@ -413,7 +413,7 @@ static ssize_t show_spread(struct device
 }
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int ics932s401_detect(struct i2c_client *client, int kind,
+static int ics932s401_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
--- linux-2.6.33-rc0.orig/include/linux/i2c.h	2009-12-06 10:23:13.000000000 +0100
+++ linux-2.6.33-rc0/include/linux/i2c.h	2009-12-08 10:29:04.000000000 +0100
@@ -161,7 +161,7 @@ struct i2c_driver {
 	const struct i2c_device_id *id_table;
 
 	/* Device detection callback for automatic device creation */
-	int (*detect)(struct i2c_client *, int kind, struct i2c_board_info *);
+	int (*detect)(struct i2c_client *, struct i2c_board_info *);
 	const struct i2c_client_address_data *address_data;
 	struct list_head clients;
 };


-- 
Jean Delvare
