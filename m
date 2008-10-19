From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Drop 2-byte address block transfer defines
Date: Sun, 19 Oct 2008 11:43:20 +0200
Message-ID: <20081019114320.11c473ef@hyperion.delvare>
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

We have no users and no implementers for these transfer types so it
makes little sense to define functionality bits for them.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 include/linux/i2c.h |    4 ----
 1 file changed, 4 deletions(-)

--- linux-2.6.28-rc0.orig/include/linux/i2c.h	2008-10-19 11:21:25.000000000 +0200
+++ linux-2.6.28-rc0/include/linux/i2c.h	2008-10-19 11:21:58.000000000 +0200
@@ -541,8 +541,6 @@ struct i2c_msg {
 #define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA 0x02000000
 #define I2C_FUNC_SMBUS_READ_I2C_BLOCK	0x04000000 /* I2C-like block xfer  */
 #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK	0x08000000 /* w/ 1-byte reg. addr. */
-#define I2C_FUNC_SMBUS_READ_I2C_BLOCK_2	 0x10000000 /* I2C-like block xfer  */
-#define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2 0x20000000 /* w/ 2-byte reg. addr. */
 
 #define I2C_FUNC_SMBUS_BYTE (I2C_FUNC_SMBUS_READ_BYTE | \
                              I2C_FUNC_SMBUS_WRITE_BYTE)
@@ -554,8 +552,6 @@ struct i2c_msg {
                                    I2C_FUNC_SMBUS_WRITE_BLOCK_DATA)
 #define I2C_FUNC_SMBUS_I2C_BLOCK (I2C_FUNC_SMBUS_READ_I2C_BLOCK | \
                                   I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)
-#define I2C_FUNC_SMBUS_I2C_BLOCK_2 (I2C_FUNC_SMBUS_READ_I2C_BLOCK_2 | \
-                                    I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2)
 
 #define I2C_FUNC_SMBUS_EMUL (I2C_FUNC_SMBUS_QUICK | \
                              I2C_FUNC_SMBUS_BYTE | \


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
