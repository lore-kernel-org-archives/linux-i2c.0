From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V3 1/2] i2c: core: add devm apis for i2c_new_dummy()
Date: Fri, 17 Jun 2016 19:12:21 +0530
Message-ID: <1466170942-21214-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from nat-hk.nvidia.com ([203.18.50.4]:33560 "EHLO
	hkmmgate101.nvidia.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751309AbcFQNzp (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 17 Jun 2016 09:55:45 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: corbet@lwn.net, wsa@the-dreams.de
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>

Add resource managed version of i2c_new_dummy().

This helps in:
 1. reducing the code size in error path to explicitly unregister
    the new dummy client.
 2. Sometime, need of the remove callback on client driver to just
    unregister the new i2c dummy client.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

---
Changes from V1:
- Got review comment on similar change for pinctrl and taken care of
 the same on this patch as V1 has similar issue.
- Add the new devm_ APIs in the Documentation/driver-model/devres.txt
- Will push the change for using this new APIs later once this is
  applied as most of consumer for these APIs are in other subsystem like
  MFD/RTC.

Changes from V2:
- Drop devm_i2c_unregister_device() as it is not used in general.
---
 drivers/i2c/i2c-core.c | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h    |  4 ++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 952d2f0..dc30b9b 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1145,6 +1145,47 @@ struct i2c_client *i2c_new_dummy(struct i2c_adapter *adapter, u16 address)
 }
 EXPORT_SYMBOL_GPL(i2c_new_dummy);
 
+static void devm_i2c_dummy_release(struct device *dev, void *res)
+{
+	i2c_unregister_device(*(struct i2c_client **)res);
+}
+
+/**
+ * devm_i2c_new_dummy - Resource managed version of i2c_new_dummy().
+ * @dev:	Device handle for which this resouce belongs to.
+ * @adapter:	the adapter managing the device
+ * @address:	seven bit address to be used
+ * Context:	can sleep
+
+ * Please refer the details of i2c_new_dummy() for more information.
+ *
+ * This returns the new i2c client on success; or NULL to indicate an error.
+ * The new i2c_client will be automatically released when the device is unbound.
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
+	if (!i2c_dummy) {
+		devres_free(ptr);
+		return NULL;
+	}
+
+	*ptr = i2c_dummy;
+	devres_add(dev, ptr);
+
+	return i2c_dummy;
+}
+EXPORT_SYMBOL_GPL(devm_i2c_new_dummy);
+
 /**
  * i2c_new_secondary_device - Helper to get the instantiated secondary address
  * and create the associated device
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 6df7bad..257b239 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -355,6 +355,10 @@ i2c_new_secondary_device(struct i2c_client *client,
 				u16 default_addr);
 
 extern void i2c_unregister_device(struct i2c_client *);
+
+extern struct i2c_client *
+devm_i2c_new_dummy(struct device *dev, struct i2c_adapter *adap, u16 address);
+
 #endif /* I2C */
 
 /* Mainboard arch_initcall() code should register all its I2C devices.
-- 
2.1.4
