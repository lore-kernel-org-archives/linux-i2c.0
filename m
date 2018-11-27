From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 07/13] i2c: acpi: Introduce
 i2c_acpi_get_i2c_resource() helper
Date: Tue, 27 Nov 2018 16:27:31 +0200
Message-ID: <20181127142731.GS10650@smile.fi.intel.com>
References: <20181126150858.16901-1-andriy.shevchenko@linux.intel.com>
 <20181126150858.16901-8-andriy.shevchenko@linux.intel.com>
 <20181127090719.GM2296@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181127090719.GM2296@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 27, 2018 at 11:07:19AM +0200, Mika Westerberg wrote:
> On Mon, Nov 26, 2018 at 05:08:52PM +0200, Andy Shevchenko wrote:
> > Besides current two users one more is coming. Definitely makes sense to
> > introduce a helper.

> Since this is exported, you may want to add kernel-doc here.

OK.

> > +++ b/include/linux/acpi.h
> > @@ -1054,6 +1054,17 @@ static inline int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
> >  }
> >  #endif
> >  
> > +#if defined(CONFIG_ACPI) && IS_ENABLED(CONFIG_I2C)
> > +bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
> > +			       struct acpi_resource_i2c_serialbus **i2c);
> > +#else
> > +static inline bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
> > +					     struct acpi_resource_i2c_serialbus **i2c)
> > +{
> > +	return false;
> > +}
> 
> I think this belongs to include/linux/i2c.h where we have
> i2c_acpi_find_bus_speed() and friends.

I don't think so. It operates on top of data structures defined solely under
ACPI umbrella. If I move them to i2c.h it would look inconsistent.

Perhaps you would like to have different namespace for it (like acpi_i2c_ ?).

-- 
With Best Regards,
Andy Shevchenko
