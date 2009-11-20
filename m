From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH 0/10] PNX clock API fixes
Date: Fri, 20 Nov 2009 14:44:22 +0000
Message-ID: <20091120144422.GA18223@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Cc: Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Following on from the previous set of patches...

The PNX4008 clock API usage is extremely poor.  Nothing works as it was
intended to - clk_set_rate() is used to turn clocks on and off, or
set dividers.  I certainly doesn't take the desired clock rate in Hz.
clk_get_rate() doesn't report the clock rate in Hz either - it doesn't
even report any kind of rate.

clk_enable and clk_disable seem to be very weird too.

This patch set fixes the I2C and watchdog drivers so that they can be
used with clk API implementations which do actually conform with the
clk API.

As per the previous set, selective cc's.  Full set will be on
linux-arm-kernel.
