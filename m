From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c/tsl2550: Use combined SMBus transactions
Date: Wed, 15 Jul 2009 22:28:24 +0200
Message-ID: <20090715222824.2250d26b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Michele De Candia <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Make the I/O faster, mainly by using combined SMBus transactions when
possible. While the TSL2550 datasheet doesn't say the device supports
them, they seem to work just fine in practice, and a combined
transaction is faster than two simple transactions in many cases and
always more reliable.

A side effect is to suppress the delays between SMBus writes and
reads. The datasheet doesn't say they are needed and things work just
fine for me without them.

I also couldn't see any reason for the delay between reading the two
channels. Nor for the loop to get a reading in the first place. The
400 ms delay between samples only matters at chip power-up, after that
the chip always hold the previously sampled value so we never get to
wait.

All these changes make reading the lux value much faster and cheaper.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Michele De Candia <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
Cc: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
---
Michele, Rodolfo, can you please test and confirm the driver still
works OK for you? Thanks.

 drivers/i2c/chips/tsl2550.c |   42 ++++++++++--------------------------------
 1 file changed, 10 insertions(+), 32 deletions(-)

--- linux-2.6.31-rc3.orig/drivers/i2c/chips/tsl2550.c	2009-07-15 22:19:51.000000000 +0200
+++ linux-2.6.31-rc3/drivers/i2c/chips/tsl2550.c	2009-07-15 22:20:03.000000000 +0200
@@ -24,10 +24,9 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/mutex.h>
-#include <linux/delay.h>
 
 #define TSL2550_DRV_NAME	"tsl2550"
-#define DRIVER_VERSION		"1.1.2"
+#define DRIVER_VERSION		"1.2"
 
 /*
  * Defines
@@ -96,32 +95,13 @@ static int tsl2550_set_power_state(struc
 
 static int tsl2550_get_adc_value(struct i2c_client *client, u8 cmd)
 {
-	unsigned long end;
-	int loop = 0, ret = 0;
+	int ret;
 
-	/*
-	 * Read ADC channel waiting at most 400ms (see data sheet for further
-	 * info).
-	 * To avoid long busy wait we spin for few milliseconds then
-	 * start sleeping.
-	 */
-	end = jiffies + msecs_to_jiffies(400);
-	while (time_before(jiffies, end)) {
-		i2c_smbus_write_byte(client, cmd);
-
-		if (loop++ < 5)
-			mdelay(1);
-		else
-			msleep(1);
-
-		ret = i2c_smbus_read_byte(client);
-		if (ret < 0)
-			return ret;
-		else if (ret & 0x0080)
-			break;
-	}
+	ret = i2c_smbus_read_byte_data(client, cmd);
+	if (ret < 0)
+		return ret;
 	if (!(ret & 0x80))
-		return -EIO;
+		return -EAGAIN;
 	return ret & 0x7f;	/* remove the "valid" bit */
 }
 
@@ -285,8 +265,6 @@ static ssize_t __tsl2550_show_lux(struct
 		return ret;
 	ch0 = ret;
 
-	mdelay(1);
-
 	ret = tsl2550_get_adc_value(client, TSL2550_READ_ADC1);
 	if (ret < 0)
 		return ret;
@@ -345,11 +323,10 @@ static int tsl2550_init_client(struct i2
 	 * Probe the chip. To do so we try to power up the device and then to
 	 * read back the 0x03 code
 	 */
-	err = i2c_smbus_write_byte(client, TSL2550_POWER_UP);
+	err = i2c_smbus_read_byte_data(client, TSL2550_POWER_UP);
 	if (err < 0)
 		return err;
-	mdelay(1);
-	if (i2c_smbus_read_byte(client) != TSL2550_POWER_UP)
+	if (err != TSL2550_POWER_UP)
 		return -ENODEV;
 	data->power_state = 1;
 
@@ -374,7 +351,8 @@ static int __devinit tsl2550_probe(struc
 	struct tsl2550_data *data;
 	int *opmode, err = 0;
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE)) {
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WRITE_BYTE
+					    | I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
 		err = -EIO;
 		goto exit;
 	}


-- 
Jean Delvare
