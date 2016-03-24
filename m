From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 12/13] eeprom: at24: add support for at24mac series
Date: Thu, 24 Mar 2016 15:46:06 +0100
Message-ID: <1458830767-23816-13-git-send-email-bgolaszewski@baylibre.com>
References: <1458830767-23816-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458830767-23816-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

Add a new read function to the at24 driver allowing to retrieve the
factory-programmed mac address embedded in chips from the at24mac
family.

These chips can be instantiated similarily to the at24cs family,
except that there's no way of having access to both the serial number
and the mac address at the same time - the user must instantiate
either an at24cs or at24mac device as both special memory areas are
accessible on the same slave address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index a95a301..26c28c2 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -238,6 +238,41 @@ static int at24cs_serial_read(struct at24_data *at24,
 	return -ETIMEDOUT;
 }
 
+static int at24mac_mac_read(struct at24_data *at24,
+			   char *buf, loff_t off, size_t count)
+{
+	unsigned long timeout, read_time;
+	struct i2c_client *client;
+	unsigned int offset = off;
+	struct i2c_msg msg[2];
+	u8 addrbuf[2];
+	int status;
+
+	client = at24_translate_offset(at24, &offset);
+
+	memset(msg, 0, sizeof(msg));
+	msg[0].addr = client->addr;
+	msg[0].buf = addrbuf;
+	addrbuf[0] = 0x90 + offset;
+	msg[0].len = 1;
+	msg[1].addr = client->addr;
+	msg[1].flags = I2C_M_RD;
+	msg[1].buf = buf;
+	msg[1].len = count;
+
+	timeout = jiffies + msecs_to_jiffies(write_timeout);
+	do {
+		read_time = jiffies;
+		status = i2c_transfer(client->adapter, msg, 2);
+		if (status == 2)
+			return count;
+
+		usleep_range(1000, 1500);
+	} while (time_before(read_time, timeout));
+
+	return -ETIMEDOUT;
+}
+
 static ssize_t at24_eeprom_read(struct at24_data *at24, char *buf,
 		unsigned offset, size_t count)
 {
@@ -631,8 +666,16 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	at24->chip = chip;
 	at24->num_addresses = num_addresses;
 
+	if ((chip.flags & AT24_FLAG_SERIAL) && (chip.flags & AT24_FLAG_MAC)) {
+		dev_err(&client->dev,
+			"invalid device data - cannot have both AT24_FLAG_SERIAL & AT24_FLAG_MAC.");
+		return -EINVAL;
+	}
+
 	if (chip.flags & AT24_FLAG_SERIAL) {
 		at24->read_func = at24cs_serial_read;
+	} else if (chip.flags & AT24_FLAG_MAC) {
+		at24->read_func = at24mac_mac_read;
 	} else {
 		at24->read_func = at24_read;
 		at24->write_func = at24_write;
-- 
2.7.4
