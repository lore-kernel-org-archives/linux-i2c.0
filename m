From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-amd756: Fix functionality flags
Date: Fri, 16 May 2008 13:54:10 +0200
Message-ID: <20080516135410.6a1f7a42@hyperion.delvare>
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

The i2c-amd756 driver pretends to support SMBus process call
transactions but actually does not. Fix it.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
This one will go in 2.6.26.

 drivers/i2c/busses/i2c-amd756.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.26-rc2.orig/drivers/i2c/busses/i2c-amd756.c	2008-05-16 13:46:14.000000000 +0200
+++ linux-2.6.26-rc2/drivers/i2c/busses/i2c-amd756.c	2008-05-16 13:46:25.000000000 +0200
@@ -290,7 +290,7 @@ static u32 amd756_func(struct i2c_adapte
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
-	    I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_PROC_CALL;
+	    I2C_FUNC_SMBUS_BLOCK_DATA;
 }
 
 static const struct i2c_algorithm smbus_algorithm = {


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
