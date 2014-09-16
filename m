From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: Intel BayTrail PMIC I2C bus support
Date: Tue, 16 Sep 2014 12:44:49 +0300
Message-ID: <20140916094449.GZ10854@lahna.fi.intel.com>
References: <1410543367-6565-1-git-send-email-david.e.box@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410543367-6565-1-git-send-email-david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, jdelvare-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org, iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Sep 12, 2014 at 10:36:07AM -0700, David E. Box wrote:
> This patch implements an I2C bus sharing mechanism between the host and platform
> hardware on select Intel BayTrail SoC platforms using the XPower AXP288 PMIC.
> 
> On these platforms access to the PMIC must be shared with platform hardware. The
> hardware unit assumes full control of the I2C bus and the host must request
> access through a special semaphore. Hardware control of the bus also makes it
> necessary to disable runtime pm to avoid interfering with hardware transactions.

Is this because we need to access the PMIC from host as well? I mean
from some PMIC driver (which driver btw)?

Otherwise it would be best to just detect _SEM and return -ENODEV.

> 
> Signed-off-by: David E. Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig                  |  10 +++
>  drivers/i2c/busses/Makefile                 |   1 +
>  drivers/i2c/busses/i2c-designware-core.h    |  14 ++++
>  drivers/i2c/busses/i2c-designware-platdrv.c |  78 +++++++++++++++++++--
>  drivers/i2c/busses/i2c-shared-controller.c  | 101 ++++++++++++++++++++++++++++
>  5 files changed, 200 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-shared-controller.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 2ac87fa..672ef23 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -441,6 +441,16 @@ config I2C_DESIGNWARE_PCI
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-designware-pci.
>  
> +config I2C_SHARED_CONTROLLER
> +	tristate "Intel Baytrail PMIC shared I2C bus support"
> +	depends on ACPI
> +	select IOSF_MBI
> +	select I2C_DESIGNWARE_CORE
> +	help
> +	  This driver enables shared access to the PMIC I2C bus on select Intel
> +	  BayTrail platforms using the XPower AXP288 PMIC. This driver is
> +	  required for host access to the PMIC on these platforms.

Can't we detect this runtime in the i2c-designware-platdrv.c code so
that you look (in the ACPI part of the driver) for _SEM and in that case
change the xfer function behaviour a bit to return -EBUSY or whatever?

Without this horrible #ifdeffery.
