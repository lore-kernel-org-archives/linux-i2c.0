From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Tue, 1 Aug 2017 23:30:01 +0200
Message-ID: <20170801233001.4b08834f@bbrezillon>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
        <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
        <20170801014021.GA20004@kroah.com>
        <20170801124801.38bbc431@bbrezillon>
        <20170801175133.GA30520@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53325 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbdHAVaN (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 1 Aug 2017 17:30:13 -0400
In-Reply-To: <20170801175133.GA30520@kroah.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@co>

Hi Greg,

Le Tue, 1 Aug 2017 10:51:33 -0700,
Greg Kroah-Hartman <gregkh@linuxfoundation.org> a écrit :

> On Tue, Aug 01, 2017 at 12:48:01PM +0200, Boris Brezillon wrote:
> > > > +static DEFINE_MUTEX(i3c_core_lock);
> > > > +
> > > > +void i3c_bus_lock(struct i3c_bus *bus, bool exclusive)
> > > > +{
> > > > +	if (exclusive)
> > > > +		down_write(&bus->lock);
> > > > +	else
> > > > +		down_read(&bus->lock);
> > > > +}    
> > > 
> > > The "exclusive" flag is odd, and messy, and hard to understand, don't
> > > you agree?  
> > 
> > I could create 2 functions, one for the exclusive lock and the other
> > one for the shared lock.  
> 
> Or you could just use a simple mutex until you determine you really
> would do better with a rw lock :)
> 
> > > And have you measured the difference in using a rw lock over
> > > a normal mutex and found it to be faster?  If not, just use a normal
> > > mutex, it's simpler and almost always better in the end.  
> > 
> > I did not measure the difference, but using a standard lock means
> > serializing all I3C accesses going through a given master in the core.  
> 
> Which you are doing with a rw lock anyway, right?

Absolutely not. If you look more closely at the code you'll see that
most of the time the lock is taken in read/non-exclusive mode. The only
situations where it's taken in exclusive mode is when the operation (and
associated command) has an impact on the bus and/or its devices.

For instance, resetting addresses of all I3C devices on the bus (using
RSTDAA) means you won't be able to send I3C messages to these devices
after that. If you don't take an exclusive lock to protect this
operation, that means you might end up with drivers queuing messages
with a device address that is about to be invalid. Also, we might soon
provide the possibility to change I3C dynamic address at runtime, which
is important since the dynamic address also encodes the priority of the
device when it's generating in-band interrupts (the lower the address
the higher the priority). We need this 'change dynamic address'
operation to be atomic for the same reason: to prevent drivers from
sending messages to an invalid address.

> 
> > Note that this lock is not here to guarantee that calls to
> > master->ops->xxx() are serialized (this part is left to the master
> > driver), but to ensure that when a bus management operation is in
> > progress (like changing the address of a device on the bus), no one can
> > send I3C frames. If we don't do that, one could queue an I3C transfer,
> > and by the time this transfer reach the bus, the I3C device this
> > message was targeting may have a different address.  
> 
> That sounds really odd.  locks should protect data, not bus access,
> right?

Well, it's protecting data: the dynamic address is a piece of
information attached to the device. 

> 
> > Unless you see a good reason to not use a R/W lock, I'd like to keep it
> > this way because master IPs are likely to implement advanced queuing
> > mechanism (allows one to queue new transfers even if the master is
> > already busy processing other requests), and serializing things at the
> > framework level will just prevent us from using this kind of
> > optimization.  
> 
> Unless you can prove otherwise, using a rw lock is almost always worse
> than just a mutex.

Is it still true when it's taken in non-exclusive mode most of the
time, and the time you spend in the critical section is non-negligible?

I won't pretend I know better than you do what is preferable, it's just
that the RW lock seemed appropriate to me for the situation I tried to
described here.

> And you shouldn't have a lock for bus transactions,
> that's just going to be a total mess.

It's not a lock for bus transactions, it's lock to protect from any
operation that can have an impact on the bus or its devices (see the
'change device address' example above).

> You could have a lock for a
> single device access, but that still seems really strange, is the i3c
> spec that bad?

Having a lock per device would complicate even more the situation
because some operations like the broadcasted RSTDAA have an impact on
all devices on the bus.

