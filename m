From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH resend] i2c: core: Use DEVICE_ATTR_RW() helper macros
Date: Fri, 25 Oct 2019 11:19:50 +0200
Message-ID: <20191025091950.23563-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-i2c@vger.kernel.org

Convert the i2c core sysfs attributes from DEVICE_ATTR() to
DEVICE_ATTR_RW(), to reduce boilerplate.
This requires renaming some functions.

Although no suitable macro exists for the delete_device attribute,
rename i2c_sysfs_delete_device() to delete_device_store() for
consistency.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/i2c/i2c-core-base.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 5f6a4985f2bc8f33..8f6940063c294b9c 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -449,15 +449,15 @@ static void i2c_client_dev_release(struct device *dev)
 }
 
 static ssize_t
-show_name(struct device *dev, struct device_attribute *attr, char *buf)
+name_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%s\n", dev->type == &i2c_client_type ?
 		       to_i2c_client(dev)->name : to_i2c_adapter(dev)->name);
 }
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static DEVICE_ATTR_RO(name);
 
 static ssize_t
-show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
+modalias_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	int len;
@@ -472,7 +472,7 @@ show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
 
 	return sprintf(buf, "%s%s\n", I2C_MODULE_PREFIX, client->name);
 }
-static DEVICE_ATTR(modalias, S_IRUGO, show_modalias, NULL);
+static DEVICE_ATTR_RO(modalias);
 
 static struct attribute *i2c_dev_attrs[] = {
 	&dev_attr_name.attr,
@@ -1039,8 +1039,8 @@ EXPORT_SYMBOL_GPL(i2c_adapter_depth);
  * the user to provide incorrect parameters.
  */
 static ssize_t
-i2c_sysfs_new_device(struct device *dev, struct device_attribute *attr,
-		     const char *buf, size_t count)
+new_device_store(struct device *dev, struct device_attribute *attr,
+		 const char *buf, size_t count)
 {
 	struct i2c_adapter *adap = to_i2c_adapter(dev);
 	struct i2c_board_info info;
@@ -1095,7 +1095,7 @@ i2c_sysfs_new_device(struct device *dev, struct device_attribute *attr,
 
 	return count;
 }
-static DEVICE_ATTR(new_device, S_IWUSR, NULL, i2c_sysfs_new_device);
+static DEVICE_ATTR_WO(new_device);
 
 /*
  * And of course let the users delete the devices they instantiated, if
@@ -1107,8 +1107,8 @@ static DEVICE_ATTR(new_device, S_IWUSR, NULL, i2c_sysfs_new_device);
  * the user to delete the wrong device.
  */
 static ssize_t
-i2c_sysfs_delete_device(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count)
+delete_device_store(struct device *dev, struct device_attribute *attr,
+		    const char *buf, size_t count)
 {
 	struct i2c_adapter *adap = to_i2c_adapter(dev);
 	struct i2c_client *client, *next;
@@ -1151,7 +1151,7 @@ i2c_sysfs_delete_device(struct device *dev, struct device_attribute *attr,
 	return res;
 }
 static DEVICE_ATTR_IGNORE_LOCKDEP(delete_device, S_IWUSR, NULL,
-				   i2c_sysfs_delete_device);
+				  delete_device_store);
 
 static struct attribute *i2c_adapter_attrs[] = {
 	&dev_attr_name.attr,
-- 
2.17.1
