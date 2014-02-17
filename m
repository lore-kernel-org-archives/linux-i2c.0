From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: designware-pci: Add Baytrail PCI IDs
Date: Mon, 17 Feb 2014 10:11:04 +0200
Message-ID: <20140217081104.GM5018@intel.com>
References: <1391524279-23409-1-git-send-email-mika.westerberg@linux.intel.com>
 <20140215152736.GF2579@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140215152736.GF2579@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Feb 15, 2014 at 04:27:37PM +0100, Wolfram Sang wrote:
> On Tue, Feb 04, 2014 at 04:31:19PM +0200, Mika Westerberg wrote:
> > Intel Baytrail I2C controllers can be enumerated from PCI as well as from
> > ACPI. In order to support this add the Baytrail PCI IDs to the driver.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> Basically fine, one question:
> 
> > -	snprintf(adap->name, sizeof(adap->name), "i2c-designware-pci-%d",
> > -		adap->nr);
> > +
> > +	if (adap->nr < 0)
> > +		snprintf(adap->name, sizeof(adap->name), "i2c-designware-pci");
> > +	else
> > +		snprintf(adap->name, sizeof(adap->name),
> > +			 "i2c-designware-pci-%d", adap->nr);
> 
> Maybe we just drop the "-%d" suffix entirely?

I suggested that already when Benson (CC'd) sent his Haswell patch series.
His opinion was that it is useful in certain cases to know the bus number
(like grepping /proc/interrupts, IIRC).

For Baytrail we don't need it so if nobody objects, I'll just go ahead and
drop it.
