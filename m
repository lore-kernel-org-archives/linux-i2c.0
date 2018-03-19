From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 21/21] eeprom: at24: simplify the i2c functionality checking
Date: Mon, 19 Mar 2018 10:17:21 +0100
Message-ID: <20180319091721.18193-22-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

Save one call and make code prettier by checking the i2c functionality
in the beginning of at24_probe(), saving the relevant values and
reusing them later.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index c42e479b880a..d15934b876c1 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -561,6 +561,7 @@ static int at24_probe(struct i2c_client *client)
 	struct nvmem_config nvmem_config = { };
 	struct at24_platform_data pdata = { };
 	struct device *dev = &client->dev;
+	bool i2c_fn_i2c, i2c_fn_block;
 	unsigned int i, num_addresses;
 	struct at24_data *at24;
 	struct regmap *regmap;
@@ -569,13 +570,15 @@ static int at24_probe(struct i2c_client *client)
 	u8 test_byte;
 	int err;
 
+	i2c_fn_i2c = i2c_check_functionality(client->adapter, I2C_FUNC_I2C);
+	i2c_fn_block = i2c_check_functionality(client->adapter,
+					       I2C_FUNC_SMBUS_WRITE_I2C_BLOCK);
+
 	err = at24_get_pdata(dev, &pdata);
 	if (err)
 		return err;
 
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
-	    !i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_WRITE_I2C_BLOCK))
+	if (!i2c_fn_i2c && !i2c_fn_block)
 		pdata.page_size = 1;
 
 	if (!pdata.page_size) {
@@ -628,8 +631,7 @@ static int at24_probe(struct i2c_client *client)
 	if (writable) {
 		at24->write_max = min_t(unsigned int,
 					pdata.page_size, at24_io_limit);
-		if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
-		    at24->write_max > I2C_SMBUS_BLOCK_MAX)
+		if (!i2c_fn_i2c && at24->write_max > I2C_SMBUS_BLOCK_MAX)
 			at24->write_max = I2C_SMBUS_BLOCK_MAX;
 	}
 
-- 
2.16.1
