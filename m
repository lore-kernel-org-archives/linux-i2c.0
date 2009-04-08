From: Daniel Silverstone <dsilvers-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
Subject: PCA953x: Support GPIOLIB GPIO naming
Date: Wed, 08 Apr 2009 15:48:12 +0100
Message-ID: <1239202092.21238.20.camel@petitemort>
Reply-To: dsilvers-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Gardner <bgardner-ohtLXRgXiI/QT0dZR+AlfA@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch adds support to the PCA953x driver to use the GPIOLIB
naming facility for GPIOs.

Signed-off-by: Daniel Silverstone <dsilvers-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>

Index: linux-2.6.27/drivers/gpio/pca953x.c
===================================================================
--- linux-2.6.27.orig/drivers/gpio/pca953x.c	2008-12-11 13:09:44.287305039 +0000
+++ linux-2.6.27/drivers/gpio/pca953x.c	2008-12-11 13:53:54.283301612 +0000
@@ -45,6 +45,7 @@
 
 	struct i2c_client *client;
 	struct gpio_chip gpio_chip;
+	char **names;
 };
 
 /* NOTE:  we can't currently rely on fault codes to come from SMBus
@@ -190,6 +191,7 @@
 	gc->label = chip->client->name;
 	gc->dev = &chip->client->dev;
 	gc->owner = THIS_MODULE;
+	gc->names = chip->names;
 }
 
 static int __devinit pca953x_probe(struct i2c_client *client,
@@ -211,6 +213,8 @@
 
 	chip->gpio_start = pdata->gpio_base;
 
+	chip->names = pdata->names;
+
 	/* initialize cached registers from their original values.
 	 * we can't share this chip with another i2c master.
 	 */
Index: linux-2.6.27/include/linux/i2c/pca953x.h
===================================================================
--- linux-2.6.27.orig/include/linux/i2c/pca953x.h	2008-12-11 13:09:55.307306141 +0000
+++ linux-2.6.27/include/linux/i2c/pca953x.h	2008-12-11 13:55:53.139301080 +0000
@@ -15,4 +15,5 @@
 	int		(*teardown)(struct i2c_client *client,
 				unsigned gpio, unsigned ngpio,
 				void *context);
+	char		**names;
 };

-- 
Daniel Silverstone                              http://www.simtec.co.uk/
PGP mail accepted and encouraged.            Key Id: 2BC8 4016 2068 7895
