From: York Sun <yorksun@freescale.com>
Subject: [PATCH] driver/i2c: Add API to add new I2C device without registering
Date: Fri, 23 Oct 2015 12:27:09 -0700
Message-ID: <1445628429-12993-1-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn1bon0140.outbound.protection.outlook.com ([157.56.111.140]:20657
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753160AbbJWT10 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 23 Oct 2015 15:27:26 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: sboyd@codeaurora.org, wsa@the-dreams.de
Cc: linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org, York Sun <yorksun@freescale.com>

Split existing API i2c_new_device(), i2c_new_probed_device() into
two halves. The first half creates new i2c devices and the second
half calls device_register(). It allows additional work to be done
before registering the device.

Signed-off-by: York Sun <yorksun@freescale.com>
CC: Wolfram Sang <wsa@the-dreams.de>
CC: Stephen Boyd <sboyd@codeaurora.org>
Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/i2c/i2c-core.c |   96 ++++++++++++++++++++++++++++++++++++++----------
 include/linux/i2c.h    |    8 ++++
 2 files changed, 85 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 5f89f1e..ff941b8 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -980,23 +980,19 @@ static void i2c_dev_set_name(struct i2c_adapter *adap,
 }
 
 /**
- * i2c_new_device - instantiate an i2c device
+ * i2c_new_device_unregistered -- instantiate an i2c device unregistered
  * @adap: the adapter managing the device
  * @info: describes one I2C device; bus_num is ignored
  * Context: can sleep
  *
- * Create an i2c device. Binding is handled through driver model
- * probe()/remove() methods.  A driver may be bound to this device when we
- * return from this function, or any later moment (e.g. maybe hotplugging will
- * load the driver module).  This call is not appropriate for use by mainboard
- * initialization logic, which usually runs during an arch_initcall() long
- * before any i2c_adapter could exist.
+ * Create an i2c device but leave it unregistered.
  *
  * This returns the new i2c client, which may be saved for later use with
- * i2c_unregister_device(); or NULL to indicate an error.
+ * device_register() or i2c_unregister_device(); or NULL to indicate an error.
  */
 struct i2c_client *
-i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
+i2c_new_device_unregistered(struct i2c_adapter *adap,
+			    struct i2c_board_info const *info)
 {
 	struct i2c_client	*client;
 	int			status;
@@ -1022,13 +1018,16 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	if (status) {
 		dev_err(&adap->dev, "Invalid %d-bit I2C address 0x%02hx\n",
 			client->flags & I2C_CLIENT_TEN ? 10 : 7, client->addr);
-		goto out_err_silent;
+		goto out_err;
 	}
 
 	/* Check for address business */
 	status = i2c_check_addr_busy(adap, i2c_encode_flags_to_addr(client));
-	if (status)
+	if (status) {
+		dev_err(&adap->dev, "i2c client %s at 0x%02x busy\n",
+			client->name, client->addr);
 		goto out_err;
+	}
 
 	client->dev.parent = &client->adapter->dev;
 	client->dev.bus = &i2c_bus_type;
@@ -1037,6 +1036,41 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	client->dev.fwnode = info->fwnode;
 
 	i2c_dev_set_name(adap, client);
+
+	return client;
+
+out_err:
+	kfree(client);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(i2c_new_device_unregistered);
+
+/**
+ * i2c_new_device - instantiate an i2c device
+ * @adap: the adapter managing the device
+ * @info: describes one I2C device; bus_num is ignored
+ * Context: can sleep
+ *
+ * Create an i2c device. Binding is handled through driver model
+ * probe()/remove() methods.  A driver may be bound to this device when we
+ * return from this function, or any later moment (e.g. maybe hotplugging will
+ * load the driver module).  This call is not appropriate for use by mainboard
+ * initialization logic, which usually runs during an arch_initcall() long
+ * before any i2c_adapter could exist.
+ *
+ * This returns the new i2c client, which may be saved for later use with
+ * i2c_unregister_device(); or NULL to indicate an error.
+ */
+struct i2c_client *
+i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
+{
+	struct i2c_client	*client;
+	int			status;
+
+	client = i2c_new_device_unregistered(adap, info);
+	if (!client)
+		goto out_err_silent;
+
 	status = device_register(&client->dev);
 	if (status)
 		goto out_err;
@@ -1050,7 +1084,6 @@ out_err:
 	dev_err(&adap->dev, "Failed to register i2c client %s at 0x%02x "
 		"(%d)\n", client->name, client->addr, status);
 out_err_silent:
-	kfree(client);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(i2c_new_device);
@@ -2455,11 +2488,9 @@ int i2c_probe_func_quick_read(struct i2c_adapter *adap, unsigned short addr)
 }
 EXPORT_SYMBOL_GPL(i2c_probe_func_quick_read);
 
-struct i2c_client *
-i2c_new_probed_device(struct i2c_adapter *adap,
-		      struct i2c_board_info *info,
-		      unsigned short const *addr_list,
-		      int (*probe)(struct i2c_adapter *, unsigned short addr))
+static unsigned short address_probe(struct i2c_adapter *adap,
+		unsigned short const *addr_list,
+		int (*probe)(struct i2c_adapter *, unsigned short addr))
 {
 	int i;
 
@@ -2486,12 +2517,39 @@ i2c_new_probed_device(struct i2c_adapter *adap,
 			break;
 	}
 
-	if (addr_list[i] == I2C_CLIENT_END) {
+	return addr_list[i];
+}
+
+struct i2c_client *
+i2c_new_probed_device_unregistered(struct i2c_adapter *adap,
+		      struct i2c_board_info *info,
+		      unsigned short const *addr_list,
+		      int (*probe)(struct i2c_adapter *, unsigned short addr))
+{
+	info->addr = address_probe(adap, addr_list, probe);
+
+	if (info->addr == I2C_CLIENT_END) {
+		dev_dbg(&adap->dev, "Probing failed, no device found\n");
+		return NULL;
+	}
+
+	return i2c_new_device_unregistered(adap, info);
+}
+EXPORT_SYMBOL_GPL(i2c_new_probed_device_unregistered);
+
+struct i2c_client *
+i2c_new_probed_device(struct i2c_adapter *adap,
+		      struct i2c_board_info *info,
+		      unsigned short const *addr_list,
+		      int (*probe)(struct i2c_adapter *, unsigned short addr))
+{
+	info->addr = address_probe(adap, addr_list, probe);
+
+	if (info->addr == I2C_CLIENT_END) {
 		dev_dbg(&adap->dev, "Probing failed, no device found\n");
 		return NULL;
 	}
 
-	info->addr = addr_list[i];
 	return i2c_new_device(adap, info);
 }
 EXPORT_SYMBOL_GPL(i2c_new_probed_device);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 768063b..85068ae 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -327,6 +327,9 @@ struct i2c_board_info {
  */
 extern struct i2c_client *
 i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info);
+extern struct i2c_client *
+i2c_new_device_unregistered(struct i2c_adapter *adap,
+			    struct i2c_board_info const *info);
 
 /* If you don't know the exact address of an I2C device, use this variant
  * instead, which can probe for device presence in a list of possible
@@ -339,6 +342,11 @@ i2c_new_probed_device(struct i2c_adapter *adap,
 		      struct i2c_board_info *info,
 		      unsigned short const *addr_list,
 		      int (*probe)(struct i2c_adapter *, unsigned short addr));
+extern struct i2c_client *
+i2c_new_probed_device_unregistered(struct i2c_adapter *adap,
+		      struct i2c_board_info *info,
+		      unsigned short const *addr_list,
+		      int (*probe)(struct i2c_adapter *, unsigned short addr));
 
 /* Common custom probe functions */
 extern int i2c_probe_func_quick_read(struct i2c_adapter *, unsigned short addr);
-- 
1.7.9.5
