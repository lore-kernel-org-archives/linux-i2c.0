From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH V2] i2c/busses: move two drivers to embedded section
Date: Tue, 1 Jun 2010 13:06:07 +0200
Message-ID: <20100601130607.1851a857@hyperion.delvare>
References: <20100601091855.42fbc9b3@hyperion.delvare>
	<1275380819-26709-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1275380819-26709-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue,  1 Jun 2010 10:26:59 +0200, Wolfram Sang wrote:
> And fix a typo while we are here
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
> 
> changes since v1:
> 
> also move the drivers in Kconfig
> 
>  drivers/i2c/busses/Kconfig  |   40 ++++++++++++++++++++--------------------
>  drivers/i2c/busses/Makefile |    6 +++---
>  2 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 87ab056..bceafbf 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -475,6 +475,26 @@ config I2C_PASEMI
>  	help
>  	  Supports the PA Semi PWRficient on-chip SMBus interfaces.
>  
> +config I2C_PCA_PLATFORM
> +	tristate "PCA9564/PCA9665 as platform device"
> +	select I2C_ALGOPCA
> +	default n
> +	help
> +	  This driver supports a memory mapped Philips PCA9564/PCA9665
> +	  parallel bus to I2C bus controller.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-pca-platform.
> +
> +config I2C_PMCMSP
> +	tristate "PMC MSP I2C TWI Controller"
> +	depends on PMC_MSP
> +	help
> +	  This driver supports the PMC TWI controller on MSP devices.
> +
> +	  This driver can also be built as module. If so, the module
> +	  will be called i2c-pmcmsp.
> +
>  config I2C_PNX
>  	tristate "I2C bus support for Philips PNX targets"
>  	depends on ARCH_PNX4008
> @@ -711,26 +731,6 @@ config I2C_PCA_ISA
>  	  delays when I2C/SMBus chip drivers are loaded (e.g. at boot
>  	  time).  If unsure, say N.
>  
> -config I2C_PCA_PLATFORM
> -	tristate "PCA9564/PCA9665 as platform device"
> -	select I2C_ALGOPCA
> -	default n
> -	help
> -	  This driver supports a memory mapped Philips PCA9564/PCA9665
> -	  parallel bus to I2C bus controller.
> -
> -	  This driver can also be built as a module.  If so, the module
> -	  will be called i2c-pca-platform.
> -
> -config I2C_PMCMSP
> -	tristate "PMC MSP I2C TWI Controller"
> -	depends on PMC_MSP
> -	help
> -	  This driver supports the PMC TWI controller on MSP devices.
> -
> -	  This driver can also be built as module. If so, the module
> -	  will be called i2c-pmcmsp.
> -
>  config I2C_SIBYTE
>  	tristate "SiByte SMBus interface"
>  	depends on SIBYTE_SB1xxx_SOC
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 097236f..936880b 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -27,7 +27,7 @@ obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
>  obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
>  obj-$(CONFIG_I2C_POWERMAC)	+= i2c-powermac.o
>  
> -# Embebbed system I2C/SMBus host controller drivers
> +# Embedded system I2C/SMBus host controller drivers
>  obj-$(CONFIG_I2C_AT91)		+= i2c-at91.o
>  obj-$(CONFIG_I2C_AU1550)	+= i2c-au1550.o
>  obj-$(CONFIG_I2C_BLACKFIN_TWI)	+= i2c-bfin-twi.o
> @@ -46,6 +46,8 @@ obj-$(CONFIG_I2C_NOMADIK)	+= i2c-nomadik.o
>  obj-$(CONFIG_I2C_OCORES)	+= i2c-ocores.o
>  obj-$(CONFIG_I2C_OMAP)		+= i2c-omap.o
>  obj-$(CONFIG_I2C_PASEMI)	+= i2c-pasemi.o
> +obj-$(CONFIG_I2C_PCA_PLATFORM)	+= i2c-pca-platform.o
> +obj-$(CONFIG_I2C_PMCMSP)	+= i2c-pmcmsp.o
>  obj-$(CONFIG_I2C_PNX)		+= i2c-pnx.o
>  obj-$(CONFIG_I2C_PXA)		+= i2c-pxa.o
>  obj-$(CONFIG_I2C_S3C2410)	+= i2c-s3c2410.o
> @@ -68,8 +70,6 @@ obj-$(CONFIG_I2C_TINY_USB)	+= i2c-tiny-usb.o
>  obj-$(CONFIG_I2C_ACORN)		+= i2c-acorn.o
>  obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
>  obj-$(CONFIG_I2C_PCA_ISA)	+= i2c-pca-isa.o
> -obj-$(CONFIG_I2C_PCA_PLATFORM)	+= i2c-pca-platform.o
> -obj-$(CONFIG_I2C_PMCMSP)	+= i2c-pmcmsp.o
>  obj-$(CONFIG_I2C_SIBYTE)	+= i2c-sibyte.o
>  obj-$(CONFIG_I2C_STUB)		+= i2c-stub.o
>  obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o

Applied, thanks.

-- 
Jean Delvare
