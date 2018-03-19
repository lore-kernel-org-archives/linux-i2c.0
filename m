From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 07/21] eeprom: at24: drop redundant variable in at24_write()
Date: Mon, 19 Mar 2018 10:17:07 +0100
Message-ID: <20180319091721.18193-8-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

We can reuse ret instead of defining a loop-local status variable.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index ff7eb8e382c2..d9d55310ffa4 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -440,18 +440,16 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	gpiod_set_value_cansleep(at24->wp_gpio, 0);
 
 	while (count) {
-		int status;
-
-		status = at24_regmap_write(at24, buf, off, count);
-		if (status < 0) {
+		ret = at24_regmap_write(at24, buf, off, count);
+		if (ret < 0) {
 			gpiod_set_value_cansleep(at24->wp_gpio, 1);
 			mutex_unlock(&at24->lock);
 			pm_runtime_put(dev);
-			return status;
+			return ret;
 		}
-		buf += status;
-		off += status;
-		count -= status;
+		buf += ret;
+		off += ret;
+		count -= ret;
 	}
 
 	gpiod_set_value_cansleep(at24->wp_gpio, 1);
-- 
2.16.1
