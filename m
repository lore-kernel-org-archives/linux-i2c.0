From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 3/6] i2c/pxa2xx: Add PCI support for PXA I2C controller
Date: Thu, 6 Jan 2011 11:12:31 +0000
Message-ID: <20110106111231.GD31708@n2100.arm.linux.org.uk>
References: <1294246263-31960-1-git-send-email-bigeasy@linutronix.de> <1294246263-31960-4-git-send-email-bigeasy@linutronix.de> <20110105230342.GO8638@n2100.arm.linux.org.uk> <20110105230834.GA26399@suse.de> <20110106105051.GA12146@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110106105051.GA12146-Hfxr4Dq0UpYb1SvskN2V4Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 06, 2011 at 11:50:51AM +0100, Sebastian Andrzej Siewior wrote:
> which functions are you talking about? I allocated one piece of memory
> which contained a platform device, ressources, platform data. It looked
> better than allocating multiple small chunks. I registered it with
> platform_device_register() and platform_device_unregister() complained
> about a missing ->release function.

Please see my email where I described the lifetime rules.  Let's say
your module is removed.  In doing so, you call platform_device_unregister()
followed by kfree().  After this, your module is removed from the system
and the memory backing the module code is unmapped.

If something holds a reference to the platform device, then that's just
waiting for an OOPS to happen.  When those references are finally given
up, your release function will be called - but the code has been unmapped.
That's one source of OOPS.  The second source of OOPS is that the platform
device will be dereferenced, but as you've already kfree'd it, the memory
could be used for some other purpose - in which case this manipulation of
what we think is still a platform device is going to corrupt some other
user.

If it hasn't been re-used, hopefully it's been poisoned, so you'll get
an OOPS from that instead.
