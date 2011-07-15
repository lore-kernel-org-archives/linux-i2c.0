From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c/imx: remove init/exit hooks from platform data
Date: Fri, 15 Jul 2011 10:00:43 +0200
Message-ID: <20110715080043.GJ26347@pengutronix.de>
References: <1310659425-17499-1-git-send-email-shawn.guo@linaro.org>
 <1310659425-17499-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1310659425-17499-2-git-send-email-shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 15, 2011 at 12:03:44AM +0800, Shawn Guo wrote:
> The init/exit hooks in platform data are being used nowhere, so can
> be removed.
> 
> Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Can safely go via the i2c tree.

Acked-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>


> ---
>  arch/arm/plat-mxc/include/mach/i2c.h |    4 ----
>  drivers/i2c/busses/i2c-imx.c         |   21 +++------------------
>  2 files changed, 3 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/i2c.h b/arch/arm/plat-mxc/include/mach/i2c.h
> index 4a5dc5c..375cdd0 100644
> --- a/arch/arm/plat-mxc/include/mach/i2c.h
> +++ b/arch/arm/plat-mxc/include/mach/i2c.h
> @@ -11,14 +11,10 @@
>  
>  /**
>   * struct imxi2c_platform_data - structure of platform data for MXC I2C driver
> - * @init:	Initialise gpio's and other board specific things
> - * @exit:	Free everything initialised by @init
>   * @bitrate:	Bus speed measured in Hz
>   *
>   **/
>  struct imxi2c_platform_data {
> -	int (*init)(struct device *dev);
> -	void (*exit)(struct device *dev);
>  	int bitrate;
>  };
>  
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 4c2a62b..54d809e 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -466,7 +466,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  {
>  	struct imx_i2c_struct *i2c_imx;
>  	struct resource *res;
> -	struct imxi2c_platform_data *pdata;
> +	struct imxi2c_platform_data *pdata = pdev->dev.platform_data;
>  	void __iomem *base;
>  	resource_size_t res_size;
>  	int irq;
> @@ -485,19 +485,11 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  		return -ENOENT;
>  	}
>  
> -	pdata = pdev->dev.platform_data;
> -
> -	if (pdata && pdata->init) {
> -		ret = pdata->init(&pdev->dev);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	res_size = resource_size(res);
>  
>  	if (!request_mem_region(res->start, res_size, DRIVER_NAME)) {
> -		ret = -EBUSY;
> -		goto fail0;
> +		dev_err(&pdev->dev, "request_mem_region failed\n");
> +		return -EBUSY;
>  	}
>  
>  	base = ioremap(res->start, res_size);
> @@ -586,9 +578,6 @@ fail2:
>  	iounmap(base);
>  fail1:
>  	release_mem_region(res->start, resource_size(res));
> -fail0:
> -	if (pdata && pdata->exit)
> -		pdata->exit(&pdev->dev);
>  	return ret; /* Return error number */
>  }
>  
> @@ -611,10 +600,6 @@ static int __exit i2c_imx_remove(struct platform_device *pdev)
>  	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
>  	writeb(0, i2c_imx->base + IMX_I2C_I2SR);
>  
> -	/* Shut down hardware */
> -	if (pdata && pdata->exit)
> -		pdata->exit(&pdev->dev);
> -
>  	clk_put(i2c_imx->clk);
>  
>  	iounmap(i2c_imx->base);
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
