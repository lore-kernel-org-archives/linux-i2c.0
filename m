From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 5/9] eeprom: at24: export the serial number through sysfs
Date: Tue, 24 Nov 2015 10:44:41 +0100
Message-ID: <1448358285-25016-6-git-send-email-bgolaszewski@baylibre.com>
References: <1448358285-25016-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448358285-25016-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

The at24 driver is now capable of reading the serial number from at24cs
EEPROM chips. Export the serial number through sysfs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 6182f47..65fca1e 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -65,6 +65,7 @@ struct at24_data {
 	 */
 	struct mutex lock;
 	struct bin_attribute bin;
+	struct bin_attribute *bin_serial;
 
 	u8 *writebuf;
 	unsigned write_max;
@@ -103,6 +104,7 @@ MODULE_PARM_DESC(write_timeout, "Time (in ms) to try writes (default 25)");
 
 #define AT24_BITMASK(x) (BIT(x) - 1)
 
+#define AT24CS_SERIAL_SIZE 16
 #define AT24CS_SERIAL_ADDR(addr) (addr + 0x08)
 
 /* create non-zero magic value for given eeprom parameters */
@@ -163,10 +165,8 @@ static struct i2c_client *at24_translate_offset(struct at24_data *at24,
 	return at24->client[i];
 }
 
-static int __attribute__((unused)) at24cs_eeprom_serial_read(
-						struct at24_data *at24,
-						char *buf, unsigned offset,
-						size_t count)
+static int at24cs_eeprom_serial_read(struct at24_data *at24, char *buf,
+				     unsigned offset, size_t count)
 {
 	unsigned long timeout, read_time;
 	struct i2c_client *client;
@@ -234,6 +234,16 @@ static int __attribute__((unused)) at24cs_eeprom_serial_read(
 	return -ETIMEDOUT;
 }
 
+static ssize_t at24cs_bin_serial_read(struct file *filp, struct kobject *kobj,
+				      struct bin_attribute *attr,
+				      char *buf, loff_t off, size_t count)
+{
+	struct at24_data *at24;
+
+	at24 = dev_get_drvdata(container_of(kobj, struct device, kobj));
+	return at24cs_eeprom_serial_read(at24, buf, off, count);
+}
+
 static ssize_t at24_eeprom_read(struct at24_data *at24, char *buf,
 		unsigned offset, size_t count)
 {
@@ -658,6 +668,30 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	at24->bin.read = at24_bin_read;
 	at24->bin.size = chip.byte_len;
 
+	if (at24->chip.flags & AT24_FLAG_SERIAL) {
+		/*
+		 * For EEPROMs containing the serial number export an
+		 * additional file allowing allowing convenvient access
+		 * to it from user-space.
+		 */
+		at24->bin_serial = devm_kzalloc(&client->dev,
+						sizeof(struct bin_attribute),
+						GFP_KERNEL);
+		if (!at24->bin_serial)
+			return -ENOMEM;
+
+		sysfs_bin_attr_init(at24->bin_serial);
+		at24->bin_serial->attr.name = "serial";
+		at24->bin_serial->attr.mode = S_IRUSR;
+		at24->bin_serial->read = at24cs_bin_serial_read;
+		at24->bin_serial->size = AT24CS_SERIAL_SIZE;
+
+		err = sysfs_create_bin_file(&client->dev.kobj,
+					    at24->bin_serial);
+		if (err)
+			goto err_clients;
+	}
+
 	at24->macc.read = at24_macc_read;
 
 	writable = !(chip.flags & AT24_FLAG_READONLY);
@@ -757,6 +791,8 @@ static int at24_remove(struct i2c_client *client)
 
 	at24 = i2c_get_clientdata(client);
 	sysfs_remove_bin_file(&client->dev.kobj, &at24->bin);
+	if (at24->bin_serial)
+		sysfs_remove_bin_file(&client->dev.kobj, at24->bin_serial);
 
 	for (i = 1; i < at24->num_addresses; i++)
 		i2c_unregister_device(at24->client[i]);
-- 
2.1.4
