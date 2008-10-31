From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Drop I2C_CLASS_CAM_DIGITAL
Date: Fri, 31 Oct 2008 11:07:20 +0100
Message-ID: <20081031110720.4dfe98a8@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

There are a number of drivers which set their i2c bus class to
I2C_CLASS_CAM_DIGITAL, however no chip driver actually checks for this
flag, so we might as well drop it now.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/media/video/cafe_ccic.c                |    1 -
 drivers/media/video/ov7670.c                   |    1 -
 drivers/media/video/ovcamchip/ovcamchip_core.c |    1 -
 drivers/media/video/w9968cf.c                  |    1 -
 include/linux/i2c.h                            |    1 -
 5 files changed, 5 deletions(-)

--- linux-2.6.28-rc2.orig/drivers/media/video/cafe_ccic.c	2008-10-24 09:28:03.000000000 +0200
+++ linux-2.6.28-rc2/drivers/media/video/cafe_ccic.c	2008-10-31 10:15:25.000000000 +0100
@@ -569,7 +569,6 @@ static int cafe_smbus_setup(struct cafe_
 
 	cafe_smbus_enable_irq(cam);
 	adap->id = I2C_HW_SMBUS_CAFE;
-	adap->class = I2C_CLASS_CAM_DIGITAL;
 	adap->owner = THIS_MODULE;
 	adap->client_register = cafe_smbus_attach;
 	adap->client_unregister = cafe_smbus_detach;
--- linux-2.6.28-rc2.orig/drivers/media/video/ov7670.c	2008-10-10 09:27:58.000000000 +0200
+++ linux-2.6.28-rc2/drivers/media/video/ov7670.c	2008-10-31 10:15:21.000000000 +0100
@@ -1347,7 +1347,6 @@ static struct i2c_driver ov7670_driver =
 		.name = "ov7670",
 	},
 	.id 		= I2C_DRIVERID_OV7670,
-	.class 		= I2C_CLASS_CAM_DIGITAL,
 	.attach_adapter = ov7670_attach,
 	.detach_client	= ov7670_detach,
 	.command	= ov7670_command,
--- linux-2.6.28-rc2.orig/drivers/media/video/ovcamchip/ovcamchip_core.c	2008-10-24 09:28:04.000000000 +0200
+++ linux-2.6.28-rc2/drivers/media/video/ovcamchip/ovcamchip_core.c	2008-10-31 10:15:17.000000000 +0100
@@ -405,7 +405,6 @@ static struct i2c_driver driver = {
 		.name =		"ovcamchip",
 	},
 	.id =			I2C_DRIVERID_OVCAMCHIP,
-	.class =		I2C_CLASS_CAM_DIGITAL,
 	.attach_adapter =	ovcamchip_attach,
 	.detach_client =	ovcamchip_detach,
 	.command =		ovcamchip_command,
--- linux-2.6.28-rc2.orig/drivers/media/video/w9968cf.c	2008-10-24 09:28:04.000000000 +0200
+++ linux-2.6.28-rc2/drivers/media/video/w9968cf.c	2008-10-31 10:15:13.000000000 +0100
@@ -1553,7 +1553,6 @@ static int w9968cf_i2c_init(struct w9968
 
 	static struct i2c_adapter adap = {
 		.id =                I2C_HW_SMBUS_W9968CF,
-		.class =             I2C_CLASS_CAM_DIGITAL,
 		.owner =             THIS_MODULE,
 		.client_register =   w9968cf_i2c_attach_inform,
 		.client_unregister = w9968cf_i2c_detach_inform,
--- linux-2.6.28-rc2.orig/include/linux/i2c.h	2008-10-31 09:49:27.000000000 +0100
+++ linux-2.6.28-rc2/include/linux/i2c.h	2008-10-31 10:15:09.000000000 +0100
@@ -393,7 +393,6 @@ static inline void i2c_set_adapdata(stru
 #define I2C_CLASS_TV_ANALOG	(1<<1)	/* bttv + friends */
 #define I2C_CLASS_TV_DIGITAL	(1<<2)	/* dvb cards */
 #define I2C_CLASS_DDC		(1<<3)	/* DDC bus on graphics adapters */
-#define I2C_CLASS_CAM_DIGITAL	(1<<5)	/* most webcams */
 #define I2C_CLASS_SPD		(1<<7)	/* SPD EEPROMs and similar */
 
 /* i2c_client_address_data is the struct for holding default client


-- 
Jean Delvare
