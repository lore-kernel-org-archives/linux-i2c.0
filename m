From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 10/21] eeprom: at24: rename at24_get_pdata()
Date: Mon, 19 Mar 2018 10:17:10 +0100
Message-ID: <20180319091721.18193-11-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

As preparation for at24_probe() refactoring: rename at24_get_pdata()
to at24_properties_to_pdata(). We're doing it because we'll move the
pdata parsing code into a separate function which will be called
at24_get_pdata(). Current routine with that name actually parses
the device properties so change its name to reflect its purpose.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index d386df6b6100..dad5b0f0606e 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -460,7 +460,8 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	return 0;
 }
 
-static void at24_get_pdata(struct device *dev, struct at24_platform_data *chip)
+static void at24_properties_to_pdata(struct device *dev,
+				     struct at24_platform_data *chip)
 {
 	int err;
 	u32 val;
@@ -547,7 +548,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 		chip.byte_len = cd->byte_len;
 		chip.flags = cd->flags;
-		at24_get_pdata(&client->dev, &chip);
+		at24_properties_to_pdata(&client->dev, &chip);
 	}
 
 	if (!chip.page_size) {
-- 
2.16.1
