From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH][v4.9.y, v4.14.y] eeprom: at24: make spd world-readable again
Date: Mon,  5 Aug 2019 10:01:25 +0200
Message-ID: <20190805080125.20943-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

From: Jean Delvare <jdelvare@suse.de>

The integration of the at24 driver into the nvmem framework broke the
world-readability of spd EEPROMs. Fix it.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: stable@vger.kernel.org
Fixes: 57d155506dd5 ("eeprom: at24: extend driver to plug into the NVMEM framework")
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Arnd Bergmann <arnd@arndb.de>
[Bartosz: backported the patch to older branches]
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index a37b9b6a315a..2eef811764ad 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -777,7 +777,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	at24->nvmem_config.name = dev_name(&client->dev);
 	at24->nvmem_config.dev = &client->dev;
 	at24->nvmem_config.read_only = !writable;
-	at24->nvmem_config.root_only = true;
+	at24->nvmem_config.root_only = !(chip.flags & AT24_FLAG_IRUGO);
 	at24->nvmem_config.owner = THIS_MODULE;
 	at24->nvmem_config.compat = true;
 	at24->nvmem_config.base_dev = &client->dev;
-- 
2.21.0
