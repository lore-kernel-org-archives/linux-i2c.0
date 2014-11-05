From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: at91: don't account as iowait
Date: Wed, 5 Nov 2014 11:55:22 +0100
Message-ID: <20141105105522.GW20550@ldesroches-Latitude-E6320>
References: <1415045776-6373-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415045776-6373-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Lindgren <simon-IfRblWqrl23QT0dZR+AlfA@public.gmane.org>, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 03, 2014 at 09:16:16PM +0100, Wolfram Sang wrote:
> iowait is for blkio [1]. I2C shouldn't use it.
> 
> [1] https://lkml.org/lkml/2014/11/3/317
> 
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Acked-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Thanks

> ---
>  drivers/i2c/busses/i2c-at91.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 917d54588d95..e05a672db3e5 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -434,7 +434,7 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
>  		}
>  	}
>  
> -	ret = wait_for_completion_io_timeout(&dev->cmd_complete,
> +	ret = wait_for_completion_timeout(&dev->cmd_complete,
>  					     dev->adapter.timeout);
>  	if (ret == 0) {
>  		dev_err(dev->dev, "controller timed out\n");
> -- 
> 2.1.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
