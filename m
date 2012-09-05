From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: [PATCH] i2c-core: fix for dep-lock validator
Date: Wed, 05 Sep 2012 14:04:25 +0200
Message-ID: <50473FC9.6000203@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

If kernel is compiled with CONFIG_PROVE_LOCKING the
validator raises an error when a multiplexer is removed
via sysfs and sub-clients are connected to it. This is a
false positive.
Documentation/lockdep-design.txt recommends to handle this
via calls to mutex_lock_nested()

Signed-off-by: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
---
Documentation originally recommends to use an enum.
This is not applicable for a tree with unlimited depth.
This is why I use the adapter id which is expected
to be unique and monotonic increasing with the depth of
the tree.

--- linux/drivers/i2c/i2c-core.c.dist	2012-09-05 09:46:50.000000000 +0200
+++ linux/drivers/i2c/i2c-core.c	2012-09-05 09:56:58.000000000 +0200
@@ -628,7 +628,7 @@ i2c_sysfs_delete_device(struct device *d

 	/* Make sure the device was added through sysfs */
 	res = -ENOENT;
-	mutex_lock(&adap->userspace_clients_lock);
+	mutex_lock_nested(&adap->userspace_clients_lock, i2c_adapter_id(adap));
 	list_for_each_entry_safe(client, next, &adap->userspace_clients,
 				 detected) {
 		if (client->addr == addr) {
@@ -936,7 +936,7 @@ int i2c_del_adapter(struct i2c_adapter *
 		return res;

 	/* Remove devices instantiated from sysfs */
-	mutex_lock(&adap->userspace_clients_lock);
+	mutex_lock_nested(&adap->userspace_clients_lock, i2c_adapter_id(adap));
 	list_for_each_entry_safe(client, next, &adap->userspace_clients,
 				 detected) {
 		dev_dbg(&adap->dev, "Removing %s at 0x%x\n", client->name,
