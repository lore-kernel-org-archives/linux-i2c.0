From: Luca Ceresoli <lucaceresoli77@gmail.com>
Subject: [PATCH v3] i2c: mux: remove duplicated i2c_algorithm
Date: Wed,  3 Oct 2018 17:19:28 +0200
Message-ID: <20181003151928.17713-1-lucaceresoli77@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Luca Ceresoli <luca@lucaceresoli.net>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org

From: Luca Ceresoli <luca@lucaceresoli.net>

i2c-mux instantiates one i2c_algorithm for each downstream adapter.
However these algorithms are all identical, depending only on the
parent adapter.

Avoid duplication by hoisting the i2c_algorithm from the adapters to
the i2c_mux_core object, and reuse it in all the adapters.

Cc: Peter Rosin <peda@axentia.se>
Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes v2 -> v3:
 - fix coding style of comment when moving it (Peter Rosin)
 - move the 'algo' member between parent and dev (Peter Rosin)

Changes v1 -> v2:
 - include i2c.h (fixes build failure on i2c-mux-ltc4306)
---
 drivers/i2c/i2c-mux.c   | 38 +++++++++++++++++++-------------------
 include/linux/i2c-mux.h |  2 ++
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index f330690b4125..6ac23004fb2a 100644
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
@@ -263,6 +262,24 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
 	muxc->deselect = deselect;
 	muxc->max_adapters = max_adapters;
 
+	/*
+	 * Need to do algo dynamically because we don't know ahead of
+	 * time what sort of physical adapter we'll be dealing with.
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
@@ -301,28 +318,11 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
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
index bd74d5706f3b..3d89600d5a9e 100644
--- a/include/linux/i2c-mux.h
+++ b/include/linux/i2c-mux.h
@@ -28,9 +28,11 @@
 #ifdef __KERNEL__
 
 #include <linux/bitops.h>
+#include <linux/i2c.h>
 
 struct i2c_mux_core {
 	struct i2c_adapter *parent;
+	struct i2c_algorithm algo;
 	struct device *dev;
 	unsigned int mux_locked:1;
 	unsigned int arbitrator:1;
-- 
2.17.1
