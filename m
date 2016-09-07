From: <jim_baxter@mentor.com>
Subject: [PATCH v1 1/2] i2c-mux: add i2c_mux_add_reparented_adapter api
Date: Wed, 7 Sep 2016 21:05:28 +0100
Message-ID: <1473278729-16329-2-git-send-email-jim_baxter@mentor.com>
References: <1473278729-16329-1-git-send-email-jim_baxter@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473278729-16329-1-git-send-email-jim_baxter@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Peter Korsgaard <peter.korsgaard@barco.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Joshua Frkuska <joshua_frkuska@mentor.com>

This new api allows the i2c adapter created by i2c-mux to be owned by
the module that calls this api. This allows module removal chaining to
be done at a higher level.

Signed-off-by: Joshua Frkuska <joshua_frkuska@mentor.com>
Signed-off-by: Jim Baxter <jim_baxter@mentor.com>
---
 drivers/i2c/i2c-mux.c   | 14 ++++++++++++--
 include/linux/i2c-mux.h | 15 +++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 8eee986..191816b 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -263,7 +263,8 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
 }
 EXPORT_SYMBOL_GPL(i2c_mux_alloc);
 
-int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
+int i2c_mux_add_reparented_adapter(struct module *owner,
+			struct i2c_mux_core *muxc,
 			u32 force_nr, u32 chan_id,
 			unsigned int class)
 {
@@ -305,7 +306,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	/* Now fill out new adapter structure */
 	snprintf(priv->adap.name, sizeof(priv->adap.name),
 		 "i2c-%d-mux (chan_id %d)", i2c_adapter_id(parent), chan_id);
-	priv->adap.owner = THIS_MODULE;
+	priv->adap.owner = owner;
 	priv->adap.algo = &priv->algo;
 	priv->adap.algo_data = priv;
 	priv->adap.dev.parent = &parent->dev;
@@ -385,6 +386,15 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	muxc->adapter[muxc->num_adapters++] = &priv->adap;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(i2c_mux_add_reparented_adapter);
+
+int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
+			u32 force_nr, u32 chan_id,
+			unsigned int class)
+{
+	return i2c_mux_add_reparented_adapter(THIS_MODULE, muxc, force_nr,
+			chan_id, class);
+}
 EXPORT_SYMBOL_GPL(i2c_mux_add_adapter);
 
 void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
index d4c1d12..d4f8610 100644
--- a/include/linux/i2c-mux.h
+++ b/include/linux/i2c-mux.h
@@ -64,6 +64,21 @@ struct i2c_adapter *i2c_root_adapter(struct device *dev);
  * Called to create an i2c bus on a multiplexed bus segment.
  * The chan_id parameter is passed to the select and deselect
  * callback functions to perform hardware-specific mux control.
+ *
+ * Unlike the simple i2c_add_mux_adapter, this is passed in the caller's
+ * module reference in order to reparent the adapter from the perspective of
+ * the i2c hierarchy. This allows the caller to be reference locked while the
+ * i2c adapter is in use.
+ */
+int i2c_mux_add_reparented_adapter(struct module *owner,
+				   struct i2c_mux_core *muxc,
+				   u32 force_nr, u32 chan_id,
+				   unsigned int class);
+
+/*
+ * Called to create an i2c bus on a multiplexed bus segment.
+ * The chan_id parameter is passed to the select and deselect
+ * callback functions to perform hardware-specific mux control.
  */
 int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 			u32 force_nr, u32 chan_id,
-- 
1.9.1
