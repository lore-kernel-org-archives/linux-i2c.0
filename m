From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Add a sysfs interface to instantiate devices
Date: Mon, 4 May 2009 18:44:05 +0200
Message-ID: <20090504184405.3b9a70e5@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Shane Dixon <shane.dixon-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add a sysfs interface to instantiate and delete I2C devices. This is
primarily a replacement of the force_* module parameters implemented
by some i2c drivers. These module parameters were implemented
internally by the I2C_CLIENT_INSMOD* macros, which don't scale well.

This can also be used when developing a driver on a self-soldered
board which doesn't yet have proper I2C device declaration at the
platform level, and presumably for various debugging situations.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
---
 Documentation/i2c/instantiating-devices |   44 +++++++++++
 drivers/i2c/i2c-core.c                  |  122 +++++++++++++++++++++++++++++++
 include/linux/i2c.h                     |    3 
 3 files changed, 168 insertions(+), 1 deletion(-)

--- linux-2.6.30-rc4.orig/drivers/i2c/i2c-core.c	2009-05-04 17:06:00.000000000 +0200
+++ linux-2.6.30-rc4/drivers/i2c/i2c-core.c	2009-05-04 17:33:58.000000000 +0200
@@ -38,8 +38,10 @@
 #include "i2c-core.h"
 
 
+/* core_lock protects i2c_adapter_idr and userspace_devices, amongst others */
 static DEFINE_MUTEX(core_lock);
 static DEFINE_IDR(i2c_adapter_idr);
+static LIST_HEAD(userspace_devices);
 
 static int i2c_check_addr(struct i2c_adapter *adapter, int addr);
 static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver);
@@ -370,8 +372,128 @@ show_adapter_name(struct device *dev, st
 	return sprintf(buf, "%s\n", adap->name);
 }
 
+/*
+ * Let users instantiate I2C devices through sysfs. This can be used when
+ * platform initialization code doesn't contain the proper data for
+ * whatever reason. Also useful for drivers that do device detection and
+ * detection fails, either because the device uses an unexpected address,
+ * or this is a compatible device with different ID register values.
+ *
+ * Parameter checking may look overzealous, but we really don't want
+ * the user to provide incorrect parameters.
+ */
+static ssize_t
+i2c_sysfs_new_device(struct device *dev, struct device_attribute *attr,
+		     const char *buf, size_t count)
+{
+	struct i2c_adapter *adap = to_i2c_adapter(dev);
+	struct i2c_board_info info;
+	struct i2c_client *client;
+	char *blank, end;
+	int res;
+
+	dev_warn(dev, "The new_device interface is still experimental "
+		 "and may change in a near future\n");
+	memset(&info, 0, sizeof(struct i2c_board_info));
+
+	blank = strchr(buf, ' ');
+	if (!blank) {
+		dev_err(dev, "%s: Missing parameters\n", "new_device");
+		return -EINVAL;
+	}
+	if (blank - buf > I2C_NAME_SIZE - 1) {
+		dev_err(dev, "%s: Invalid device name\n", "new_device");
+		return -EINVAL;
+	}
+	memcpy(info.type, buf, blank - buf);
+
+	/* Parse remaining parameters, reject extra parameters */
+	res = sscanf(++blank, "%hi%c", &info.addr, &end);
+	if (res < 1) {
+		dev_err(dev, "%s: Can't parse I2C address\n", "new_device");
+		return -EINVAL;
+	}
+	if (res > 1  && end != '\n') {
+		dev_err(dev, "%s: Extra parameters\n", "new_device");
+		return -EINVAL;
+	}
+
+	if (info.addr < 0x03 || info.addr > 0x77) {
+		dev_err(dev, "%s: Invalid I2C address 0x%hx\n", "new_device",
+			info.addr);
+		return -EINVAL;
+	}
+
+	client = i2c_new_device(adap, &info);
+	if (!client)
+		return -EEXIST;
+
+	/* Keep track of the added device */
+	mutex_lock(&core_lock);
+	list_add_tail(&client->detected, &userspace_devices);
+	mutex_unlock(&core_lock);
+	dev_info(dev, "%s: Instantiated device %s at 0x%02hx\n", "new_device",
+		 info.type, info.addr);
+
+	return count;
+}
+
+/*
+ * And of course let the users delete the devices they instantiated, if
+ * they got it wrong. This interface can only be used to delete devices
+ * instantiated by i2c_sysfs_new_device above. This guarantees that we
+ * don't delete devices to which some kernel code still has references.
+ *
+ * Parameter checking may look overzealous, but we really don't want
+ * the user to delete the wrong device.
+ */
+static ssize_t
+i2c_sysfs_delete_device(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct i2c_adapter *adap = to_i2c_adapter(dev);
+	struct i2c_client *client, *next;
+	unsigned short addr;
+	char end;
+	int res;
+
+	/* Parse parameters, reject extra parameters */
+	res = sscanf(buf, "%hi%c", &addr, &end);
+	if (res < 1) {
+		dev_err(dev, "%s: Can't parse I2C address\n", "delete_device");
+		return -EINVAL;
+	}
+	if (res > 1  && end != '\n') {
+		dev_err(dev, "%s: Extra parameters\n", "delete_device");
+		return -EINVAL;
+	}
+
+	/* Make sure the device was added through sysfs */
+	res = -ENOENT;
+	mutex_lock(&core_lock);
+	list_for_each_entry_safe(client, next, &userspace_devices, detected) {
+		if (client->addr == addr && client->adapter == adap) {
+			dev_info(dev, "%s: Deleting device %s at 0x%02hx\n",
+				 "delete_device", client->name, client->addr);
+
+			list_del(&client->detected);
+			i2c_unregister_device(client);
+			res = count;
+			break;
+		}
+	}
+	mutex_unlock(&core_lock);
+
+	if (res < 0)
+		dev_err(dev, "%s: Can't find device in list\n",
+			"delete_device");
+	return res;
+}
+
 static struct device_attribute i2c_adapter_attrs[] = {
 	__ATTR(name, S_IRUGO, show_adapter_name, NULL),
+	__ATTR(new_device, S_IWUSR, NULL, i2c_sysfs_new_device),
+	__ATTR(delete_device, S_IWUSR, NULL, i2c_sysfs_delete_device),
 	{ },
 };
 
