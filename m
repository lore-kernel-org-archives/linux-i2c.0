From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: make i2c_get_adapter prototype clearer
Date: Thu, 17 Feb 2011 14:08:02 +0100
Message-ID: <20110217140802.494ba0e5@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Rename the parameter of i2c_get_adapter() to "nr", to make it clear we
are passing an adapter number and not an adapter ID (which have gone
away by now.)

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    4 ++--
 include/linux/i2c.h    |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.38-rc5.orig/drivers/i2c/i2c-core.c	2011-01-19 14:44:23.000000000 +0100
+++ linux-2.6.38-rc5/drivers/i2c/i2c-core.c	2011-02-17 13:50:32.000000000 +0100
@@ -1583,12 +1583,12 @@ i2c_new_probed_device(struct i2c_adapter
 }
 EXPORT_SYMBOL_GPL(i2c_new_probed_device);
 
-struct i2c_adapter *i2c_get_adapter(int id)
+struct i2c_adapter *i2c_get_adapter(int nr)
 {
 	struct i2c_adapter *adapter;
 
 	mutex_lock(&core_lock);
-	adapter = idr_find(&i2c_adapter_idr, id);
+	adapter = idr_find(&i2c_adapter_idr, nr);
 	if (adapter && !try_module_get(adapter->owner))
 		adapter = NULL;
 
--- linux-2.6.38-rc5.orig/include/linux/i2c.h	2011-02-17 13:49:41.000000000 +0100
+++ linux-2.6.38-rc5/include/linux/i2c.h	2011-02-17 13:50:16.000000000 +0100
@@ -448,7 +448,7 @@ extern void i2c_release_client(struct i2
 extern void i2c_clients_command(struct i2c_adapter *adap,
 				unsigned int cmd, void *arg);
 
-extern struct i2c_adapter *i2c_get_adapter(int id);
+extern struct i2c_adapter *i2c_get_adapter(int nr);
 extern void i2c_put_adapter(struct i2c_adapter *adap);
 
 


-- 
Jean Delvare
