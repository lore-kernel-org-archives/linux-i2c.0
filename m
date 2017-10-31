From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 12/15] hwmon: (w83793) Remove duplicate NULL check
Date: Tue, 31 Oct 2017 16:21:46 +0200
Message-ID: <20171031142149.32512-12-andriy.shevchenko@linux.intel.com>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:36400 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753518AbdJaOXb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 31 Oct 2017 10:23:31 -0400
In-Reply-To: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rudolf Marek <r.marek@assembler.cz>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org

Since i2c_unregister_device() became NULL-aware we may remove duplicate
NULL check.

Cc: Rudolf Marek <r.marek@assembler.cz>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwmon/w83793.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index 5ba9d9f1daa1..0af0f6283b35 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -1564,10 +1564,8 @@ static int w83793_remove(struct i2c_client *client)
 	for (i = 0; i < ARRAY_SIZE(w83793_temp); i++)
 		device_remove_file(dev, &w83793_temp[i].dev_attr);
 
-	if (data->lm75[0] != NULL)
-		i2c_unregister_device(data->lm75[0]);
-	if (data->lm75[1] != NULL)
-		i2c_unregister_device(data->lm75[1]);
+	i2c_unregister_device(data->lm75[0]);
+	i2c_unregister_device(data->lm75[1]);
 
 	/* Decrease data reference counter */
 	mutex_lock(&watchdog_data_mutex);
@@ -1625,8 +1623,7 @@ w83793_detect_subclients(struct i2c_client *client)
 	/* Undo inits in case of errors */
 
 ERROR_SC_1:
-	if (data->lm75[0] != NULL)
-		i2c_unregister_device(data->lm75[0]);
+	i2c_unregister_device(data->lm75[0]);
 ERROR_SC_0:
 	return err;
 }
@@ -1962,10 +1959,8 @@ static int w83793_probe(struct i2c_client *client,
 	for (i = 0; i < ARRAY_SIZE(w83793_temp); i++)
 		device_remove_file(dev, &w83793_temp[i].dev_attr);
 
-	if (data->lm75[0] != NULL)
-		i2c_unregister_device(data->lm75[0]);
-	if (data->lm75[1] != NULL)
-		i2c_unregister_device(data->lm75[1]);
+	i2c_unregister_device(data->lm75[0]);
+	i2c_unregister_device(data->lm75[1]);
 free_mem:
 	kfree(data);
 exit:
-- 
2.14.2
