From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: move of helpers into the core
Date: Wed, 21 Aug 2013 10:54:18 +0300
Message-ID: <20130821075417.GC4898@intel.com>
References: <1376918361-7014-1-git-send-email-wsa@the-dreams.de>
 <3792014.HtzPVmLjnf@vostro.rjw.lan>
 <5212A293.2030903@wwwdotorg.org>
 <3721030.UJAkTdQrEC@vostro.rjw.lan>
 <20130820092813.GW4898@intel.com>
 <20130820143043.GA2993@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130820143043.GA2993@katana>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Stephen Warren <swarren@wwwdotorg.org>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jerry Snitselaar <jerry.snitselaar@oracle.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 20, 2013 at 04:30:43PM +0200, Wolfram Sang wrote:
> On Tue, Aug 20, 2013 at 12:28:13PM +0300, Mika Westerberg wrote:
> > [Added Jerry as he found out a problem when acpi_i2c is being build as a
> > module, this should solve it as well.]
> > 
> > On Tue, Aug 20, 2013 at 01:25:27AM +0200, Rafael J. Wysocki wrote:
> > > On Monday, August 19, 2013 04:56:19 PM Stephen Warren wrote:
> > > > On 08/19/2013 05:04 PM, Rafael J. Wysocki wrote:
> > > > > On Monday, August 19, 2013 03:19:18 PM Wolfram Sang wrote:
> > > > >> I2C of helpers used to live in of_i2c.c but experience (from SPI) shows
> > > > >> that it is much cleaner to have this in the core. This also removes a
> > > > >> circular dependency between the helpers and the core, and so we can
> > > > >> finally register child nodes in the core instead of doing this manually
> > > > >> in each driver. So, fix the drivers and documentation, too.
> > > > > 
> > > > > Perhaps we should do the analogous for ACPI then?
> > 
> > Here is the ACPI version based on the current patch from Wolfram (there is
> > a compile error because of missing dummy implementation of
> > of_i2c_register_devices())
> > 
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Subject: [PATCH] i2c: move ACPI helpers into the core
> > 
> > This follows what has already been done for the DeviceTree helpers. Move
> > the ACPI helpers from drivers/acpi/acpi_i2c.c to the I2C core and update
> > documentation accordingly.
> > 
> > This also solves a problem reported by Jerry Snitselaar that we can't build
> > the ACPI I2C helpers as a module.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Nice, one thing, though:
> 
> >  	/* create pre-declared device nodes */
> >  	of_i2c_register_devices(adap);
> > +	acpi_i2c_register_devices(adap);
> 
> I prefer the if (IS_ENABLED()) solution and will use this in my V2 as
> well.

For the ACPI part we need to have the dummy stub because CONFIG_ACPI is
needed in order to be able to call the ACPI APIs -- there are still
functions that are only available when CONFIG_ACPI is enabled.
