From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client
 devices
Date: Sun, 15 Sep 2013 16:28:24 +0300
Message-ID: <20130915132823.GL7393@intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-2-git-send-email-mika.westerberg@linux.intel.com>
 <87vc25pvvm.fsf@linaro.org>
 <20130913065434.GZ7393@intel.com>
 <87bo3whjz4.fsf@linaro.org>
 <20130913145022.GC7393@intel.com>
 <20130913173149.GE7393@intel.com>
 <87ioy4e8bw.fsf@linaro.org>
 <20130915064139.GJ7393@intel.com>
 <20130915124744.GW29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130915124744.GW29403-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Sep 15, 2013 at 01:47:44PM +0100, Mark Brown wrote:
> On Sun, Sep 15, 2013 at 09:41:39AM +0300, Mika Westerberg wrote:
> 
> > There's also a less intrusive way of fixing the problem we see with ACPI
> > enabled I2C devices:
> 
> > 	1. In I2C core i2c_device_probe() we power on the I2C controller
> > 	and attach the client device to the ACPI power domain. Just like in
> > 	this patch but we don't touch the I2C client device runtime PM.
> 
> > 	-> This should allow the existing drivers to keep using whatever
> > 	runtime PM strategy they have chosen.
> 
> There should be no explicit need to power on the I2C controller if it's
> implemented the same way the existing ones are - just have it power
> itself on when it is doing a transfer.

The problem is that the ACPI child device can't be in higher power state
than its parent (and this is also what the runtime PM expects). If we don't
power the I2C controller device before we power on the I2C client device
that rule is violated and we get an complaint to the console.

> > 	2. For ACPI enumerated I2C client devices drivers we need to
> > 	implement the runtime PM in order to save power (otherwise the
> > 	devices will be left powered on).
> 
> > and do the same for SPI devices as well.
> 
> > Then only thing that changes for non-ACPI devices is that the controller
> > will be powered on during the client device probe (well, and during
> > remove).
> 
> > Thoughts?
> 
> This is definitely less intrusive than the current proposal, there's one
> ACPI I2C device binding queued for -next after the merge window (rt5640)
> which will need an update.

OK, thanks for the heads up. I'll check it.
