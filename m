From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 4/9] eeprom: at24: support reading of the serial number
Date: Wed,  2 Dec 2015 11:25:21 +0100
Message-ID: <1449051926-21918-5-git-send-email-bgolaszewski@baylibre.com>
References: <1449051926-21918-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449051926-21918-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

The at24cs series EEPROM chips have an additional read-only memory area
containing a factory pre-programmed serial number. In order to access
it, one has to perform a dummy write before reading the serial number
bytes.

Add a function that allows to access the serial number.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 08cc327..6182f47 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -163,6 +163,77 @@ static struct i2c_client *at24_translate_offset(struct at24_data *at24,
 	return at24->client[i];
 }
 
+static int __attribute__((unused)) at24cs_eeprom_serial_read(
+						struct at24_data *at24,
+						char *buf, unsigned offset,
+						size_t count)
+{
+	unsigned long timeout, read_time;
+	struct i2c_client *client;
+	struct i2c_msg msg[2];
+	u8 addrbuf[2];
+	int status;
+
+	mutex_lock(&at24->lock);
+
+	client = at24->client[1];
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
+	/*
+	 * Reads fail if the previous write didn't complete yet. We may
+	 * loop a few times until this one succeeds, waiting at least
+	 * long enough for one entire page write to work.
+	 */
+	timeout = jiffies + msecs_to_jiffies(write_timeout);
+	do {
+		read_time = jiffies;
+		status = i2c_transfer(client->adapter, msg, 2);
+		if (status == 2) {
+			mutex_unlock(&at24->lock);
+			return count;
+		}
+
+		/* REVISIT: at HZ=100, this is sloooow */
+		msleep(1);
+	} while (time_before(read_time, timeout));
+
+	mutex_unlock(&at24->lock);
+
+	return -ETIMEDOUT;
+}
+
 static ssize_t at24_eeprom_read(struct at24_data *at24, char *buf,
 		unsigned offset, size_t count)
 {
-- 
2.1.4
