From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 13/14] eeprom: at24: add support for at24mac series
Date: Mon,  6 Jun 2016 10:48:55 +0200
Message-ID: <1465202936-16832-14-git-send-email-bgolaszewski@baylibre.com>
References: <1465202936-16832-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465202936-16832-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, GregKH <greg@kroah.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
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
 drivers/misc/eeprom/at24.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 0b5240d..b3afe15 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -347,6 +347,36 @@ static ssize_t at24_eeprom_read_serial(struct at24_data *at24, char *buf,
 	return -ETIMEDOUT;
 }
 
+static ssize_t at24_eeprom_read_mac(struct at24_data *at24, char *buf,
+				    unsigned int offset, size_t count)
+{
+	unsigned long timeout, read_time;
+	struct i2c_client *client;
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
+	loop_until_timeout(timeout, read_time) {
+		status = i2c_transfer(client->adapter, msg, 2);
+		if (status == 2)
+			return count;
+	}
+
+	return -ETIMEDOUT;
+}
+
 /*
  * Note that if the hardware write-protect pin is pulled high, the whole
  * chip is normally write protected. But there are plenty of product
@@ -648,8 +678,16 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	at24->chip = chip;
 	at24->num_addresses = num_addresses;
 
+	if ((chip.flags & AT24_FLAG_SERIAL) && (chip.flags & AT24_FLAG_MAC)) {
+		dev_err(&client->dev,
+			"invalid device data - cannot have both AT24_FLAG_SERIAL & AT24_FLAG_MAC.");
+		return -EINVAL;
+	}
+
 	if (chip.flags & AT24_FLAG_SERIAL) {
 		at24->read_func = at24_eeprom_read_serial;
+	} else if (chip.flags & AT24_FLAG_MAC) {
+		at24->read_func = at24_eeprom_read_mac;
 	} else {
 		at24->read_func = at24->use_smbus ? at24_eeprom_read_smbus
 						  : at24_eeprom_read_i2c;
-- 
2.7.4
