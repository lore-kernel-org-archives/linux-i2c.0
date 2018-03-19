From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 13/21] eeprom: at24: readability tweak in at24_probe()
Date: Mon, 19 Mar 2018 10:17:13 +0100
Message-ID: <20180319091721.18193-14-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

Use a helper variable for the size we want to allocate with
devm_kzalloc() and save an ugly line break.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index e4c1997c2b56..ea5e81cb8e8c 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -520,6 +520,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	struct device *dev = &client->dev;
 	unsigned int i, num_addresses;
 	struct at24_data *at24;
+	size_t at24_size;
 	bool writable;
 	u8 test_byte;
 	int err;
@@ -573,8 +574,8 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	regmap_config.reg_bits = (pdata.flags & AT24_FLAG_ADDR16) ? 16 : 8;
 	regmap_config.disable_locking = true;
 
-	at24 = devm_kzalloc(dev, sizeof(struct at24_data) + num_addresses *
-			    sizeof(struct at24_client), GFP_KERNEL);
+	at24_size = sizeof(*at24) + num_addresses * sizeof(struct at24_client);
+	at24 = devm_kzalloc(dev, at24_size, GFP_KERNEL);
 	if (!at24)
 		return -ENOMEM;
 
-- 
2.16.1
