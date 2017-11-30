From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 1/1] =?UTF-8?q?at24:=20Fix=20I=C2=B2C=20device=20selection?= =?UTF-8?q?=20for=20runtime=20PM?=
Date: Fri,  1 Dec 2017 00:35:24 +0200
Message-ID: <20171130223524.31716-1-sakari.ailus@linux.intel.com>
References: <1512068603-12378-1-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:57724 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750760AbdK3Wf1 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 30 Nov 2017 17:35:27 -0500
In-Reply-To: <1512068603-12378-1-git-send-email-svendev@arcx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, svendev@arcx.com
Cc: linux-kernel@vger.kernel.org, divagar.mohandass@intel.com, brgl@bgdev.pl

The at24 driver creates dummy I²C devices to access offsets in the chip
that are outside the area supported using a single I²C address. It is not
meaningful to use runtime PM to such devices; the system firmware (ACPI)
does not know about these devices nor runtime PM was enabled for them.
Always use the real device instead of the dummy ones.

Fixes: 98e8201039af ("eeprom: at24: enable runtime pm support")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/misc/eeprom/at24.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index e0b4b36ef010..07b6b61b96ee 100644
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
2.11.0
