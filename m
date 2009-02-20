From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-dev: Clarify the unit of ioctl I2C_TIMEOUT
Date: Fri, 20 Feb 2009 13:21:37 +0100
Message-ID: <20090220132137.6a86dda6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The unit in which user-space can set the bus timeout value is jiffies
for historical reasons (back when HZ was always 100.) This is however
not good because user-space doesn't know how long a jiffy lasts. The
timeout value should instead be set in a fixed time unit. Given the
original value of HZ, this unit should be 10 ms, for compatibility.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/i2c-dev.c   |    6 +++++-
 include/linux/i2c-dev.h |    2 +-
 include/linux/i2c.h     |    2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

--- linux-2.6.29-rc5.orig/drivers/i2c/i2c-dev.c	2009-01-06 20:24:44.000000000 +0100
+++ linux-2.6.29-rc5/drivers/i2c/i2c-dev.c	2009-02-20 12:59:38.000000000 +0100
@@ -35,6 +35,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
 #include <linux/smp_lock.h>
+#include <linux/jiffies.h>
 #include <asm/uaccess.h>
 
 static struct i2c_driver i2cdev_driver;
@@ -422,7 +423,10 @@ static long i2cdev_ioctl(struct file *fi
 		client->adapter->retries = arg;
 		break;
 	case I2C_TIMEOUT:
-		client->adapter->timeout = arg;
+		/* For historical reasons, user-space sets the timeout
+		 *  value in units of 10 ms.
+		 */
+		client->adapter->timeout = msecs_to_jiffies(arg * 10);
 		break;
 	default:
 		/* NOTE:  returning a fault code here could cause trouble
--- linux-2.6.29-rc5.orig/include/linux/i2c-dev.h	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.29-rc5/include/linux/i2c-dev.h	2009-02-20 12:48:08.000000000 +0100
@@ -33,7 +33,7 @@
  */
 #define I2C_RETRIES	0x0701	/* number of times a device address should
 				   be polled when not acknowledging */
-#define I2C_TIMEOUT	0x0702	/* set timeout in jiffies - call with int */
+#define I2C_TIMEOUT	0x0702	/* set timeout in units of 10 ms */
 
 /* NOTE: Slave address is 7 or 10 bits, but 10-bit addresses
  * are NOT supported! (due to code brokenness)
--- linux-2.6.29-rc5.orig/include/linux/i2c.h	2009-01-29 08:27:20.000000000 +0100
+++ linux-2.6.29-rc5/include/linux/i2c.h	2009-02-20 12:47:39.000000000 +0100
@@ -361,7 +361,7 @@ struct i2c_adapter {
 	struct mutex bus_lock;
 	struct mutex clist_lock;
 
-	int timeout;
+	int timeout;			/* in jiffies */
 	int retries;
 	struct device dev;		/* the adapter device */
 


-- 
Jean Delvare
