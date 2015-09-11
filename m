From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] i2c-dev: Fix I2C_SLAVE ioctl comment
Date: Fri, 11 Sep 2015 11:27:18 +0200
Message-ID: <20150911112718.7f9effb2@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The first part of the comment is wrong since November 2007, delete it.

The second part of the comment is related to I2C_PEC, not I2C_SLAVE, so
move it where it belongs.

Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/i2c-dev.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

--- linux-4.2.orig/drivers/i2c/i2c-dev.c	2015-09-11 11:22:00.962436523 +0200
+++ linux-4.2/drivers/i2c/i2c-dev.c	2015-09-11 11:22:22.532879192 +0200
@@ -421,16 +421,6 @@ static long i2cdev_ioctl(struct file *fi
 	switch (cmd) {
 	case I2C_SLAVE:
 	case I2C_SLAVE_FORCE:
-		/* NOTE:  devices set up to work with "new style" drivers
-		 * can't use I2C_SLAVE, even when the device node is not
-		 * bound to a driver.  Only I2C_SLAVE_FORCE will work.
-		 *
-		 * Setting the PEC flag here won't affect kernel drivers,
-		 * which will be using the i2c_client node registered with
-		 * the driver model core.  Likewise, when that client has
-		 * the PEC flag already set, the i2c-dev driver won't see
-		 * (or use) this setting.
-		 */
 		if ((arg > 0x3ff) ||
 		    (((client->flags & I2C_M_TEN) == 0) && arg > 0x7f))
 			return -EINVAL;
@@ -446,6 +436,13 @@ static long i2cdev_ioctl(struct file *fi
 			client->flags &= ~I2C_M_TEN;
 		return 0;
 	case I2C_PEC:
+		/*
+		 * Setting the PEC flag here won't affect kernel drivers,
+		 * which will be using the i2c_client node registered with
+		 * the driver model core.  Likewise, when that client has
+		 * the PEC flag already set, the i2c-dev driver won't see
+		 * (or use) this setting.
+		 */
 		if (arg)
 			client->flags |= I2C_CLIENT_PEC;
 		else


-- 
Jean Delvare
SUSE L3 Support
