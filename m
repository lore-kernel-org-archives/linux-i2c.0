From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: reorganize muxes to a standard pattern
Date: Sun, 27 Nov 2011 21:48:47 +0100
Message-ID: <20111127214847.547542fb@endymion.delvare>
References: <1321220474-11378-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1321220474-11378-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Sorry for the late reply.

On Sun, 13 Nov 2011 22:41:14 +0100, Wolfram Sang wrote:
> Analog to ca632f5 (spi: reorganize drivers), introduce a standard pattern
> for naming the muxes. This is done for the rest of the I2C subsystem already, so
> we stay in sync with that.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
> 
> Only build tested.
> 
>  drivers/i2c/muxes/Kconfig                          |    9 ---------
>  drivers/i2c/muxes/Makefile                         |    6 +++---
>  .../i2c/muxes/{gpio-i2cmux.c => i2c-mux-gpio.c}    |    0
>  drivers/i2c/muxes/{pca9541.c => i2c-mux-pca9541.c} |    0
>  drivers/i2c/muxes/{pca954x.c => i2c-mux-pca954x.c} |    0
>  5 files changed, 3 insertions(+), 12 deletions(-)
>  rename drivers/i2c/muxes/{gpio-i2cmux.c => i2c-mux-gpio.c} (100%)
>  rename drivers/i2c/muxes/{pca9541.c => i2c-mux-pca9541.c} (100%)
>  rename drivers/i2c/muxes/{pca954x.c => i2c-mux-pca954x.c} (100%)

You forgot to rename Documentation/i2c/muxes/gpio-i2cmux.

I thought the naming had been discussed before, but I can't find the
references, and to be honest the new names please me, so I have no
reason to decline your proposal. I would have appreciated an ack from
the driver authors (Cc'd) though. I'll apply your patch as soon as I
receive an updated version, unless I get an objection before then.

> 
> diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
> index 90b7a01..a112d9d 100644
> --- a/drivers/i2c/muxes/Kconfig
> +++ b/drivers/i2c/muxes/Kconfig
> @@ -14,9 +14,6 @@ config I2C_MUX_GPIO
>  	  I2C busses connected through a MUX, which is controlled
>  	  through GPIO pins.
>  
> -	  This driver can also be built as a module.  If so, the module
> -	  will be called gpio-i2cmux.
> -
>  config I2C_MUX_PCA9541
>  	tristate "NXP PCA9541 I2C Master Selector"
>  	depends on EXPERIMENTAL
> @@ -24,9 +21,6 @@ config I2C_MUX_PCA9541
>  	  If you say yes here you get support for the NXP PCA9541
>  	  I2C Master Selector.
>  
> -	  This driver can also be built as a module.  If so, the module
> -	  will be called pca9541.
> -
>  config I2C_MUX_PCA954x
>  	tristate "Philips PCA954x I2C Mux/switches"
>  	depends on EXPERIMENTAL
> @@ -34,7 +28,4 @@ config I2C_MUX_PCA954x
>  	  If you say yes here you get support for the Philips PCA954x
>  	  I2C mux/switch devices.
>  
> -	  This driver can also be built as a module.  If so, the module
> -	  will be called pca954x.
> -
>  endmenu
> diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
> index 4640436..5826249 100644
> --- a/drivers/i2c/muxes/Makefile
> +++ b/drivers/i2c/muxes/Makefile
> @@ -1,8 +1,8 @@
>  #
>  # Makefile for multiplexer I2C chip drivers.
>  
> -obj-$(CONFIG_I2C_MUX_GPIO)	+= gpio-i2cmux.o
> -obj-$(CONFIG_I2C_MUX_PCA9541)	+= pca9541.o
> -obj-$(CONFIG_I2C_MUX_PCA954x)	+= pca954x.o
> +obj-$(CONFIG_I2C_MUX_GPIO)	+= i2c-mux-gpio.o
> +obj-$(CONFIG_I2C_MUX_PCA9541)	+= i2c-mux-pca9541.o
> +obj-$(CONFIG_I2C_MUX_PCA954x)	+= i2c-mux-pca954x.o
>  
>  ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
> diff --git a/drivers/i2c/muxes/gpio-i2cmux.c b/drivers/i2c/muxes/i2c-mux-gpio.c
> similarity index 100%
> rename from drivers/i2c/muxes/gpio-i2cmux.c
> rename to drivers/i2c/muxes/i2c-mux-gpio.c
> diff --git a/drivers/i2c/muxes/pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
> similarity index 100%
> rename from drivers/i2c/muxes/pca9541.c
> rename to drivers/i2c/muxes/i2c-mux-pca9541.c
> diff --git a/drivers/i2c/muxes/pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
> similarity index 100%
> rename from drivers/i2c/muxes/pca954x.c
> rename to drivers/i2c/muxes/i2c-mux-pca954x.c


-- 
Jean Delvare
