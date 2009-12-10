From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 5/5] i2c: Get rid of I2C_CLIENT_MODULE_PARM
Date: Thu, 10 Dec 2009 18:57:17 +0100
Message-ID: <20091210185717.75504df6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There is no user left of I2C_CLIENT_MODULE_PARM, so we can finally
get rid of this ugly macro.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 include/linux/i2c.h |   35 -----------------------------------
 1 file changed, 35 deletions(-)

--- linux-2.6.32-rc6.orig/include/linux/i2c.h	2009-11-06 10:35:38.000000000 +0100
+++ linux-2.6.32-rc6/include/linux/i2c.h	2009-11-06 10:35:42.000000000 +0100
@@ -568,39 +568,4 @@ union i2c_smbus_data {
 #define I2C_SMBUS_BLOCK_PROC_CALL   7		/* SMBus 2.0 */
 #define I2C_SMBUS_I2C_BLOCK_DATA    8
 
-
-#ifdef __KERNEL__
-
-/* These defines are used for probing i2c client addresses */
-/* The length of the option lists */
-#define I2C_CLIENT_MAX_OPTS 48
-
-/* Default fill of many variables */
-#define I2C_CLIENT_DEFAULTS {I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
-			     I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END}
-
-/* I2C_CLIENT_MODULE_PARM creates a module parameter, and puts it in the
-   module header */
-
-#define I2C_CLIENT_MODULE_PARM(var,desc) \
-  static unsigned short var[I2C_CLIENT_MAX_OPTS] = I2C_CLIENT_DEFAULTS; \
-  static unsigned int var##_num; \
-  module_param_array(var, short, &var##_num, 0); \
-  MODULE_PARM_DESC(var, desc)
-
-#endif /* __KERNEL__ */
 #endif /* _LINUX_I2C_H */


-- 
Jean Delvare
