From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] ds2482: Discard obsolete detect method
Date: Sun, 20 Sep 2009 13:34:59 +0200
Message-ID: <20090920133459.1455416e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There is no point in implementing a detect callback for the DS2482, as
this device can't be detected. It was there solely to handle "force"
module parameters to instantiate devices, but now we have a better sysfs
interface that can do the same.

So we can get rid of the ugly module parameters and the detect callback.
This shrinks the binary module size by 21%.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/w1/masters/ds2482 |    6 +++---
 drivers/w1/masters/ds2482.c     |   35 +++++------------------------------
 2 files changed, 8 insertions(+), 33 deletions(-)

--- linux-2.6.32-pre.orig/Documentation/w1/masters/ds2482	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.32-pre/Documentation/w1/masters/ds2482	2009-09-20 13:33:54.000000000 +0200
@@ -24,8 +24,8 @@ General Remarks
 
 Valid addresses are 0x18, 0x19, 0x1a, and 0x1b.
 However, the device cannot be detected without writing to the i2c bus, so no
-detection is done.
-You should force the device address.
+detection is done. You should instantiate the device explicitly.
 
-$ modprobe ds2482 force=0,0x18
+$ modprobe ds2482
+$ echo ds2482 0x18 > /sys/bus/i2c/devices/i2c-0/new_device
 
--- linux-2.6.32-pre.orig/drivers/w1/masters/ds2482.c	2009-09-20 10:52:20.000000000 +0200
+++ linux-2.6.32-pre/drivers/w1/masters/ds2482.c	2009-09-20 12:18:25.000000000 +0200
@@ -24,19 +24,6 @@
 #include "../w1_int.h"
 
 /**
- * Address is selected using 2 pins, resulting in 4 possible addresses.
- *  0x18, 0x19, 0x1a, 0x1b
- * However, the chip cannot be detected without doing an i2c write,
- * so use the force module parameter.
- */
-static const unsigned short normal_i2c[] = { I2C_CLIENT_END };
-
-/**
- * Insmod parameters
- */
-I2C_CLIENT_INSMOD_1(ds2482);
-
-/**
  * The DS2482 registers - there are 3 registers that are addressed by a read
  * pointer. The read pointer is set by the last command executed.
  *
@@ -96,8 +83,6 @@ static const u8 ds2482_chan_rd[8] =
 
 static int ds2482_probe(struct i2c_client *client,
 			const struct i2c_device_id *id);
-static int ds2482_detect(struct i2c_client *client, int kind,
-			 struct i2c_board_info *info);
 static int ds2482_remove(struct i2c_client *client);
 
 
@@ -117,8 +102,6 @@ static struct i2c_driver ds2482_driver =
 	.probe		= ds2482_probe,
 	.remove		= ds2482_remove,
 	.id_table	= ds2482_id,
-	.detect		= ds2482_detect,
-	.address_data	= &addr_data,
 };
 
 /*
@@ -425,19 +408,6 @@ static u8 ds2482_w1_reset_bus(void *data
 }
 
 
-static int ds2482_detect(struct i2c_client *client, int kind,
-			 struct i2c_board_info *info)
-{
-	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
-				     I2C_FUNC_SMBUS_BYTE))
-		return -ENODEV;
-
-	strlcpy(info->type, "ds2482", I2C_NAME_SIZE);
-
-	return 0;
-}
-
 static int ds2482_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -446,6 +416,11 @@ static int ds2482_probe(struct i2c_clien
 	int temp1;
 	int idx;
 
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
+				     I2C_FUNC_SMBUS_BYTE))
+		return -ENODEV;
+
 	if (!(data = kzalloc(sizeof(struct ds2482_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;


-- 
Jean Delvare
