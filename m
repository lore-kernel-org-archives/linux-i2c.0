From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] ARM: PNX4008: i2c-pnx: use the same dev_id for
 request_irq and free_irq
Date: Sat, 21 Nov 2009 16:16:19 +0000
Message-ID: <20091121161619.GO13398@fluff.org.uk>
References: <E1NBsaT-0007az-Aa@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1NBsaT-0007az-Aa-eh5Bv4kxaXIANfyc6IWni62ZND6+EDdj@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Nov 21, 2009 at 04:13:25PM +0000, Russell King - ARM Linux wrote:
> This allows i2c-pnx to free its interrupt handler when the module
> is removed or if an error occurs; using the same dev_id for both
> request_irq and free_irq is desirable.
> 
> Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>

If you want to merge this via your current pnx work, then have my ack
to this, otherwise let me know and i'll add it to i2c-fixes.

Acked-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-pnx.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
> index 1fca590..fbab684 100644
> --- a/drivers/i2c/busses/i2c-pnx.c
> +++ b/drivers/i2c/busses/i2c-pnx.c
> @@ -650,7 +650,7 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
>  	return 0;
>  
>  out_irq:
> -	free_irq(alg_data->irq, alg_data);
> +	free_irq(alg_data->irq, i2c_pnx->adapter);
>  out_clock:
>  	i2c_pnx->set_clock_stop(pdev);
>  out_unmap:
> @@ -669,7 +669,7 @@ static int __devexit i2c_pnx_remove(struct platform_device *pdev)
>  	struct i2c_adapter *adap = i2c_pnx->adapter;
>  	struct i2c_pnx_algo_data *alg_data = adap->algo_data;
>  
> -	free_irq(alg_data->irq, alg_data);
> +	free_irq(alg_data->irq, i2c_pnx->adapter);
>  	i2c_del_adapter(adap);
>  	i2c_pnx->set_clock_stop(pdev);
>  	iounmap((void *)alg_data->ioaddr);
> -- 
> 1.6.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
