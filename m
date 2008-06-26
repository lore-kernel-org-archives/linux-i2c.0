From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-dev: Delete empty detach_client callback
Date: Thu, 26 Jun 2008 14:01:27 +0200
Message-ID: <20080626140127.2e8e87f2@hyperion.delvare>
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

Implementing detach_client is optional, so there is no point in
an empty implementation.

Likewise, i2c driver IDs are optional, and we don't need one.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/i2c-dev.c  |    7 -------
 include/linux/i2c-id.h |    2 --
 2 files changed, 9 deletions(-)

--- linux-2.6.26-rc8.orig/drivers/i2c/i2c-dev.c	2008-06-26 13:59:13.000000000 +0200
+++ linux-2.6.26-rc8/drivers/i2c/i2c-dev.c	2008-06-26 13:59:30.000000000 +0200
@@ -548,19 +548,12 @@ static int i2cdev_detach_adapter(struct 
 	return 0;
 }
 
-static int i2cdev_detach_client(struct i2c_client *client)
-{
-	return 0;
-}
-
 static struct i2c_driver i2cdev_driver = {
 	.driver = {
 		.name	= "dev_driver",
 	},
-	.id		= I2C_DRIVERID_I2CDEV,
 	.attach_adapter	= i2cdev_attach_adapter,
 	.detach_adapter	= i2cdev_detach_adapter,
-	.detach_client	= i2cdev_detach_client,
 };
 
 /* ------------------------------------------------------------------------- */
--- linux-2.6.26-rc8.orig/include/linux/i2c-id.h	2008-06-26 13:59:15.000000000 +0200
+++ linux-2.6.26-rc8/include/linux/i2c-id.h	2008-06-26 13:59:30.000000000 +0200
@@ -83,8 +83,6 @@
 #define I2C_DRIVERID_M52790 	95      /* Mitsubishi M52790SP/FP AV switch */
 #define I2C_DRIVERID_CS5345	96	/* cs5345 audio processor	*/
 
-#define I2C_DRIVERID_I2CDEV	900
-
 #define I2C_DRIVERID_OV7670 1048	/* Omnivision 7670 camera */
 
 /*


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
