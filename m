From: "Maciej W. Rozycki" <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: [PATCH] I2C: SiByte: Mark i2c_sibyte_add_bus() as static
Date: Sun, 11 May 2008 03:14:05 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0805110311170.18978@cliff.in.clinika.pl>
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

 The i2c_sibyte_add_bus() function is not called, nor meant to, from 
outside, so mark it as static; fixing a sparse warning too.

Signed-off-by: Maciej W. Rozycki <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
---
 It should be obvious.  Please apply.

  Maciej

patch-2.6.26-rc1-20080505-sibyte-i2c-sparse-16
diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/drivers/i2c/busses/i2c-sibyte.c linux-2.6.26-rc1-20080505/drivers/i2c/busses/i2c-sibyte.c
--- linux-2.6.26-rc1-20080505.macro/drivers/i2c/busses/i2c-sibyte.c	2008-05-05 02:55:25.000000000 +0000
+++ linux-2.6.26-rc1-20080505/drivers/i2c/busses/i2c-sibyte.c	2008-05-11 01:11:00.000000000 +0000
@@ -132,7 +132,7 @@ static const struct i2c_algorithm i2c_si
 /*
  * registering functions to load algorithms at runtime
  */
-int __init i2c_sibyte_add_bus(struct i2c_adapter *i2c_adap, int speed)
+static int __init i2c_sibyte_add_bus(struct i2c_adapter *i2c_adap, int speed)
 {
 	struct i2c_algo_sibyte_data *adap = i2c_adap->algo_data;
 

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
