From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Tue, 1 Aug 2017 19:13:27 -0700
Message-ID: <20170802021327.GB23033@kroah.com>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
 <20170801014021.GA20004@kroah.com>
 <20170801124801.38bbc431@bbrezillon>
 <20170801175133.GA30520@kroah.com>
 <20170801233001.4b08834f@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170801233001.4b08834f@bbrezillon>
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@co>
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 01, 2017 at 11:30:01PM +0200, Boris Brezillon wrote:
> Hi Greg,
> 
> Le Tue, 1 Aug 2017 10:51:33 -0700,
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> a écrit :
> 
> > On Tue, Aug 01, 2017 at 12:48:01PM +0200, Boris Brezillon wrote:
> > > > > +static DEFINE_MUTEX(i3c_core_lock);
> > > > > +
> > > > > +void i3c_bus_lock(struct i3c_bus *bus, bool exclusive)
> > > > > +{
> > > > > +	if (exclusive)
> > > > > +		down_write(&bus->lock);
> > > > > +	else
> > > > > +		down_read(&bus->lock);
> > > > > +}    
> > > > 
> > > > The "exclusive" flag is odd, and messy, and hard to understand, don't
> > > > you agree?  
> > > 
> > > I could create 2 functions, one for the exclusive lock and the other
> > > one for the shared lock.  
> > 
> > Or you could just use a simple mutex until you determine you really
> > would do better with a rw lock :)
> > 
> > > > And have you measured the difference in using a rw lock over
> > > > a normal mutex and found it to be faster?  If not, just use a normal
> > > > mutex, it's simpler and almost always better in the end.  
> > > 
> > > I did not measure the difference, but using a standard lock means
> > > serializing all I3C accesses going through a given master in the core.  
> > 
> > Which you are doing with a rw lock anyway, right?
> 
> Absolutely not. If you look more closely at the code you'll see that
> most of the time the lock is taken in read/non-exclusive mode. The only
> situations where it's taken in exclusive mode is when the operation (and
> associated command) has an impact on the bus and/or its devices.

Then you really need to document the heck out of this, as it was not
obvious at all :)

> > > Unless you see a good reason to not use a R/W lock, I'd like to keep it
> > > this way because master IPs are likely to implement advanced queuing
> > > mechanism (allows one to queue new transfers even if the master is
> > > already busy processing other requests), and serializing things at the
> > > framework level will just prevent us from using this kind of
> > > optimization.  
> > 
> > Unless you can prove otherwise, using a rw lock is almost always worse
> > than just a mutex.
> 
> Is it still true when it's taken in non-exclusive mode most of the
> time, and the time you spend in the critical section is non-negligible?
> 
> I won't pretend I know better than you do what is preferable, it's just
> that the RW lock seemed appropriate to me for the situation I tried to
> described here.

Again, measure it.  If you can't measure it, then don't use it.  Use a
simple lock instead.  Seriously, don't make it more complex until you
really have to.  It sounds like you didn't measure it at all, which
isn't good, please do so.

> > And you shouldn't have a lock for bus transactions,
> > that's just going to be a total mess.
> 
> It's not a lock for bus transactions, it's lock to protect from any
> operation that can have an impact on the bus or its devices (see the
> 'change device address' example above).

Again, document it really well please.

> > > > > +		ret = sprintf(buf + offset, "%s\n", hdrcap_strings[mode]);    
> > > > 
> > > > Multiple lines in a single sysfs file?  No.  
> > > 
> > > Okay. Would that be okay with a different separator (like a comma)?  
> > 
> > No, sysfs files are "one value per file", given you don't have any
> > documentation saying what this file is supposed to be showing, I can't
> > really judge the proper way for you to present it to userspace :)
> 
> Okay. Let's put that aside until I send a v2 with a sysfs doc.
> 
> Still, note that the "one value per file" rule does not apply to all
> sysfs files. I have 2 examples in mind (maybe they are bad examples,
> but they exist):
> 
> - /sys/class/leds/<led>/trigger returns a list of supported triggers
>   each of them is separated by a space
> - /sys/class/graphics/<fbx>/modes lists the supported video modes, one
>   per line

I'm not saying there are not bad files, but I didn't review them :)

A list of supported triggers all on one line and one you pick from it
(the power file is also the same way), is different from multiple lines.
The graphics stuff should be fixed up.

thanks,

greg k-h
