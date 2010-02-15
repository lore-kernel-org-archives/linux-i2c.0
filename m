From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] i2c: Hook up runtime PM support
Date: Mon, 15 Feb 2010 19:15:49 +0000
Message-ID: <20100215191548.GB24590@rakim.wolfsonmicro.main>
References: <1265373011-12874-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20100215191409.14d87257@hyperion.delvare>
 <20100215183058.GA24590@rakim.wolfsonmicro.main>
 <201002152008.24142.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201002152008.24142.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 15, 2010 at 08:08:24PM +0100, Rafael J. Wysocki wrote:
> On Monday 15 February 2010, Mark Brown wrote:
> > On Mon, Feb 15, 2010 at 07:14:09PM +0100, Jean Delvare wrote:

> > > Applied, thanks. I am a little surprised to see that these functions
> > > have nothing i2c-specific, so I am wondering why we have to duplicate
> > > them in every bus type... Shouldn't the functions above be part of
> > > drivers/base/power/runtime.c and exported so that all bus types that
> > > want them can reuse them?

> In fact this is the first bus type that doesn't need anything specific in these
> routines so fat.

Not really - the platform bus is the same, it's just that some platforms
are also able to do some neat stuff with the information they glean via
runtime PM.  The platform bus is actually a bit of a problem here since
it gets used both for on-SoC devices where that sort of stuff is
possible and also for things like MFDs and random memory mapped things
on the system, meaning that drivers can't take advantage of runtime PM
unless someone goes through and does something per-SoC which is a bit
inconvnient.

There's other buses like SPI that are in the same boat as I2C - they
don't really have a cohesive bus level power management structure, or
the power management is fully handled by with noop methods on the bus
and holding the parent open until all the children are idle.
