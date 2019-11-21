From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH] drivers: i2c: introduce devm_i2c_add_adapter()
Date: Thu, 21 Nov 2019 16:27:16 +0100
Message-ID: <20191121152716.23940-1-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Introduce devm'ed version of i2c_add_adapter() which triggers
i2c_del_adapter() to be called when parent device is removed.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/i2c/i2c-core-base.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h         |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 5f6a4985f2bc..bd713e451633 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1452,6 +1452,44 @@ int i2c_add_adapter(struct i2c_adapter *adapter)
 }
 EXPORT_SYMBOL(i2c_add_adapter);
 
+static void devm_i2c_adapter_release(struct device *dev, void *res)
+{
+	i2c_del_adapter(*(struct i2c_adapter**)res);
+}
+
+/**
+ * devm_i2c_add_adapter - devm version of i2c_add_adapter()
+ * @adapter: the adapter to add
+ * @data: private data to attach (if non-NULL)
+ * Context: can sleep
+ */
+int devm_i2c_add_adapter(struct device *parent,
+			 struct i2c_adapter *adap,
+			 void *data)
+{
+	struct i2c_adapter **dr;
+	int rc;
+
+	dr = devres_alloc(devm_i2c_adapter_release, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	rc = i2c_add_adapter(adap);
+	if (rc) {
+		devres_free(dr);
+		return rc;
+	}
+
+	if (data)
+		i2c_set_adapdata(adap, data);
+
+	*dr = adap;
+	devres_add(parent, dr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_i2c_add_adapter);
+
 /**
  * i2c_add_numbered_adapter - declare i2c adapter, use static bus number
  * @adap: the adapter to register (with adap->nr initialized)
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 1361637c369d..8dc07d03a502 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -834,6 +834,8 @@ static inline void i2c_mark_adapter_resumed(struct i2c_adapter *adap)
  */
 #if IS_ENABLED(CONFIG_I2C)
 extern int i2c_add_adapter(struct i2c_adapter *adap);
+extern int devm_i2c_add_adapter(struct device *parent,
+				struct i2c_adapter *adap, void *data);
 extern void i2c_del_adapter(struct i2c_adapter *adap);
 extern int i2c_add_numbered_adapter(struct i2c_adapter *adap);
 
-- 
2.11.0
