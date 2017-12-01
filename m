From: Sven Van Asbroeck <svendev@arcx.com>
Subject: [PATCH] eeprom: at24: fix I2C device selection for runtime PM
Date: Fri, 1 Dec 2017 13:04:41 -0500
Message-ID: <1512151481-27483-1-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: svendev@arcx.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: divagar.mohandass@intel.com, sakari.ailus@linux.intel.com, brgl@bgdev.pl
List-Id: linux-i2c@vger.kernel.org

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
index e0b4b36..07b6b61 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -561,18 +561,16 @@ static ssize_t at24_eeprom_write_i2c(struct at24_data *at24, const char *buf,
 static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 {
 	struct at24_data *at24 = priv;
-	struct i2c_client *client;
+	struct device *dev = &at24->client[0]->dev;
 	char *buf = val;
 	int ret;
 
 	if (unlikely(!count))
 		return count;
 
-	client = at24_translate_offset(at24, &off);
-
-	ret = pm_runtime_get_sync(&client->dev);
+	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(&client->dev);
+		pm_runtime_put_noidle(dev);
 		return ret;
 	}
 
@@ -588,7 +586,7 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 		status = at24->read_func(at24, buf, off, count);
 		if (status < 0) {
 			mutex_unlock(&at24->lock);
-			pm_runtime_put(&client->dev);
+			pm_runtime_put(dev);
 			return status;
 		}
 		buf += status;
@@ -598,7 +596,7 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 
 	mutex_unlock(&at24->lock);
 
-	pm_runtime_put(&client->dev);
+	pm_runtime_put(dev);
 
 	return 0;
 }
@@ -606,18 +604,16 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 {
 	struct at24_data *at24 = priv;
-	struct i2c_client *client;
+	struct device *dev = &at24->client[0]->dev;
 	char *buf = val;
 	int ret;
 
 	if (unlikely(!count))
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
 
@@ -633,7 +629,7 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 		status = at24->write_func(at24, buf, off, count);
 		if (status < 0) {
 			mutex_unlock(&at24->lock);
-			pm_runtime_put(&client->dev);
+			pm_runtime_put(dev);
 			return status;
 		}
 		buf += status;
@@ -643,7 +639,7 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 
 	mutex_unlock(&at24->lock);
 
-	pm_runtime_put(&client->dev);
+	pm_runtime_put(dev);
 
 	return 0;
 }
-- 
1.9.1
