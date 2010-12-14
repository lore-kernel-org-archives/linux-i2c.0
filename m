From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [linux-pm] pm_runtime_suspended() and non-pm_runtime-using
	(i2c) drivers
Date: Tue, 14 Dec 2010 16:40:59 +0000
Message-ID: <20101214164059.GE5723@sirena.org.uk>
References: <AANLkTik7D2mDJN=BaasvLa4xx0fQBgjHREqQB06aD9JU@mail.gmail.com> <Pine.LNX.4.44L0.1012141114150.2087-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1012141114150.2087-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, rjw-KKrjLPT3xs0@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 14, 2010 at 11:16:45AM -0500, Alan Stern wrote:

> I'm not familiar with the details of how the i2c subsystem works.  But
> in general, the subsystem code should call pm_runtime_set_active()  
> for every device before registering it.  Then if a driver doesn't use
> any runtime-PM functions, pm_runtime_suspended() will return false.

Hrm, if that's the case then we also need to update at least the
platform and SPI buses.  Though looking at the documentation this is
going to get a bit interesting as there's a requirement that the parent
has runtime PM enabled on it...  It's certainly not terribly apparent
from the documentation.

It'd be really helpful if it were clearer what noop buses like this were
supposed to do to get runtime PM working.
