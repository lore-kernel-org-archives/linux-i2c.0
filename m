From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/2] i2c: move locking operations to their own struct
Date: Fri, 29 Jul 2016 10:17:57 +0200
Message-ID: <1469780277-31085-3-git-send-email-peda@axentia.se>
References: <1469780277-31085-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-he1eur01on0131.outbound.protection.outlook.com ([104.47.0.131]:56384
	"EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750752AbcG2JuJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 29 Jul 2016 05:50:09 -0400
In-Reply-To: <1469780277-31085-1-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

This makes it trivial to constify them, so do that.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/i2c-core.c | 13 ++++++++-----
 drivers/i2c/i2c-mux.c  | 25 ++++++++++++++++---------
 include/linux/i2c.h    | 25 ++++++++++++++++++-------
 3 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 2c9135ffdf10..ce252ba13247 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1511,6 +1511,12 @@ static int __process_new_adapter(struct device_driver *d, void *data)
 	return i2c_do_add_adapter(to_i2c_driver(d), data);
 }
 
+static const struct i2c_lock_operations i2c_adapter_lock_ops = {
+	.lock_bus =    i2c_adapter_lock_bus,
+	.trylock_bus = i2c_adapter_trylock_bus,
+	.unlock_bus =  i2c_adapter_unlock_bus,
+};
+
 static int i2c_register_adapter(struct i2c_adapter *adap)
 {
 	int res = 0;
@@ -1533,11 +1539,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 		return -EINVAL;
 	}
 
-	if (!adap->lock_bus) {
-		adap->lock_bus = i2c_adapter_lock_bus;
-		adap->trylock_bus = i2c_adapter_trylock_bus;
-		adap->unlock_bus = i2c_adapter_unlock_bus;
-	}
+	if (!adap->lock_ops)
+		adap->lock_ops = &i2c_adapter_lock_ops;
 
 	rt_mutex_init(&adap->bus_lock);
 	rt_mutex_init(&adap->mux_lock);
diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 764f195795e4..14741ff31041 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -263,6 +263,18 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
 }
 EXPORT_SYMBOL_GPL(i2c_mux_alloc);
 
+static const struct i2c_lock_operations i2c_mux_lock_ops = {
+	.lock_bus =    i2c_mux_lock_bus,
+	.trylock_bus = i2c_mux_trylock_bus,
+	.unlock_bus =  i2c_mux_unlock_bus,
+};
+
+static const struct i2c_lock_operations i2c_parent_lock_ops = {
+	.lock_bus =    i2c_parent_lock_bus,
+	.trylock_bus = i2c_parent_trylock_bus,
+	.unlock_bus =  i2c_parent_unlock_bus,
+};
+
 int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 			u32 force_nr, u32 chan_id,
 			unsigned int class)
@@ -312,15 +324,10 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	priv->adap.retries = parent->retries;
 	priv->adap.timeout = parent->timeout;
 	priv->adap.quirks = parent->quirks;
-	if (muxc->mux_locked) {
-		priv->adap.lock_bus = i2c_mux_lock_bus;
-		priv->adap.trylock_bus = i2c_mux_trylock_bus;
-		priv->adap.unlock_bus = i2c_mux_unlock_bus;
-	} else {
-		priv->adap.lock_bus = i2c_parent_lock_bus;
-		priv->adap.trylock_bus = i2c_parent_trylock_bus;
-		priv->adap.unlock_bus = i2c_parent_unlock_bus;
-	}
+	if (muxc->mux_locked)
+		priv->adap.lock_ops = &i2c_mux_lock_ops;
+	else
+		priv->adap.lock_ops = &i2c_parent_lock_ops;
 
 	/* Sanity check on class */
 	if (i2c_mux_parent_classes(parent) & class)
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index e1a8d72ebccb..765bea57eeb3 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -414,6 +414,20 @@ struct i2c_algorithm {
 };
 
 /**
+ * struct i2c_lock_operations - represent I2C locking operations
+ * @lock_bus: Get exclusive access to an I2C bus segment
+ * @trylock_bus: Try to get exclusive access to an I2C bus segment
+ * @unlock_bus: Release exclusive access to an I2C bus segment
+ *
+ * The main operations are wrapped by i2c_lock_bus and i2c_unlock_bus.
+ */
+struct i2c_lock_operations {
+	void (*lock_bus)(struct i2c_adapter *, unsigned int flags);
+	int (*trylock_bus)(struct i2c_adapter *, unsigned int flags);
+	void (*unlock_bus)(struct i2c_adapter *, unsigned int flags);
+};
+
+/**
  * struct i2c_timings - I2C timing information
  * @bus_freq_hz: the bus frequency in Hz
  * @scl_rise_ns: time SCL signal takes to rise in ns; t(r) in the I2C specification
@@ -523,6 +537,7 @@ struct i2c_adapter {
 	void *algo_data;
 
 	/* data fields that are valid for all devices	*/
+	const struct i2c_lock_operations *lock_ops;
 	struct rt_mutex bus_lock;
 	struct rt_mutex mux_lock;
 
@@ -539,10 +554,6 @@ struct i2c_adapter {
 
 	struct i2c_bus_recovery_info *bus_recovery_info;
 	const struct i2c_adapter_quirks *quirks;
-
-	void (*lock_bus)(struct i2c_adapter *, unsigned int flags);
-	int (*trylock_bus)(struct i2c_adapter *, unsigned int flags);
-	void (*unlock_bus)(struct i2c_adapter *, unsigned int flags);
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
@@ -584,7 +595,7 @@ int i2c_for_each_dev(void *data, int (*fn)(struct device *, void *));
 static inline void
 i2c_lock_bus(struct i2c_adapter *adapter, unsigned int flags)
 {
-	adapter->lock_bus(adapter, flags);
+	adapter->lock_ops->lock_bus(adapter, flags);
 }
 
 /**
@@ -598,7 +609,7 @@ i2c_lock_bus(struct i2c_adapter *adapter, unsigned int flags)
 static inline int
 i2c_trylock_bus(struct i2c_adapter *adapter, unsigned int flags)
 {
-	return adapter->trylock_bus(adapter, flags);
+	return adapter->lock_ops->trylock_bus(adapter, flags);
 }
 
 /**
@@ -610,7 +621,7 @@ i2c_trylock_bus(struct i2c_adapter *adapter, unsigned int flags)
 static inline void
 i2c_unlock_bus(struct i2c_adapter *adapter, unsigned int flags)
 {
-	adapter->unlock_bus(adapter, flags);
+	adapter->lock_ops->unlock_bus(adapter, flags);
 }
 
 static inline void
-- 
2.1.4
