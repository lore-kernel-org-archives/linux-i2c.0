From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 16/21] eeprom: at24: move platform data processing into a separate routine
Date: Mon, 19 Mar 2018 10:17:16 +0100
Message-ID: <20180319091721.18193-17-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

This driver can receive its device data from different sources
depending on the system. Move the entire code processing platform data,
device tree and acpi into a separate function.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 70 ++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 243d46912f29..bed6917468e1 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -493,6 +493,43 @@ static void at24_properties_to_pdata(struct device *dev,
 	}
 }
 
+static int at24_get_pdata(struct device *dev, struct at24_platform_data *pdata)
+{
+	struct device_node *of_node = dev->of_node;
+	const struct at24_chip_data *cdata;
+	const struct i2c_device_id *id;
+	struct at24_platform_data *pd;
+
+	pd = dev_get_platdata(dev);
+	if (pd) {
+		memcpy(pdata, pd, sizeof(*pdata));
+		return 0;
+	}
+
+	id = i2c_match_id(at24_ids, to_i2c_client(dev));
+
+	/*
+	 * The I2C core allows OF nodes compatibles to match against the
+	 * I2C device ID table as a fallback, so check not only if an OF
+	 * node is present but also if it matches an OF device ID entry.
+	 */
+	if (of_node && of_match_device(at24_of_match, dev))
+		cdata = of_device_get_match_data(dev);
+	else if (id)
+		cdata = (void *)&id->driver_data;
+	else
+		cdata = acpi_device_get_match_data(dev);
+
+	if (!cdata)
+		return -ENODEV;
+
+	pdata->byte_len = cdata->byte_len;
+	pdata->flags = cdata->flags;
+	at24_properties_to_pdata(dev, pdata);
+
+	return 0;
+}
+
 static unsigned int at24_get_offset_adj(u8 flags, unsigned int byte_len)
 {
 	if (flags & AT24_FLAG_MAC) {
@@ -520,10 +557,8 @@ static int at24_probe(struct i2c_client *client)
 {
 	struct regmap_config regmap_config = { };
 	struct nvmem_config nvmem_config = { };
-	const struct at24_chip_data *cd = NULL;
 	struct at24_platform_data pdata = { };
 	struct device *dev = &client->dev;
-	const struct i2c_device_id *id;
 	unsigned int i, num_addresses;
 	struct at24_data *at24;
 	size_t at24_size;
@@ -531,34 +566,9 @@ static int at24_probe(struct i2c_client *client)
 	u8 test_byte;
 	int err;
 
-	id = i2c_match_id(at24_ids, client);
-
-	if (dev->platform_data) {
-		pdata = *(struct at24_platform_data *)dev->platform_data;
-	} else {
-		/*
-		 * The I2C core allows OF nodes compatibles to match against the
-		 * I2C device ID table as a fallback, so check not only if an OF
-		 * node is present but also if it matches an OF device ID entry.
-		 */
-		if (dev->of_node && of_match_device(at24_of_match, dev)) {
-			cd = of_device_get_match_data(dev);
-		} else if (id) {
-			cd = (void *)id->driver_data;
-		} else {
-			const struct acpi_device_id *aid;
-
-			aid = acpi_match_device(at24_acpi_ids, dev);
-			if (aid)
-				cd = (void *)aid->driver_data;
-		}
-		if (!cd)
-			return -ENODEV;
-
-		pdata.byte_len = cd->byte_len;
-		pdata.flags = cd->flags;
-		at24_properties_to_pdata(dev, &pdata);
-	}
+	err = at24_get_pdata(dev, &pdata);
+	if (err)
+		return err;
 
 	if (!pdata.page_size) {
 		dev_err(dev, "page_size must not be 0!\n");
-- 
2.16.1
