From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 10/14] eeprom: at24: support reading the serial number
Date: Mon,  6 Jun 2016 10:48:52 +0200
Message-ID: <1465202936-16832-11-git-send-email-bgolaszewski@baylibre.com>
References: <1465202936-16832-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37526 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbcFFItS (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 6 Jun 2016 04:49:18 -0400
Received: by mail-wm0-f54.google.com with SMTP id k204so16919317wmk.0
        for <linux-i2c@vger.kernel.org>; Mon, 06 Jun 2016 01:49:17 -0700 (PDT)
In-Reply-To: <1465202936-16832-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, GregKH <greg@kroah.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The at24cs series EEPROM chips have an additional read-only memory area
containing a factory pre-programmed serial number. In order to access
it, one has to perform a dummy write before reading the serial number
bytes.

Add a function that allows to access the serial number and assign it
to at24->read_func if the chip allows serial number read operations
and the driver was passed the relevant flag for this device.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 62 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 6acf35a..29bbdad 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -276,6 +276,59 @@ static ssize_t at24_eeprom_read_i2c(struct at24_data *at24, char *buf,
 	return -ETIMEDOUT;
 }
 
+static ssize_t at24_eeprom_read_serial(struct at24_data *at24, char *buf,
+				       unsigned int offset, size_t count)
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
+
+	/*
+	 * The address pointer of the device is shared between the regular
+	 * EEPROM array and the serial number block. The dummy write (part of
+	 * the sequential read protocol) ensures the address pointer is reset
+	 * to the desired position.
+	 */
+	if (at24->chip.flags & AT24_FLAG_ADDR16) {
+		/*
+		 * For 16 bit address pointers, the word address must contain
+		 * a '10' sequence in bits 11 and 10 regardless of the
+		 * intended position of the address pointer.
+		 */
+		addrbuf[0] = 0x08;
+		addrbuf[1] = offset;
+		msg[0].len = 2;
+	} else {
+		/*
+		 * Otherwise the word address must begin with a '10' sequence,
+		 * regardless of the intended address.
+		 */
+		addrbuf[0] = 0x80 + offset;
+		msg[0].len = 1;
+	}
+
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
@@ -577,8 +630,13 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	at24->chip = chip;
 	at24->num_addresses = num_addresses;
 
-	at24->read_func = at24->use_smbus ? at24_eeprom_read_smbus
-					  : at24_eeprom_read_i2c;
+	if (chip.flags & AT24_FLAG_SERIAL) {
+		at24->read_func = at24_eeprom_read_serial;
+	} else {
+		at24->read_func = at24->use_smbus ? at24_eeprom_read_smbus
+						  : at24_eeprom_read_i2c;
+	}
+
 	if (at24->use_smbus) {
 		if (at24->use_smbus_write == I2C_SMBUS_I2C_BLOCK_DATA)
 			at24->write_func = at24_eeprom_write_smbus_block;
-- 
2.7.4
