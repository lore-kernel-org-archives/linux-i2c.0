From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 4/5] i2c: Drop I2C_CLIENT_INSMOD_2 to 8
Date: Thu, 10 Dec 2009 18:56:43 +0100
Message-ID: <20091210185643.334b185a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

These macros simply declare an enum, so drivers might as well declare
it themselves. This puts an end to the arbitrary limit of 8 chip types
per i2c driver.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/hwmon/adm1021.c |    5 ++---
 drivers/hwmon/adm1025.c |    6 +-----
 drivers/hwmon/adm1031.c |    3 +--
 drivers/hwmon/adm9240.c |    3 +--
 drivers/hwmon/adt7475.c |    2 +-
 drivers/hwmon/dme1737.c |    6 +-----
 drivers/hwmon/f75375s.c |    3 +--
 drivers/hwmon/fschmd.c  |    3 ++-
 drivers/hwmon/gl518sm.c |    3 +--
 drivers/hwmon/lm78.c    |    3 +--
 drivers/hwmon/lm83.c    |    6 +-----
 drivers/hwmon/lm85.c    |    8 +++++---
 drivers/hwmon/lm87.c    |    6 +-----
 drivers/hwmon/lm90.c    |    7 +------
 drivers/hwmon/thmc50.c  |    2 +-
 drivers/hwmon/tmp401.c  |    3 +--
 drivers/hwmon/tmp421.c  |    3 +--
 drivers/hwmon/w83781d.c |    5 +++--
 include/linux/i2c.h     |   24 ------------------------
 19 files changed, 26 insertions(+), 75 deletions(-)

