From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 4/5] i2c: core: Move ACPI gpio IRQ handling into
 i2c_acpi_get_irq
Date: Wed, 22 May 2019 09:19:05 +0100
Message-ID: <20190522081905.GC99937@ediswmail.ad.cirrus.com>
References: <20190521150502.27305-1-ckeepax@opensource.cirrus.com>
 <20190521150502.27305-5-ckeepax@opensource.cirrus.com>
 <20190521172726.GO9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190521172726.GO9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: wsa@the-dreams.de, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Tue, May 21, 2019 at 08:27:26PM +0300, Andy Shevchenko wrote:
> On Tue, May 21, 2019 at 04:05:01PM +0100, Charles Keepax wrote:
> > It makes sense to contain all the ACPI IRQ handling in a single helper
> > function.
> 
> > Note that this one is somewhat interesting, it seems the search
> > through the resource list is done against the companion device
> > of the adapter but the GPIO search is done against the companion
> > device of the client. It feels to me like these really should
> > be done on the same device, and certainly this is what SPI
> > does (both against the equivalent of the adapter). Perhaps
> > someone with more ACPI knowledge than myself could comment?
> 
> It would be interesting to see the path how you come to this conclusion.
> 

Apologies but I am not sure which conclusion you are referencing.
Assuming it is them being called with different acpi_device's.
It is perhaps me misunderstanding things but it looks like
i2c_acpi_get_info implies the adev should correspond to the
adapter. Where as acpi_dev_gpio_irq_get is called with the result
of ACPI_COMPANION(dev) where dev is client->dev.

> >  	acpi_dev_free_resource_list(&resource_list);
> >  
> > +	if (*irq < 0)
> > +		*irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(&client->dev), 0);
> 
> I think adev here is what we may use here.
> 

Indeed that is what I would have expected as well, I will update
the code to do so and hopefully any issues will come out in
testing.

> You may put assert here and see if it happens when you test your series.
> 

Alas I don't have a good way to test this series, they come out
of some additional work Wolfram wanted based on some issues
caused by a device tree fix I made a while back.

Thanks,
Charles
