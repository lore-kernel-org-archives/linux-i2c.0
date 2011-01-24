From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: octeon: Make the timeout independent of CONFIG_HZ
Date: Mon, 24 Jan 2011 15:00:05 +0100
Message-ID: <20110124150005.577b0235@endymion.delvare>
References: <4D3D7290.9050203@corscience.de>
	<1295872826-22129-1-git-send-email-walle@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1295872826-22129-1-git-send-email-walle-pDveNdigDaDu9UdzE1sIFA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bernhard Walle <walle-pDveNdigDaDu9UdzE1sIFA@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 24 Jan 2011 13:40:26 +0100, Bernhard Walle wrote:
> Since the timeout in the struct i2c_adapter use jiffies as unit and a
> timeout should be independent of CONFIG_HZ, use a value of HZ/50 which
> is equal to the current value 2 for CONFIG_HZ=100.
> 
> Signed-off-by: Bernhard Walle <walle-pDveNdigDaDu9UdzE1sIFA@public.gmane.org>

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

Ben, please apply.

> ---
>  drivers/i2c/busses/i2c-octeon.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
> index 4cffda5..d07e5c7 100644
> --- a/drivers/i2c/busses/i2c-octeon.c
> +++ b/drivers/i2c/busses/i2c-octeon.c
> @@ -469,7 +469,7 @@ static struct i2c_adapter octeon_i2c_ops = {
>  	.owner = THIS_MODULE,
>  	.name = "OCTEON adapter",
>  	.algo = &octeon_i2c_algo,
> -	.timeout = 2,
> +	.timeout = HZ/50,
>  };
>  
>  /**


-- 
Jean Delvare
