From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] at91: dt: i2c: add a new compatibility string for the
 at91sam9261
Date: Wed, 15 Jan 2014 11:59:24 +0100
Message-ID: <52D66A0C.4090509@atmel.com>
References: <1389781467-29626-1-git-send-email-jjhiblot@traphandler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389781467-29626-1-git-send-email-jjhiblot-dLKeG7h1OhBDOHtkgc7UlQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Jacques Hiblot <jjhiblot-dLKeG7h1OhBDOHtkgc7UlQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: b.brezillon-ZNYIgs0QAGpBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "'linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 15/01/2014 11:24, Jean-Jacques Hiblot :
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot-dLKeG7h1OhBDOHtkgc7UlQ@public.gmane.org>

Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Thanks Jean-Jacques.

Side note: do not forget i2c maintainer and ml.

> ---
>  drivers/i2c/busses/i2c-at91.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 8edba9d..843d012 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -589,6 +589,9 @@ static const struct of_device_id atmel_twi_dt_ids[] = {
>  		.compatible = "atmel,at91sam9260-i2c",
>  		.data = &at91sam9260_config,
>  	} , {
> +		.compatible = "atmel,at91sam9261-i2c",
> +		.data = &at91sam9261_config,
> +	} , {
>  		.compatible = "atmel,at91sam9g20-i2c",
>  		.data = &at91sam9g20_config,
>  	} , {
> 


-- 
Nicolas Ferre
