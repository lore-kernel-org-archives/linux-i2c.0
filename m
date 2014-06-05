From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 7/7] OF/ACPI/I2C: Add generic match function for the
 aforementioned systems
Date: Thu, 5 Jun 2014 11:00:00 +0300
Message-ID: <20140605080000.GE5214@lahna.fi.intel.com>
References: <1401883796-17841-1-git-send-email-lee.jones@linaro.org>
 <1401883796-17841-8-git-send-email-lee.jones@linaro.org>
 <5769487.6cMQUCkisu@vostro.rjw.lan>
 <20140604125141.GB5214@lahna.fi.intel.com>
 <20140604132820.GA19550@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140604132820.GA19550@lee--X1>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 04, 2014 at 02:28:20PM +0100, Lee Jones wrote:
> On Wed, 04 Jun 2014, Mika Westerberg wrote:
> > On Wed, Jun 04, 2014 at 02:37:42PM +0200, Rafael J. Wysocki wrote:
> > > On Wednesday, June 04, 2014 01:09:56 PM Lee Jones wrote:
> > > > Currently this is a helper function for the I2C subsystem to aid the
> > > > matching of non-standard compatible strings and devices which use DT
> > > > and/or ACPI, but do not supply any nodes (see: [1] Method 4).  However,
> > > > it has been made more generic as it can be used to only make one call
> > > > for drivers which support any mixture of OF, ACPI and/or I2C matching.
> > > > 
> > > > The initial aim is for of_match_device() to be replaced by this call
> > > > in all I2C device drivers.
> > > > 
> > > > [1] Documentation/i2c/instantiating-devices
> > > > 
> > > > Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > 
> > > Mika, can you please have a look at this, please?
> > 
> > I don't see any fundamental problems with this wrt. ACPI.
> > 
> > That said, I find it kind of weird to have generic function that then
> > has knowledge of how different buses do their matching.
> > 
> > I would rather see something like firmware_device_match(dev) that goes
> > and matches from DT/ACPI and leave bus specific match to happen internal
> > to that bus.
> 
> Unfortunately that completely defeats the object of the patch.  When a
> of_match_device() is invoked it solely looks up devices based on OF
> matching, but I2C is special in that devices can be registered via
> sysfs, thus will no have device node.  If of_match_device() is called
> in one of these instances it will fail.  The idea of this patch is to
> generify the matching into something does has the knowledge to firstly
> attempt a traditional match, and if that fails will fall back to a
> special i2c_{of,acpi}_match_device() which knows how to deal with
> node-less registration.

OK, then but since this is now I2C specific, why call it device_match()
instead of something like i2c_device_match()? Or do you have plans to
add there more knowledge about other buses like SPI and PCI to name few?
