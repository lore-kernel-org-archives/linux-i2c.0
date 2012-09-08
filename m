From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v3] i2c-core: Fix for lockdep validator
Date: Sat, 8 Sep 2012 09:38:14 +0200
Message-ID: <20120908093814.21c1174d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

If kernel is compiled with CONFIG_PROVE_LOCKING the
validator raises an error when a multiplexer is removed
via sysfs and sub-clients are connected to it. This is a
false positive.
Documentation/lockdep-design.txt recommends to handle this
via calls to mutex_lock_nested().

Based on an earlier fix from Michael Lawnick.

Note that the extra code resolves to nothing unless
CONFIG_DEBUG_LOCK_ALLOC=y.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
---
Changes since v2:
 * Inline function i2c_adapter_depth to avoid a compiler warning.
 * Document the reason why it it implemented that way.

 drivers/i2c/i2c-core.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

--- linux-3.6-rc4.orig/drivers/i2c/i2c-core.c	2012-09-07 17:53:31.000000000 +0200
+++ linux-3.6-rc4/drivers/i2c/i2c-core.c	2012-09-08 09:36:13.538537033 +0200
@@ -637,6 +637,22 @@ static void i2c_adapter_dev_release(stru
 }
 
 /*
+ * This function is only needed for mutex_lock_nested, so it is never
+ * called unless locking correctness checking is enabled. Thus we
+ * make it inline to avoid a compiler warning. That's what gcc ends up
+ * doing anyway.
+ */
+static inline unsigned int i2c_adapter_depth(struct i2c_adapter *adapter)
+{
+	unsigned int depth = 0;
+
+	while ((adapter = i2c_parent_is_i2c_adapter(adapter)))
+		depth++;
+
+	return depth;
+}
+
+/*
  * Let users instantiate I2C devices through sysfs. This can be used when
  * platform initialization code doesn't contain the proper data for
  * whatever reason. Also useful for drivers that do device detection and
@@ -726,7 +742,8 @@ i2c_sysfs_delete_device(struct device *d
 
 	/* Make sure the device was added through sysfs */
 	res = -ENOENT;
-	mutex_lock(&adap->userspace_clients_lock);
+	mutex_lock_nested(&adap->userspace_clients_lock,
+			  i2c_adapter_depth(adap));
 	list_for_each_entry_safe(client, next, &adap->userspace_clients,
 				 detected) {
 		if (client->addr == addr) {
@@ -1073,7 +1090,8 @@ int i2c_del_adapter(struct i2c_adapter *
 		return res;
 
 	/* Remove devices instantiated from sysfs */
-	mutex_lock(&adap->userspace_clients_lock);
+	mutex_lock_nested(&adap->userspace_clients_lock,
+			  i2c_adapter_depth(adap));
 	list_for_each_entry_safe(client, next, &adap->userspace_clients,
 				 detected) {
 		dev_dbg(&adap->dev, "Removing %s at 0x%x\n", client->name,


-- 
Jean Delvare
