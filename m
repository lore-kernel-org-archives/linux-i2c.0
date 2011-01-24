From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: octeon: Make the timeout 1*HZ instead of 1 jiffy
Date: Mon, 24 Jan 2011 13:14:05 +0100
Message-ID: <20110124131405.4583a7af@endymion.delvare>
References: <1295870741-19970-1-git-send-email-walle@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1295870741-19970-1-git-send-email-walle-pDveNdigDaDu9UdzE1sIFA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bernhard Walle <walle-pDveNdigDaDu9UdzE1sIFA@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Bernhard,

On Mon, 24 Jan 2011 13:05:41 +0100, Bernhard Walle wrote:
> Since the timeout in the struct i2c_adapter use jiffies as unit and a
> timeout should be independent of CONFIG_HZ and most drivers that specify
> a timeout here use just HZ, change the i2c-octeon driver to use 1*HZ
> (which is a second), too.
> 
> Signed-off-by: Bernhard Walle <walle-pDveNdigDaDu9UdzE1sIFA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-octeon.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
> index 0fe1102..537a4ee 100644
> --- a/drivers/i2c/busses/i2c-octeon.c
> +++ b/drivers/i2c/busses/i2c-octeon.c
> @@ -460,7 +460,7 @@ static struct i2c_adapter octeon_i2c_ops = {
>  	.owner = THIS_MODULE,
>  	.name = "OCTEON adapter",
>  	.algo = &octeon_i2c_algo,
> -	.timeout = 2,
> +	.timeout = HZ,
>  };
>  
>  /**

This is a large timeout value, much larger than any value the
i2c-octeon driver was using today for any possible value of HZ.
Wouldn't it make more sense to set it to HZ / 50, which is 2 for HZ =
100, leaving the setting unchanged for this common case at least?

-- 
Jean Delvare
