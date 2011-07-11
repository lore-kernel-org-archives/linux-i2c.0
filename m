From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [RESEND] [PATCH] i2c: Support for Netlogic XLR/XLS on-chip I2C
 controller.
Date: Mon, 11 Jul 2011 16:14:15 +0900
Message-ID: <20110711071412.GB5092@opensource.wolfsonmicro.com>
References: <20110623135057.GA26772@jayachandranc.netlogicmicro.com>
 <20110709093742.GA9247@sirena.org.uk>
 <20110711070202.GB31303@jayachandranc.netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110711070202.GB31303-l4W0uAg2RDvWG0bvociYJ/An/qbn1+6FOui0OUZsNXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Jayachandran C." <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 11, 2011 at 12:32:03PM +0530, Jayachandran C. wrote:
> On Sat, Jul 09, 2011 at 10:37:42AM +0100, Mark Brown wrote:
> > On Fri, Jul 08, 2011 at 03:42:04PM +0530, Jayachandran C. wrote:

> > > +	if (bus == 0)
> > > +		mmio = netlogic_io_mmio(NETLOGIC_IO_I2C_0_OFFSET);
> > > +	else
> > > +		mmio = netlogic_io_mmio(NETLOGIC_IO_I2C_1_OFFSET);

> > > +	return (u32 *)mmio;

> > Functions like this should be static, though in this case the memory
> > region should be passed in as a resource rather than being embedded in
> > the driver.

> Since it is a SoC device, the address will not change at all. But yes, the
> right way is to use the platform_device resource pointer for this.

That doesn't follow at all - while the address won't change for a
particular SoC the same IP may be used in multiple SoCs.

> > This is going to loop infinitely if the bus locks up for some reason.
> > There should be some limit on how long we try for.  It also looks like
> > we're busy waiting here which isn't terribly good.

> Can add a udelay here, and a loop count.

udelay() still busy waits, and I2C transactions take a *long* time.
