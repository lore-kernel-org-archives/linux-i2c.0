From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 08/21] eeprom: at24: make struct initialization uniform in at24_probe()
Date: Mon, 19 Mar 2018 10:17:08 +0100
Message-ID: <20180319091721.18193-9-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

When zeroing structs, use "{ }" everywhere.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index d9d55310ffa4..83a9223e62fb 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -515,7 +515,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	struct regmap_config regmap_config = { };
 	struct nvmem_config nvmem_config = { };
 	const struct at24_chip_data *cd = NULL;
-	struct at24_platform_data chip = { 0 };
+	struct at24_platform_data chip = { };
 	unsigned int i, num_addresses;
 	struct at24_data *at24;
 	bool writable;
-- 
2.16.1
