From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] i2c: imx: use of_alias_get_id to order i2c devices
Date: Fri, 12 Apr 2013 09:49:39 +0800
Message-ID: <20130412014937.GB16970@S2101-09.ap.freescale.net>
References: <1365527379-17786-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1365527379-17786-1-git-send-email-p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 09, 2013 at 07:09:39PM +0200, Philipp Zabel wrote:
> This allows to order i2c character devices as they are numbered
> in the reference manual, instead of ordering them by register
> base address.
> 
> Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

I'm fine with the patch, but let's see if DT maintainers have an
opinion.

Shawn

> ---
>  drivers/i2c/busses/i2c-imx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 82f20c6..e5a3f08 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -488,6 +488,7 @@ static struct i2c_algorithm i2c_imx_algo = {
>  
>  static int __init i2c_imx_probe(struct platform_device *pdev)
>  {
> +	struct device_node *np = pdev->dev.of_node;
>  	const struct of_device_id *of_id = of_match_device(i2c_imx_dt_ids,
>  							   &pdev->dev);
>  	struct imx_i2c_struct *i2c_imx;
> @@ -531,7 +532,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  	i2c_imx->adapter.owner		= THIS_MODULE;
>  	i2c_imx->adapter.algo		= &i2c_imx_algo;
>  	i2c_imx->adapter.dev.parent	= &pdev->dev;
> -	i2c_imx->adapter.nr 		= pdev->id;
> +	i2c_imx->adapter.nr		= (pdev->id < 0) ? of_alias_get_id(np, "i2c") : pdev->id;
>  	i2c_imx->adapter.dev.of_node	= pdev->dev.of_node;
>  	i2c_imx->base			= base;
>  
> -- 
> 1.8.2.rc2
> 
