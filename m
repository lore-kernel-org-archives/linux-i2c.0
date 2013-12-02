From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] ARM: at91: sama5d3: reduce TWI internal clock frequency
Date: Mon, 2 Dec 2013 09:42:11 +0100
Message-ID: <529C47E3.2010508@atmel.com>
References: <1385136523-11962-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385136523-11962-1-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 22/11/2013 17:08, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org :
> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>
> With some devices, transfer hangs during I2C frame transmission. This issue
> disappears when reducing the internal frequency of the TWI IP. Even if it is
> indicated that internal clock max frequency is 66MHz, it seems we have
> oversampling on I2C signals making TWI believe that a transfer in progress
> is done.
>
> This fix has no impact on the I2C bus frequency.
>
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> #3.10+
> Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

added to at91-3.14-dt branch.

thanks,


> ---
>
> v2: update commit message
>
>   arch/arm/mach-at91/sama5d3.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-at91/sama5d3.c b/arch/arm/mach-at91/sama5d3.c
> index 4012797..4ee0de5 100644
> --- a/arch/arm/mach-at91/sama5d3.c
> +++ b/arch/arm/mach-at91/sama5d3.c
> @@ -95,19 +95,19 @@ static struct clk twi0_clk = {
>   	.name		= "twi0_clk",
>   	.pid		= SAMA5D3_ID_TWI0,
>   	.type		= CLK_TYPE_PERIPHERAL,
> -	.div		= AT91_PMC_PCR_DIV2,
> +	.div		= AT91_PMC_PCR_DIV8,
>   };
>   static struct clk twi1_clk = {
>   	.name		= "twi1_clk",
>   	.pid		= SAMA5D3_ID_TWI1,
>   	.type		= CLK_TYPE_PERIPHERAL,
> -	.div		= AT91_PMC_PCR_DIV2,
> +	.div		= AT91_PMC_PCR_DIV8,
>   };
>   static struct clk twi2_clk = {
>   	.name		= "twi2_clk",
>   	.pid		= SAMA5D3_ID_TWI2,
>   	.type		= CLK_TYPE_PERIPHERAL,
> -	.div		= AT91_PMC_PCR_DIV2,
> +	.div		= AT91_PMC_PCR_DIV8,
>   };
>   static struct clk mmc0_clk = {
>   	.name		= "mci0_clk",
>


-- 
Nicolas Ferre
