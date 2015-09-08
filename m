From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] i2c-dev: Fix typo in ioctl name reference
Date: Tue, 8 Sep 2015 11:05:49 +0200
Message-ID: <20150908110549.411e99a8@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The ioctl is named I2C_RDWR for "I2C read/write". But references to it
were misspelled "rdrw". Fix them.

Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/i2c-dev.c        |    6 +++---
 fs/compat_ioctl.c            |    2 +-
 include/uapi/linux/i2c-dev.h |    4 +++-
 3 files changed, 7 insertions(+), 5 deletions(-)

--- linux-4.2.orig/drivers/i2c/i2c-dev.c	2015-09-08 09:40:43.287812694 +0200
+++ linux-4.2/drivers/i2c/i2c-dev.c	2015-09-08 09:48:55.191927122 +0200
@@ -235,7 +235,7 @@ static int i2cdev_check_addr(struct i2c_
 	return result;
 }
 
-static noinline int i2cdev_ioctl_rdrw(struct i2c_client *client,
+static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 		unsigned long arg)
 {
 	struct i2c_rdwr_ioctl_data rdwr_arg;
@@ -250,7 +250,7 @@ static noinline int i2cdev_ioctl_rdrw(st
 
 	/* Put an arbitrary limit on the number of messages that can
 	 * be sent at once */
-	if (rdwr_arg.nmsgs > I2C_RDRW_IOCTL_MAX_MSGS)
+	if (rdwr_arg.nmsgs > I2C_RDWR_IOCTL_MAX_MSGS)
 		return -EINVAL;
 
 	rdwr_pa = memdup_user(rdwr_arg.msgs,
@@ -456,7 +456,7 @@ static long i2cdev_ioctl(struct file *fi
 		return put_user(funcs, (unsigned long __user *)arg);
 
 	case I2C_RDWR:
-		return i2cdev_ioctl_rdrw(client, arg);
+		return i2cdev_ioctl_rdwr(client, arg);
 
 	case I2C_SMBUS:
 		return i2cdev_ioctl_smbus(client, arg);
--- linux-4.2.orig/fs/compat_ioctl.c	2015-09-08 09:40:43.287812694 +0200
+++ linux-4.2/fs/compat_ioctl.c	2015-09-08 09:48:55.193927164 +0200
@@ -686,7 +686,7 @@ static int do_i2c_rdwr_ioctl(unsigned in
 
 	if (get_user(nmsgs, &udata->nmsgs))
 		return -EFAULT;
-	if (nmsgs > I2C_RDRW_IOCTL_MAX_MSGS)
+	if (nmsgs > I2C_RDWR_IOCTL_MAX_MSGS)
 		return -EINVAL;
 
 	if (get_user(datap, &udata->msgs))
--- linux-4.2.orig/include/uapi/linux/i2c-dev.h	2015-09-08 09:40:43.287812694 +0200
+++ linux-4.2/include/uapi/linux/i2c-dev.h	2015-09-08 09:48:55.193927164 +0200
@@ -66,7 +66,9 @@ struct i2c_rdwr_ioctl_data {
 	__u32 nmsgs;			/* number of i2c_msgs */
 };
 
-#define  I2C_RDRW_IOCTL_MAX_MSGS	42
+#define  I2C_RDWR_IOCTL_MAX_MSGS	42
+/* Originally defined with a typo, keep if for now for compatibility */
+#define  I2C_RDRW_IOCTL_MAX_MSGS	I2C_RDWR_IOCTL_MAX_MSGS
 
 
 #endif /* _UAPI_LINUX_I2C_DEV_H */


-- 
Jean Delvare
SUSE L3 Support
