From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 03/21] eeprom: at24: arrange local variables
Date: Mon, 19 Mar 2018 10:17:03 +0100
Message-ID: <20180319091721.18193-4-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

Arrange declarations of local variables by line length as visually
it's easier to read.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 2600657c7034..2a4154eeb1bd 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -370,11 +370,14 @@ static ssize_t at24_regmap_write(struct at24_data *at24, const char *buf,
 
 static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 {
-	struct at24_data *at24 = priv;
-	struct device *dev = &at24->client[0].client->dev;
+	struct at24_data *at24;
+	struct device *dev;
 	char *buf = val;
 	int ret;
 
+	at24 = priv;
+	dev = &at24->client[0].client->dev;
+
 	if (unlikely(!count))
 		return count;
 
@@ -416,11 +419,14 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 
 static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 {
-	struct at24_data *at24 = priv;
-	struct device *dev = &at24->client[0].client->dev;
+	struct at24_data *at24;
+	struct device *dev;
 	char *buf = val;
 	int ret;
 
+	at24 = priv;
+	dev = &at24->client[0].client->dev;
+
 	if (unlikely(!count))
 		return -EINVAL;
 
@@ -515,15 +521,15 @@ static unsigned int at24_get_offset_adj(u8 flags, unsigned int byte_len)
 
 static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
-	struct at24_platform_data chip = { 0 };
-	const struct at24_chip_data *cd = NULL;
-	bool writable;
-	struct at24_data *at24;
-	int err;
-	unsigned int i, num_addresses;
 	struct regmap_config regmap_config = { };
 	struct nvmem_config nvmem_config = { };
+	const struct at24_chip_data *cd = NULL;
+	struct at24_platform_data chip = { 0 };
+	unsigned int i, num_addresses;
+	struct at24_data *at24;
+	bool writable;
 	u8 test_byte;
+	int err;
 
 	if (client->dev.platform_data) {
 		chip = *(struct at24_platform_data *)client->dev.platform_data;
-- 
2.16.1
