From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] i2c: of: Fix of_i2c header file
Date: Tue, 20 Nov 2012 15:47:25 +0100
Message-ID: <1353422845-5621-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

If the OF_I2C configure option is not enabled or not available like on
SPARC, the of_find_i2c_device_by_node and of_find_i2c_adapter_by_node
functions are not declared and can thus lead to compilation errors in
drivers using those.

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Reported-by: fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
---
 include/linux/of_i2c.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/of_i2c.h b/include/linux/of_i2c.h
index 1cb775f..f1ec7f7 100644
--- a/include/linux/of_i2c.h
+++ b/include/linux/of_i2c.h
@@ -29,6 +29,19 @@ static inline void of_i2c_register_devices(struct i2c_adapter *adap)
 {
 	return;
 }
+
+static inline
+struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
+{
+	return NULL;
+}
+
+static inline
+struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_OF_I2C */
 
 #endif /* __LINUX_OF_I2C_H */
-- 
1.7.9.5
