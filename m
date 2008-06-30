From: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] Add the of_find_i2c_device_by_node function, V3
Date: Mon, 30 Jun 2008 14:34:15 -0400
Message-ID: <20080630183415.4614.68308.stgit@terra>
References: <20080630183413.4614.8840.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080630183413.4614.8840.stgit@terra>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Add the of_find_i2c_device_by_node function. This allows you to follow a reference in the device to an i2c device node and then locate the linux device instantiated by the device tree. Example use, an i2s codec controlled by i2c.
---

 drivers/i2c/i2c-core.c |    2 +-
 drivers/of/of_i2c.c    |   37 ++++++++++++++++++++++++++-----------
 include/linux/i2c.h    |    3 +++
 include/linux/of_i2c.h |    2 ++
 4 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index d0175f4..e3abe1b 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -208,7 +208,7 @@ static struct device_attribute i2c_dev_attrs[] = {
 	{ },
 };
 
-static struct bus_type i2c_bus_type = {
+struct bus_type i2c_bus_type = {
 	.name		= "i2c",
 	.dev_attrs	= i2c_dev_attrs,
 	.match		= i2c_device_match,
diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index 715a444..ca69a16 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -75,7 +75,7 @@ static int of_find_i2c_driver(struct device_node *node,
 void of_register_i2c_devices(struct i2c_adapter *adap,
 			     struct device_node *adap_node)
 {
-	void *result;
+	struct i2c_client *i2c_dev;
 	struct device_node *node;
 
 	for_each_child_of_node(adap_node, node) {
@@ -90,29 +90,44 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 			continue;
 		}
 
-		info.irq = irq_of_parse_and_map(node, 0);
-		if (info.irq == NO_IRQ)
-			info.irq = -1;
-
-		if (of_find_i2c_driver(node, &info) < 0) {
-			irq_dispose_mapping(info.irq);
+		if (of_find_i2c_driver(node, &info) < 0)
 			continue;
-		}
 
+		info.irq = irq_of_parse_and_map(node, 0);
 		info.addr = *addr;
 
-		request_module(info.type);
+		request_module("%s", info.type);
 
-		result = i2c_new_device(adap, &info);
-		if (result == NULL) {
+		i2c_dev = i2c_new_device(adap, &info);
+		if (i2c_dev == NULL) {
 			printk(KERN_ERR
 			       "of-i2c: Failed to load driver for %s\n",
 			       info.type);
 			irq_dispose_mapping(info.irq);
 			continue;
 		}
+		
+		i2c_dev->dev.archdata.of_node = of_node_get(node);
 	}
 }
 EXPORT_SYMBOL(of_register_i2c_devices);
 
+static int of_dev_node_match(struct device *dev, void *data)
+{
+        return dev->archdata.of_node == data;
+}
+
+struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
+{
+	struct device *dev;
+	
+	dev = bus_find_device(&i2c_bus_type, NULL, node, 
+					 of_dev_node_match);
+	if (!dev)
+		return NULL;
+		
+	return to_i2c_client(dev);
+}
+EXPORT_SYMBOL(of_find_i2c_device_by_node);
+
 MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index fb9af6a..186b22d 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -92,6 +92,9 @@ extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
 extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,
 					  u8 command, u8 length,
 					  const u8 *values);
+					  
+/* Base of the i2c bus */
+extern struct bus_type i2c_bus_type; 
 
 /*
  * A driver is capable of handling one or more physical devices present on
diff --git a/include/linux/of_i2c.h b/include/linux/of_i2c.h
index bd2a870..17d5897 100644
--- a/include/linux/of_i2c.h
+++ b/include/linux/of_i2c.h
@@ -16,5 +16,7 @@
 
 void of_register_i2c_devices(struct i2c_adapter *adap,
 			     struct device_node *adap_node);
+struct i2c_client *of_find_i2c_device_by_node(struct device_node *node);
+			     
 
 #endif /* __LINUX_OF_I2C_H */


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
