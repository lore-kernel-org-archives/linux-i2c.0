From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c-pxa2xx: return proper error code in
 ce4100_i2c_probe error paths
Date: Wed, 13 Jul 2011 22:32:04 +0100
Message-ID: <20110713213204.GE3369@freya.fluff.org>
References: <1310534439.6086.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1310534439.6086.1.camel@phoenix>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jul 13, 2011 at 01:20:39PM +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

thanks, will apply

> ---
>  drivers/i2c/busses/i2c-pxa-pci.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pxa-pci.c b/drivers/i2c/busses/i2c-pxa-pci.c
> index 6659d26..b73da6c 100644
> --- a/drivers/i2c/busses/i2c-pxa-pci.c
> +++ b/drivers/i2c/busses/i2c-pxa-pci.c
> @@ -109,12 +109,15 @@ static int __devinit ce4100_i2c_probe(struct pci_dev *dev,
>  		return -EINVAL;
>  	}
>  	sds = kzalloc(sizeof(*sds), GFP_KERNEL);
> -	if (!sds)
> +	if (!sds) {
> +		ret = -ENOMEM;
>  		goto err_mem;
> +	}
>  
>  	for (i = 0; i < ARRAY_SIZE(sds->pdev); i++) {
>  		sds->pdev[i] = add_i2c_device(dev, i);
>  		if (IS_ERR(sds->pdev[i])) {
> +			ret = PTR_ERR(sds->pdev[i]);
>  			while (--i >= 0)
>  				platform_device_unregister(sds->pdev[i]);
>  			goto err_dev_add;
> -- 
> 1.7.4.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
