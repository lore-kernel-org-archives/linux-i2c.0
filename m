From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: at24.c,
	how to get kobject for sysfs/bin_attribute methods?
Date: Mon, 28 Jul 2008 09:25:15 -0400
Message-ID: <9e4733910807280625k573fabf5x34f85636e4dcfd7d@mail.gmail.com>
References: <488D6513.6070701@sitecno.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <488D6513.6070701-91aMuT3/2DXHOG6cAo2yLw@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Matti Kaasinen <matti.kaasinen-91aMuT3/2DXHOG6cAo2yLw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

PowerPC is going to use this....

Add the of_find_i2c_device_by_node function

From: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Add the of_find_i2c_device_by_node function. This allows you to follow
a reference in the device tree to an i2c device node and then locate
the linux device instantiated by the device tree. Example use, an i2s
codec controlled by i2c. Depends on patch exporting i2c root bus symbol.

Signed-off-by: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---

 drivers/of/of_i2c.c    |   28 ++++++++++++++++++++++++----
 include/linux/of_i2c.h |    2 ++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index 6a98dc8..ba7b394 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -19,7 +19,7 @@
 void of_register_i2c_devices(struct i2c_adapter *adap,
 			     struct device_node *adap_node)
 {
-	void *result;
+	struct i2c_client *i2c_dev;
 	struct device_node *node;

 	for_each_child_of_node(adap_node, node) {
@@ -41,18 +41,38 @@ void of_register_i2c_devices(struct i2c_adapter *adap,

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


-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
