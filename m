From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: imx: Use dev_info to indicate that i2c driver
 was succesfully registered
Date: Fri, 3 Aug 2012 16:25:25 +0200
Message-ID: <20120803142525.GX1451@pengutronix.de>
References: <1343853495-23479-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1343853495-23479-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Aug 01, 2012 at 05:38:14PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> 
> It is useful information in dmesg to have a message indicating that the i2c
> driver was succesfully registered, so promote it to dev_info.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Both:

Acked-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Sascha

> ---
>  drivers/i2c/busses/i2c-imx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 0722f86..e143629 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -564,7 +564,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  		resource_size(res), res->start);
>  	dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n",
>  		i2c_imx->adapter.name);
> -	dev_dbg(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
> +	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
>  
>  	return 0;   /* Return OK */
>  }
> -- 
> 1.7.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
