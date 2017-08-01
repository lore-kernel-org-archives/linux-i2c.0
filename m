From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Tue, 1 Aug 2017 12:48:01 +0200
Message-ID: <20170801124801.38bbc431@bbrezillon>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
        <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
        <20170801014021.GA20004@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170801014021.GA20004-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Przemyslaw Sroka <psroka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Arkadiusz Golec <agolec-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alan Douglas <adouglas-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Bartosz Folta <bfolta-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Damian Kos <dkos-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alicja Jurasik-Urbaniak <alicja-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Jan Kotas <jank-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Cyprian Wronka <cwronka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak@co>
List-Id: linux-i2c@vger.kernel.org

Hello Greg,

On Mon, 31 Jul 2017 18:40:21 -0700
Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:

> On Mon, Jul 31, 2017 at 06:24:47PM +0200, Boris Brezillon wrote:
> > Add core infrastructure to support I3C in Linux and document it.
> > 
> > This infrastructure is not complete yet and will be extended over
> > time.
> > 
> > There are a few design choices that are worth mentioning because they
> > impact the way I3C device drivers can interact with their devices:
> > 
> > - all functions used to send I3C/I2C frames must be called in
> >   non-atomic context. Mainly done this way to ease implementation, but
> >   this is still open to discussion. Please let me know if you think it's
> >   worth considering an asynchronous model here
> > - the bus element is a separate object and is not implicitly described
> >   by the master (as done in I2C). The reason is that I want to be able
> >   to handle multiple master connected to the same bus and visible to
> >   Linux.
> >   In this situation, we should only have one instance of the device and
> >   not one per master, and sharing the bus object would be part of the
> >   solution to gracefully handle this case.
> >   I'm not sure we will ever need to deal with multiple masters
> >   controlling the same bus and exposed under Linux, but separating the
> >   bus and master concept is pretty easy, hence the decision to do it
> >   like that.
> >   The other benefit of separating the bus and master concepts is that
> >   master devices appear under the bus directory in sysfs.
> > - I2C backward compatibility has been designed to be transparent to I2C
> >   drivers and the I2C subsystem. The I3C master just registers an I2C
> >   adapter which creates a new I2C bus. I'd say that, from a
> >   representation PoV it's not ideal because what should appear as a
> >   single I3C bus exposing I3C and I2C devices here appears as 2
> >   different busses connected to each other through the parenting (the
> >   I3C master is the parent of the I2C and I3C busses).
> >   On the other hand, I don't see a better solution if we want something
> >   that is not invasive.
> > - the whole API is exposed through a single header file (i3c.h), but I'm
> >   seriously considering the option of splitting the I3C driver/user API
> >   and the I3C master one, mainly to hide I3C core internals and restrict
> >   what I3C users can do to a limited set of functionalities (send
> >   I3C/I2C frames to a specific device and that's all).
> > 
> > Missing features in this preliminary version:
> > - no support for IBI (In Band Interrupts). This is something I'm working
> >   on, and I'm still unsure how to represent it: an irqchip or a
> >   completely independent representation that would be I3C specific.
> >   Right now, I'm more inclined to go for the irqchip approach, since
> >   this is something people are used to deal with already.
> > - no Hot Join support, which is similar to hotplug
> > - no support for multi-master and the associated concepts (mastership
> >   handover, support for secondary masters, ...)
> > - I2C devices can only be described using DT because this is the only
> >   use case I have. However, the framework can easily be extended with
> >   ACPI and board info support
> > - I3C slave framework. This has been completely omitted, but shouldn't
> >   have a huge impact on the I3C framework because I3C slaves don't see
> >   the whole bus, it's only about handling master requests and generating
> >   IBIs. Some of the struct, constant and enum definitions could be
> >   shared, but most of the I3C slave framework logic will be different
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > ---
> >  Documentation/i3c/conf.py               |   10 +
> >  Documentation/i3c/device-driver-api.rst |    7 +
> >  Documentation/i3c/index.rst             |    9 +
> >  Documentation/i3c/master-driver-api.rst |    8 +
> >  Documentation/i3c/protocol.rst          |  199 +++++
> >  Documentation/index.rst                 |    1 +
> >  drivers/Kconfig                         |    2 +
> >  drivers/Makefile                        |    2 +-
> >  drivers/i3c/Kconfig                     |   24 +
> >  drivers/i3c/Makefile                    |    3 +
> >  drivers/i3c/core.c                      |  532 ++++++++++++++
> >  drivers/i3c/device.c                    |  138 ++++
> >  drivers/i3c/internals.h                 |   45 ++
> >  drivers/i3c/master.c                    | 1225 +++++++++++++++++++++++++++++++
> >  drivers/i3c/master/Kconfig              |    0
> >  drivers/i3c/master/Makefile             |    0
> >  include/linux/i3c/ccc.h                 |  389 ++++++++++
> >  include/linux/i3c/device.h              |  212 ++++++
> >  include/linux/i3c/master.h              |  453 ++++++++++++
> >  include/linux/mod_devicetable.h         |   15 +
> >  20 files changed, 3273 insertions(+), 1 deletion(-)  
> 
> Any chance you can break the documentation out from this patch to make
> it smaller and a bit simpler to review?

Sure. I'll put the doc and code in 2 different commits.

> 
> Here's a few random review comments, I have only glanced at this, not
> done any real reading of this at all...
> 
> > +menu "I3C support"
> > +
> > +config I3C
> > +	tristate "I3C support"
> > +	---help---
> > +	  I3C (pronounce: I-cube-C) is a serial protocol standardized by the
> > +	  MIPI alliance.
> > +
> > +	  It's supposed to be backward compatible with I2C while providing
> > +	  support for high speed transfers and native interrupt support
> > +	  without the need for extra pins.
> > +
> > +	  The I3C protocol also standardizes the slave device types and is
> > +	  mainly design to communicate with sensors.
> > +
> > +	  If you want I3C support, you should say Y here and also to the
> > +	  specific driver for your bus adapter(s) below.
> > +
> > +	  This I3C support can also be built as a module.  If so, the module
> > +	  will be called i3c.
> > +
> > +source "drivers/i3c/master/Kconfig"  
> 
> Don't source unless i3c is enabled, right?

Right, I'll also switch to menuconfig instead of menu+config.

> 
> > +
> > +endmenu
> > diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
> > new file mode 100644
> > index 000000000000..0605a275f47b
> > --- /dev/null
> > +++ b/drivers/i3c/Makefile
> > @@ -0,0 +1,3 @@
> > +i3c-y				:= core.o device.o master.o
> > +obj-$(CONFIG_I3C)		+= i3c.o
> > +obj-$(CONFIG_I3C)		+= master/
> > diff --git a/drivers/i3c/core.c b/drivers/i3c/core.c
> > new file mode 100644
> > index 000000000000..c000fb458547
> > --- /dev/null
> > +++ b/drivers/i3c/core.c
> > @@ -0,0 +1,532 @@
> > +/*
> > + * Copyright (C) 2017 Cadence Design Systems Inc.
> > + *
> > + * Author: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License as published by the Free
> > + * Software Foundation; either version 2 of the License, or (at your option)
> > + * any later version.  
> 
> I have to ask, do you really mean "or any later version"?

I'll ask Cadence.

> 
> > +static DEFINE_IDR(i3c_bus_idr);  
> 
> You never clean this up when the module goes away :(

I'll call idr_destroy() in i3c_exit().

> 
> > +static DEFINE_MUTEX(i3c_core_lock);
> > +
> > +void i3c_bus_lock(struct i3c_bus *bus, bool exclusive)
> > +{
> > +	if (exclusive)
> > +		down_write(&bus->lock);
> > +	else
> > +		down_read(&bus->lock);
> > +}  
> 
> The "exclusive" flag is odd, and messy, and hard to understand, don't
> you agree?

I could create 2 functions, one for the exclusive lock and the other
one for the shared lock.

> And have you measured the difference in using a rw lock over
> a normal mutex and found it to be faster?  If not, just use a normal
> mutex, it's simpler and almost always better in the end.

I did not measure the difference, but using a standard lock means
serializing all I3C accesses going through a given master in the core.

Note that this lock is not here to guarantee that calls to
master->ops->xxx() are serialized (this part is left to the master
driver), but to ensure that when a bus management operation is in
progress (like changing the address of a device on the bus), no one can
send I3C frames. If we don't do that, one could queue an I3C transfer,
and by the time this transfer reach the bus, the I3C device this
message was targeting may have a different address.

Unless you see a good reason to not use a R/W lock, I'd like to keep it
this way because master IPs are likely to implement advanced queuing
mechanism (allows one to queue new transfers even if the master is
already busy processing other requests), and serializing things at the
framework level will just prevent us from using this kind of
optimization.

> 
> > +
> > +void i3c_bus_unlock(struct i3c_bus *bus, bool exclusive)
> > +{
> > +	if (exclusive)
> > +		up_write(&bus->lock);
> > +	else
> > +		up_read(&bus->lock);
> > +}
> > +
> > +static ssize_t bcr_show(struct device *dev,
> > +			struct device_attribute *da,
> > +			char *buf)
> > +{
> > +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> > +	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
> > +	ssize_t ret;
> > +
> > +	i3c_bus_lock(bus, false);
> > +	ret = sprintf(buf, "%x\n", i3cdev->info.bcr);
> > +	i3c_bus_unlock(bus, false);
> > +
> > +	return ret;
> > +}
> > +static DEVICE_ATTR_RO(bcr);
> > +
> > +static ssize_t dcr_show(struct device *dev,
> > +			struct device_attribute *da,
> > +			char *buf)
> > +{
> > +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> > +	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
> > +	ssize_t ret;
> > +
> > +	i3c_bus_lock(bus, false);
> > +	ret = sprintf(buf, "%x\n", i3cdev->info.dcr);
> > +	i3c_bus_unlock(bus, false);
> > +
> > +	return ret;
> > +}
> > +static DEVICE_ATTR_RO(dcr);
> > +
> > +static ssize_t pid_show(struct device *dev,
> > +			struct device_attribute *da,
> > +			char *buf)
> > +{
> > +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> > +	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
> > +	ssize_t ret;
> > +
> > +	i3c_bus_lock(bus, false);
> > +	ret = sprintf(buf, "%llx\n", i3cdev->info.pid);
> > +	i3c_bus_unlock(bus, false);
> > +
> > +	return ret;
> > +}
> > +static DEVICE_ATTR_RO(pid);  
> 
> No Documentation/ABI entries for all of these sysfs files?

Yep, I mentioned the lack of sysfs doc in my cover letter. Will address
that in v2.

> 
> > +
> > +static ssize_t address_show(struct device *dev,
> > +			    struct device_attribute *da,
> > +			    char *buf)
> > +{
> > +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> > +	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
> > +	ssize_t ret;
> > +
> > +	i3c_bus_lock(bus, false);
> > +	ret = sprintf(buf, "%02x\n", i3cdev->info.dyn_addr);
> > +	i3c_bus_unlock(bus, false);
> > +
> > +	return ret;
> > +}
> > +static DEVICE_ATTR_RO(address);
> > +
> > +static const char * const hdrcap_strings[] = {
> > +	"hdr-ddr", "hdr-tsp", "hdr-tsl",
> > +};
> > +
> > +static ssize_t hdrcap_show(struct device *dev,
> > +			   struct device_attribute *da,
> > +			   char *buf)
> > +{
> > +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> > +	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
> > +	unsigned long caps = i3cdev->info.hdr_cap;
> > +	ssize_t offset = 0, ret;
> > +	int mode;
> > +
> > +	i3c_bus_lock(bus, false);
> > +	for_each_set_bit(mode, &caps, 8) {
> > +		if (mode >= ARRAY_SIZE(hdrcap_strings))
> > +			break;
> > +
> > +		if (!hdrcap_strings[mode])
> > +			continue;
> > +
> > +		ret = sprintf(buf + offset, "%s\n", hdrcap_strings[mode]);  
> 
> Multiple lines in a single sysfs file?  No.

Okay. Would that be okay with a different separator (like a comma)?

> 
> > +		if (ret < 0)
> > +			goto out;
> > +
> > +		offset += ret;
> > +	}
> > +	ret = offset;
> > +
> > +out:
> > +	i3c_bus_unlock(bus, false);
> > +
> > +	return ret;
> > +}
> > +static DEVICE_ATTR_RO(hdrcap);
> > +
> > +static struct attribute *i3c_device_attrs[] = {
> > +	&dev_attr_bcr.attr,
> > +	&dev_attr_dcr.attr,
> > +	&dev_attr_pid.attr,
> > +	&dev_attr_address.attr,
> > +	&dev_attr_hdrcap.attr,
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group i3c_device_group = {
> > +	.attrs = i3c_device_attrs,
> > +};
> > +
> > +static const struct attribute_group *i3c_device_groups[] = {
> > +	&i3c_device_group,
> > +	NULL,
> > +};  
> 
> ATTRIBUTE_GROUPS()?

My initial plan was to have a common set of attributes that apply to
both devices and masters, and then add specific attributes in each of
them when they only apply to a specific device type.

Something like:

static const struct attribute_group i3c_common_group = {
	.attrs = i3c_common_attrs,
};

static const struct attribute_group i3c_device_group = {
	.attrs = i3c_device_attrs,
};

static const struct attribute_group *i3c_device_groups[] = {
	&i3c_common_group,
	&i3c_device_group,
	NULL,
};

static const struct attribute_group i3c_master_group = {
	.attrs = i3c_master_attrs,
};

static const struct attribute_group *i3c_master_groups[] = {
	&i3c_common_group,
	&i3c_master_group,
	NULL,
};

It turned out I didn't have device or master specific attributes in this
version, so this differentiation is useless right now. I'll drop that
in my v2.

Just out of curiosity, what's the preferred solution when you need to
do something like that? Should we just use ATTRIBUTE_GROUPS() and
duplicate the entries that apply to both device types?

> 
> 
> > +
> > +static int i3c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
> > +{
> > +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> > +	u16 manuf = I3C_PID_MANUF_ID(i3cdev->info.pid);
> > +	u16 part = I3C_PID_PART_ID(i3cdev->info.pid);
> > +	u16 ext = I3C_PID_EXTRA_INFO(i3cdev->info.pid);
> > +
> > +	if (I3C_PID_RND_LOWER_32BITS(i3cdev->info.pid))
> > +		return add_uevent_var(env, "MODALIAS=i3c:dcr%02Xmanuf%04X",
> > +				      i3cdev->info.dcr, manuf);
> > +
> > +	return add_uevent_var(env,
> > +			      "MODALIAS=i3c:dcr%02Xmanuf%04Xpart%04xext%04x",
> > +			      i3cdev->info.dcr, manuf, part, ext);
> > +}
> > +
> > +const struct device_type i3c_device_type = {
> > +	.groups	= i3c_device_groups,
> > +	.uevent = i3c_device_uevent,
> > +};  
> 
> No release type?  Oh that's bad bad bad and implies you have never
> removed a device from your system as the kernel would have complained
> loudly at you.

You got me, never tried to remove a device :-). Note that these
->release() hooks will just be dummy ones, because right now, device
resources are freed at bus destruction time.

Also, I see that dev->release() is called instead of
dev->type->release() if it's not NULL [1]. what's the preferred solution
here? Set dev->release or type->release()?

Thanks for your review,

Boris

[1]http://elixir.free-electrons.com/linux/v4.13-rc3/source/drivers/base/core.c#L809
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