--- linux-2.6.30-rc4.orig/include/linux/i2c.h	2009-05-04 17:05:59.000000000 +0200
+++ linux-2.6.30-rc4/include/linux/i2c.h	2009-05-04 17:06:02.000000000 +0200
@@ -178,7 +178,8 @@ struct i2c_driver {
  * @driver: device's driver, hence pointer to access routines
  * @dev: Driver model device node for the slave.
  * @irq: indicates the IRQ generated by this device (if any)
- * @detected: member of an i2c_driver.clients list
+ * @detected: member of an i2c_driver.clients list or i2c-core's
+ *	userspace_devices list
  *
  * An i2c_client identifies a single device (i.e. chip) connected to an
  * i2c bus. The behaviour exposed to Linux is defined by the driver
--- linux-2.6.30-rc4.orig/Documentation/i2c/instantiating-devices	2009-04-08 08:52:10.000000000 +0200
+++ linux-2.6.30-rc4/Documentation/i2c/instantiating-devices	2009-05-04 18:42:56.000000000 +0200
@@ -165,3 +165,47 @@ was done there. Two significant differen
 Once again, method 3 should be avoided wherever possible. Explicit device
 instantiation (methods 1 and 2) is much preferred for it is safer and
 faster.
+
+
+Method 4: Instantiate from user-space
+-------------------------------------
+
+In general, the kernel should know which I2C devices are connected and
+what addresses they live at. However, in certain cases, it does not, so a
+sysfs interface was added to let the user provide the information. This
+interface is made of 2 attribute files which are created in every I2C bus
+directory: new_device and delete_device. Both files are write only and you
+must write the right parameters to them in order to properly instantiate,
+respectively delete, an I2C device.
+
+File new_device takes 2 parameters: the name of the I2C device (a string)
+and the address of the I2C device (a number, typically expressed in
+hexadecimal starting with 0x, but can also be expressed in decimal.)
+
+File delete_device takes a single parameter: the address of the I2C
+device. As no two devices can live at the same address on a given I2C
+segment, the address is sufficient to uniquely identify the device to be
+deleted.
+
+Example:
+# echo eeprom 0x50 > /sys/class/i2c-adapter/i2c-3/new_device
+
+While this interface should only be used when in-kernel device declaration
+can't be done, there is a variety of cases where it can be helpful:
+* The I2C driver usually detects devices (method 3 above) but the bus
+  segment your device lives on doesn't have the proper class bit set and
+  thus detection doesn't trigger.
+* The I2C driver usually detects devices, but your device lives at an
+  unexpected address.
+* The I2C driver usually detects devices, but your device is not detected,
+  either because the detection routine is too strict, or because your
+  device is not officially supported yet but you know it is compatible.
+* You are developing a driver on a test board, where you soldered the I2C
+  device yourself.
+
+This interface is a replacement for the force_* module parameters some I2C
+drivers implement. Being implemented in i2c-core rather than in each
+device driver individually, it is much more efficient, and also has the
+advantage that you do not have to reload the driver to change a setting.
+You can also instantiate the device before the driver is loaded or even
+available, and you don't need to know what driver the device needs.


-- 
Jean Delvare
