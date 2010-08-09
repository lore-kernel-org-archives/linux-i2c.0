From: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [CORRECTED] I2C driver supporting Moorestown and Medfield platform
Date: Mon, 09 Aug 2010 14:52:44 +0900
Message-ID: <4C5F97AC.1020509@renesas.com>
References: <20100803143431.23655.31975.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100803143431.23655.31975.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 8/3/2010 11:34 PM, Alan Cox wrote:
> (And the correct patch attached this time)
> 
> From: Wen Wang <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> Initial release of the driver. Updated and verified on hardware.
> 
> Cleaned up as follows
> 
> Alan Cox:
>    Squash down the switches into tables, and use the PCI ident field. We
>    could perhaps take this further and put the platform and port number into
>    this.
>    uint32t -> u32
>    bracketing of case statements
>    spacing and '!' usage
>    Check the speed (which is now 0/1/2) is valid and ignore otherwise.
> 
> Arjan van de Ven:
>    Initial power management hooks
> 
> 
> Signed-off-by: Wen Wang <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Arjan van de Ven <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
> 
>  drivers/i2c/busses/Kconfig    |    9 
>  drivers/i2c/busses/Makefile   |    1 
>  drivers/i2c/busses/i2c-mrst.c | 1082 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1092 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-mrst.c
> 
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 15a9702..46b9acb 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -420,6 +420,15 @@ config I2C_IXP2000
>  	  This driver is deprecated and will be dropped soon. Use i2c-gpio
>  	  instead.
>  
> +config I2C_MRST
> +	tristate "Intel Moorestown/Medfield Platform I2C controller"
> +	help
> +	  Say Y here if you have an Intel Moorestown/Medfield platform I2C
> +	  controller.
> +
> +	  This support is also available as a module. If so, the module
> +	  will be called i2c-mrst.
> +
>  config I2C_MPC
>  	tristate "MPC107/824x/85xx/512x/52xx/83xx/86xx"
>  	depends on PPC32

I'm not sure how commonly used MRST mnemonic is in the Intel's
hardware/software resources, but IMO, MRST is not easy to imagine
that it represents "Moorstone".  But this is not such a big deal.

> diff --git a/drivers/i2c/busses/i2c-mrst.c b/drivers/i2c/busses/i2c-mrst.c
> new file mode 100644
> index 0000000..79f45fb
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-mrst.c
> @@ -0,0 +1,1082 @@
> +/*
> + * Support for Moorestown/Medfield I2C chip
> + *
> + * Copyright (c) 2009 Intel Corporation.
> + * Copyright (c) 2009 Synopsys. Inc.

Having a quick glance of the patch, the driver is similar to the
existing I2C_DESIGNWARE driver.  Presumably Intel people have already
checkekd the i2c-designware.c and made a decision that it would be
reasonable to create a new I2C driver to incorporate its requirements
(such as PCI resource handlings, power management code, etc.), rather
than to extend the existing one.  Is my understanding correct?

I'm not objecting to the patch, but would like to know the background
of this driver, as one of the DW users.
-- 
Shinya Kuribayashi
Renesas Electronics
