From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 04/13] eeprom: at24: make locking more fine-grained
Date: Mon, 11 Apr 2016 11:57:20 -0700
Message-ID: <1460401049-25459-5-git-send-email-bgolaszewski@baylibre.com>
References: <1460401049-25459-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460401049-25459-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, srinivas.kandagatla@linaro.org, maxime.ripard@free-electrons.com
Cc: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

The only field in struct at24_data that needs locking in the module
code is u8 *writebuf. Other data is already protected by i2c core.

Rename the lock in at24_data to wrbuf_lock and only use it where
writebuf is accessed.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 744c526..9e01428 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -59,13 +59,8 @@ struct at24_data {
 	int use_smbus;
 	int use_smbus_write;
 
-	/*
-	 * Lock protects against activities from other Linux tasks,
-	 * but not from changes by other I2C masters.
-	 */
-	struct mutex lock;
-
 	u8 *writebuf;
+	struct mutex wrbuf_lock;
 	unsigned write_max;
 	unsigned num_addresses;
 
@@ -260,12 +255,6 @@ static ssize_t at24_read(struct at24_data *at24,
 	if (unlikely(!count))
 		return count;
 
-	/*
-	 * Read data from chip, protecting against concurrent updates
-	 * from this host, but not from other I2C masters.
-	 */
-	mutex_lock(&at24->lock);
-
 	while (count) {
 		ssize_t	status;
 
@@ -281,8 +270,6 @@ static ssize_t at24_read(struct at24_data *at24,
 		retval += status;
 	}
 
-	mutex_unlock(&at24->lock);
-
 	return retval;
 }
 
@@ -322,6 +309,8 @@ static ssize_t at24_eeprom_write(struct at24_data *at24, const char *buf,
 		msg.addr = client->addr;
 		msg.flags = 0;
 
+		mutex_lock(&at24->wrbuf_lock);
+
 		/* msg.buf is u8 and casts will mask the values */
 		msg.buf = at24->writebuf;
 		if (at24->chip.flags & AT24_FLAG_ADDR16)
@@ -356,6 +345,7 @@ static ssize_t at24_eeprom_write(struct at24_data *at24, const char *buf,
 				status = count;
 		} else {
 			status = i2c_transfer(client->adapter, &msg, 1);
+			mutex_unlock(&at24->wrbuf_lock);
 			if (status == 1)
 				status = count;
 		}
@@ -380,12 +370,6 @@ static ssize_t at24_write(struct at24_data *at24, const char *buf, loff_t off,
 	if (unlikely(!count))
 		return count;
 
-	/*
-	 * Write data to chip, protecting against concurrent updates
-	 * from this host, but not from other I2C masters.
-	 */
-	mutex_lock(&at24->lock);
-
 	while (count) {
 		ssize_t	status;
 
@@ -401,8 +385,6 @@ static ssize_t at24_write(struct at24_data *at24, const char *buf, loff_t off,
 		retval += status;
 	}
 
-	mutex_unlock(&at24->lock);
-
 	return retval;
 }
 
@@ -566,7 +548,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (!at24)
 		return -ENOMEM;
 
-	mutex_init(&at24->lock);
+	mutex_init(&at24->wrbuf_lock);
 	at24->use_smbus = use_smbus;
 	at24->use_smbus_write = use_smbus_write;
 	at24->chip = chip;
-- 
2.7.4
