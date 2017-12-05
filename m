From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH resubmit 1/2] i2c: core: add device-managed version of
 i2c_new_dummy
Date: Tue, 5 Dec 2017 20:44:54 +0100
Message-ID: <19d37e48-0b64-b33c-993a-a1cae39efb54@gmail.com>
References: <e70df557-3f71-9de2-6b1a-de566b47eb33@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35683 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdLETpN (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 5 Dec 2017 14:45:13 -0500
In-Reply-To: <e70df557-3f71-9de2-6b1a-de566b47eb33@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

i2c_new_dummy is typically called from the probe function of the
driver for the primary i2c client. It requires calls to
i2c_unregister_device in the error path of the probe function and
in the remove function.
This can be simplified by introducing a device-managed version.

Note the changed error case return value type:
i2c_new_dummy returns NULL whilst devm_new_i2c_dummy returns an ERR_PTR.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 Documentation/driver-model/devres.txt |  3 +++
 drivers/i2c/i2c-core-base.c           | 39 +++++++++++++++++++++++++++++++++++
 include/linux/i2c.h                   |  3 +++
 3 files changed, 45 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index c180045eb..6e2bccf85 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -259,6 +259,9 @@ GPIO
   devm_gpio_request_one()
   devm_gpio_free()
 
+I2C
+  devm_i2c_new_dummy
+
 IIO
   devm_iio_device_alloc()
   devm_iio_device_free()
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index bf52cca87..c1db67f9a 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -820,6 +820,45 @@ struct i2c_client *i2c_new_dummy(struct i2c_adapter *adapter, u16 address)
 }
 EXPORT_SYMBOL_GPL(i2c_new_dummy);
 
+static void devm_i2c_release_dummy(struct device *dev, void *res)
+{
+	i2c_unregister_device(*(struct i2c_client **)res);
+}
+
+/**
+ * devm_i2c_new_dummy - return a new i2c device bound to a dummy driver
+ * @dev: device the managed resource is bound to
+ * @adapter: the adapter managing the device
+ * @address: seven bit address to be used
+ * Context: can sleep
+ *
+ * This is the device-managed version of i2c_new_dummy.
+ * Note the changed return value type: It returns the new i2c client
+ * or an ERR_PTR in case of an error.
+ */
+struct i2c_client *devm_i2c_new_dummy(struct device *dev,
+				      struct i2c_adapter *adapter,
+				      u16 address)
+{
+	struct i2c_client *ret, **dr;
+
+	dr = devres_alloc(devm_i2c_release_dummy, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return ERR_PTR(-ENOMEM);
+
+	ret = i2c_new_dummy(adapter, address);
+	if (!ret) {
+		devres_free(dr);
+		return ERR_PTR(-EBUSY);
+	}
+
+	*dr = ret;
+	devres_add(dev, dr);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_i2c_new_dummy);
+
 /**
  * i2c_new_secondary_device - Helper to get the instantiated secondary address
  * and create the associated device
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index a556db976..c27eac1e1 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -383,6 +383,9 @@ extern int i2c_probe_func_quick_read(struct i2c_adapter *, unsigned short addr);
 extern struct i2c_client *
 i2c_new_dummy(struct i2c_adapter *adap, u16 address);
 
+extern struct i2c_client *
+devm_i2c_new_dummy(struct device *dev, struct i2c_adapter *adap, u16 address);
+
 extern struct i2c_client *
 i2c_new_secondary_device(struct i2c_client *client,
 				const char *name,
-- 
2.15.1
