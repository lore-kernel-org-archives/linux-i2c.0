From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: simplify boilerplate code for attribute groups
Date: Mon, 19 Jan 2015 20:12:24 +0100
Message-ID: <1421694744-19528-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Declaring attribute groups can be done with macros these days, let's use
them for consistency and readability reasons. Also, put the ATTR macros
directly below the referenced functions while we are here.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 15cc5902cf89..15be1e95e1d2 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -803,6 +803,7 @@ show_name(struct device *dev, struct device_attribute *attr, char *buf)
 	return sprintf(buf, "%s\n", dev->type == &i2c_client_type ?
 		       to_i2c_client(dev)->name : to_i2c_adapter(dev)->name);
 }
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
 static ssize_t
 show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
@@ -816,8 +817,6 @@ show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
 
 	return sprintf(buf, "%s%s\n", I2C_MODULE_PREFIX, client->name);
 }
-
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 static DEVICE_ATTR(modalias, S_IRUGO, show_modalias, NULL);
 
 static struct attribute *i2c_dev_attrs[] = {
@@ -826,15 +825,7 @@ static struct attribute *i2c_dev_attrs[] = {
 	&dev_attr_modalias.attr,
 	NULL
 };
-
-static struct attribute_group i2c_dev_attr_group = {
-	.attrs		= i2c_dev_attrs,
-};
-
-static const struct attribute_group *i2c_dev_attr_groups[] = {
-	&i2c_dev_attr_group,
-	NULL
-};
+ATTRIBUTE_GROUPS(i2c_dev);
 
 static const struct dev_pm_ops i2c_device_pm_ops = {
 	.suspend = i2c_device_pm_suspend,
@@ -861,7 +852,7 @@ struct bus_type i2c_bus_type = {
 EXPORT_SYMBOL_GPL(i2c_bus_type);
 
 static struct device_type i2c_client_type = {
-	.groups		= i2c_dev_attr_groups,
+	.groups		= i2c_dev_groups,
 	.uevent		= i2c_device_uevent,
 	.release	= i2c_client_dev_release,
 };
@@ -1259,6 +1250,7 @@ i2c_sysfs_new_device(struct device *dev, struct device_attribute *attr,
 
 	return count;
 }
+static DEVICE_ATTR(new_device, S_IWUSR, NULL, i2c_sysfs_new_device);
 
 /*
  * And of course let the users delete the devices they instantiated, if
@@ -1313,8 +1305,6 @@ i2c_sysfs_delete_device(struct device *dev, struct device_attribute *attr,
 			"delete_device");
 	return res;
 }
-
-static DEVICE_ATTR(new_device, S_IWUSR, NULL, i2c_sysfs_new_device);
 static DEVICE_ATTR_IGNORE_LOCKDEP(delete_device, S_IWUSR, NULL,
 				   i2c_sysfs_delete_device);
 
@@ -1324,18 +1314,10 @@ static struct attribute *i2c_adapter_attrs[] = {
 	&dev_attr_delete_device.attr,
 	NULL
 };
-
-static struct attribute_group i2c_adapter_attr_group = {
-	.attrs		= i2c_adapter_attrs,
-};
-
-static const struct attribute_group *i2c_adapter_attr_groups[] = {
-	&i2c_adapter_attr_group,
-	NULL
-};
+ATTRIBUTE_GROUPS(i2c_adapter);
 
 struct device_type i2c_adapter_type = {
-	.groups		= i2c_adapter_attr_groups,
+	.groups		= i2c_adapter_groups,
 	.release	= i2c_adapter_dev_release,
 };
 EXPORT_SYMBOL_GPL(i2c_adapter_type);
-- 
2.1.3
