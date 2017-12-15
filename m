From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v5 1/3] i2c: core: improve return value handling of
 i2c_new_device and i2c_new_dummy
Date: Sat, 16 Dec 2017 00:05:27 +0100
Message-ID: <47a92255-982c-8e91-9774-2004509a1dd6@gmail.com>
References: <ee904c64-e1b3-7fa0-7df4-7e77530a974a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37659 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755848AbdLOXHj (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 15 Dec 2017 18:07:39 -0500
In-Reply-To: <ee904c64-e1b3-7fa0-7df4-7e77530a974a@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Currently i2c_new_device and i2c_new_dummy return just NULL in error
case although they have more error details internally. Therefore move
the functionality into new functions returning detailed errors and
add wrappers for compatibilty with the current API.

This allows to use these functions with detailed error codes within
the i2c core or for API extensions.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
v3:
- prefix i2c_new_device and i2c_new_dummy with two underscores
  instead one
v4:
- add missing kernel doc
- add reviewed-by
v5:
- fix a copy & paste error in a kernel doc comment
---
 drivers/i2c/i2c-core-base.c | 70 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 57 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index bb34a5d41..cb3f29fb8 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -656,7 +656,7 @@ static int i2c_dev_irq_from_resources(const struct resource *resources,
 }
 
 /**
- * i2c_new_device - instantiate an i2c device
+ * __i2c_new_device - instantiate an i2c device
  * @adap: the adapter managing the device
  * @info: describes one I2C device; bus_num is ignored
  * Context: can sleep
@@ -669,17 +669,17 @@ static int i2c_dev_irq_from_resources(const struct resource *resources,
  * before any i2c_adapter could exist.
  *
  * This returns the new i2c client, which may be saved for later use with
- * i2c_unregister_device(); or NULL to indicate an error.
+ * i2c_unregister_device(); or an ERR_PTR to indicate an error.
  */
-struct i2c_client *
-i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
+static struct i2c_client *
+__i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 {
 	struct i2c_client	*client;
 	int			status;
 
 	client = kzalloc(sizeof *client, GFP_KERNEL);
 	if (!client)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	client->adapter = adap;
 
@@ -746,7 +746,29 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 		client->name, client->addr, status);
 out_err_silent:
 	kfree(client);
-	return NULL;
+	return ERR_PTR(status);
+}
+
+/**
+ * i2c_new_device - instantiate an i2c device
+ * @adap: the adapter managing the device
+ * @info: describes one I2C device; bus_num is ignored
+ * Context: can sleep
+ *
+ * This function has the same functionality like __i2_new_device, it just
+ * returns NULL instead of an ERR_PTR in case of an error for compatibility
+ * with current I2C API.
+ *
+ * This returns the new i2c client, which may be saved for later use with
+ * i2c_unregister_device(); or NULL to indicate an error.
+ */
+struct i2c_client *
+i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
+{
+	struct i2c_client *ret;
+
+	ret = __i2c_new_device(adap, info);
+	return IS_ERR(ret) ? NULL : ret;
 }
 EXPORT_SYMBOL_GPL(i2c_new_device);
 
@@ -793,7 +815,7 @@ static struct i2c_driver dummy_driver = {
 };
 
 /**
- * i2c_new_dummy - return a new i2c device bound to a dummy driver
+ * __i2c_new_dummy - return a new i2c device bound to a dummy driver
  * @adapter: the adapter managing the device
  * @address: seven bit address to be used
  * Context: can sleep
@@ -808,15 +830,37 @@ static struct i2c_driver dummy_driver = {
  * different driver.
  *
  * This returns the new i2c client, which should be saved for later use with
- * i2c_unregister_device(); or NULL to indicate an error.
+ * i2c_unregister_device(); or an ERR_PTR to indicate an error.
  */
-struct i2c_client *i2c_new_dummy(struct i2c_adapter *adapter, u16 address)
+static struct i2c_client *
+__i2c_new_dummy(struct i2c_adapter *adapter, u16 address)
 {
 	struct i2c_board_info info = {
 		I2C_BOARD_INFO("dummy", address),
 	};
 
-	return i2c_new_device(adapter, &info);
+	return __i2c_new_device(adapter, &info);
+}
+
+/**
+ * i2c_new_dummy - return a new i2c device bound to a dummy driver
+ * @adapter: the adapter managing the device
+ * @address: seven bit address to be used
+ * Context: can sleep
+ *
+ * This function has the same functionality like __i2_new_dummy, it just
+ * returns NULL instead of an ERR_PTR in case of an error for compatibility
+ * with current I2C API.
+ *
+ * This returns the new i2c client, which should be saved for later use with
+ * i2c_unregister_device(); or NULL to indicate an error.
+ */
+struct i2c_client *i2c_new_dummy(struct i2c_adapter *adapter, u16 address)
+{
+	struct i2c_client *ret;
+
+	ret = __i2c_new_dummy(adapter, address);
+	return IS_ERR(ret) ? NULL : ret;
 }
 EXPORT_SYMBOL_GPL(i2c_new_dummy);
 
@@ -939,9 +983,9 @@ i2c_sysfs_new_device(struct device *dev, struct device_attribute *attr,
 		info.flags |= I2C_CLIENT_SLAVE;
 	}
 
-	client = i2c_new_device(adap, &info);
-	if (!client)
-		return -EINVAL;
+	client = __i2c_new_device(adap, &info);
+	if (IS_ERR(client))
+		return PTR_ERR(client);
 
 	/* Keep track of the added device */
 	mutex_lock(&adap->userspace_clients_lock);
-- 
2.15.1
