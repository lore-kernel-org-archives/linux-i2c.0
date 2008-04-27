From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c/tps65010: Add missing intialization of client data
Date: Sun, 27 Apr 2008 20:16:22 +0200
Message-ID: <20080427201622.01649249@hyperion.delvare>
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
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

tps65010_remove() calls i2c_get_clientdata(client) but the client data
is never set during initialization, so it gets a NULL pointer at best.

I guess it was never spotted because the tps65010 driver is typically
not built modular so this function is discarded.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/i2c/chips/tps65010.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.26-rc0.orig/drivers/i2c/chips/tps65010.c	2008-04-27 20:03:14.000000000 +0200
+++ linux-2.6.26-rc0/drivers/i2c/chips/tps65010.c	2008-04-27 20:05:23.000000000 +0200
@@ -527,6 +527,7 @@ static int __exit tps65010_remove(struct
 	flush_scheduled_work();
 	debugfs_remove(tps->file);
 	kfree(tps);
+	i2c_set_clientdata(client, NULL);
 	the_tps = NULL;
 	return 0;
 }
@@ -616,6 +617,7 @@ static int tps65010_probe(struct i2c_cli
 		i2c_smbus_read_byte_data(client, TPS_DEFGPIO),
 		i2c_smbus_read_byte_data(client, TPS_MASK3));
 
+	i2c_set_clientdata(client, tps);
 	the_tps = tps;
 
 #if	defined(CONFIG_USB_GADGET) && !defined(CONFIG_USB_OTG)


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
