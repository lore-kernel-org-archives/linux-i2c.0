From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Drop legacy locking in i2c_new_probed_device
Date: Fri, 18 Jan 2008 12:57:23 +0100
Message-ID: <20080118125723.03543668@hyperion.delvare>
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
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

It is no longer required to hold adapter->clist_lock to call
i2c_check_addr.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
---
This goes on top of David Brownell's patch that reworked i2c_check_addr.

 drivers/i2c/i2c-core.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-2.6.24-rc8.orig/drivers/i2c/i2c-core.c	2008-01-18 12:11:51.000000000 +0100
+++ linux-2.6.24-rc8/drivers/i2c/i2c-core.c	2008-01-18 12:11:57.000000000 +0100
@@ -1086,7 +1086,6 @@ i2c_new_probed_device(struct i2c_adapter
 		return NULL;
 	}
 
-	mutex_lock(&adap->clist_lock);
 	for (i = 0; addr_list[i] != I2C_CLIENT_END; i++) {
 		/* Check address validity */
 		if (addr_list[i] < 0x03 || addr_list[i] > 0x77) {
@@ -1124,7 +1123,6 @@ i2c_new_probed_device(struct i2c_adapter
 				break;
 		}
 	}
-	mutex_unlock(&adap->clist_lock);
 
 	if (addr_list[i] == I2C_CLIENT_END) {
 		dev_dbg(&adap->dev, "Probing failed, no device found\n");


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
