From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 01/21] eeprom: at24: disable regmap locking
Date: Mon, 19 Mar 2018 10:17:01 +0100
Message-ID: <20180319091721.18193-2-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

We use our own mutex for locking. Disable the regmap-specific locking.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 01f9c4921c50..73af6c5a2d73 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -577,6 +577,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	regmap_config.val_bits = 8;
 	regmap_config.reg_bits = (chip.flags & AT24_FLAG_ADDR16) ? 16 : 8;
+	regmap_config.disable_locking = true;
 
 	at24 = devm_kzalloc(&client->dev, sizeof(struct at24_data) +
 		num_addresses * sizeof(struct at24_client), GFP_KERNEL);
-- 
2.16.1
