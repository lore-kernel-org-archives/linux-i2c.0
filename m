From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/2] MAX8997/8966 MFD Driver Initial Release
 (PMIC+RTC+MUIC+Haptic+...)
Date: Mon, 31 Jan 2011 00:19:15 +0100
Message-ID: <20110130231914.GB2565@sortiz-mobl>
References: <1294988018-25100-1-git-send-email-myungjoo.ham@samsung.com>
 <1294988018-25100-2-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1294988018-25100-2-git-send-email-myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, myungjoo.ham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On Fri, Jan 14, 2011 at 03:53:37PM +0900, MyungJoo Ham wrote:
> MAX8997/MAX8966 chip is a multi-function device with I2C bussses. The
> chip includes PMIC, RTC, Fuel Gauge, MUIC, Haptic, Flash control, and
> Battery (charging) control.
> 
> This patch is an initial release of a MAX8997/8966 driver that supports
> to enable the chip with its primary I2C bus that connects every device
> mentioned above except for Fuel Gauge, which uses another I2C bus. The
> fuel gauge is not supported by this mfd driver and is supported by a
> seperated driver of MAX17042 Fuel Gauge (yes, the fuel gauge part is
> compatible with MAX17042).
The patch looks good, I just have one comment:

 
> Signed-off-by: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/mfd/Kconfig                 |   12 ++
>  drivers/mfd/Makefile                |    1 +
>  drivers/mfd/max8997.c               |  211 +++++++++++++++++++++++++++++++
>  include/linux/mfd/max8997-private.h |  238 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max8997.h         |   88 +++++++++++++
>  5 files changed, 550 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mfd/max8997.c
>  create mode 100644 include/linux/mfd/max8997-private.h
>  create mode 100644 include/linux/mfd/max8997.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index da9d297..486bf38 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -293,6 +293,18 @@ config MFD_MAX8925
>  	  accessing the device, additional drivers must be enabled in order
>  	  to use the functionality of the device.
>  
> +config MFD_MAX8997
> +	bool "Maxim Semiconductor MAX8997/8966 PMIC Support"
> +	depends on I2C=y && GENERIC_HARDIRQS
> +	select MFD_CORE
> +	help
> +	  Say yes here to support for Maxim Semiconductor MAX8998/8966.
> +	  This is a Power Management IC with RTC, Flash, Fuel Gauge, Haptic,
> +	  MUIC controls on chip.
> +	  This driver provies common support for accessing the device,
> +	  additional drivers must be enabled in order to use the functionality
> +	  of the device.
> +
>  config MFD_MAX8998
>  	bool "Maxim Semiconductor MAX8998/National LP3974 PMIC Support"
>  	depends on I2C=y && GENERIC_HARDIRQS
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 848e7ea..0356b85 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -60,6 +60,7 @@ obj-$(CONFIG_UCB1400_CORE)	+= ucb1400_core.o
>  obj-$(CONFIG_PMIC_DA903X)	+= da903x.o
>  max8925-objs			:= max8925-core.o max8925-i2c.o
>  obj-$(CONFIG_MFD_MAX8925)	+= max8925.o
> +obj-$(CONFIG_MFD_MAX8997)	+= max8997.o
>  obj-$(CONFIG_MFD_MAX8998)	+= max8998.o max8998-irq.o
>  
>  pcf50633-objs			:= pcf50633-core.o pcf50633-irq.o
> diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
> new file mode 100644
> index 0000000..ac70501
> --- /dev/null
> +++ b/drivers/mfd/max8997.c
> @@ -0,0 +1,211 @@
> +/*
> + * max8997.c - mfd core driver for the Maxim 8966 and 8997
> + *
> + * Copyright (C) 2011 Samsung Electronics
> + * MyungJoo Ham <myungjoo.ham-T5JinQjy6aBBDgjK7y7TUQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + *
> + * This driver is based on max8998.c
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/max8997.h>
> +#include <linux/mfd/max8997-private.h>
> +
> +#define I2C_ADDR_PMIC	(0xCC >> 1)
> +#define I2C_ADDR_MUIC	(0x4A >> 1)
> +#define I2C_ADDR_BATTERY	(0x6C >> 1)
> +#define I2C_ADDR_RTC	(0x0C >> 1)
> +#define I2C_ADDR_HAPTIC	(0x90 >> 1)
> +
> +static struct mfd_cell max8997_devs[] = {
> +#ifdef CONFIG_REGULATOR_MAX8997
I think you can get rid of all the ifdefs below.
If the driver is not selected, you'll be safe anyway.


Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
