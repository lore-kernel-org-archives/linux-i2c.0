From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-tiny-usb: Fix on big-endian systems
Date: Thu, 28 Jan 2010 09:34:13 +0100
Message-ID: <20100128093413.31aad8a2@hyperion.delvare>
References: <20100122194807.1e2131d4@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100122194807.1e2131d4-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Till Harbaum <till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The functionality bit vector is always returned as a little-endian
32-bit number by the device, so it must be byte-swapped to the host
endianness.

On the other hand, the delay value is handled by the USB stack, so no
byte swapping is needed on our side.

This fixes bug #15105:
http://bugzilla.kernel.org/show_bug.cgi?id=15105

Reported-by: Jens Richter <jens-dOUPgdA+p/6o8zYe/P2rPqhivhuVJJ3m@public.gmane.org>
Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Tested-by: Jens Richter <jens-dOUPgdA+p/6o8zYe/P2rPqhivhuVJJ3m@public.gmane.org>
Cc: Till Harbaum <till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>
Cc: stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
---
 drivers/i2c/busses/i2c-tiny-usb.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.33-rc5.orig/drivers/i2c/busses/i2c-tiny-usb.c	2010-01-28 08:08:54.000000000 +0100
+++ linux-2.6.33-rc5/drivers/i2c/busses/i2c-tiny-usb.c	2010-01-28 09:13:30.000000000 +0100
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/module.h>
+#include <linux/types.h>
 
 /* include interfaces to usb layer */
 #include <linux/usb.h>
@@ -31,8 +32,8 @@
 #define CMD_I2C_IO_END		(1<<1)
 
 /* i2c bit delay, default is 10us -> 100kHz */
-static int delay = 10;
-module_param(delay, int, 0);
+static unsigned short delay = 10;
+module_param(delay, ushort, 0);
 MODULE_PARM_DESC(delay, "bit delay in microseconds, "
 		 "e.g. 10 for 100kHz (default is 100kHz)");
 
@@ -109,7 +110,7 @@ static int usb_xfer(struct i2c_adapter *
 
 static u32 usb_func(struct i2c_adapter *adapter)
 {
-	u32 func;
+	__le32 func;
 
 	/* get functionality from adapter */
 	if (usb_read(adapter, CMD_GET_FUNC, 0, 0, &func, sizeof(func)) !=
@@ -118,7 +119,7 @@ static u32 usb_func(struct i2c_adapter *
 		return 0;
 	}
 
-	return func;
+	return le32_to_cpu(func);
 }
 
 /* This is the actual algorithm we define */
@@ -216,8 +217,7 @@ static int i2c_tiny_usb_probe(struct usb
 		 "i2c-tiny-usb at bus %03d device %03d",
 		 dev->usb_dev->bus->busnum, dev->usb_dev->devnum);
 
-	if (usb_write(&dev->adapter, CMD_SET_DELAY,
-		      cpu_to_le16(delay), 0, NULL, 0) != 0) {
+	if (usb_write(&dev->adapter, CMD_SET_DELAY, delay, 0, NULL, 0) != 0) {
 		dev_err(&dev->adapter.dev,
 			"failure setting delay to %dus\n", delay);
 		retval = -EIO;


-- 
Jean Delvare
