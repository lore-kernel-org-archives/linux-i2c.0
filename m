From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 09/21] eeprom: at24: don't check if byte_len is a power of 2
Date: Mon, 19 Mar 2018 10:17:09 +0100
Message-ID: <20180319091721.18193-10-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

We support certain models the size of which is not a power of 2. This
is not a reason to emit a warning.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 83a9223e62fb..d386df6b6100 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -550,9 +550,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		at24_get_pdata(&client->dev, &chip);
 	}
 
-	if (!is_power_of_2(chip.byte_len))
-		dev_warn(&client->dev,
-			"byte_len looks suspicious (no power of 2)!\n");
 	if (!chip.page_size) {
 		dev_err(&client->dev, "page_size must not be 0!\n");
 		return -EINVAL;
-- 
2.16.1
