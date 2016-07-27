From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 5/7] i2c: mux: add support for 'i2c-mux', 'i2c-arb' and 'i2c-gate' DT subnodes
Date: Wed, 27 Jul 2016 10:43:28 +0200
Message-ID: <1469609010-23049-6-git-send-email-peda@axentia.se>
References: <1469609010-23049-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469609010-23049-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Kalle Valo <kvalo@codeaurora.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Emil Velikov <emil.l.velikov@gmail.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Crestez Dan Leonard <leonard.crestez@intel.com>
List-Id: linux-i2c@vger.kernel.org

Backwards compatibility is preserved; the subnodes are in practice
optional.

However, the mux core needs to know what subnode it should examine, so add
a couple of new flags for i2c_mux_alloc for this purpose.

The rule is that if the mux core finds a 'reg' property in the appropriate
subnode, e.g. if 'reg' exists in the 'i2c-mux' subnode, then the mux core
will assume that this is an old style entry and not an i2c-mux subnode
(correspondingly for arbitrators and gates with 'i2c-arb' and 'i2c-gate').

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/i2c-mux.c   | 44 ++++++++++++++++++++++++++++++++++++--------
 include/linux/i2c-mux.h |  8 ++++++--
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 8eee98634cda..c1ae719d1a7a 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -255,6 +255,10 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
 	muxc->dev = dev;
 	if (flags & I2C_MUX_LOCKED)
 		muxc->mux_locked = true;
+	if (flags & I2C_MUX_ARBITRATOR)
+		muxc->arbitrator = true;
+	if (flags & I2C_MUX_GATE)
+		muxc->gate = true;
 	muxc->select = select;
 	muxc->deselect = deselect;
 	muxc->max_adapters = max_adapters;
@@ -335,18 +339,42 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	 * nothing if !CONFIG_OF.
 	 */
 	if (muxc->dev->of_node) {
-		struct device_node *child;
+		struct device_node *dev_node = muxc->dev->of_node;
+		struct device_node *mux_node, *child = NULL;
 		u32 reg;
 
-		for_each_child_of_node(muxc->dev->of_node, child) {
-			ret = of_property_read_u32(child, "reg", &reg);
-			if (ret)
-				continue;
-			if (chan_id == reg) {
-				priv->adap.dev.of_node = child;
-				break;
+		if (muxc->arbitrator)
+			mux_node = of_get_child_by_name(dev_node, "i2c-arb");
+		else if (muxc->gate)
+			mux_node = of_get_child_by_name(dev_node, "i2c-gate");
+		else
+			mux_node = of_get_child_by_name(dev_node, "i2c-mux");
+
+		if (mux_node) {
+			/* A "reg" property indicates an old-style DT entry */
+			if (!of_property_read_u32(mux_node, "reg", &reg)) {
+				of_node_put(mux_node);
+				mux_node = NULL;
+			}
+		}
+
+		if (!mux_node)
+			mux_node = of_node_get(dev_node);
+		else if (muxc->arbitrator || muxc->gate)
+			child = of_node_get(mux_node);
+
+		if (!child) {
+			for_each_child_of_node(mux_node, child) {
+				ret = of_property_read_u32(child, "reg", &reg);
+				if (ret)
+					continue;
+				if (chan_id == reg)
+					break;
 			}
 		}
+
+		priv->adap.dev.of_node = child;
+		of_node_put(mux_node);
 	}
 
 	/*
diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
index d4c1d12f900d..bd74d5706f3b 100644
--- a/include/linux/i2c-mux.h
+++ b/include/linux/i2c-mux.h
@@ -32,7 +32,9 @@
 struct i2c_mux_core {
 	struct i2c_adapter *parent;
 	struct device *dev;
-	bool mux_locked;
+	unsigned int mux_locked:1;
+	unsigned int arbitrator:1;
+	unsigned int gate:1;
 
 	void *priv;
 
@@ -51,7 +53,9 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
 				   int (*deselect)(struct i2c_mux_core *, u32));
 
 /* flags for i2c_mux_alloc */
-#define I2C_MUX_LOCKED BIT(0)
+#define I2C_MUX_LOCKED     BIT(0)
+#define I2C_MUX_ARBITRATOR BIT(1)
+#define I2C_MUX_GATE       BIT(2)
 
 static inline void *i2c_mux_priv(struct i2c_mux_core *muxc)
 {
-- 
2.1.4
