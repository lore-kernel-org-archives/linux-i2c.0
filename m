From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 09/15] i2c: acpi: Introduce
 i2c_acpi_get_i2c_resource() helper
Date: Fri, 30 Nov 2018 14:17:54 +0200
Message-ID: <20181130121754.GO10650@smile.fi.intel.com>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
 <20181128114535.80223-10-andriy.shevchenko@linux.intel.com>
 <20181130095533.GC1079@kunai>
 <20181130105759.GK10650@smile.fi.intel.com>
 <20181130110652.ckj75wrxxaez2sq2@ninjato>
 <20181130114543.GM10650@smile.fi.intel.com>
 <20181130114950.av6pnedcqu27jyjc@ninjato>
 <20181130121231.GO3078@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181130121231.GO3078@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 30, 2018 at 02:12:31PM +0200, Mika Westerberg wrote:
> On Fri, Nov 30, 2018 at 12:49:50PM +0100, Wolfram Sang wrote:
> > 
> > > > Is this something we have to live with or which can be cleaned up
> > > > somewhen?
> > > 
> > > My opinion that we might need something like
> > > drivers/acpi/acpi_i2c_lib.c
> > > drivers/acpi/acpi_gpio_lib.c
> > > etc.
> > >
> > 
> > Collect all of them in drivers/acpi/acpi_libs.c?
> > 
> > > But better to ask Rafael and Mika what they think about this.
> 
> IMHO all the bus specific ACPI things should go under those buses (so
> the opposite what is proposed here) but I also don't think any of this
> is show stopper for the patch series under discussion ;-)

Thank you guys for your input, let me fix this later, out of this series.

-- 
With Best Regards,
Andy Shevchenko
