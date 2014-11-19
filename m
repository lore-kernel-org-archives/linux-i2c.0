From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c: img-scb: Allow building for MIPS
Date: Wed, 19 Nov 2014 00:03:08 +0000
Message-ID: <20141119000308.GL1739@jhogan-linux.le.imgtec.org>
References: <1416355113-8942-1-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416355113-8942-1-git-send-email-abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 18, 2014 at 03:58:33PM -0800, Andrew Bresticker wrote:
> The SCB is present on IMG SoCs other than the META-based TZ1090,
> such as the MIPS-based Pistachio SoC.  Relax the Kconfig dependency
> so that it can be built on any MIPS or META machine.
> 
> Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Looks good to me.

Acked-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

Cheers
James

> ---
> Based on i2c/for-next
> ---
>  drivers/i2c/busses/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 03c6119..16c649a 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -526,10 +526,10 @@ config I2C_IBM_IIC
>  
>  config I2C_IMG
>  	tristate "Imagination Technologies I2C SCB Controller"
> -	depends on SOC_TZ1090 || COMPILE_TEST
> +	depends on MIPS || METAG || COMPILE_TEST
>  	help
>  	  Say Y here if you want to use the IMG I2C SCB controller,
> -	  available on the TZ1090 SoC.
> +	  available on the TZ1090 and other IMG SoCs.
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-img-scb.
> -- 
> 2.1.0.rc2.206.gedb03e5
> 
