From: Luca Ceresoli <lucaceresoli77@gmail.com>
Subject: [PATCH v2] i2c: mux: remove duplicated i2c_algorithm
Date: Thu, 27 Sep 2018 15:38:15 +0200
Message-ID: <20180927133815.19089-1-lucaceresoli77@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Luca Ceresoli <luca@lucaceresoli.net>, Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

From: Luca Ceresoli <luca@lucaceresoli.net>

i2c-mux instantiates one i2c_algorithm for each downstream adapter.
However these algorithms are all identical, depending only on the
parent adapter.

Avoid duplication by hoisting the i2c_algorithm from the adapters to
the i2c_mux_core object, and reuse it in all the adapters.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes v1 -> v2:
 - include i2c.h (fixes build failure on i2c-mux-ltc4306)
---
 drivers/i2c/i2c-mux.c   | 37 ++++++++++++++++++-------------------
 include/linux/i2c-mux.h |  2 ++
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index f330690b4125..2b0cc2ad0a17 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -30,7 +30,6 @@
 /* multiplexer per channel data */
 struct i2c_mux_priv {
 	struct i2c_adapter adap;
-	struct i2c_algorithm algo;
 	struct i2c_mux_core *muxc;
 	u32 chan_id;
 };
@@ -263,6 +262,23 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
 	muxc->deselect = deselect;
 	muxc->max_adapters = max_adapters;
 
+	/* Need to do algo dynamically because we don't know ahead
+	 * of time what sort of physical adapter we'll be dealing with.
+	 */
+	if (parent->algo->master_xfer) {
+		if (muxc->mux_locked)
+			muxc->algo.master_xfer = i2c_mux_master_xfer;
+		else
+			muxc->algo.master_xfer = __i2c_mux_master_xfer;
+	}
+	if (parent->algo->smbus_xfer) {
+		if (muxc->mux_locked)
+			muxc->algo.smbus_xfer = i2c_mux_smbus_xfer;
+		else
+			muxc->algo.smbus_xfer = __i2c_mux_smbus_xfer;
+	}
+	muxc->algo.functionality = i2c_mux_functionality;
+
 	return muxc;
 }
 EXPORT_SYMBOL_GPL(i2c_mux_alloc);
@@ -301,28 +317,11 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	priv->muxc = muxc;
 	priv->chan_id = chan_id;
 
-	/* Need to do algo dynamically because we don't know ahead
-	 * of time what sort of physical adapter we'll be dealing with.
-	 */
-	if (parent->algo->master_xfer) {
-		if (muxc->mux_locked)
-			priv->algo.master_xfer = i2c_mux_master_xfer;
-		else
-			priv->algo.master_xfer = __i2c_mux_master_xfer;
-	}
-	if (parent->algo->smbus_xfer) {
-		if (muxc->mux_locked)
-			priv->algo.smbus_xfer = i2c_mux_smbus_xfer;
-		else
-			priv->algo.smbus_xfer = __i2c_mux_smbus_xfer;
-	}
-	priv->algo.functionality = i2c_mux_functionality;
-
 	/* Now fill out new adapter structure */
 	snprintf(priv->adap.name, sizeof(priv->adap.name),
 		 "i2c-%d-mux (chan_id %d)", i2c_adapter_id(parent), chan_id);
 	priv->adap.owner = THIS_MODULE;
-	priv->adap.algo = &priv->algo;
+	priv->adap.algo = &muxc->algo;
 	priv->adap.algo_data = priv;
 	priv->adap.dev.parent = &parent->dev;
 	priv->adap.retries = parent->retries;
diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
index bd74d5706f3b..5a4ffca99f5d 100644
--- a/include/linux/i2c-mux.h
+++ b/include/linux/i2c-mux.h
@@ -28,6 +28,7 @@
 #ifdef __KERNEL__
 
 #include <linux/bitops.h>
+#include <linux/i2c.h>
 
 struct i2c_mux_core {
 	struct i2c_adapter *parent;
@@ -36,6 +37,7 @@ struct i2c_mux_core {
 	unsigned int arbitrator:1;
 	unsigned int gate:1;
 
+	struct i2c_algorithm algo;
 	void *priv;
 
 	int (*select)(struct i2c_mux_core *, u32 chan_id);
-- 
2.17.1
