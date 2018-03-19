From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 14/21] eeprom: at24: provide and use at24_base_client_dev()
Date: Mon, 19 Mar 2018 10:17:14 +0100
Message-ID: <20180319091721.18193-15-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

Use a helper function for accessing the device struct of the base
i2c client. This routine is named in a way that reflects its purpose
unlike the previously hand-coded dereferencing.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index ea5e81cb8e8c..02b710919b8b 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -260,6 +260,11 @@ static struct at24_client *at24_translate_offset(struct at24_data *at24,
 	return &at24->client[i];
 }
 
+static struct device *at24_base_client_dev(struct at24_data *at24)
+{
+	return &at24->client[0].client->dev;
+}
+
 static size_t at24_adjust_read_count(struct at24_data *at24,
 				      unsigned int offset, size_t count)
 {
@@ -371,7 +376,7 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 	int ret;
 
 	at24 = priv;
-	dev = &at24->client[0].client->dev;
+	dev = at24_base_client_dev(at24);
 
 	if (unlikely(!count))
 		return count;
@@ -418,7 +423,7 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	int ret;
 
 	at24 = priv;
-	dev = &at24->client[0].client->dev;
+	dev = at24_base_client_dev(at24);
 
 	if (unlikely(!count))
 		return -EINVAL;
-- 
2.16.1
