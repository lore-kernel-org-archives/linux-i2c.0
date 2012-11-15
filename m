From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: at91: fix compilation warning
Date: Thu, 15 Nov 2012 18:16:37 +0100
Message-ID: <50A52375.4070304@atmel.com>
References: <1352911493-6979-1-git-send-email-ludovic.desroches@atmel.com> <1352911493-6979-2-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352911493-6979-2-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 11/14/2012 05:44 PM, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org :
> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Maybe tell Wolfram to remove this one from the series and add it to his
3.7 tree...

Bye,

> ---
>  drivers/i2c/busses/i2c-at91.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index a6670eb..dc8cb22 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -412,7 +412,7 @@ static struct at91_twi_pdata * __devinit at91_twi_get_driver_data(
>  		match = of_match_node(atmel_twi_dt_ids, pdev->dev.of_node);
>  		if (!match)
>  			return NULL;
> -		return match->data;
> +		return (struct at91_twi_pdata *) match->data;
>  	}
>  	return (struct at91_twi_pdata *) platform_get_device_id(pdev)->driver_data;
>  }
> 


-- 
Nicolas Ferre
