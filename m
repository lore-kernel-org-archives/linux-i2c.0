From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/5] I2C driver for MXC
Date: Fri, 3 Apr 2009 14:35:24 +0200
Message-ID: <20090403123524.GU23731@pengutronix.de>
References: <49C89E13.7040801@gmail.com> <200904011358.21191.hs4233@mail.mn-solutions.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200904011358.21191.hs4233-x6+DxXLjN1AJvtFkdXX2Hg4jNU5vUVPG@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Holger Schurig <hs4233-x6+DxXLjN1AJvtFkdXX2Hg4jNU5vUVPG@public.gmane.org>
Cc: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 01, 2009 at 01:58:21PM +0200, Holger Schurig wrote:
> [PATCH] imx21: activate i2c
> 
> Set the correct clkdev-name for the i2c clock.
> 
> It also get's rid of the ARCH_NR_GPIOS define on the rationale
> that isn't an ARCH-wide setting anyway. If a device has two
> pca953x devices, the reserved number will be wrong.
> 
> Signed-off-by: Holger Schurig <hs4233-x6+DxXLjN1AJvtFkdXX2Hg4jNU5vUVPG@public.gmane.org>

Scheduled for -rc

Sascha

> 
> ---
> 
> This patch applies on top Darius' patch "[PATCH 1/5] I2C driver for MXC" from
> 24th march.
> 
> --- linux.orig/arch/arm/plat-mxc/include/mach/mx21.h
> +++ linux/arch/arm/plat-mxc/include/mach/mx21.h
> @@ -54,9 +54,6 @@
>  
>  #define IRAM_BASE_ADDR          0xFFFFE800	/* internal ram */
>  
> -/* this CPU supports up to 192 GPIOs (don't forget the baseboard!) */
> -#define ARCH_NR_GPIOS		(6*32 + 16)
> -
>  /* fixed interrupt numbers */
>  #define MXC_INT_USBCTRL         58
>  #define MXC_INT_USBCTRL         58
> --- linux.orig/arch/arm/mach-mx2/clock_imx21.c
> +++ linux/arch/arm/mach-mx2/clock_imx21.c
> @@ -931,7 +931,7 @@
>  	_REGISTER_CLOCK(NULL, "slcdc", slcdc_clk[0])
>  	_REGISTER_CLOCK("imx-wdt.0", NULL, wdog_clk)
>  	_REGISTER_CLOCK(NULL, "gpio", gpio_clk)
> -	_REGISTER_CLOCK(NULL, "i2c", i2c_clk)
> +	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
>  	_REGISTER_CLOCK("mxc-keypad", NULL, kpp_clk)
>  	_REGISTER_CLOCK(NULL, "owire", owire_clk)
>  	_REGISTER_CLOCK(NULL, "rtc", rtc_clk)
> 
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
