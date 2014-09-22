From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for AMD I2C controller
Date: Mon, 22 Sep 2014 12:12:07 +0300
Message-ID: <20140922091207.GJ1786@lahna.fi.intel.com>
References: <1411032367-20274-1-git-send-email-mika.westerberg@linux.intel.com>
 <1411032367-20274-2-git-send-email-mika.westerberg@linux.intel.com>
 <20140920093633.GG1612@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140920093633.GG1612@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Sep 20, 2014 at 11:36:34AM +0200, Wolfram Sang wrote:
> On Thu, Sep 18, 2014 at 12:26:07PM +0300, Mika Westerberg wrote:
> > From: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > 
> > Add support for AMD version of the DW I2C host controller. The device is
> > enumerated from ACPI namespace with ACPI ID AMD0010. Because the core
> > driver needs an input source clock, and this is not an Intel LPSS device
> > where clocks are provided through drivers/acpi/acpi_lpss.c, we register the
> > clock ourselves if the clock rate is given in ->driver_data.
> > 
> > Signed-off-by: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> 
> Applied to for-next, still wondering...

Thanks!

> 
> >  drivers/i2c/busses/Kconfig                  |  1 +
> >  drivers/i2c/busses/i2c-designware-platdrv.c | 27 +++++++++++++++++++++++++++
> >  2 files changed, 28 insertions(+)
> > 
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > index 2ac87fa3058d..9384498ef3c1 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -422,6 +422,7 @@ config I2C_DESIGNWARE_CORE
> >  
> >  config I2C_DESIGNWARE_PLATFORM
> >  	tristate "Synopsys DesignWare Platform"
> > +	depends on COMMON_CLK
> 
> ... do all previous users have COMMON_CLK?

The driver is being used on x86, ARM and ARC it seems. For x86 and ARM
we pretty much have COMMON_CLK nowadays but I'm not sure about ARC.
That's why I have copied Christian Ruppert.

Christian,

Do you see problems on your side if we depend on COMMON_CLK?
