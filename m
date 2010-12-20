From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] I2C: Add support for 64bit system.
Date: Mon, 20 Dec 2010 14:59:54 +0000
Message-ID: <20101220145954.GA1126@trinity.fluff.org>
References: <1292830654-7056-1-git-send-email-B33228@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1292830654-7056-1-git-send-email-B33228-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Xulei <B33228-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 20, 2010 at 03:37:34PM +0800, Xulei wrote:
> Currently I2C_MPC supports 32bit system only, then this
> modification makes it support 32bit and 64bit system both.
> 
> Signed-off-by: Xulei <B33228-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

This been build or run tested?

> ---
>  drivers/i2c/busses/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 9c6170c..3392f4b 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -422,7 +422,7 @@ config I2C_IXP2000
>  
>  config I2C_MPC
>  	tristate "MPC107/824x/85xx/512x/52xx/83xx/86xx"
> -	depends on PPC32
> +	depends on PPC32 || PPC64
>  	help
>  	  If you say yes to this option, support will be included for the
>  	  built-in I2C interface on the MPC107, Tsi107, MPC512x, MPC52xx,
> -- 
> 1.7.0.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
