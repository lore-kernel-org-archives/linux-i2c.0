From: Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH] i2c: slave framework support for SMBus Alert
Date: Tue,  9 Aug 2016 17:02:53 -0700
Message-ID: <1470787373-26738-2-git-send-email-brendanhiggins@google.com>
References: <1470787373-26738-1-git-send-email-brendanhiggins@google.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33697 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbcHJADk (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 9 Aug 2016 20:03:40 -0400
Received: by mail-pf0-f176.google.com with SMTP id y134so9662108pfg.0
        for <linux-i2c@vger.kernel.org>; Tue, 09 Aug 2016 17:03:40 -0700 (PDT)
In-Reply-To: <1470787373-26738-1-git-send-email-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Brendan Higgins <brendanhiggins@google.com>

Currently, only handling SMBus alerts as a SMBus master is supported.
This adds support for the generation of SMBus Alerts as a slave.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/i2c/i2c-core.c | 22 ++++++++++++++++++++++
 include/linux/i2c.h    |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index e584d88..9d49cee 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -3252,6 +3252,28 @@ int i2c_slave_unregister(struct i2c_client *client)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(i2c_slave_unregister);
+
+int i2c_slave_smbus_alert(struct i2c_client *client)
+{
+	int ret;
+
+	if (!client->adapter->algo->smbus_alert_slave) {
+		dev_err(&client->dev, "%s: not supported by adapter\n",
+			__func__);
+		return -EOPNOTSUPP;
+	}
+
+	i2c_lock_adapter(client->adapter);
+	ret = client->adapter->algo->smbus_alert_slave(client);
+	i2c_unlock_adapter(client->adapter);
+
+	if (ret != 0)
+		dev_err(&client->dev, "%s: adapter returned error %d\n",
+			__func__, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i2c_slave_smbus_alert);
 #endif
 
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 200cf13b..43b98f5 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -271,6 +271,8 @@ static inline int i2c_slave_event(struct i2c_client *client,
 {
 	return client->slave_cb(client, event, val);
 }
+
+extern int i2c_slave_smbus_alert(struct i2c_client *client);
 #endif
 
 /**
@@ -381,6 +383,8 @@ i2c_register_board_info(int busnum, struct i2c_board_info const *info,
  *   from the I2C_FUNC_* flags.
  * @reg_slave: Register given client to I2C slave mode of this adapter
  * @unreg_slave: Unregister given client from I2C slave mode of this adapter
+ * @smbus_alert_slave: Create an smbus alert from the I2C slave mode of this
+ *   adapter
  *
  * The following structs are for those who like to implement new bus drivers:
  * i2c_algorithm is the interface to a class of hardware solutions which can
@@ -410,6 +414,7 @@ struct i2c_algorithm {
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 	int (*reg_slave)(struct i2c_client *client);
 	int (*unreg_slave)(struct i2c_client *client);
+	int (*smbus_alert_slave)(struct i2c_client *client);
 #endif
 };
 
-- 
2.8.0.rc3.226.g39d4020
