From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 2/3] i2c: core: add device-managed version of i2c_new_dummy
Date: Wed, 6 Dec 2017 22:13:20 +0100
Message-ID: <f699c42b-0054-8e9f-1f38-68701203e2a7@gmail.com>
References: <c765d409-5d33-8d6f-c883-9be93f507e01@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c765d409-5d33-8d6f-c883-9be93f507e01@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

i2c_new_dummy is typically called from the probe function of the
driver for the primary i2c client. It requires calls to
i2c_unregister_device in the error path of the probe function and
in the remove function.
This can be simplified by introducing a device-managed version.

Note the changed error case return value type:
i2c_new_dummy returns NULL whilst devm_new_i2c_dummy returns an ERR_PTR.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- use new function _i2c_new_dummy with detailed error codes
---
 Documentation/driver-model/devres.txt |  3 +++
 drivers/i2c/i2c-core-base.c           | 38 +++++++++++++++++++++++++++++++++++
 include/linux/i2c.h                   |  3 +++
 3 files changed, 44 insertions(+)

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
index 3faa9b1d3..7b3cd95be 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -840,6 +840,44 @@ struct i2c_client *i2c_new_dummy(struct i2c_adapter *adapter, u16 address)
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
+	ret = _i2c_new_dummy(adapter, address);
+	if (IS_ERR(ret)) {
+		devres_free(dr);
+	} else {
+		*dr = ret;
+		devres_add(dev, dr);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_i2c_new_dummy);
+
 /**
  * i2c_new_secondary_device - Helper to get the instantiated secondary address
  * and create the associated device
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 5d7f3c185..aca6ebbb8 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -441,6 +441,9 @@ extern int i2c_probe_func_quick_read(struct i2c_adapter *, unsigned short addr);
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
