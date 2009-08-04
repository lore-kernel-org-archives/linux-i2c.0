From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Do not give adapters a default parent
Date: Tue, 4 Aug 2009 12:55:34 +0200
Message-ID: <20090804125534.6a555cc2@hyperion.delvare>
References: <20090426103025.4525edd3@hyperion.delvare>
	<20090704191431.3d352d0b@hyperion.delvare>
	<ac3eb2510907051319i414a5e78r74d623ebb0508d0@mail.gmail.com>
	<20090705225616.1d4817e7@hyperion.delvare>
	<ac3eb2510907051434i4ee351cbk3db17b50c7e7618b@mail.gmail.com>
	<20090722210753.35802816@hyperion.delvare>
	<1248296688.2065.4.camel@yio.site>
	<20090723160259.78a10e37@hyperion.delvare>
	<ac3eb2510907230819g1b8edf63g42ffc4c87dbc0cb5@mail.gmail.com>
	<20090728144755.69d328d4@hyperion.delvare>
	<ac3eb2510907300812q2d848108ofe1d25801f7b990f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ac3eb2510907300812q2d848108ofe1d25801f7b990f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Kay,

On Thu, 30 Jul 2009 11:12:05 -0400, Kay Sievers wrote:
> On Tue, Jul 28, 2009 at 08:47, Jean Delvare<khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> >
> > What's the merge timeline for this patch?
> 
> I just did it in the moment you asked, there are no other users so
> far. Just submit it with your changes that need it, if Greg is ok with
> that?

OK, will do.

> >> > Other than that (and in practice even with that) your patch works just
> >> > fine for me. Thanks! Unfortunately it doesn't provide perfect
> >> > compatibility, [...] to add this device link (pointing to "..") temporarily
> >> > or would that be too confusing?
> >>
> >> I think that's ok, if it solves a real problem. The entire idea of _a_
> >> "device" link is pretty flawed, and the reason we ripped all the
> >> "struct class_device" devices out.
> >
> > OK, I've added the "device" link and now compatibility works perfectly.
> > I'll post the updated patch series soon, if you want to take a look.
> 
> Sounds great.
> 
> > Would it make sense to move the "device" link creation into
> > class_compat_create_link()? I suspect other users of a compatibility
> > class may need it as well.
> 
> Might make sense, as long as it's not the built-in default.
> 
> Sometimes we need to insert devices into the devpath, and then the
> "device" link does not point to the direct parent, but the next one.
> So it would need to take another device parameter, if we do that, and
> also accept NULL, if no such link is really needed.
> 
> The "device" link itself is a pretty broken concept, and should be
> avoided wherever possible, so it should be as optional as we can do
> it. :)

Yes, you are perfectly right. I have come up with the following
implementation, would that be OK with you? If it is, please add your
Signed-off-by.

From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: Add support for compatibility classes

When turning class devices into bus devices, we may need to
temporarily add links in sysfs so that user-space applications
are not confused. This is done by adding the following API:

* Functions to register and unregister compatibility classes.
  These appear in sysfs at the same location as regular classes, but
  instead of class devices, they contain links to bus devices.
* Functions to create and delete such links. Additionally, the caller
  can optionally pass a target device to which a "device" link should
  point (typically that would be the device's parent), to fully emulate
  the original class device.

The i2c subsystem will be the first user of this API, as i2c adapters
are being converted from class devices to bus devices.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/base/class.c   |   87 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |    8 ++++
 2 files changed, 95 insertions(+)

--- linux-2.6.31-rc4.orig/drivers/base/class.c	2009-07-30 22:21:31.000000000 +0200
+++ linux-2.6.31-rc4/drivers/base/class.c	2009-07-31 18:45:37.000000000 +0200
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
+ * Compatibility class are meant as a temporary user-space compatibility
+ * workaround when converting a family of class devices to a bus devices.
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
--- linux-2.6.31-rc4.orig/include/linux/device.h	2009-07-30 22:21:31.000000000 +0200
+++ linux-2.6.31-rc4/include/linux/device.h	2009-07-31 11:30:25.000000000 +0200
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
