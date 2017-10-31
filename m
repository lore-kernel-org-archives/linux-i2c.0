From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 10/15] hwmon: (w83791d) Remove duplicate NULL check
Date: Tue, 31 Oct 2017 16:21:44 +0200
Message-ID: <20171031142149.32512-10-andriy.shevchenko@linux.intel.com>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
Sender: linux-hwmon-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Marc Hulsman <m.hulsman@tudelft.nl>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Since i2c_unregister_device() became NULL-aware we may remove duplicate
NULL check.

Cc: Marc Hulsman <m.hulsman@tudelft.nl>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwmon/w83791d.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index 8af6081b4ab4..28fa3bd2c096 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -1316,8 +1316,7 @@ static int w83791d_detect_subclients(struct i2c_client *client)
 /* Undo inits in case of errors */
 
 error_sc_1:
-	if (data->lm75[0] != NULL)
-		i2c_unregister_device(data->lm75[0]);
+	i2c_unregister_device(data->lm75[0]);
 error_sc_0:
 	return err;
 }
@@ -1434,10 +1433,8 @@ static int w83791d_probe(struct i2c_client *client,
 error4:
 	sysfs_remove_group(&client->dev.kobj, &w83791d_group);
 error3:
-	if (data->lm75[0] != NULL)
-		i2c_unregister_device(data->lm75[0]);
-	if (data->lm75[1] != NULL)
-		i2c_unregister_device(data->lm75[1]);
+	i2c_unregister_device(data->lm75[0]);
+	i2c_unregister_device(data->lm75[1]);
 	return err;
 }
 
@@ -1448,10 +1445,8 @@ static int w83791d_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &w83791d_group);
 
-	if (data->lm75[0] != NULL)
-		i2c_unregister_device(data->lm75[0]);
-	if (data->lm75[1] != NULL)
-		i2c_unregister_device(data->lm75[1]);
+	i2c_unregister_device(data->lm75[0]);
+	i2c_unregister_device(data->lm75[1]);
 
 	return 0;
 }
-- 
2.14.2

