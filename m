From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/2] i2c-tools: Clean up <linux/i2c-dev.h>
Date: Thu, 15 Mar 2012 16:59:47 +0100
Message-ID: <20120315165947.28828417@endymion.delvare>
References: <20120315165344.5f8e060f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120315165344.5f8e060f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Minimize differences between kernel and user-space flavors of
<linux/i2c-dev.h>.
---
 include/linux/i2c-dev.h |   60 +++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 33 deletions(-)

--- i2c-tools.orig/include/linux/i2c-dev.h	2010-12-12 14:22:33.000000000 +0100
+++ i2c-tools/include/linux/i2c-dev.h	2012-03-15 09:47:41.134895370 +0100
@@ -20,10 +20,8 @@
     MA 02110-1301 USA.
 */
 
-/* $Id: i2c-dev.h 5894 2010-12-12 13:22:29Z khali $ */
-
-#ifndef LIB_I2CDEV_H
-#define LIB_I2CDEV_H
+#ifndef _LINUX_I2C_DEV_H
+#define _LINUX_I2C_DEV_H
 
 #include <linux/types.h>
 #include <sys/ioctl.h>
@@ -111,52 +109,48 @@ union i2c_smbus_data {
 #define I2C_SMBUS_I2C_BLOCK_DATA    8
 
 
-/* ----- commands for the ioctl like i2c_command call:
- * note that additional calls are defined in the algorithm and hw 
- *	dependent layers - these can be listed here, or see the 
- *	corresponding header files.
+/* /dev/i2c-X ioctl commands.  The ioctl's parameter is always an
+ * unsigned long, except for:
+ *	- I2C_FUNCS, takes pointer to an unsigned long
+ *	- I2C_RDWR, takes pointer to struct i2c_rdwr_ioctl_data
+ *	- I2C_SMBUS, takes pointer to struct i2c_smbus_ioctl_data
  */
-				/* -> bit-adapter specific ioctls	*/
-#define I2C_RETRIES	0x0701	/* number of times a device address      */
-				/* should be polled when not            */
-                                /* acknowledging 			*/
-#define I2C_TIMEOUT	0x0702	/* set timeout - call with int 		*/
-
-
-/* this is for i2c-dev.c	*/
-#define I2C_SLAVE	0x0703	/* Change slave address			*/
-				/* Attn.: Slave address is 7 or 10 bits */
-#define I2C_SLAVE_FORCE	0x0706	/* Change slave address			*/
-				/* Attn.: Slave address is 7 or 10 bits */
-				/* This changes the address, even if it */
-				/* is already taken!			*/
-#define I2C_TENBIT	0x0704	/* 0 for 7 bit addrs, != 0 for 10 bit	*/
+#define I2C_RETRIES	0x0701	/* number of times a device address should
+				   be polled when not acknowledging */
+#define I2C_TIMEOUT	0x0702	/* set timeout in units of 10 ms */
 
-#define I2C_FUNCS	0x0705	/* Get the adapter functionality */
-#define I2C_RDWR	0x0707	/* Combined R/W transfer (one stop only)*/
-#define I2C_PEC		0x0708	/* != 0 for SMBus PEC                   */
+/* NOTE: Slave address is 7 or 10 bits, but 10-bit addresses
+ * are NOT supported! (due to code brokenness)
+ */
+#define I2C_SLAVE	0x0703	/* Use this slave address */
+#define I2C_SLAVE_FORCE	0x0706	/* Use this slave address, even if it
+				   is already in use by a driver! */
+#define I2C_TENBIT	0x0704	/* 0 for 7 bit addrs, != 0 for 10 bit */
 
-#define I2C_SMBUS	0x0720	/* SMBus-level access */
+#define I2C_FUNCS	0x0705	/* Get the adapter functionality mask */
 
-/* -- i2c.h -- */
+#define I2C_RDWR	0x0707	/* Combined R/W transfer (one STOP only) */
 
+#define I2C_PEC		0x0708	/* != 0 to use PEC with SMBus */
+#define I2C_SMBUS	0x0720	/* SMBus transfer */
 
-/* Note: 10-bit addresses are NOT supported! */
 
 /* This is the structure as used in the I2C_SMBUS ioctl call */
 struct i2c_smbus_ioctl_data {
-	char read_write;
+	__u8 read_write;
 	__u8 command;
-	int size;
+	__u32 size;
 	union i2c_smbus_data *data;
 };
 
 /* This is the structure as used in the I2C_RDWR ioctl call */
 struct i2c_rdwr_ioctl_data {
 	struct i2c_msg *msgs;	/* pointers to i2c_msgs */
-	int nmsgs;		/* number of i2c_msgs */
+	__u32 nmsgs;			/* number of i2c_msgs */
 };
 
+#define  I2C_RDRW_IOCTL_MAX_MSGS	42
+
 
 static inline __s32 i2c_smbus_access(int file, char read_write, __u8 command, 
                                      int size, union i2c_smbus_data *data)
@@ -332,4 +326,4 @@ static inline __s32 i2c_smbus_block_proc
 }
 
 
-#endif /* LIB_I2CDEV_H */
+#endif /* _LINUX_I2C_DEV_H */

-- 
Jean Delvare
