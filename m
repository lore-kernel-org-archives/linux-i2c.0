From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Drop unused i2c_driver.id field
Date: Fri, 19 Jun 2009 19:44:05 +0200
Message-ID: <20090619194405.315dfb37@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Nobody is using i2c_driver.id any longer, so we can drop that field.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 include/linux/i2c-id.h |   11 -----------
 include/linux/i2c.h    |    2 --
 2 files changed, 13 deletions(-)

--- linux-2.6.31-pre.orig/include/linux/i2c-id.h	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.31-pre/include/linux/i2c-id.h	2009-06-19 19:18:39.000000000 +0200
@@ -28,17 +28,6 @@
    identify a legacy client. If you don't need them, just don't set them. */
 
 /*
- * ---- Driver types -----------------------------------------------------
- */
-
-#define I2C_DRIVERID_MSP3400	 1
-#define I2C_DRIVERID_TUNER	 2
-#define I2C_DRIVERID_TDA7432	27	/* Stereo sound processor	*/
-#define I2C_DRIVERID_TVAUDIO    29      /* Generic TV sound driver      */
-#define I2C_DRIVERID_SAA711X	73	/* saa711x video encoders	*/
-#define I2C_DRIVERID_INFRARED	75	/* I2C InfraRed on Video boards */
-
-/*
  * ---- Adapter types ----------------------------------------------------
  */
 
--- linux-2.6.31-pre.orig/include/linux/i2c.h	2009-06-19 08:57:56.000000000 +0200
+++ linux-2.6.31-pre/include/linux/i2c.h	2009-06-19 19:18:29.000000000 +0200
@@ -98,7 +98,6 @@ extern s32 i2c_smbus_write_i2c_block_dat
 
 /**
  * struct i2c_driver - represent an I2C device driver
- * @id: Unique driver ID (optional)
  * @class: What kind of i2c device we instantiate (for detect)
  * @attach_adapter: Callback for bus addition (for legacy drivers)
  * @detach_adapter: Callback for bus removal (for legacy drivers)
@@ -135,7 +134,6 @@ extern s32 i2c_smbus_write_i2c_block_dat
  * not allowed.
  */
 struct i2c_driver {
-	int id;
 	unsigned int class;
 
 	/* Notifies the driver that a new bus has appeared or is about to be


-- 
Jean Delvare
