From: divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Subject: [PATCH 3/3] eeprom: at24: enable runtime pm support
Date: Thu, 27 Jul 2017 22:13:09 +0530
Message-ID: <1501173789-25959-4-git-send-email-divagar.mohandass@intel.com>
References: <1501173789-25959-1-git-send-email-divagar.mohandass@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1501173789-25959-1-git-send-email-divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Currently the device is kept in D0, there is an opportunity
to save power by enabling runtime pm.

Device can be daisy chained from PMIC and we can't rely on I2C core
for auto resume/suspend. Driver will decide when to resume/suspend.

Signed-off-by: Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/misc/eeprom/at24.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 2199c42..0d26681 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -24,6 +24,7 @@
 #include <linux/i2c.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_data/at24.h>
+#include <linux/pm_runtime.h>
 
 /*
  * I2C EEPROMs from most vendors are inexpensive and mostly interchangeable.
@@ -501,11 +502,21 @@ static ssize_t at24_eeprom_write_i2c(struct at24_data *at24, const char *buf,
 static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 {
 	struct at24_data *at24 = priv;
+	struct i2c_client *client;
 	char *buf = val;
+	int ret;
 
 	if (unlikely(!count))
 		return count;
 
+	client = at24_translate_offset(at24, &off);
+
+	ret = pm_runtime_get_sync(&client->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(&client->dev);
+		return ret;
+	}
+
 	/*
 	 * Read data from chip, protecting against concurrent updates
 	 * from this host, but not from other I2C masters.
@@ -527,17 +538,29 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 
 	mutex_unlock(&at24->lock);
 
+	pm_runtime_put(&client->dev);
+
 	return 0;
 }
 
 static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 {
 	struct at24_data *at24 = priv;
+	struct i2c_client *client;
 	char *buf = val;
+	int ret;
 
 	if (unlikely(!count))
 		return -EINVAL;
 
+	client = at24_translate_offset(at24, &off);
+
+	ret = pm_runtime_get_sync(&client->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(&client->dev);
+		return ret;
+	}
+
 	/*
 	 * Write data to chip, protecting against concurrent updates
 	 * from this host, but not from other I2C masters.
@@ -559,6 +582,8 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 
 	mutex_unlock(&at24->lock);
 
+	pm_runtime_put(&client->dev);
+
 	return 0;
 }
 
@@ -743,6 +768,13 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	i2c_set_clientdata(client, at24);
 
+	/* enable runtime pm */
+	err = pm_runtime_set_active(&client->dev);
+	if (err < 0)
+		goto err_clients;
+
+	pm_runtime_enable(&client->dev);
+
 	/*
 	 * Perform a one-byte test read to verify that the
 	 * chip is functional.
@@ -810,6 +842,8 @@ static int at24_remove(struct i2c_client *client)
 	for (i = 1; i < at24->num_addresses; i++)
 		i2c_unregister_device(at24->client[i]);
 
+	pm_runtime_disable(&client->dev);
+
 	return 0;
 }
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
