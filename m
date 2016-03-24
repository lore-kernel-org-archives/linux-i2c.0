From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 07/13] eeprom: at24: support reading of the serial number
Date: Thu, 24 Mar 2016 17:19:37 +0100
Message-ID: <1458836383-6668-8-git-send-email-bgolaszewski@baylibre.com>
References: <1458836383-6668-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37020 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756729AbcCXQTy (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 24 Mar 2016 12:19:54 -0400
Received: by mail-wm0-f54.google.com with SMTP id p65so73383541wmp.0
        for <linux-i2c@vger.kernel.org>; Thu, 24 Mar 2016 09:19:54 -0700 (PDT)
In-Reply-To: <1458836383-6668-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

The at24cs series EEPROM chips have an additional read-only memory area
containing a factory pre-programmed serial number. In order to access
it, one has to perform a dummy write before reading the serial number
bytes.

Add a function that allows to access the serial number.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index bc5be1e..fda5c56 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -159,6 +159,65 @@ static struct i2c_client *at24_translate_offset(struct at24_data *at24,
 	return at24->client[i];
 }
 
+static ssize_t __attribute__((unused))
+at24cs_serial_read(struct at24_data *at24,
+		   char *buf, loff_t off, size_t count)
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
-- 
2.7.4
