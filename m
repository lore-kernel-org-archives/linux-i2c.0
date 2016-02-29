From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 1/2] i2c: core: add devm apis for i2c_new_dummy and i2c_unregister
Date: Mon, 29 Feb 2016 19:07:02 +0530
Message-ID: <1456753023-20559-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, corbet@lwn.net
Cc: bjorn.andersson@sonymobile.com, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-i2c@vger.kernel.org

Add resource managed version of i2c_new_dummy() and
i2c_unregister_device().

This helps in reducing the code size in error path and device
remove callbacks and making proper sequence for deallocations.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

---
Changes from V1:
- Got review comment on similar change for pinctrl and taken care of
  the same on this patch as V1 has similar issue.
- Add the new devm_ APIs in the Documentation/driver-model/devres.txt
- Will push the change for using this new APIs later once this is
  applied as most of consumer for these APIs are in other subsystem like
  MFD/RTC.

 drivers/i2c/i2c-core.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h    |  6 +++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 2949ab3..b5cd30b 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1158,6 +1158,72 @@ struct i2c_client *i2c_new_dummy(struct i2c_adapter *adapter, u16 address)
 }
 EXPORT_SYMBOL_GPL(i2c_new_dummy);
 
+static void devm_i2c_dummy_release(struct device *dev, void *res)
+{
+	i2c_unregister_device(*(struct i2c_client **)res);
+}
+
+/**
+ * devm_i2c_new_dummy - Resource managed version of i2c_new_dummy()
+ * @dev: Device pointer for which this resouce belongs to.
+ * @adapter: the adapter managing the device
+ * @address: seven bit address to be used
+ * Context: can sleep
+ *
+ * This returns the new i2c client. Returns a valid pointer to struct
+ * i2c_client or NULL to indicate error. The i2c_client will be
+ * automatically released when the device is unbound.
+ */
+struct i2c_client *devm_i2c_new_dummy(struct device *dev,
+				      struct i2c_adapter *adapter,
+				      u16 address)
+{
+	struct i2c_client **ptr, *i2c_dummy;
+
+	ptr = devres_alloc(devm_i2c_dummy_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	i2c_dummy = i2c_new_dummy(adapter, address);
+	if (i2c_dummy) {
+		*ptr = i2c_dummy;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return i2c_dummy;
+}
+EXPORT_SYMBOL_GPL(devm_i2c_new_dummy);
+
+static int devm_i2c_client_match(struct device *dev, void *res, void *data)
+{
+	struct i2c_client **r = res;
+
+	if (WARN_ON(!r || !*r))
+		return 0;
+
+	return *r == data;
+}
+
+/**
+ * devm_i2c_unregister_device - Resource managed version of
+ *				i2c_unregister_device()
+ * @dev: Device for which which resource was allocated.
+ * @client: i2c client to free
+ *
+ * Unregister a dummy i2c with devm_i2c_unregister_device().
+ * Normally this function will not need to be called and the resource
+ * management code will ensure that the resource is freed.
+ */
+void devm_i2c_unregister_device(struct device *dev, struct i2c_client *client)
+{
+	WARN_ON(devres_release(dev, devm_i2c_dummy_release,
+			       devm_i2c_client_match, client));
+}
+EXPORT_SYMBOL_GPL(devm_i2c_unregister_device);
+
 /* ------------------------------------------------------------------------- */
 
 /* I2C bus adapters -- one roots each I2C or SMBUS segment */
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 200cf13b..3abb1f9 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -350,6 +350,12 @@ extern struct i2c_client *
 i2c_new_dummy(struct i2c_adapter *adap, u16 address);
 
 extern void i2c_unregister_device(struct i2c_client *);
+
+extern struct i2c_client *devm_i2c_new_dummy(struct device *dev,
+					     struct i2c_adapter *adapter,
+					     u16 address);
+extern void devm_i2c_unregister_device(struct device *dev,
+				       struct i2c_client *client);
 #endif /* I2C */
 
 /* Mainboard arch_initcall() code should register all its I2C devices.
-- 
2.1.4
