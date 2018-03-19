From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 02/21] eeprom: at24: remove nvmem_config from at24_data
Date: Mon, 19 Mar 2018 10:17:02 +0100
Message-ID: <20180319091721.18193-3-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

This structure only needs to exist during the call to nvmem_register().

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 73af6c5a2d73..2600657c7034 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -75,7 +75,6 @@ struct at24_data {
 	unsigned int num_addresses;
 	unsigned int offset_adj;
 
-	struct nvmem_config nvmem_config;
 	struct nvmem_device *nvmem;
 
 	struct gpio_desc *wp_gpio;
@@ -523,6 +522,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	int err;
 	unsigned int i, num_addresses;
 	struct regmap_config regmap_config = { };
+	struct nvmem_config nvmem_config = { };
 	u8 test_byte;
 
 	if (client->dev.platform_data) {
@@ -650,21 +650,21 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		goto err_clients;
 	}
 
-	at24->nvmem_config.name = dev_name(&client->dev);
-	at24->nvmem_config.dev = &client->dev;
-	at24->nvmem_config.read_only = !writable;
-	at24->nvmem_config.root_only = true;
-	at24->nvmem_config.owner = THIS_MODULE;
-	at24->nvmem_config.compat = true;
-	at24->nvmem_config.base_dev = &client->dev;
-	at24->nvmem_config.reg_read = at24_read;
-	at24->nvmem_config.reg_write = at24_write;
-	at24->nvmem_config.priv = at24;
-	at24->nvmem_config.stride = 1;
-	at24->nvmem_config.word_size = 1;
-	at24->nvmem_config.size = chip.byte_len;
-
-	at24->nvmem = nvmem_register(&at24->nvmem_config);
+	nvmem_config.name = dev_name(&client->dev);
+	nvmem_config.dev = &client->dev;
+	nvmem_config.read_only = !writable;
+	nvmem_config.root_only = true;
+	nvmem_config.owner = THIS_MODULE;
+	nvmem_config.compat = true;
+	nvmem_config.base_dev = &client->dev;
+	nvmem_config.reg_read = at24_read;
+	nvmem_config.reg_write = at24_write;
+	nvmem_config.priv = at24;
+	nvmem_config.stride = 1;
+	nvmem_config.word_size = 1;
+	nvmem_config.size = chip.byte_len;
+
+	at24->nvmem = nvmem_register(&nvmem_config);
 
 	if (IS_ERR(at24->nvmem)) {
 		err = PTR_ERR(at24->nvmem);
-- 
2.16.1
