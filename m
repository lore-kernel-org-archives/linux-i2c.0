From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [linux-pm] pm_runtime_suspended() and non-pm_runtime-using
	(i2c) drivers
Date: Tue, 14 Dec 2010 23:19:25 +0000
Message-ID: <20101214231924.GA26411@opensource.wolfsonmicro.com>
References: <20101214220050.GB25106@opensource.wolfsonmicro.com> <Pine.LNX.4.44L0.1012141754190.2087-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1012141754190.2087-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, rjw-KKrjLPT3xs0@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 14, 2010 at 06:03:06PM -0500, Alan Stern wrote:
> On Tue, 14 Dec 2010, Mark Brown wrote:

> > When I've been working with the runtime PM subsystem before I've thought
> > that it might be nice to have a specific RPM_UNINITIAZLIZED state which
> > would generally get out of the way.  It might be a bit clearer than the

> That's an interesting suggestion.  In general the PM core can't tell 
> what power state a device is really in when it is first discovered and 
> registered.

> I don't know if it would really solve your problem, though.  What we 
> really need is a better way to tell when a device shouldn't prevent its 
> parent from suspending.  Something like: If a device has no driver and 
> no children, it should automatically be put in the RPM_SUSPENDED state.

Yes, there'd need to be a bunch of code implementing behaviours that
look like what you suggest above and I'm not clear if it'd be worth the
hassle of implementing it - like I say, I'm not generally comfortable
enough with my understanding in this area to have a strong opinion on
the best approach.
