From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH RFC] eeprom: at24: extend driver to plug into the NVMEM framework
Date: Sun, 16 Aug 2015 04:54:09 +0200
Message-ID: <1439693649-10809-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
List-Id: linux-i2c@vger.kernel.org

Add a read only regmap for accessing the EEPROM, and then use that
with the NVMEM framework.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/misc/eeprom/at24.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 2d3db81be099..0e80c0c09d4e 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -22,6 +22,8 @@
 #include <linux/jiffies.h>
 #include <linux/of.h>
 #include <linux/i2c.h>
+#include <linux/nvmem-provider.h>
+#include <linux/regmap.h>
 #include <linux/platform_data/at24.h>
 
 /*
@@ -69,6 +71,10 @@ struct at24_data {
 	unsigned write_max;
 	unsigned num_addresses;
 
+	struct regmap_config regmap_config;
+	struct nvmem_config nvmem_config;
+	struct nvmem_device *nvmem;
+
 	/*
 	 * Some chips tie up multiple I2C addresses; dummy devices reserve
 	 * them for us, and we'll use them with SMBus calls.
@@ -471,6 +477,34 @@ static ssize_t at24_macc_write(struct memory_accessor *macc, const char *buf,
 
 /*-------------------------------------------------------------------------*/
 
+/*
+ * Provide a regmap interface, which is registered with the NVMEM
+ * framework
+*/
+static int at24_regmap_read(void *context, const void *reg, size_t reg_size,
+			    void *val, size_t val_size)
+{
+	struct at24_data *at24 = context;
+	off_t offset = *(u32 *)reg;
+
+	return at24_read(at24, val, offset, val_size);
+}
+
+static int at24_regmap_write(void *context, const void *data, size_t count)
+{
+	struct at24_data *at24 = context;
+
+	return at24_write(at24, data, 0, count);
+}
+
+static const struct regmap_bus at24_regmap_bus = {
+	.read = at24_regmap_read,
+	.write = at24_regmap_write,
+	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
+};
+
+/*-------------------------------------------------------------------------*/
+
 #ifdef CONFIG_OF
 static void at24_get_ofdata(struct i2c_client *client,
 		struct at24_platform_data *chip)
@@ -502,6 +536,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	int err;
 	unsigned i, num_addresses;
 	kernel_ulong_t magic;
+	struct regmap *regmap;
 
 	if (client->dev.platform_data) {
 		chip = *(struct at24_platform_data *)client->dev.platform_data;
@@ -644,6 +679,30 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (err)
 		goto err_clients;
 
+	at24->regmap_config.reg_bits = 32;
+	at24->regmap_config.val_bits = 8;
+	at24->regmap_config.reg_stride = 1;
+	at24->regmap_config.max_register = at24->bin.size - 1;
+
+	regmap = devm_regmap_init(&client->dev, &at24_regmap_bus, at24,
+				  &at24->regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "regmap init failed\n");
+		err = PTR_ERR(regmap);
+		goto err_sysfs;
+	}
+
+	at24->nvmem_config.name = dev_name(&client->dev);
+	at24->nvmem_config.dev = &client->dev;
+	at24->nvmem_config.read_only = !writable;
+	at24->nvmem_config.owner = THIS_MODULE;
+
+	at24->nvmem = nvmem_register(&at24->nvmem_config);
+	if (IS_ERR(at24->nvmem)) {
+		err = PTR_ERR(at24->nvmem);
+		goto err_sysfs;
+	}
+
 	i2c_set_clientdata(client, at24);
 
 	dev_info(&client->dev, "%zu byte %s EEPROM, %s, %u bytes/write\n",
@@ -662,6 +721,9 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	return 0;
 
+err_sysfs:
+	sysfs_remove_bin_file(&client->dev.kobj, &at24->bin);
+
 err_clients:
 	for (i = 1; i < num_addresses; i++)
 		if (at24->client[i])
@@ -676,6 +738,9 @@ static int at24_remove(struct i2c_client *client)
 	int i;
 
 	at24 = i2c_get_clientdata(client);
+
+	nvmem_unregister(at24->nvmem);
+
 	sysfs_remove_bin_file(&client->dev.kobj, &at24->bin);
 
 	for (i = 1; i < at24->num_addresses; i++)
-- 
2.5.0
