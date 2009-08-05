From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/4] Add support for compatibility classes
Date: Wed, 5 Aug 2009 11:11:50 +0200
Message-ID: <20090805111150.6541f6f6@hyperion.delvare>
References: <20090805110537.73735169@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090805110537.73735169-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>

When turning class devices into bus devices, we may need to
temporarily add links in sysfs so that user-space applications
are not confused. This is done by adding the following API:

* Functions to register and unregister compatibility classes.
  These appear in sysfs at the same location as regular classes, but
  instead of class devices, they contain links to bus devices.
* Functions to create and delete such links. Additionally, the caller
  can optionally pass a target device to which a "device" link should
  point (typically that would be the device's parent), to fully
  emulate the original class device.

The i2c subsystem will be the first user of this API, as i2c adapters
are being converted from class devices to bus devices.

Signed-off-by: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/base/class.c   |   87 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |    8 ++++
 2 files changed, 95 insertions(+)

--- linux-2.6.31-rc5.orig/drivers/base/class.c	2009-08-03 22:10:23.000000000 +0200
+++ linux-2.6.31-rc5/drivers/base/class.c	2009-08-04 12:47:09.000000000 +0200
@@ -488,6 +488,93 @@ void class_interface_unregister(struct c
 	class_put(parent);
 }
 
+struct class_compat {
+	struct kobject *kobj;
+};
+
+/**
+ * class_compat_register - register a compatibility class
+ * @name: the name of the class
+ *
+ * Compatibility classes are meant as a temporary user-space compatibility
+ * workaround when converting a family of class devices to bus devices.
+ */
+struct class_compat *class_compat_register(const char *name)
+{
+	struct class_compat *cls;
+
+	cls = kmalloc(sizeof(struct class_compat), GFP_KERNEL);
+	if (!cls)
+		return NULL;
+	cls->kobj = kobject_create_and_add(name, &class_kset->kobj);
+	if (!cls->kobj) {
+		kfree(cls);
+		return NULL;
+	}
+	return cls;
+}
+EXPORT_SYMBOL_GPL(class_compat_register);
+
+/**
+ * class_compat_unregister - unregister a compatibility class
+ * @cls: the class to unregister
+ */
+void class_compat_unregister(struct class_compat *cls)
+{
+	kobject_put(cls->kobj);
+	kfree(cls);
+}
+EXPORT_SYMBOL_GPL(class_compat_unregister);
+
+/**
+ * class_compat_create_link - create a compatibility class device link to
+ *			      a bus device
+ * @cls: the compatibility class
+ * @dev: the target bus device
+ * @device_link: an optional device to which a "device" link should be created
+ */
+int class_compat_create_link(struct class_compat *cls, struct device *dev,
+			     struct device *device_link)
+{
+	int error;
+
+	error = sysfs_create_link(cls->kobj, &dev->kobj, dev_name(dev));
+	if (error)
+		return error;
+
+	/*
+	 * Optionally add a "device" link (typically to the parent), as a
+	 * class device would have one and we want to provide as much
+	 * backwards compatibility as possible.
+	 */
+	if (device_link) {
+		error = sysfs_create_link(&dev->kobj, &device_link->kobj,
+					  "device");
+		if (error)
+			sysfs_remove_link(cls->kobj, dev_name(dev));
+	}
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(class_compat_create_link);
+
+/**
+ * class_compat_remove_link - remove a compatibility class device link to
+ *			      a bus device
+ * @cls: the compatibility class
+ * @dev: the target bus device
+ * @device_link: an optional device to which a "device" link was previously
+ * 		 created
+ */
+void class_compat_remove_link(struct class_compat *cls, struct device *dev,
+			      struct device *device_link)
+{
+	if (device_link)
+		sysfs_remove_link(&dev->kobj, "device");
+	sysfs_remove_link(cls->kobj, dev_name(dev));
+}
+EXPORT_SYMBOL_GPL(class_compat_remove_link);
+
 int __init classes_init(void)
 {
 	class_kset = kset_create_and_add("class", NULL, NULL);
--- linux-2.6.31-rc5.orig/include/linux/device.h	2009-08-03 22:10:23.000000000 +0200
+++ linux-2.6.31-rc5/include/linux/device.h	2009-08-04 11:58:07.000000000 +0200
@@ -223,6 +223,14 @@ extern void class_unregister(struct clas
 	__class_register(class, &__key);	\
 })
 
+struct class_compat;
+struct class_compat *class_compat_register(const char *name);
+void class_compat_unregister(struct class_compat *cls);
+int class_compat_create_link(struct class_compat *cls, struct device *dev,
+			     struct device *device_link);
+void class_compat_remove_link(struct class_compat *cls, struct device *dev,
+			      struct device *device_link);
+
 extern void class_dev_iter_init(struct class_dev_iter *iter,
 				struct class *class,
 				struct device *start,

-- 
Jean Delvare
