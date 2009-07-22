From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: Re: [PATCH] i2c: Do not give adapters a default parent
Date: Wed, 22 Jul 2009 23:04:48 +0200
Message-ID: <1248296688.2065.4.camel@yio.site>
References: <20090426103025.4525edd3@hyperion.delvare>
	 <20090504124341.42405e79@hyperion.delvare>
	 <ac3eb2510905040540k65afe3f8k7e6c696d11bf7e1d@mail.gmail.com>
	 <20090704191431.3d352d0b@hyperion.delvare>
	 <ac3eb2510907051319i414a5e78r74d623ebb0508d0@mail.gmail.com>
	 <20090705225616.1d4817e7@hyperion.delvare>
	 <ac3eb2510907051434i4ee351cbk3db17b50c7e7618b@mail.gmail.com>
	 <20090722210753.35802816@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090722210753.35802816-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 2009-07-22 at 21:07 +0200, Jean Delvare wrote:
> > > * Do we need an actually struct class for each fake class, or just a
> > >  class name?
> > 
> > We will need to create a kobject for the compat class directory, we
> > will not need a "struct class" for it and can just use a simple
> > pointer to the registered kobject. If we use a string, we would need
> > to find the registered kobject with every call to create a link there,
> > not necessarily bad, but an explicitely registered object might be
> > easier.
> 
> Any progress on this? I have just committed the patches to
> sensors-detect and libsensors, and the kernel patch is ready to go, but
> without the compatibility links it doesn't make any sense to push it
> upstream

Something like this? Please change it as you need. I did only a very
quick test.

The only important part is that the kobject of the class directly is not
exposed, so nobody else can do weird things with it.

Thanks,
Kay


--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -488,6 +488,45 @@ void class_interface_unregister(struct c
 	class_put(parent);
 }
 
+struct class_compat {
+	struct kobject *kobj;
+};
+
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
+void class_compat_unregister(struct class_compat *cls)
+{
+	kobject_put(cls->kobj);
+	kfree(cls);
+}
+EXPORT_SYMBOL_GPL(class_compat_unregister);
+
+int class_compat_create_link(struct class_compat *cls, struct device *dev)
+{
+	return sysfs_create_link(cls->kobj, &dev->kobj, dev_name(dev));
+}
+EXPORT_SYMBOL_GPL(class_compat_create_link);
+
+void class_compat_remove_link(struct class_compat *cls, struct device *dev)
+{
+	return sysfs_remove_link(cls->kobj, dev_name(dev));
+}
+EXPORT_SYMBOL_GPL(class_compat_remove_link);
+
 int __init classes_init(void)
 {
 	class_kset = kset_create_and_add("class", NULL, NULL);

--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -223,6 +223,12 @@ extern void class_unregister(struct clas
 	__class_register(class, &__key);	\
 })
 
+struct class_compat;
+struct class_compat *class_compat_register(const char *name);
+void class_compat_unregister(struct class_compat *cls);
+int class_compat_create_link(struct class_compat *cls, struct device *dev);
+void class_compat_remove_link(struct class_compat *cls, struct device *dev);
+
 extern void class_dev_iter_init(struct class_dev_iter *iter,
 				struct class *class,
 				struct device *start,
