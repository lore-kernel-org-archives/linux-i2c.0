From: Sven Van Asbroeck <svendev@arcx.com>
Subject: [PATCH v2] eeprom: at24: fix I2C device selection for runtime PM
Date: Fri, 1 Dec 2017 13:37:12 -0500
Message-ID: <1512153432-491-1-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.arcx.com ([184.94.50.18]:38381 "EHLO WEBMAIL.arcx.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751208AbdLAShe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 1 Dec 2017 13:37:34 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: svendev@arcx.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: divagar.mohandass@intel.com, sakari.ailus@linux.intel.com, brgl@bgdev.pl

From: Sakari Ailus <sakari.ailus@linux.intel.com>

The at24 driver creates dummy I2C devices to access offsets in the chip
that are outside the area supported using a single I2C address. It is not
meaningful to use runtime PM to such devices; the system firmware (ACPI)
does not know about these devices nor runtime PM was enabled for them.
Always use the real device instead of the dummy ones.

Fixes: 98e8201039af ("eeprom: at24: enable runtime pm support")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Sven Van Asbroeck on a 24AA16/24LC16B <svendev@arcx.com>
[Bartosz: rebased on top of previous fixes for 4.15, tweaked the
          commit message]
[Sven: fixed Bartosz's rebase]
Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 305a7a4..20b4f26 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -562,7 +562,7 @@ static ssize_t at24_eeprom_write_i2c(struct at24_data *at24, const char *buf,
 static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 {
 	struct at24_data *at24 = priv;
-	struct i2c_client *client;
+	struct device *dev = &at24->client[0]->dev;
 	char *buf = val;
 	int ret;
 
@@ -572,11 +572,9 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 	if (off + count > at24->chip.byte_len)
 		return -EINVAL;
 
-	client = at24_translate_offset(at24, &off);
-
-	ret = pm_runtime_get_sync(&client->dev);
+	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(&client->dev);
+		pm_runtime_put_noidle(dev);
 		return ret;
 	}
 
@@ -592,7 +590,7 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 		status = at24->read_func(at24, buf, off, count);
 		if (status < 0) {
 			mutex_unlock(&at24->lock);
-			pm_runtime_put(&client->dev);
+			pm_runtime_put(dev);
 			return status;
 		}
 		buf += status;
@@ -602,7 +600,7 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 
 	mutex_unlock(&at24->lock);
 
-	pm_runtime_put(&client->dev);
+	pm_runtime_put(dev);
 
 	return 0;
 }
@@ -610,7 +608,7 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 {
 	struct at24_data *at24 = priv;
-	struct i2c_client *client;
+	struct device *dev = &at24->client[0]->dev;
 	char *buf = val;
 	int ret;
 
@@ -620,11 +618,9 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	if (off + count > at24->chip.byte_len)
 		return -EINVAL;
 
-	client = at24_translate_offset(at24, &off);
-
-	ret = pm_runtime_get_sync(&client->dev);
+	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(&client->dev);
+		pm_runtime_put_noidle(dev);
 		return ret;
 	}
 
@@ -640,7 +636,7 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 		status = at24->write_func(at24, buf, off, count);
 		if (status < 0) {
 			mutex_unlock(&at24->lock);
-			pm_runtime_put(&client->dev);
+			pm_runtime_put(dev);
 			return status;
 		}
 		buf += status;
@@ -650,7 +646,7 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 
 	mutex_unlock(&at24->lock);
 
-	pm_runtime_put(&client->dev);
+	pm_runtime_put(dev);
 
 	return 0;
 }
-- 
1.9.1
