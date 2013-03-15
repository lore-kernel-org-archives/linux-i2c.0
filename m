From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] MAINTAINERS: add maintainer entry for atmel i2c driver
Date: Fri, 15 Mar 2013 17:07:18 +0100
Message-ID: <51434736.5020004@atmel.com>
References: <1363361577-7770-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1363361577-7770-1-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 03/15/2013 04:32 PM, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org :
> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> 
> Create an entry for atmel i2c driver: i2c-at91.c
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

> ---
> Hello,
> 
> If there are no objections, I'll take the maintenance of the at91 i2c driver
> since there is no maintainer.

Sure, no objection ;-)
Good luck!

> Wolfram, can you take this patch or do I have to ask someone else?
> 
> Regards
> 
> Ludovic
> 
> 
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9561658..d667ecc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1467,6 +1467,12 @@ F:	drivers/dma/at_hdmac.c
>  F:	drivers/dma/at_hdmac_regs.h
>  F:	include/linux/platform_data/dma-atmel.h
>  
> +ATMEL I2C DRIVER
> +M:	Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> +L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +S:	Supported
> +F:	drivers/i2c/busses/i2c-at91.c
> +
>  ATMEL ISI DRIVER
>  M:	Josh Wu <josh.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>  L:	linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> 


-- 
Nicolas Ferre
