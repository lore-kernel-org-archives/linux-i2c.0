From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 09/15] i2c: acpi: Introduce
 i2c_acpi_get_i2c_resource() helper
Date: Fri, 30 Nov 2018 13:45:43 +0200
Message-ID: <20181130114543.GM10650@smile.fi.intel.com>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
 <20181128114535.80223-10-andriy.shevchenko@linux.intel.com>
 <20181130095533.GC1079@kunai>
 <20181130105759.GK10650@smile.fi.intel.com>
 <20181130110652.ckj75wrxxaez2sq2@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181130110652.ckj75wrxxaez2sq2@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 30, 2018 at 12:06:52PM +0100, Wolfram Sang wrote:
> > > >  drivers/i2c/i2c-core-acpi.c | 41 ++++++++++++++++++++++++++-----------
> > > >  include/linux/acpi.h        | 11 ++++++++++
> > > 
> > > Any reason this is not in i2c.h?
> > 
> > Yes. As I explained earlier to some people there are facts affecting this:
> > - the function is operate on top of solely ACPI structures
> 
> And moving the function itself to the ACPI realm then?

Unfortunately I don't see the place where it fits good. See below.

> I don't say this is a show-stopper for this series, but I just wonder...
> 
> > - there is already similar function for GPIO and it stays like that
> > 
> > On top of this recently I've discovered, that i2c.h has separate #ifdef for I2C
> > and ACPI which theoretically might produce a linker error in some cases.
> 
> Is this something we have to live with or which can be cleaned up
> somewhen?

My opinion that we might need something like
drivers/acpi/acpi_i2c_lib.c
drivers/acpi/acpi_gpio_lib.c
etc.

But better to ask Rafael and Mika what they think about this.

-- 
With Best Regards,
Andy Shevchenko
