From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 11/15] hwmon: (w83792d) Remove duplicate NULL check
Date: Tue, 31 Oct 2017 16:21:45 +0200
Message-ID: <20171031142149.32512-11-andriy.shevchenko@linux.intel.com>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28036 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752209AbdJaOW0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 31 Oct 2017 10:22:26 -0400
In-Reply-To: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org

Since i2c_unregister_device() became NULL-aware we may remove duplicate
NULL check.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwmon/w83792d.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index d764602d70db..76aa39e537e0 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -981,8 +981,7 @@ w83792d_detect_subclients(struct i2c_client *new_client)
 /* Undo inits in case of errors */
 
 ERROR_SC_1:
-	if (data->lm75[0] != NULL)
-		i2c_unregister_device(data->lm75[0]);
+	i2c_unregister_device(data->lm75[0]);
 ERROR_SC_0:
 	return err;
 }
@@ -1456,10 +1455,8 @@ w83792d_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	for (i = 0; i < ARRAY_SIZE(w83792d_group_fan); i++)
 		sysfs_remove_group(&dev->kobj, &w83792d_group_fan[i]);
 exit_i2c_unregister:
-	if (data->lm75[0] != NULL)
-		i2c_unregister_device(data->lm75[0]);
-	if (data->lm75[1] != NULL)
-		i2c_unregister_device(data->lm75[1]);
+	i2c_unregister_device(data->lm75[0]);
+	i2c_unregister_device(data->lm75[1]);
 	return err;
 }
 
@@ -1475,10 +1472,8 @@ w83792d_remove(struct i2c_client *client)
 		sysfs_remove_group(&client->dev.kobj,
 				   &w83792d_group_fan[i]);
 
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
