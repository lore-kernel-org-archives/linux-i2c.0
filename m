From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Tue, 1 Aug 2017 10:51:33 -0700
Message-ID: <20170801175133.GA30520@kroah.com>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
 <20170801014021.GA20004@kroah.com>
 <20170801124801.38bbc431@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170801124801.38bbc431@bbrezillon>
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@co>
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 01, 2017 at 12:48:01PM +0200, Boris Brezillon wrote:
> > > +static DEFINE_MUTEX(i3c_core_lock);
> > > +
> > > +void i3c_bus_lock(struct i3c_bus *bus, bool exclusive)
> > > +{
> > > +	if (exclusive)
> > > +		down_write(&bus->lock);
> > > +	else
> > > +		down_read(&bus->lock);
> > > +}  
> > 
> > The "exclusive" flag is odd, and messy, and hard to understand, don't
> > you agree?
> 
> I could create 2 functions, one for the exclusive lock and the other
> one for the shared lock.

Or you could just use a simple mutex until you determine you really
would do better with a rw lock :)

> > And have you measured the difference in using a rw lock over
> > a normal mutex and found it to be faster?  If not, just use a normal
> > mutex, it's simpler and almost always better in the end.
> 
> I did not measure the difference, but using a standard lock means
> serializing all I3C accesses going through a given master in the core.

Which you are doing with a rw lock anyway, right?

> Note that this lock is not here to guarantee that calls to
> master->ops->xxx() are serialized (this part is left to the master
> driver), but to ensure that when a bus management operation is in
> progress (like changing the address of a device on the bus), no one can
> send I3C frames. If we don't do that, one could queue an I3C transfer,
> and by the time this transfer reach the bus, the I3C device this
> message was targeting may have a different address.

That sounds really odd.  locks should protect data, not bus access,
right?

> Unless you see a good reason to not use a R/W lock, I'd like to keep it
> this way because master IPs are likely to implement advanced queuing
> mechanism (allows one to queue new transfers even if the master is
> already busy processing other requests), and serializing things at the
> framework level will just prevent us from using this kind of
> optimization.

Unless you can prove otherwise, using a rw lock is almost always worse
than just a mutex.  And you shouldn't have a lock for bus transactions,
that's just going to be a total mess.  You could have a lock for a
single device access, but that still seems really strange, is the i3c
spec that bad?

> > > +static ssize_t hdrcap_show(struct device *dev,
> > > +			   struct device_attribute *da,
> > > +			   char *buf)
> > > +{
> > > +	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
> > > +	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
> > > +	unsigned long caps = i3cdev->info.hdr_cap;
> > > +	ssize_t offset = 0, ret;
> > > +	int mode;
> > > +
> > > +	i3c_bus_lock(bus, false);
> > > +	for_each_set_bit(mode, &caps, 8) {
> > > +		if (mode >= ARRAY_SIZE(hdrcap_strings))
> > > +			break;
> > > +
> > > +		if (!hdrcap_strings[mode])
> > > +			continue;
> > > +
> > > +		ret = sprintf(buf + offset, "%s\n", hdrcap_strings[mode]);  
> > 
> > Multiple lines in a single sysfs file?  No.
> 
> Okay. Would that be okay with a different separator (like a comma)?

No, sysfs files are "one value per file", given you don't have any
documentation saying what this file is supposed to be showing, I can't
really judge the proper way for you to present it to userspace :)

> > > +static const struct attribute_group *i3c_device_groups[] = {
> > > +	&i3c_device_group,
> > > +	NULL,
> > > +};  
> > 
> > ATTRIBUTE_GROUPS()?
> 
> My initial plan was to have a common set of attributes that apply to
> both devices and masters, and then add specific attributes in each of
> them when they only apply to a specific device type.

That's fine, but you do know that attributes can be enabled/disabled at
device creation time with the return value of the callback is_visable(),
right?  Why not just use that here, simplifying a lot of logic?

> Just out of curiosity, what's the preferred solution when you need to
> do something like that? Should we just use ATTRIBUTE_GROUPS() and
> duplicate the entries that apply to both device types?

is_visable()?

> > No release type?  Oh that's bad bad bad and implies you have never
> > removed a device from your system as the kernel would have complained
> > loudly at you.
> 
> You got me, never tried to remove a device :-). Note that these
> ->release() hooks will just be dummy ones, because right now, device
> resources are freed at bus destruction time.

You better not have a "dummy" release hook, do that and as per the
kernel documentation, I get to make fun of you in public for doing that
:(

> Also, I see that dev->release() is called instead of
> dev->type->release() if it's not NULL [1]. what's the preferred solution
> here? Set dev->release or type->release()?

It depends on how your bus is managed, who controls the creation of the
resources, free it in the same place you create it.

thanks,

greg k-h
