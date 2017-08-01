From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Mon, 31 Jul 2017 18:40:21 -0700
Message-ID: <20170801014021.GA20004@kroah.com>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@co>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 31, 2017 at 06:24:47PM +0200, Boris Brezillon wrote:
> Add core infrastructure to support I3C in Linux and document it.
> 
> This infrastructure is not complete yet and will be extended over
> time.
> 
> There are a few design choices that are worth mentioning because they
> impact the way I3C device drivers can interact with their devices:
> 
> - all functions used to send I3C/I2C frames must be called in
>   non-atomic context. Mainly done this way to ease implementation, but
>   this is still open to discussion. Please let me know if you think it's
>   worth considering an asynchronous model here
> - the bus element is a separate object and is not implicitly described
>   by the master (as done in I2C). The reason is that I want to be able
>   to handle multiple master connected to the same bus and visible to
>   Linux.
>   In this situation, we should only have one instance of the device and
>   not one per master, and sharing the bus object would be part of the
>   solution to gracefully handle this case.
>   I'm not sure we will ever need to deal with multiple masters
>   controlling the same bus and exposed under Linux, but separating the
>   bus and master concept is pretty easy, hence the decision to do it
>   like that.
>   The other benefit of separating the bus and master concepts is that
>   master devices appear under the bus directory in sysfs.
> - I2C backward compatibility has been designed to be transparent to I2C
>   drivers and the I2C subsystem. The I3C master just registers an I2C
>   adapter which creates a new I2C bus. I'd say that, from a
>   representation PoV it's not ideal because what should appear as a
>   single I3C bus exposing I3C and I2C devices here appears as 2
>   different busses connected to each other through the parenting (the
>   I3C master is the parent of the I2C and I3C busses).
>   On the other hand, I don't see a better solution if we want something
>   that is not invasive.
> - the whole API is exposed through a single header file (i3c.h), but I'm
>   seriously considering the option of splitting the I3C driver/user API
>   and the I3C master one, mainly to hide I3C core internals and restrict
>   what I3C users can do to a limited set of functionalities (send
>   I3C/I2C frames to a specific device and that's all).
> 
> Missing features in this preliminary version:
> - no support for IBI (In Band Interrupts). This is something I'm working
>   on, and I'm still unsure how to represent it: an irqchip or a
>   completely independent representation that would be I3C specific.
>   Right now, I'm more inclined to go for the irqchip approach, since
>   this is something people are used to deal with already.
> - no Hot Join support, which is similar to hotplug
> - no support for multi-master and the associated concepts (mastership
>   handover, support for secondary masters, ...)
> - I2C devices can only be described using DT because this is the only
>   use case I have. However, the framework can easily be extended with
>   ACPI and board info support
> - I3C slave framework. This has been completely omitted, but shouldn't
>   have a huge impact on the I3C framework because I3C slaves don't see
>   the whole bus, it's only about handling master requests and generating
>   IBIs. Some of the struct, constant and enum definitions could be
>   shared, but most of the I3C slave framework logic will be different
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  Documentation/i3c/conf.py               |   10 +
>  Documentation/i3c/device-driver-api.rst |    7 +
>  Documentation/i3c/index.rst             |    9 +
>  Documentation/i3c/master-driver-api.rst |    8 +
>  Documentation/i3c/protocol.rst          |  199 +++++
>  Documentation/index.rst                 |    1 +
>  drivers/Kconfig                         |    2 +
>  drivers/Makefile                        |    2 +-
>  drivers/i3c/Kconfig                     |   24 +
>  drivers/i3c/Makefile                    |    3 +
>  drivers/i3c/core.c                      |  532 ++++++++++++++
>  drivers/i3c/device.c                    |  138 ++++
>  drivers/i3c/internals.h                 |   45 ++
>  drivers/i3c/master.c                    | 1225 +++++++++++++++++++++++++++++++
>  drivers/i3c/master/Kconfig              |    0
>  drivers/i3c/master/Makefile             |    0
>  include/linux/i3c/ccc.h                 |  389 ++++++++++
>  include/linux/i3c/device.h              |  212 ++++++
>  include/linux/i3c/master.h              |  453 ++++++++++++
>  include/linux/mod_devicetable.h         |   15 +
>  20 files changed, 3273 insertions(+), 1 deletion(-)

Any chance you can break the documentation out from this patch to make
it smaller and a bit simpler to review?

Here's a few random review comments, I have only glanced at this, not
done any real reading of this at all...

> +menu "I3C support"
> +
> +config I3C
> +	tristate "I3C support"
> +	---help---
> +	  I3C (pronounce: I-cube-C) is a serial protocol standardized by the
> +	  MIPI alliance.
> +
> +	  It's supposed to be backward compatible with I2C while providing
> +	  support for high speed transfers and native interrupt support
> +	  without the need for extra pins.
> +
> +	  The I3C protocol also standardizes the slave device types and is
> +	  mainly design to communicate with sensors.
> +
> +	  If you want I3C support, you should say Y here and also to the
> +	  specific driver for your bus adapter(s) below.
> +
> +	  This I3C support can also be built as a module.  If so, the module
> +	  will be called i3c.
> +
> +source "drivers/i3c/master/Kconfig"

Don't source unless i3c is enabled, right?

> +
> +endmenu
> diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
> new file mode 100644
> index 000000000000..0605a275f47b
> --- /dev/null
> +++ b/drivers/i3c/Makefile
> @@ -0,0 +1,3 @@
> +i3c-y				:= core.o device.o master.o
> +obj-$(CONFIG_I3C)		+= i3c.o
> +obj-$(CONFIG_I3C)		+= master/
> diff --git a/drivers/i3c/core.c b/drivers/i3c/core.c
> new file mode 100644
> index 000000000000..c000fb458547
> --- /dev/null
> +++ b/drivers/i3c/core.c
> @@ -0,0 +1,532 @@
> +/*
> + * Copyright (C) 2017 Cadence Design Systems Inc.
> + *
> + * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.

I have to ask, do you really mean "or any later version"?

> +static DEFINE_IDR(i3c_bus_idr);

You never clean this up when the module goes away :(

> +static DEFINE_MUTEX(i3c_core_lock);
> +
> +void i3c_bus_lock(struct i3c_bus *bus, bool exclusive)
> +{
> +	if (exclusive)
> +		down_write(&bus->lock);
> +	else
> +		down_read(&bus->lock);
> +}

The "exclusive" flag is odd, and messy, and hard to understand, don't
you agree?  And have you measured the difference in using a rw lock over
a normal mutex and found it to be faster?  If not, just use a normal
mutex, it's simpler and almost always better in the end.

> +
> +void i3c_bus_unlock(struct i3c_bus *bus, bool exclusive)
> +{
> +	if (exclusive)
> +		up_write(&bus->lock);
> +	else
> +		up_read(&bus->lock);
> +}
> +
> +static ssize_t bcr_show(struct device *dev,
> +			struct device_attribute *da,
> +			char *buf)
> +{
> +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> +	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
> +	ssize_t ret;
> +
> +	i3c_bus_lock(bus, false);
> +	ret = sprintf(buf, "%x\n", i3cdev->info.bcr);
> +	i3c_bus_unlock(bus, false);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(bcr);
> +
> +static ssize_t dcr_show(struct device *dev,
> +			struct device_attribute *da,
> +			char *buf)
> +{
> +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> +	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
> +	ssize_t ret;
> +
> +	i3c_bus_lock(bus, false);
> +	ret = sprintf(buf, "%x\n", i3cdev->info.dcr);
> +	i3c_bus_unlock(bus, false);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(dcr);
> +
> +static ssize_t pid_show(struct device *dev,
> +			struct device_attribute *da,
> +			char *buf)
> +{
> +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> +	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
> +	ssize_t ret;
> +
> +	i3c_bus_lock(bus, false);
> +	ret = sprintf(buf, "%llx\n", i3cdev->info.pid);
> +	i3c_bus_unlock(bus, false);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(pid);

No Documentation/ABI entries for all of these sysfs files?

> +
> +static ssize_t address_show(struct device *dev,
> +			    struct device_attribute *da,
> +			    char *buf)
> +{
> +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> +	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
> +	ssize_t ret;
> +
> +	i3c_bus_lock(bus, false);
> +	ret = sprintf(buf, "%02x\n", i3cdev->info.dyn_addr);
> +	i3c_bus_unlock(bus, false);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(address);
> +
> +static const char * const hdrcap_strings[] = {
> +	"hdr-ddr", "hdr-tsp", "hdr-tsl",
> +};
> +
> +static ssize_t hdrcap_show(struct device *dev,
> +			   struct device_attribute *da,
> +			   char *buf)
> +{
> +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> +	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
> +	unsigned long caps = i3cdev->info.hdr_cap;
> +	ssize_t offset = 0, ret;
> +	int mode;
> +
> +	i3c_bus_lock(bus, false);
> +	for_each_set_bit(mode, &caps, 8) {
> +		if (mode >= ARRAY_SIZE(hdrcap_strings))
> +			break;
> +
> +		if (!hdrcap_strings[mode])
> +			continue;
> +
> +		ret = sprintf(buf + offset, "%s\n", hdrcap_strings[mode]);

Multiple lines in a single sysfs file?  No.

> +		if (ret < 0)
> +			goto out;
> +
> +		offset += ret;
> +	}
> +	ret = offset;
> +
> +out:
> +	i3c_bus_unlock(bus, false);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(hdrcap);
> +
> +static struct attribute *i3c_device_attrs[] = {
> +	&dev_attr_bcr.attr,
> +	&dev_attr_dcr.attr,
> +	&dev_attr_pid.attr,
> +	&dev_attr_address.attr,
> +	&dev_attr_hdrcap.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group i3c_device_group = {
> +	.attrs = i3c_device_attrs,
> +};
> +
> +static const struct attribute_group *i3c_device_groups[] = {
> +	&i3c_device_group,
> +	NULL,
> +};

ATTRIBUTE_GROUPS()?


> +
> +static int i3c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
> +{
> +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> +	u16 manuf = I3C_PID_MANUF_ID(i3cdev->info.pid);
> +	u16 part = I3C_PID_PART_ID(i3cdev->info.pid);
> +	u16 ext = I3C_PID_EXTRA_INFO(i3cdev->info.pid);
> +
> +	if (I3C_PID_RND_LOWER_32BITS(i3cdev->info.pid))
> +		return add_uevent_var(env, "MODALIAS=i3c:dcr%02Xmanuf%04X",
> +				      i3cdev->info.dcr, manuf);
> +
> +	return add_uevent_var(env,
> +			      "MODALIAS=i3c:dcr%02Xmanuf%04Xpart%04xext%04x",
> +			      i3cdev->info.dcr, manuf, part, ext);
> +}
> +
> +const struct device_type i3c_device_type = {
> +	.groups	= i3c_device_groups,
> +	.uevent = i3c_device_uevent,
> +};

No release type?  Oh that's bad bad bad and implies you have never
removed a device from your system as the kernel would have complained
loudly at you.

> +
> +static const struct attribute_group *i3c_master_groups[] = {
> +	&i3c_device_group,
> +	NULL,
> +};

ATTRIBUTE_GROUPS()?

> +
> +const struct device_type i3c_master_type = {
> +	.groups	= i3c_master_groups,
> +};
> +
> +static const char * const i3c_bus_mode_strings[] = {
> +	[I3C_BUS_MODE_PURE] = "pure",
> +	[I3C_BUS_MODE_MIXED_FAST] = "mixed-fast",
> +	[I3C_BUS_MODE_MIXED_SLOW] = "mixed-slow",
> +};
> +
> +static ssize_t mode_show(struct device *dev,
> +			 struct device_attribute *da,
> +			 char *buf)
> +{
> +	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
> +	ssize_t ret;
> +
> +	i3c_bus_lock(i3cbus, false);
> +	if (i3cbus->mode < 0 ||
> +	    i3cbus->mode > ARRAY_SIZE(i3c_bus_mode_strings) ||
> +	    !i3c_bus_mode_strings[i3cbus->mode])
> +		ret = sprintf(buf, "unknown\n");
> +	else
> +		ret = sprintf(buf, "%s\n", i3c_bus_mode_strings[i3cbus->mode]);
> +	i3c_bus_unlock(i3cbus, false);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(mode);
> +
> +static ssize_t current_master_show(struct device *dev,
> +				   struct device_attribute *da,
> +				   char *buf)
> +{
> +	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
> +	ssize_t ret;
> +
> +	i3c_bus_lock(i3cbus, false);
> +	ret = sprintf(buf, "%s\n", dev_name(&i3cbus->cur_master->dev));
> +	i3c_bus_unlock(i3cbus, false);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(current_master);
> +
> +static ssize_t i3c_scl_frequency_show(struct device *dev,
> +				      struct device_attribute *da,
> +				      char *buf)
> +{
> +	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
> +	ssize_t ret;
> +
> +	i3c_bus_lock(i3cbus, false);
> +	ret = sprintf(buf, "%ld\n", i3cbus->scl_rate.i3c);
> +	i3c_bus_unlock(i3cbus, false);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(i3c_scl_frequency);
> +
> +static ssize_t i2c_scl_frequency_show(struct device *dev,
> +				      struct device_attribute *da,
> +				      char *buf)
> +{
> +	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
> +	ssize_t ret;
> +
> +	i3c_bus_lock(i3cbus, false);
> +	ret = sprintf(buf, "%ld\n", i3cbus->scl_rate.i2c);
> +	i3c_bus_unlock(i3cbus, false);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(i2c_scl_frequency);
> +
> +static struct attribute *i3c_busdev_attrs[] = {
> +	&dev_attr_mode.attr,
> +	&dev_attr_current_master.attr,
> +	&dev_attr_i3c_scl_frequency.attr,
> +	&dev_attr_i2c_scl_frequency.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(i3c_busdev);

Yeah, you used it here!

that's all the time I have right now...

thanks,

greg k-h
