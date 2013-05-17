From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] i2c: suppress lockdep warning on delete_device
Date: Fri, 17 May 2013 13:16:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1305171313000.1012-100000@iolanthe.rowland.org>
References: <519659F7.90608@nsn.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <519659F7.90608-OYasijW0DpE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 17 May 2013, Alexander Sverdlin wrote:

> Hi!
> 
> On 05/17/2013 05:31 PM, ext Alan Stern wrote:
> >>>> i2c: suppress lockdep warning on delete_device
> >>>>
> >>>> Since commit 846f99749ab68bbc7f75c74fec305de675b1a1bf the following lockdep
> >>>> warning is thrown in case i2c device is removed (via delete_device sysfs
> >>>> attribute) which contains subdevices (e.g. i2c multiplexer):
> >>>
> >>> Can you explain this in a little more detail?  Exactly what does the
> >>> delete_device attribute do, when called for device D?
> >>>
> >>> That is, what does a write to /sys/bus/i2c/devices/D/delete_device do?
> >>
> >> Like USB with its hubs, I2C structure could be tree-like, with I2C multiplexers.
> >> delete_device attribute removes I2C device from the subsystem, which is usually not
> >> a problem, except the case when device is a multiplexer and sub-devices should be
> >> removed first. Here we have the problem: holding a "s_active" lock on
> >> "delete_device" attribute of a parent (multiplexer) we need to delete children, but
> >> they were created with the same static attribute "delete_device".
> >>
> >> The safety of this operation is exactly the same as in USB case... Any more clever
> >> lockdep annotation is exactly not so easy...
> >
> > If I understand you correctly, if D is an I2C multiplexer then writing
> > to /sys/bus/i2c/devices/D/delete_device will get rid of all of D's
> > children (and their descendants) and will also get rid of D itself --
> > right?
> >
> > That's _not_ what the USB attributes do.  For example, if D is a USB
> > hub then writing 0 to /sys/bus/usb/devices/D/bConfigurationValue will
> > get rid of all D's descendants but will not get rid of D.
> 
> Well, seems that what I've described above wasn't precise enough...

That's why I asked what "exactly" the attribute does.  :-)

> Actually only "bus controllers" have "delete_device" attribute. Simple devices
> on the bus do not have it. User write an address of the slave device to this
> attribute to delete it. This works fine for simple devices. In case of multiplexer
> (which is in turn also a "bus controller") there are nested "delete_device"
> attributes. So it's only possible to delete child nodes and not the controller itself,
> writing to its "delete_device". So from my POV, it fits to USB concept...

Okay.  If writing to the attribute doesn't delete the object which the 
attribute is attached to, then your patch is the correct approach.

Alan Stern
