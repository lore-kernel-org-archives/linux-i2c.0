From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH]i2c-dev: add ioctls PROBE and REMOVE
Date: Tue, 7 Apr 2009 12:15:50 +0200
Message-ID: <20090407121550.7d15bfae@hyperion.delvare>
References: <49CB43E0.2050503@gmx.de>
	<49CCA82F.90106@gmx.de>
	<20090327134034.754908b5@hyperion.delvare>
	<49CCD0FC.9030500@gmx.de>
	<20090327145726.13c99aed@hyperion.delvare>
	<20090327150716.094666d1@hyperion.delvare>
	<49D4B14B.50405@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49D4B14B.50405-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

Sorry for the late answer, I am pretty busy with the 2.6.30 merge
window.

On Thu, 02 Apr 2009 14:36:27 +0200, Michael Lawnick wrote:
> Jean Delvare said the following:
> > BTW, if you don't want your problem to be overlooked, I strongly
> > suggest that you create yourself a wiki account on
> > http://i2c.wiki.kernel.org/, create a page describing the problem and
> > its proposed solution, and link to it from the "Work in progress"
> > section.
> > 
> Ok, done.
> <http://i2c.wiki.kernel.org/index.php?title=SysFs_entries_add_device/delete_device>

Thank you.

> I made a patch, that uses i2c_new_device. But this won't use the detect
> method of the client, so its possible to instantiate almost any code on
> the given address :-(
> Shouldn't we use i2c_detect_address() or something similar?

No. The whole point of the sysfs entries you are adding is to let the
user instantiate I2C devices (at the device driver model level) for
physical devices which can _not_ be detected. For devices which can be
reliably detected, you would simply implement the .detect() method, set
the I2C class, and let i2c-core and the device driver take care of the
detection and device creation.

I hear you, "what about hot-plugged devices, they won't be detected"?
For one thing, these need to be behind a mux or gate, which we don't
support at the moment, so discussing this now doesn't make much sense.
But at any rate I don't think that the files you are adding in sysfs
are meant to address this particular issue. If we want to be able to
re-trigger detection on a given I2C segment (which currently only
happens at I2C adapter creation time and when a new driver is
registered) this would be done by a separate sysfs entry (say "detect",
write 1 to re-trigger all detections on a given segment). But really
I'd rather wait for Rodoflo's work to be merged first, depending on the
implementation there may or may not be a practical need for this.

Right now I am working hard at getting rid of the few remaining legacy
i2c device drivers. Then I can clean up i2c-core and then we can look
into Rodolfo's patches. I know it seems to take forever, but actually
we are making progress and will finally get there.

-- 
Jean Delvare
