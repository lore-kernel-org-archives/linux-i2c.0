From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH]i2c-dev: add ioctls PROBE and REMOVE
Date: Fri, 27 Mar 2009 14:57:26 +0100
Message-ID: <20090327145726.13c99aed@hyperion.delvare>
References: <49CB43E0.2050503@gmx.de>
	<49CCA82F.90106@gmx.de>
	<20090327134034.754908b5@hyperion.delvare>
	<49CCD0FC.9030500@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49CCD0FC.9030500-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 27 Mar 2009 14:13:32 +0100, Michael Lawnick wrote:
> Jean Delvare said the following:
> > Hi Michael,
> > 
> > On Fri, 27 Mar 2009 11:19:27 +0100, Michael Lawnick wrote:
> >> could you give it a look?
> >> If you at least ACK the interface, I could do the patch for the
> >> documentation.
> > 
> > Come on, which part of "this should be implemented in sysfs" did you
> > not understand? I'm a little tired of you trying to implement it using
> > _all_ other possible ways except the one we agreed on. If you need this
> > feature faster than I can implement it, please stick to the plan and
> > implement it using sysfs. If not, then just stay quiet and wait for it
> > to happen.
> 
> Huh - don't bite me!
> 
> This step I wanted to discuss next:
> AFAICS I2C subsystem doesn't implement any sysFs-entry itself. They are
> all either from client or device-driver system.

You didn't look carefully then. From i2c-core.c:

static ssize_t
show_adapter_name(struct device *dev, struct device_attribute *attr, char *buf)
{
	struct i2c_adapter *adap = to_i2c_adapter(dev);
	return sprintf(buf, "%s\n", adap->name);
}

static struct device_attribute i2c_adapter_attrs[] = {
	__ATTR(name, S_IRUGO, show_adapter_name, NULL),
	{ },
};

static struct class i2c_adapter_class = {
	.owner			= THIS_MODULE,
	.name			= "i2c-adapter",
	.dev_attrs		= i2c_adapter_attrs,
};

> I not even dared to ask
> for a comment to this before adding the feature on i2c-dev, a way that
> does not change the visible interface.

What do you think i2c-dev is, if not a visible interface? If we add a
new ioctl to the i2c-dev interface, we have to maintain it forever.
That's not to be done lightly just because you can't wait for you
actual need to be fulfilled by i2c-core.

> I can't wait too long for implementation on sysFs. I'm ready to do it
> now, if we agree on the place where to create the entries, naming and
> interface.

The place is very clearly /sys/class/i2c-adapter/i2c-*, next to the
"name" attribute I quoted above.

The naming and interface are to be discussed. Could be 2 write-only
files, add_device and delete_device, and the most basic syntax I can
think of would be:

echo lm75 0x49 > /sys/class/i2c-adapter/i2c-0/add_device
echo 0x49 > /sys/class/i2c-adapter/i2c-0/delete_device

add_device would optionally accept an irq value. As for delete_device,
I am wondering if we should require the chip name as well, for symmetry
with add_device and for safety reasons, or if the above is sufficient.

> What is your time line?

Getting rid of the legacy binding model has higher priority and is far
from being done. I also must take care of Rodolfo's multiplexer
support, which a lot of people have been asking for, and which might as
well be what you really need. The above interface comes next, I can't
give it higher priority as the same can already be achieved today using
module parameters for most drivers.

> Naming IMHO should be probe/remove, parameters could be

No, we can't use probe/remove as these are used for a completely
different meaning in the Linux driver model (and these _are_ misnomers
there, no question about that, but we have to live with it.) Not that
"probe" would be a good name anyway, as you are instantiating a device,
you are not probing for anything.

> "<client-name>,<id>" / "<id>", just as done in i2c-dev implementation,
> if created per adapter.

I'd go with a space instead of comma between parameters, for
consistency with the pci subsystem's "new_id" files.

And it's really <address>, NOT <id>, even though we use the address as
part of the device id internally.

> But where to place?

Answered above, that was the easy part.

-- 
Jean Delvare