> 
> > > > +static ssize_t hdrcap_show(struct device *dev,
> > > > +			   struct device_attribute *da,
> > > > +			   char *buf)
> > > > +{
> > > > +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> > > > +	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
> > > > +	unsigned long caps = i3cdev->info.hdr_cap;
> > > > +	ssize_t offset = 0, ret;
> > > > +	int mode;
> > > > +
> > > > +	i3c_bus_lock(bus, false);
> > > > +	for_each_set_bit(mode, &caps, 8) {
> > > > +		if (mode >= ARRAY_SIZE(hdrcap_strings))
> > > > +			break;
> > > > +
> > > > +		if (!hdrcap_strings[mode])
> > > > +			continue;
> > > > +
> > > > +		ret = sprintf(buf + offset, "%s\n", hdrcap_strings[mode]);    
> > > 
> > > Multiple lines in a single sysfs file?  No.  
> > 
> > Okay. Would that be okay with a different separator (like a comma)?  
> 
> No, sysfs files are "one value per file", given you don't have any
> documentation saying what this file is supposed to be showing, I can't
> really judge the proper way for you to present it to userspace :)

Okay. Let's put that aside until I send a v2 with a sysfs doc.

Still, note that the "one value per file" rule does not apply to all
sysfs files. I have 2 examples in mind (maybe they are bad examples,
but they exist):

- /sys/class/leds/<led>/trigger returns a list of supported triggers
  each of them is separated by a space
- /sys/class/graphics/<fbx>/modes lists the supported video modes, one
  per line


> 
> > > > +static const struct attribute_group *i3c_device_groups[] = {
> > > > +	&i3c_device_group,
> > > > +	NULL,
> > > > +};    
> > > 
> > > ATTRIBUTE_GROUPS()?  
> > 
> > My initial plan was to have a common set of attributes that apply to
> > both devices and masters, and then add specific attributes in each of
> > them when they only apply to a specific device type.  
> 
> That's fine, but you do know that attributes can be enabled/disabled at
> device creation time with the return value of the callback is_visable(),
> right?  Why not just use that here, simplifying a lot of logic?

I didn't know that, thanks for the hint.

> 
> > Just out of curiosity, what's the preferred solution when you need to
> > do something like that? Should we just use ATTRIBUTE_GROUPS() and
> > duplicate the entries that apply to both device types?  
> 
> is_visable()?
> 
> > > No release type?  Oh that's bad bad bad and implies you have never
> > > removed a device from your system as the kernel would have complained
> > > loudly at you.  
> > 
> > You got me, never tried to remove a device :-). Note that these  
> > ->release() hooks will just be dummy ones, because right now, device  
> > resources are freed at bus destruction time.  
> 
> You better not have a "dummy" release hook, do that and as per the
> kernel documentation, I get to make fun of you in public for doing that
> :(

I'm not afraid of admitting I don't know everything, even the
simplest things that you consider as basics for a kernel developer. You
can make fun of me publicly if you want but that's not helping :-P.

BTW, the very reason I Cc-ed you in the first place is to have feedback
on this implementation, and please note that this is an RFC, so of
course, not everything is perfect. I'm here to learn from your reviews,
but that doesn't prevent me from asking more details about the
reasoning behind your suggestions. That's part of the learning process,
right?

The reason I proposed this dummy ->release() hook is because the
lifetime of the i2c/i3c dev allocated by the I3C framework goes beyond
the underlying struct device object embedded in it. Indeed, when the
i3c_device object is allocated, the I3C master can attach private data
to it (this is done inside master->ops->bus_init()), and these data
are expected to be freed in master->ops->bus_cleanup() which is done
after all devices attached to the I3C bus have been unregistered (so
the ->release() callback of each I3C dev has already been called before
we enter ->bus_cleanup()).

Now, maybe I took a wrong approach here, but I just wanted to explain
why releasing the I3C dev inside dev->release() or
dev->type->release() is not possible with the current implementation. 

> 
> > Also, I see that dev->release() is called instead of
> > dev->type->release() if it's not NULL [1]. what's the preferred solution
> > here? Set dev->release or type->release()?  
> 
> It depends on how your bus is managed, who controls the creation of the
> resources, free it in the same place you create it.

I3C devices are allocated by the master inside its ->bus_init() hook,
and I currently free all devices in i3c_bus_cleanup(), which is kind of
symmetric.

I understand that you're not happy with this solution, so I'll try to
come up with a different approach where dev->release() calls a master
hook to release private master data and only then frees the i3c_device
object.

I hope you're not taking my answers as a sign of arrogance, because
this is definitely not what it is. I just want to make sure you
understand why I made some (bad?) choices when designing this framework.

I really appreciate your reviews and will of course take all of your
comments into account before sending a v2.

Thanks for your time.

Boris
