From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH] i2c: core: add devm apis for i2c_new_dummy and i2c_unregister
Date: Mon, 8 Feb 2016 18:57:38 +0530
Message-ID: <1454938058-28457-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-i2c@vger.kernel.org

Add device managed APIs for i2c_new_dummy() and
i2c_unregister_device() so that it can be managed by
device framework for freeing it.

This helps on following:
1. Maintaining the resource allocation and deallocation
	i2c_dummy = i2c_new_dummy();
	devm_regmap_init_i2c(i2c_dummy, &regmap_config)

	On this case, the user of i2c_dummy which is
	devm_regmap_init_i2c() is managed allocation where
	i2c_new_dummy() is not.
	On Free path, we have
		i2c_unregister_device(i2c_dummy)
	and later, device framework release the regmap. In this
	case, client of i2c_dummy after the i2c_dummy.

	By using devm apis, the sequence can be maintain
		i2c_dummy = devm_i2c_new_dummy();
		devm_regmap_init_i2c(i2c_dummy, &regmap_config)

	and resource deallocation will be done in reverse order
	by device framework.

2. No need to release the i2c_client in error/remove path and hence
   there is less code requirement.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/i2c/i2c-core.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h    |  6 +++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index ffe715d..b512d72 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1158,6 +1158,76 @@ struct i2c_client *i2c_new_dummy(struct i2c_adapter *adapter, u16 address)
 }
 EXPORT_SYMBOL_GPL(i2c_new_dummy);
 
+static void devm_i2c_dummy_release(struct device *dev, void *res)
+{
+	i2c_unregister_device(*(struct i2c_client **)res);
+}
+
+/**
+ * devm_i2c_new_dummy - Resource managed i2c_new_dummy()
+ * @dev: Device pointer for which this resouce belongs to.
+ * @adapter: the adapter managing the device
+ * @address: seven bit address to be used
+ * Context: can sleep
+ *
+ * This returns the new i2c client. Returns a valid pointer to struct
+ * i2c_client or NULL to indicate error. The i2c_cleint automatically
+ * be released when the device is unbound.
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
+	if (!r || !*r) {
+		WARN_ON(!r || !*r);
+		return 0;
+	}
+	return *r == data;
+}
+
+/**
+ * devm_i2c_unregister_device - Resource managed i2c_unregister_device()
+ * @dev: Device for which which resource was allocated.
+ * @client: i2c client to free
+ *
+ * Unregister a dummy i2c with devm_i2c_unregister_device().
+ * Normally this function will not need to be called and the resource
+ * management code will ensure that the resource is freed.
+ */
+void devm_i2c_unregister_device(struct device *dev, struct i2c_client *client)
+{
+	int rc;
+
+	rc = devres_release(dev, devm_i2c_dummy_release, devm_i2c_client_match,
+			    client);
+	if (rc != 0)
+		WARN_ON(rc);
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
