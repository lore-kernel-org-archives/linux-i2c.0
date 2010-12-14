From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [linux-pm] pm_runtime_suspended() and non-pm_runtime-using
	(i2c) drivers
Date: Tue, 14 Dec 2010 22:00:51 +0000
Message-ID: <20101214220050.GB25106@opensource.wolfsonmicro.com>
References: <20101214180941.GB13644@rakim.wolfsonmicro.main> <Pine.LNX.4.44L0.1012141406500.2087-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1012141406500.2087-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, rjw-KKrjLPT3xs0@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 14, 2010 at 02:10:58PM -0500, Alan Stern wrote:

> I see.  It sounds like you're really saying that new devices default to 
> the wrong runtime state.  If pm_runtime_init() would set new devices to 
> RPM_ACTIVE instead of RPM_SUSPENDED then this problem wouldn't arise.  
> Children could do whatever they want, and even if the parent's driver 
> was totally ignorant of runtime PM, it would work out.

In this case that's the desired behaviour but I worry that it'd break
some other use case (eg, keeping a parent awake because there was an
unclaimed device sitting around).  

When I've been working with the runtime PM subsystem before I've thought
that it might be nice to have a specific RPM_UNINITIAZLIZED state which
would generally get out of the way.  It might be a bit clearer than the
current situation conceptually but I've never felt I had a firm enough
grasp on what was going on to really say, everything always feels more
complicated than I feel it should if I understood it properly.

Thinking about it in the case of I2C we probably also want to mark the
device as ignoring its children when it registers as an I2C controller,
while an I2C controller that does runtime PM will probably figure this
out for itself it would save a bit of effort.
