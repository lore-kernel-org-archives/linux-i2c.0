From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] max6875: Discard obsolete detect method
Date: Sun, 20 Sep 2009 12:07:46 +0200
Message-ID: <20090920120746.5bc4e1f0@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There is no point in implementing a detect callback for the MAX6875, as
this device can't be detected. It was there solely to handle "force"
module parameters to instantiate devices, but now we have a better sysfs
interface that can do the same.

So we can get rid of the ugly module parameters and the detect callback.
This basically divides the binary module size by 2.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/misc-devices/max6875 |    6 ++++--
 drivers/misc/eeprom/max6875.c      |   29 +++++------------------------
 2 files changed, 9 insertions(+), 26 deletions(-)

--- linux-2.6.32-pre.orig/drivers/misc/eeprom/max6875.c	2009-09-20 11:30:43.000000000 +0200
+++ linux-2.6.32-pre/drivers/misc/eeprom/max6875.c	2009-09-20 11:37:41.000000000 +0200
@@ -33,12 +33,6 @@
 #include <linux/i2c.h>
 #include <linux/mutex.h>
 
-/* Do not scan - the MAX6875 access method will write to some EEPROM chips */
-static const unsigned short normal_i2c[] = { I2C_CLIENT_END };
-
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(max6875);
-
 /* The MAX6875 can only read/write 16 bytes at a time */
 #define SLICE_SIZE			16
 #define SLICE_BITS			4
@@ -146,31 +140,21 @@ static struct bin_attribute user_eeprom_
 	.read = max6875_read,
 };
 
-/* Return 0 if detection is successful, -ENODEV otherwise */
-static int max6875_detect(struct i2c_client *client, int kind,
-			  struct i2c_board_info *info)
+static int max6875_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adapter = client->adapter;
+	struct max6875_data *data;
+	int err;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WRITE_BYTE_DATA
 				     | I2C_FUNC_SMBUS_READ_BYTE))
 		return -ENODEV;
 
-	/* Only check even addresses */
+	/* Only bind to even addresses */
 	if (client->addr & 1)
 		return -ENODEV;
 
-	strlcpy(info->type, "max6875", I2C_NAME_SIZE);
-
-	return 0;
-}
-
-static int max6875_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
-{
-	struct max6875_data *data;
-	int err;
-
 	if (!(data = kzalloc(sizeof(struct max6875_data), GFP_KERNEL)))
 		return -ENOMEM;
 
@@ -222,9 +206,6 @@ static struct i2c_driver max6875_driver
 	.probe		= max6875_probe,
 	.remove		= max6875_remove,
 	.id_table	= max6875_id,
-
-	.detect		= max6875_detect,
-	.address_data	= &addr_data,
 };
 
 static int __init max6875_init(void)
--- linux-2.6.32-pre.orig/Documentation/misc-devices/max6875	2009-09-20 11:36:24.000000000 +0200
+++ linux-2.6.32-pre/Documentation/misc-devices/max6875	2009-09-20 11:41:24.000000000 +0200
@@ -42,10 +42,12 @@ General Remarks
 
 Valid addresses for the MAX6875 are 0x50 and 0x52.
 Valid addresses for the MAX6874 are 0x50, 0x52, 0x54 and 0x56.
-The driver does not probe any address, so you must force the address.
+The driver does not probe any address, so you explicitly instantiate the
+devices.
 
 Example:
-$ modprobe max6875 force=0,0x50
+$ modprobe max6875
+$ echo max6875 0x50 > /sys/bus/i2c/devices/i2c-0/new_device
 
 The MAX6874/MAX6875 ignores address bit 0, so this driver attaches to multiple
 addresses.  For example, for address 0x50, it also reserves 0x51.


-- 
Jean Delvare
