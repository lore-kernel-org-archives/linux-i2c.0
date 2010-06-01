From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c/busses/Makefile: move two drivers to the embedded
 section
Date: Tue, 1 Jun 2010 09:18:55 +0200
Message-ID: <20100601091855.42fbc9b3@hyperion.delvare>
References: <1275013128-12470-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1275013128-12470-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Fri, 28 May 2010 04:18:48 +0200, Wolfram Sang wrote:
> And fix a typo while we are here.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
> 
> I moved the drivers before I checked how many of the embedded drivers do
> subsys_initcall() and how many don't (13 vs 19 BTW); and to check if it makes
> sense to mass-convert the latter. However, I still feel that such a change
> should better be done per driver if there is somebody needing it and willing to
> test, so this patch is the only outcome of my investigation :)
> 
>  drivers/i2c/busses/Makefile |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
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

If you move them in Makefile, you have to move them in Kconfig as well,
otherwise it gets confusing.

-- 
Jean Delvare
