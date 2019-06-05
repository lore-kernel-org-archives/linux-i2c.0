From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3 2/6] i2c: acpi: Use available IRQ helper functions
Date: Wed, 5 Jun 2019 09:26:41 +0100
Message-ID: <20190605082641.GM28362@ediswmail.ad.cirrus.com>
References: <20190528142900.24147-1-ckeepax@opensource.cirrus.com>
 <20190528142900.24147-2-ckeepax@opensource.cirrus.com>
 <20190604170052.GQ9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190604170052.GQ9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: wsa@the-dreams.de, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 04, 2019 at 08:00:52PM +0300, Andy Shevchenko wrote:
> On Tue, May 28, 2019 at 03:28:56PM +0100, Charles Keepax wrote:
> > Use the available IRQ helper functions, most of the functions have
> > additional helpful side affects like configuring the trigger type of the
> > IRQ.
> > 
> 
> You do here two things, i.e.
> - splitting out helper function
> - converting it to use helpers
> 
> I would split the patch to do exact these steps separately, e.g.:
> - splitting out to a local helper
> - replacing open coded stuff with existing helpers
> 

This can't really be done like this, the helper is called by
acpi_dev_get_resources and I need the acpi_resource from that to
call acpi_dev_resource_interrupt. I guess I could do a separate
patch to start using i2c_dev_irq_from_resource if that would be
preferrable? But I think the rest needs to stay together.

Thanks,
Charles
