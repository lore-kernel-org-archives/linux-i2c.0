From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: add optional regulator support
Date: Tue, 20 Mar 2012 10:46:19 +0200
Message-ID: <20120320084619.GZ32276@intel.com>
References: <1332161180-32502-1-git-send-email-mika.westerberg@linux.intel.com>
 <20120319142807.GA9334@sirena.org.uk>
 <20120319154130.GX32276@intel.com>
 <20120319162434.GC5132@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120319162434.GC5132-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Jani Nikula <jani.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Kirill A. Shutemov" <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 19, 2012 at 04:24:34PM +0000, Mark Brown wrote:

> This is all exactly what I'd expect and really sounds exactly like the
> case I described - the panel needs the supply so the panel driver should
> be managing it when required.  There's nothing system or controller
> specific about the fact that the panel needs all its supplies up to run,
> and indeed there's already some LCD and backlight drivers which manage
> their supplies.

We already have the panel driver to manage its regulator and it works as
should. The problem is that when we blank the display and switch off the
panel power, it drives the whole I2C bus to low (due to HW bug in the
panel). This effectively prevents any other driver to talk to their device
on the same bus :-/

This is the reason we shared the same panel regulator with I2C controller -
power is only cut off when both drivers do regulator_disable().

> So what happens in a system where the regulator is required but fails to
> appear for some reason is that the driver happily runs on without saying
> anything which isn't going to be great for diagnostics and will produce
> some interesting races when we start to deploy deferred probe.

Ah, true - it should print some sort of warning in that case instead of
silently failing.

I understand your point wrt. this patch and I think we can go forward by
keeping this in our local kernel tree as a workaround for particular HW
issue.

Thank you for your comments.
