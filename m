From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH V4 2/2] i2c-designware: Add Intel Baytrail PMIC I2C bus
 support
Date: Thu, 22 Jan 2015 16:28:19 +0200
Message-ID: <20150122142819.GG1850@lahna.fi.intel.com>
References: <1417478973-25522-1-git-send-email-david.e.box@linux.intel.com>
 <1421313137-1613-3-git-send-email-david.e.box@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421313137-1613-3-git-send-email-david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, jdelvare-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 15, 2015 at 01:12:17AM -0800, David E. Box wrote:
> This patch implements an I2C bus sharing mechanism between the host and platform
> hardware on select Intel BayTrail SoC platforms using the X-Powers AXP288 PMIC.
> 
> On these platforms access to the PMIC must be shared with platform hardware. The
> hardware unit assumes full control of the I2C bus and the host must request
> access through a special semaphore. Hardware control of the bus also makes it
> necessary to disable runtime pm to avoid interfering with hardware transactions.
> 
> Signed-off-by: David E. Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

One comment, though:

> ---
>  drivers/i2c/busses/Kconfig                   |  11 ++
>  drivers/i2c/busses/Makefile                  |   1 +
>  drivers/i2c/busses/i2c-designware-baytrail.c | 160 +++++++++++++++++++++++++++
>  drivers/i2c/busses/i2c-designware-core.h     |   6 +
>  drivers/i2c/busses/i2c-designware-platdrv.c  |  20 +++-
>  5 files changed, 193 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-designware-baytrail.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 917c358..9a83c46 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -464,6 +464,17 @@ config I2C_DESIGNWARE_PCI
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-designware-pci.
>  
> +config I2C_DESIGNWARE_BAYTRAIL
> +	bool "Intel Baytrail I2C semaphore support"

It would be nice if it was possible to compile this as a module.

> +	depends on I2C_DESIGNWARE_PLATFORM
> +	select IOSF_MBI
> +	help
> +	  This driver enables managed host access to the PMIC I2C bus on select
> +	  Intel BayTrail platforms using the X-Powers AXP288 PMIC. It allows
> +	  the host to request uninterrupted access to the PMIC's I2C bus from
> +	  the platform firmware controlling it. You should say Y if running on
> +	  a BayTrail system using the AXP288.
> +
