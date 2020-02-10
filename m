From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/3] i2c: rename of_i2c_setup_smbus_alert() to keep in sync
Date: Mon, 10 Feb 2020 18:29:26 +0100
Message-ID: <20200210172929.6001-3-wsa+renesas@sang-engineering.com>
References: <20200210172929.6001-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200210172929.6001-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Phil Reid <preid@electromag.com.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The parent function i2c_setup_smbus_alert() has been renamed, so rename
this one, too, for consistency.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core-base.c  | 2 +-
 drivers/i2c/i2c-core-smbus.c | 4 ++--
 include/linux/i2c-smbus.h    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index cefad0881942..0ac3d6d8b2e2 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1329,7 +1329,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 		goto out_list;
 	}
 
-	res = of_i2c_setup_smbus_alert(adap);
+	res = of_i2c_install_smbus_alert(adap);
 	if (res)
 		goto out_reg;
 
diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 06f2e4d78d3c..5ab30d627b4d 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -698,7 +698,7 @@ struct i2c_client *i2c_install_smbus_alert(struct i2c_adapter *adapter,
 EXPORT_SYMBOL_GPL(i2c_install_smbus_alert);
 
 #if IS_ENABLED(CONFIG_I2C_SMBUS) && IS_ENABLED(CONFIG_OF)
-int of_i2c_setup_smbus_alert(struct i2c_adapter *adapter)
+int of_i2c_install_smbus_alert(struct i2c_adapter *adapter)
 {
 	struct i2c_client *client;
 	int irq;
@@ -716,5 +716,5 @@ int of_i2c_setup_smbus_alert(struct i2c_adapter *adapter)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(of_i2c_setup_smbus_alert);
+EXPORT_SYMBOL_GPL(of_i2c_install_smbus_alert);
 #endif
diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
index 409da1e478d6..aa24a11d1a83 100644
--- a/include/linux/i2c-smbus.h
+++ b/include/linux/i2c-smbus.h
@@ -36,9 +36,9 @@ struct i2c_client *i2c_install_smbus_alert(struct i2c_adapter *adapter,
 int i2c_handle_smbus_alert(struct i2c_client *ara);
 
 #if IS_ENABLED(CONFIG_I2C_SMBUS) && IS_ENABLED(CONFIG_OF)
-int of_i2c_setup_smbus_alert(struct i2c_adapter *adap);
+int of_i2c_install_smbus_alert(struct i2c_adapter *adap);
 #else
-static inline int of_i2c_setup_smbus_alert(struct i2c_adapter *adap)
+static inline int of_i2c_install_smbus_alert(struct i2c_adapter *adap)
 {
 	return 0;
 }
-- 
2.20.1
