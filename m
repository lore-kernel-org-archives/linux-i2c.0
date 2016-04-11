From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 09/13] eeprom: at24: use at24cs_serial_read()
Date: Mon, 11 Apr 2016 11:57:25 -0700
Message-ID: <1460401049-25459-10-git-send-email-bgolaszewski@baylibre.com>
References: <1460401049-25459-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460401049-25459-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, srinivas.kandagatla@linaro.org, maxime.ripard@free-electrons.com
Cc: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

Assign at24cs_serial_read() to at24->read_func if the chip allows serial
number read operation.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 4c868a2..d3e4d66 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -163,9 +163,8 @@ static struct i2c_client *at24_translate_offset(struct at24_data *at24,
 	return at24->client[i];
 }
 
-static ssize_t __attribute__((unused))
-at24cs_serial_read(struct at24_data *at24,
-		   char *buf, loff_t off, size_t count)
+static ssize_t at24cs_serial_read(struct at24_data *at24,
+				  char *buf, loff_t off, size_t count)
 {
 	unsigned long timeout, read_time;
 	struct i2c_client *client;
@@ -615,8 +614,12 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	at24->chip = chip;
 	at24->num_addresses = num_addresses;
 
-	at24->read_func = at24_read;
-	at24->write_func = at24_write;
+	if (chip.flags & AT24_FLAG_SERIAL) {
+		at24->read_func = at24cs_serial_read;
+	} else {
+		at24->read_func = at24_read;
+		at24->write_func = at24_write;
+	}
 
 	writable = !(chip.flags & AT24_FLAG_READONLY);
 	if (writable) {
-- 
2.7.4
