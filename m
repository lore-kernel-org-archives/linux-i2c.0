From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH 2/2] of/i2c: implement of_find_i2c_adapter_by_node
Date: Tue, 17 Apr 2012 12:43:34 -0600
Message-ID: <1334688214-8400-2-git-send-email-swarren@wwwdotorg.org>
References: <1334688214-8400-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334688214-8400-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

This finds the struct i2c_adapter * for a given device tree node. Just
like of_find_i2c_device_by_node.

Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Note: This series is a dependency for the pinctrl I2C bus mux I will send in a
minute. It'd probably be easiest to merge this through the I2C tree.
It might also be useful to put this patch (and the others I'll send) in
a separate tree so it can be merged into any SoC trees that wish to use
this new feature.

 drivers/of/of_i2c.c    |   14 ++++++++++++++
 include/linux/of_i2c.h |    4 ++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index 0684887..1e173f3 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -94,4 +94,18 @@ struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
 }
 EXPORT_SYMBOL(of_find_i2c_device_by_node);
 
+/* must call put_device() when done with returned i2c_adapter device */
+struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
+{
+	struct device *dev;
+
+	dev = bus_find_device(&i2c_bus_type, NULL, node,
+					 of_dev_node_match);
+	if (!dev)
+		return NULL;
+
+	return i2c_verify_adapter(dev);
+}
+EXPORT_SYMBOL(of_find_i2c_adapter_by_node);
+
 MODULE_LICENSE("GPL");
diff --git a/include/linux/of_i2c.h b/include/linux/of_i2c.h
index 0efe8d4..1cb775f 100644
--- a/include/linux/of_i2c.h
+++ b/include/linux/of_i2c.h
@@ -20,6 +20,10 @@ extern void of_i2c_register_devices(struct i2c_adapter *adap);
 /* must call put_device() when done with returned i2c_client device */
 extern struct i2c_client *of_find_i2c_device_by_node(struct device_node *node);
 
+/* must call put_device() when done with returned i2c_adapter device */
+extern struct i2c_adapter *of_find_i2c_adapter_by_node(
+						struct device_node *node);
+
 #else
 static inline void of_i2c_register_devices(struct i2c_adapter *adap)
 {
-- 
1.7.0.4
