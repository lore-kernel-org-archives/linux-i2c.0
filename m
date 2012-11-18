From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: Kconfig: Allow I2C_MXS to be selected by MX23
Date: Sun, 18 Nov 2012 06:23:28 +0100
Message-ID: <201211180623.29126.marex@denx.de>
References: <1353181734-13253-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1353181734-13253-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, f.koliqi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Fabio Estevam,

> From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> 
> With the recent DMA support addition to the i2c-mxs driver, it is now
> possible to also run it on mx23, so update the Kconfig entry accordingly.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index e9df461..34f48f3 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -482,12 +482,12 @@ config I2C_MV64XXX
>  	  will be called i2c-mv64xxx.
> 
>  config I2C_MXS
> -	tristate "Freescale i.MX28 I2C interface"
> -	depends on SOC_IMX28
> +	tristate "Freescale MXS I2C interface"
> +	depends on ARCH_MXS
>  	select STMP_DEVICE
>  	help
>  	  Say Y here if you want to use the I2C bus controller on
> -	  the Freescale i.MX28 processors.
> +	  the Freescale MXS processors.
> 
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-mxs.

Won't i.MX23/i.MX28 instead of MXS be less confusing? Either way:

Acked-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Best regards,
Marek Vasut
