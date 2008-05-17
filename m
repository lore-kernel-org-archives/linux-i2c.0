From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c/max6875: Really prevent 24RF08 corruption
Date: Sat, 17 May 2008 13:23:31 +0200
Message-ID: <20080517132331.59507e96@hyperion.delvare>
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

i2c-core takes care of the possible corruption of 24RF08 chips for
quite some times, so device devices no longer need to do it. And they
really should not, as applying the prevention twice voids it.

I thought that I had fixed all drivers long ago but apparently I had
missed that one.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Gardner <bgardner-ohtLXRgXiI/QT0dZR+AlfA@public.gmane.org>
---
This one should go in 2.6.26.

 drivers/i2c/chips/max6875.c |    3 ---
 1 file changed, 3 deletions(-)

--- linux-2.6.26-rc2.orig/drivers/i2c/chips/max6875.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.26-rc2/drivers/i2c/chips/max6875.c	2008-05-17 12:34:59.000000000 +0200
@@ -207,9 +207,6 @@ static int max6875_detect(struct i2c_ada
 	fake_client->flags = 0;
 	strlcpy(fake_client->name, "max6875 subclient", I2C_NAME_SIZE);
 
-	/* Prevent 24RF08 corruption (in case of user error) */
-	i2c_smbus_write_quick(real_client, 0);
-
 	if ((err = i2c_attach_client(real_client)) != 0)
 		goto exit_kfree2;
 


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
