From: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH V3 2/2] i2c-designware: Add Intel Baytrail PMIC I2C bus
 support
Date: Thu, 4 Dec 2014 11:11:14 -0800
Message-ID: <20141204191114.GC1530@pathfinder>
References: <1411497626-7984-1-git-send-email-david.e.box@linux.intel.com>
 <1417478973-25522-1-git-send-email-david.e.box@linux.intel.com>
 <1417478973-25522-3-git-send-email-david.e.box@linux.intel.com>
 <20141203161046.GC28857@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141203161046.GC28857-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, jdelvare-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 03, 2014 at 06:10:46PM +0200, Mika Westerberg wrote:
> On Mon, Dec 01, 2014 at 04:09:33PM -0800, David E. Box wrote:
> > This patch implements an I2C bus sharing mechanism between the host and platform
> > hardware on select Intel BayTrail SoC platforms using the X-Powers AXP288 PMIC.
> > 
> > On these platforms access to the PMIC must be shared with platform hardware. The
> > hardware unit assumes full control of the I2C bus and the host must request
> > access through a special semaphore. Hardware control of the bus also makes it
> > necessary to disable runtime pm to avoid interfering with hardware transactions.
> > 
> > Signed-off-by: David E. Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >  drivers/i2c/busses/Kconfig                   |  12 +++
> >  drivers/i2c/busses/Makefile                  |   1 +
> >  drivers/i2c/busses/i2c-designware-baytrail.c | 155 +++++++++++++++++++++++++++
> >  drivers/i2c/busses/i2c-designware-core.h     |   6 ++
> >  4 files changed, 174 insertions(+)
> >  create mode 100644 drivers/i2c/busses/i2c-designware-baytrail.c
> > 
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > index 917c358..d2bfd88 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -464,6 +464,18 @@ config I2C_DESIGNWARE_PCI
> >  	  This driver can also be built as a module.  If so, the module
> >  	  will be called i2c-designware-pci.
> >  
> > +config I2C_DESIGNWARE_BAYTRAIL
> > +	bool "Intel Baytrail I2C semaphore support"
> > +	depends on I2C_DESIGNWARE_PLATFORM=y
> 
> Hmm, is there something preventing to compile this as module?
> 

There were load order issues. This driver is really a support module for the
platform driver. I think Wolfram suggested this earlier but I didn't realize it
until now. The proper solution is to link it conditionally with
i2c-designware-platform.

Dave
