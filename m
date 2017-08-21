From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] i2c: core: add device-managed version of i2c_new_dummy
Date: Mon, 21 Aug 2017 20:24:07 +0200
Message-ID: <de2f844a-9d41-fa0e-cd55-fc7d2cea24d5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36907 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753348AbdHUSYR (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 21 Aug 2017 14:24:17 -0400
Received: by mail-wr0-f196.google.com with SMTP id z91so19197839wrc.4
        for <linux-i2c@vger.kernel.org>; Mon, 21 Aug 2017 11:24:16 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

i2c_new_dummy is typically called from the probe function of the
driver for the primary i2c client. It requires calls to
i2c_unregister_device in the error path of the probe function and
in the remove function.
This can be simplified by introducing a device-managed version.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/i2c/i2c-core-base.c | 29 +++++++++++++++++++++++++++++
 include/linux/i2c.h         |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 12822a4b..7eb48328 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -868,6 +868,35 @@ struct i2c_client *i2c_new_dummy(struct i2c_adapter *adapter, u16 address)
 }
 EXPORT_SYMBOL_GPL(i2c_new_dummy);
 
+static void devm_i2c_release_dummy(struct device *dev, void *res)
+{
+	i2c_unregister_device(*(struct i2c_client **)res);
+}
+
+/* managed version of i2c_new_dummy */
+struct i2c_client *devm_i2c_new_dummy(struct device *dev,
+				      struct i2c_adapter *adapter,
+				      u16 address)
+{
+	struct i2c_client *ret, **dr;
+
+	dr = devres_alloc(devm_i2c_release_dummy, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return NULL;
+
+	ret = i2c_new_dummy(adapter, address);
+	if (!ret) {
+		devres_free(dr);
+		return NULL;
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
index d501d395..d0c091e6 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -381,6 +381,9 @@ extern int i2c_probe_func_quick_read(struct i2c_adapter *, unsigned short addr);
 extern struct i2c_client *
 i2c_new_dummy(struct i2c_adapter *adap, u16 address);
 
+extern struct i2c_client *
+devm_i2c_new_dummy(struct device *dev, struct i2c_adapter *adap, u16 address);
+
 extern struct i2c_client *
 i2c_new_secondary_device(struct i2c_client *client,
 				const char *name,
-- 
2.14.1
