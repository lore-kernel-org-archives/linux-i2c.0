From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Do not give adapters a default parent
Date: Thu, 23 Jul 2009 16:02:59 +0200
Message-ID: <20090723160259.78a10e37@hyperion.delvare>
References: <20090426103025.4525edd3@hyperion.delvare>
	<20090504124341.42405e79@hyperion.delvare>
	<ac3eb2510905040540k65afe3f8k7e6c696d11bf7e1d@mail.gmail.com>
	<20090704191431.3d352d0b@hyperion.delvare>
	<ac3eb2510907051319i414a5e78r74d623ebb0508d0@mail.gmail.com>
	<20090705225616.1d4817e7@hyperion.delvare>
	<ac3eb2510907051434i4ee351cbk3db17b50c7e7618b@mail.gmail.com>
	<20090722210753.35802816@hyperion.delvare>
	<1248296688.2065.4.camel@yio.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1248296688.2065.4.camel-2/CBIq5w30c@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Kay,

On Wed, 22 Jul 2009 23:04:48 +0200, Kay Sievers wrote:
> On Wed, 2009-07-22 at 21:07 +0200, Jean Delvare wrote:
> > Any progress on this? I have just committed the patches to
> > sensors-detect and libsensors, and the kernel patch is ready to go, but
> > without the compatibility links it doesn't make any sense to push it
> > upstream
> 
> Something like this? Please change it as you need. I did only a very
> quick test.
> 
> The only important part is that the kobject of the class directly is not
> exposed, so nobody else can do weird things with it.
> (...)
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -488,6 +488,45 @@ void class_interface_unregister(struct c
>  	class_put(parent);
>  }
>  
> +struct class_compat {
> +	struct kobject *kobj;
> +};
> +
> +struct class_compat *class_compat_register(const char *name)
> +{
> +	struct class_compat *cls;
> +
> +	cls = kmalloc(sizeof(struct class_compat), GFP_KERNEL);
> +	if (!cls)
> +		return NULL;
> +	cls->kobj = kobject_create_and_add(name, &class_kset->kobj);
> +	if (!cls->kobj) {
> +		kfree(cls);
> +		return NULL;
> +	}
> +	return cls;
> +}
> +EXPORT_SYMBOL_GPL(class_compat_register);
> +
> +void class_compat_unregister(struct class_compat *cls)
> +{
> +	kobject_put(cls->kobj);
> +	kfree(cls);
> +}
> +EXPORT_SYMBOL_GPL(class_compat_unregister);
> +
> +int class_compat_create_link(struct class_compat *cls, struct device *dev)
> +{
> +	return sysfs_create_link(cls->kobj, &dev->kobj, dev_name(dev));
> +}
> +EXPORT_SYMBOL_GPL(class_compat_create_link);
> +
> +void class_compat_remove_link(struct class_compat *cls, struct device *dev)
> +{
> +	return sysfs_remove_link(cls->kobj, dev_name(dev));

I don't think you need the "return" here, as sysfs_remove_link returns
void.

> +}
> +EXPORT_SYMBOL_GPL(class_compat_remove_link);
> +
>  int __init classes_init(void)
>  {
>  	class_kset = kset_create_and_add("class", NULL, NULL);
> 
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -223,6 +223,12 @@ extern void class_unregister(struct clas
>  	__class_register(class, &__key);	\
>  })
>  
> +struct class_compat;
> +struct class_compat *class_compat_register(const char *name);
> +void class_compat_unregister(struct class_compat *cls);
> +int class_compat_create_link(struct class_compat *cls, struct device *dev);
> +void class_compat_remove_link(struct class_compat *cls, struct device *dev);
> +
>  extern void class_dev_iter_init(struct class_dev_iter *iter,
>  				struct class *class,
>  				struct device *start,

Other than that (and in practice even with that) your patch works just
fine for me. Thanks! Unfortunately it doesn't provide perfect
compatibility, because sensors-detect likes to query attributes of the
i2c-adapter's parent device (when it is a PCI device) and the lack of
device link (now that i2c adapters are bus devices) prevent it from
doing so. I will have to check how bad it is for older versions of the
script (when I am done moving to my new place, that is.) For the
current version, it prevents sensors-detect from being smart on default
answers, but that's about it, so it isn't a blocker IMHO. And I'm
not really sure if/how this could be addressed anyway. Would it be OK
to add this device link (pointing to "..") temporarily or would that be
too confusing?

libsensors only needs the adapter's name so the compatibility layer
works perfectly there.

Another thing we have to discuss is the compatibility option. For now
I've made it i2c-specific and enabled by default:

config I2C_COMPAT
	boolean "Enable compatibility bits for old user-space"
	default y
	help
	  Say Y here if you intend to run lm-sensors 3.1.1 or older.

But this means a lot of ifdefs in my code (6). With a system-wide
option, we could provide empty stubs I could get rid of them. OTOH, It
is easier to control the lifetime, and change the default value, of a
subsystem specific option. So I'm not too sure what do to. Maybe it
depends on how many subsystems will need the compatibility layer... Do
you have an opinion?

Thanks,
-- 
Jean Delvare
