From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [linux-pm] pm_runtime_suspended() and non-pm_runtime-using
 (i2c) drivers
Date: Tue, 14 Dec 2010 18:09:42 +0000
Message-ID: <20101214180941.GB13644@rakim.wolfsonmicro.main>
References: <20101214164059.GE5723@sirena.org.uk>
 <Pine.LNX.4.44L0.1012141236530.2087-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1012141236530.2087-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, rjw-KKrjLPT3xs0@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 14, 2010 at 12:44:24PM -0500, Alan Stern wrote:
> On Tue, 14 Dec 2010, Mark Brown wrote:
> > On Tue, Dec 14, 2010 at 11:16:45AM -0500, Alan Stern wrote:

> > > I'm not familiar with the details of how the i2c subsystem works.  But
> > > in general, the subsystem code should call pm_runtime_set_active()  
> > > for every device before registering it.  Then if a driver doesn't use
> > > any runtime-PM functions, pm_runtime_suspended() will return false.

> > Hrm, if that's the case then we also need to update at least the
> > platform and SPI buses.  Though looking at the documentation this is
> > going to get a bit interesting as there's a requirement that the parent
> > has runtime PM enabled on it...

> The parent can either be set to the active state or set to ignore its 
> children.  The parent does not have to be enabled for runtime PM.

Both of those require that the parent is set up to know something about
runtime PM to some extent - in the case of buses like I2C the parent is
a largely unrelated thing on a different bus which may or may not have
runtime PM implemented.

> >  It's certainly not terribly apparent
> > from the documentation.

> What part isn't clear from the documentation?  I think the description 
> of pm_runtime_set_active() in Documentation/power/runtime_pm.txt is 
> pretty straightforward.

It's not clear to me that one needs to do this in order to avoid
breaking the suspend and resume calls of drivers that aren't doing
anything with runtime PM.  It's clear what it does, but it's less clear
that the bus should do it or that not doing it will have an impact on
stuff that isn't using runtime PM.

> > It'd be really helpful if it were clearer what noop buses like this were
> > supposed to do to get runtime PM working.

> I'm a little confused.  When you say this is a "noop" bus, do you mean
> that it can't do any power management?  If so, why does it need to get
> runtime PM working?

The bus as a whole may not be able to do anything useful with runtime PM
but individual devices on it may be able to do so - for example, a multi
function device provides a parent device and a bunch of children for
that device.  Runtime PM provides a nice way for the children to
individually suspend themselves and let the parent implement extra power
savings if all the children suspend.  It also provides a userspace API
for controlling runtime suspend behaviour which drivers may find useful,
and stuff like the autosuspend delays might be useful to some.
