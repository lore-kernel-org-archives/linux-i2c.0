From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V2] i2c: imx: make bitrate an u32 type
Date: Tue, 10 Jul 2012 10:42:39 +0200
Message-ID: <20120710084239.GZ30009@pengutronix.de>
References: <1341872910-26687-1-git-send-email-wolfram@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1341872910-26687-1-git-send-email-wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 10, 2012 at 12:28:30AM +0200, Wolfram Sang wrote:
> sparse found this assignment of u32 to an int. Fix it:
> 
> drivers/i2c/busses/i2c-imx.c:540:56: warning: incorrect type in argument 3 (different signedness)
> 
> and also fix the type in platform_data. All current users use values
> which fit into the old and new type, so it is a safe change.
> 
> Signed-off-by: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Acked-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Sascha

> ---
> 
> Changes since V1: also change type in platform_data. Thanks to Richard.
> 
>  arch/arm/plat-mxc/include/mach/i2c.h |    2 +-
>  drivers/i2c/busses/i2c-imx.c         |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/i2c.h b/arch/arm/plat-mxc/include/mach/i2c.h
> index 375cdd0..8289d91 100644
> --- a/arch/arm/plat-mxc/include/mach/i2c.h
> +++ b/arch/arm/plat-mxc/include/mach/i2c.h
> @@ -15,7 +15,7 @@
>   *
>   **/
>  struct imxi2c_platform_data {
> -	int bitrate;
> +	u32 bitrate;
>  };
>  
>  #endif /* __ASM_ARCH_I2C_H_ */
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index dd2a083..90460dd 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -471,8 +471,8 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  	struct imxi2c_platform_data *pdata = pdev->dev.platform_data;
>  	struct pinctrl *pinctrl;
>  	void __iomem *base;
> -	int irq, bitrate;
> -	int ret;
> +	int irq, ret;
> +	u32 bitrate;
>  
>  	dev_dbg(&pdev->dev, "<%s>\n", __func__);
>  
> -- 
> 1.7.10.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
