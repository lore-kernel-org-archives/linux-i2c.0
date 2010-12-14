From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] pm_runtime_suspended() and non-pm_runtime-using (i2c)
 drivers
Date: Tue, 14 Dec 2010 12:44:24 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012141236530.2087-100000@iolanthe.rowland.org>
References: <20101214164059.GE5723@sirena.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101214164059.GE5723-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, rjw-KKrjLPT3xs0@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 14 Dec 2010, Mark Brown wrote:

> On Tue, Dec 14, 2010 at 11:16:45AM -0500, Alan Stern wrote:
> 
> > I'm not familiar with the details of how the i2c subsystem works.  But
> > in general, the subsystem code should call pm_runtime_set_active()  
> > for every device before registering it.  Then if a driver doesn't use
> > any runtime-PM functions, pm_runtime_suspended() will return false.
> 
> Hrm, if that's the case then we also need to update at least the
> platform and SPI buses.  Though looking at the documentation this is
> going to get a bit interesting as there's a requirement that the parent
> has runtime PM enabled on it...

The parent can either be set to the active state or set to ignore its 
children.  The parent does not have to be enabled for runtime PM.

>  It's certainly not terribly apparent
> from the documentation.

What part isn't clear from the documentation?  I think the description 
of pm_runtime_set_active() in Documentation/power/runtime_pm.txt is 
pretty straightforward.

> It'd be really helpful if it were clearer what noop buses like this were
> supposed to do to get runtime PM working.

I'm a little confused.  When you say this is a "noop" bus, do you mean
that it can't do any power management?  If so, why does it need to get
runtime PM working?

Alan Stern
