From: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 1/4] i2c: core: fix leaked device refcount on of_find_i2c_* error path
Date: Mon, 27 Jul 2015 17:30:48 +0300
Message-ID: <1438007451-8553-2-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1438007451-8553-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438007451-8553-1-git-send-email-vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

If of_find_i2c_device_by_node() or of_find_i2c_adapter_by_node() find
a device by node, but its type does not match, a reference to that
device is still held. This change fixes the problem.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
---
Changes from v1 to v2:
* none, new change

 drivers/i2c/i2c-core.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index e6d4935..d5fe5a4 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1338,13 +1338,17 @@ static int of_dev_node_match(struct device *dev, void *data)
 struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
 {
 	struct device *dev;
+	struct i2c_client *client;
 
-	dev = bus_find_device(&i2c_bus_type, NULL, node,
-					 of_dev_node_match);
+	dev = bus_find_device(&i2c_bus_type, NULL, node, of_dev_node_match);
 	if (!dev)
 		return NULL;
 
-	return i2c_verify_client(dev);
+	client = i2c_verify_client(dev);
+	if (!client)
+		put_device(dev);
+
+	return client;
 }
 EXPORT_SYMBOL(of_find_i2c_device_by_node);
 
@@ -1352,13 +1356,17 @@ EXPORT_SYMBOL(of_find_i2c_device_by_node);
 struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
 {
 	struct device *dev;
+	struct i2c_adapter *adapter;
 
-	dev = bus_find_device(&i2c_bus_type, NULL, node,
-					 of_dev_node_match);
+	dev = bus_find_device(&i2c_bus_type, NULL, node, of_dev_node_match);
 	if (!dev)
 		return NULL;
 
-	return i2c_verify_adapter(dev);
+	adapter = i2c_verify_adapter(dev);
+	if (!adapter)
+		put_device(dev);
+
+	return adapter;
 }
 EXPORT_SYMBOL(of_find_i2c_adapter_by_node);
 #else
-- 
2.1.4