--- linux-2.6.33-rc0.orig/drivers/hwmon/adm1021.c	2009-12-08 10:45:41.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adm1021.c	2009-12-08 11:19:14.000000000 +0100
@@ -34,9 +34,8 @@
 static const unsigned short normal_i2c[] = {
 	0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, 0x4e, I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_8(adm1021, adm1023, max1617, max1617a, thmc10, lm84, gl523sm,
-			mc1066);
+enum chips {
+	adm1021, adm1023, max1617, max1617a, thmc10, lm84, gl523sm, mc1066 };
 
 /* adm1021 constants specified below */
 
--- linux-2.6.33-rc0.orig/drivers/hwmon/adm1025.c	2009-12-08 10:45:41.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adm1025.c	2009-12-08 11:19:14.000000000 +0100
@@ -64,11 +64,7 @@
 
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
-/*
- * Insmod parameters
- */
-
-I2C_CLIENT_INSMOD_2(adm1025, ne1619);
+enum chips { adm1025, ne1619 };
 
 /*
  * The ADM1025 registers
--- linux-2.6.33-rc0.orig/drivers/hwmon/adm1031.c	2009-12-08 10:45:41.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adm1031.c	2009-12-08 11:19:14.000000000 +0100
@@ -64,8 +64,7 @@
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_2(adm1030, adm1031);
+enum chips { adm1030, adm1031 };
 
 typedef u8 auto_chan_table_t[8][2];
 
--- linux-2.6.33-rc0.orig/drivers/hwmon/adm9240.c	2009-12-08 10:45:41.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adm9240.c	2009-12-08 11:19:14.000000000 +0100
@@ -55,8 +55,7 @@
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f,
 					I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_3(adm9240, ds1780, lm81);
+enum chips { adm9240, ds1780, lm81 };
 
 /* ADM9240 registers */
 #define ADM9240_REG_MAN_ID		0x3e
--- linux-2.6.33-rc0.orig/drivers/hwmon/adt7475.c	2009-12-08 11:04:22.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/adt7475.c	2009-12-08 11:19:14.000000000 +0100
@@ -148,7 +148,7 @@
 
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
-I2C_CLIENT_INSMOD_4(adt7473, adt7475, adt7476, adt7490);
+enum chips { adt7473, adt7475, adt7476, adt7490 };
 
 static const struct i2c_device_id adt7475_id[] = {
 	{ "adt7473", adt7473 },
--- linux-2.6.33-rc0.orig/drivers/hwmon/dme1737.c	2009-12-08 10:45:41.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/dme1737.c	2009-12-08 11:19:14.000000000 +0100
@@ -57,11 +57,7 @@ MODULE_PARM_DESC(probe_all_addr, "Includ
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = {0x2c, 0x2d, 0x2e, I2C_CLIENT_END};
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_2(dme1737, sch5027);
-
-/* ISA chip types */
-enum isa_chips { sch311x = sch5027 + 1 };
+enum chips { dme1737, sch5027, sch311x };
 
 /* ---------------------------------------------------------------------
  * Registers
--- linux-2.6.33-rc0.orig/drivers/hwmon/f75375s.c	2009-12-08 10:45:41.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/f75375s.c	2009-12-08 11:19:14.000000000 +0100
@@ -39,8 +39,7 @@
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2d, 0x2e, I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_2(f75373, f75375);
+enum chips { f75373, f75375 };
 
 /* Fintek F75375 registers  */
 #define F75375_REG_CONFIG0		0x0
--- linux-2.6.33-rc0.orig/drivers/hwmon/fschmd.c	2009-12-08 10:45:41.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/fschmd.c	2009-12-08 11:19:14.000000000 +0100
@@ -56,7 +56,8 @@ static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
-I2C_CLIENT_INSMOD_7(fscpos, fscher, fscscy, fschrc, fschmd, fschds, fscsyl);
+
+enum chips { fscpos, fscher, fscscy, fschrc, fschmd, fschds, fscsyl };
 
 /*
  * The FSCHMD registers and other defines
--- linux-2.6.33-rc0.orig/drivers/hwmon/gl518sm.c	2009-12-08 10:45:41.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/gl518sm.c	2009-12-08 11:19:14.000000000 +0100
@@ -46,8 +46,7 @@
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_2(gl518sm_r00, gl518sm_r80);
+enum chips { gl518sm_r00, gl518sm_r80 };
 
 /* Many GL518 constants specified below */
 
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm78.c	2009-12-08 10:45:41.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm78.c	2009-12-08 11:19:14.000000000 +0100
@@ -41,8 +41,7 @@ static const unsigned short normal_i2c[]
 						0x2e, 0x2f, I2C_CLIENT_END };
 static unsigned short isa_address = 0x290;
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_2(lm78, lm79);
+enum chips { lm78, lm79 };
 
 /* Many LM78 constants specified below */
 
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm83.c	2009-12-08 10:45:41.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm83.c	2009-12-08 11:19:14.000000000 +0100
@@ -51,11 +51,7 @@
 static const unsigned short normal_i2c[] = {
 	0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, 0x4e, I2C_CLIENT_END };
 
-/*
- * Insmod parameters
- */
-
-I2C_CLIENT_INSMOD_2(lm83, lm82);
+enum chips { lm83, lm82 };
 
 /*
  * The LM83 registers
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm85.c	2009-12-08 10:45:41.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm85.c	2009-12-08 11:19:14.000000000 +0100
@@ -38,9 +38,11 @@
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_7(lm85b, lm85c, adm1027, adt7463, adt7468, emc6d100,
-		    emc6d102);
+enum chips {
+	any_chip, lm85b, lm85c,
+	adm1027, adt7463, adt7468,
+	emc6d100, emc6d102
+};
 
 /* The LM85 registers */
 
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm87.c	2009-12-08 10:45:41.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm87.c	2009-12-08 11:19:14.000000000 +0100
@@ -74,11 +74,7 @@
 
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
-/*
- * Insmod parameters
- */
-
-I2C_CLIENT_INSMOD_2(lm87, adm1024);
+enum chips { lm87, adm1024 };
 
 /*
  * The LM87 registers
--- linux-2.6.33-rc0.orig/drivers/hwmon/lm90.c	2009-12-08 10:45:41.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/lm90.c	2009-12-08 11:19:14.000000000 +0100
@@ -93,12 +93,7 @@
 static const unsigned short normal_i2c[] = {
 	0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, 0x4e, I2C_CLIENT_END };
 
-/*
- * Insmod parameters
- */
-
-I2C_CLIENT_INSMOD_8(lm90, adm1032, lm99, lm86, max6657, adt7461, max6680,
-		    max6646);
+enum chips { lm90, adm1032, lm99, lm86, max6657, adt7461, max6680, max6646 };
 
 /*
  * The LM90 registers
--- linux-2.6.33-rc0.orig/drivers/hwmon/thmc50.c	2009-12-08 10:45:41.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/thmc50.c	2009-12-08 11:19:14.000000000 +0100
@@ -35,7 +35,7 @@ MODULE_LICENSE("GPL");
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
 /* Insmod parameters */
-I2C_CLIENT_INSMOD_2(thmc50, adm1022);
+enum chips { thmc50, adm1022 };
 
 static unsigned short adm1022_temp3[16];
 static unsigned int adm1022_temp3_num;
--- linux-2.6.33-rc0.orig/drivers/hwmon/tmp401.c	2009-12-08 10:45:41.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/tmp401.c	2009-12-08 11:19:14.000000000 +0100
@@ -42,8 +42,7 @@
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x4c, I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_2(tmp401, tmp411);
+enum chips { tmp401, tmp411 };
 
 /*
  * The TMP401 registers, note some registers have different addresses for
--- linux-2.6.33-rc0.orig/drivers/hwmon/tmp421.c	2009-12-08 10:45:41.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/tmp421.c	2009-12-08 11:19:14.000000000 +0100
@@ -39,8 +39,7 @@
 static unsigned short normal_i2c[] = { 0x2a, 0x4c, 0x4d, 0x4e, 0x4f,
 				       I2C_CLIENT_END };
 
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_3(tmp421, tmp422, tmp423);
+enum chips { tmp421, tmp422, tmp423 };
 
 /* The TMP421 registers */
 #define TMP421_CONFIG_REG_1			0x09
--- linux-2.6.33-rc0.orig/drivers/hwmon/w83781d.c	2009-12-08 10:45:41.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/w83781d.c	2009-12-08 11:19:14.000000000 +0100
@@ -56,9 +56,10 @@
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
 						0x2e, 0x2f, I2C_CLIENT_END };
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_4(w83781d, w83782d, w83783s, as99127f);
 
+enum chips { w83781d, w83782d, w83783s, as99127f };
+
+/* Insmod parameters */
 static unsigned short force_subclients[4];
 module_param_array(force_subclients, short, NULL, 0);
 MODULE_PARM_DESC(force_subclients, "List of subclient addresses: "
--- linux-2.6.33-rc0.orig/include/linux/i2c.h	2009-12-08 11:04:56.000000000 +0100
+++ linux-2.6.33-rc0/include/linux/i2c.h	2009-12-08 11:19:14.000000000 +0100
@@ -602,29 +602,5 @@ union i2c_smbus_data {
   module_param_array(var, short, &var##_num, 0); \
   MODULE_PARM_DESC(var, desc)
 
-/* These are the ones you want to use in your own drivers. Pick the one
-   which matches the number of devices the driver differenciates between. */
-#define I2C_CLIENT_INSMOD_2(chip1, chip2)				\
-enum chips { any_chip, chip1, chip2 }
-
-#define I2C_CLIENT_INSMOD_3(chip1, chip2, chip3)			\
-enum chips { any_chip, chip1, chip2, chip3 }
-
-#define I2C_CLIENT_INSMOD_4(chip1, chip2, chip3, chip4)			\
-enum chips { any_chip, chip1, chip2, chip3, chip4 }
-
-#define I2C_CLIENT_INSMOD_5(chip1, chip2, chip3, chip4, chip5)		\
-enum chips { any_chip, chip1, chip2, chip3, chip4, chip5 }
-
-#define I2C_CLIENT_INSMOD_6(chip1, chip2, chip3, chip4, chip5, chip6)	\
-enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6 }
-
-#define I2C_CLIENT_INSMOD_7(chip1, chip2, chip3, chip4, chip5, chip6, chip7) \
-enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6,	\
-	     chip7 }
-
-#define I2C_CLIENT_INSMOD_8(chip1, chip2, chip3, chip4, chip5, chip6, chip7, chip8) \
-enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6,	\
-	     chip7, chip8 }
 #endif /* __KERNEL__ */
 #endif /* _LINUX_I2C_H */


-- 
Jean Delvare
