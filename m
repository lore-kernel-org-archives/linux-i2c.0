From: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: [PATCH 07/59] i2c/i2c-pxa: Fix possible NULL pointer dereference
Date: Mon, 25 Feb 2013 10:44:10 +0200
Message-ID: <512B245A.1020703@compulab.co.il>
References: <1361745852-28629-1-git-send-email-s.syam@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1361745852-28629-1-git-send-email-s.syam-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Syam Sidhardhan <syamsidhardh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 02/25/13 00:44, Syam Sidhardhan wrote:
> When platform_get_resource() returns NULL, there is a possible
> NULL pointer dereference in release_mem_region(). Rearrange the
> goto lables appropriately.
> 
> Signed-off-by: Syam Sidhardhan <s.syam-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

I think this has been already addressed in [1],
but I don't know if it was applied already...

[1] https://patchwork.kernel.org/patch/2141301/

> ---
> 
> Only compile tested.
> 
>  drivers/i2c/busses/i2c-pxa.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index 1034d93..7ddda5c 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1104,18 +1104,18 @@ static int i2c_pxa_probe(struct platform_device *dev)
>  	if (ret > 0)
>  		ret = i2c_pxa_probe_pdata(dev, i2c, &i2c_type);
>  	if (ret < 0)
> -		goto eclk;
> +		goto emalloc;
>  
>  	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
>  	irq = platform_get_irq(dev, 0);
>  	if (res == NULL || irq < 0) {
>  		ret = -ENODEV;
> -		goto eclk;
> +		goto emalloc;
>  	}
>  
>  	if (!request_mem_region(res->start, resource_size(res), res->name)) {
>  		ret = -ENOMEM;
> -		goto eclk;
> +		goto emalloc;
>  	}
>  
>  	i2c->adap.owner   = THIS_MODULE;
> @@ -1209,9 +1209,9 @@ ereqirq:
>  eremap:
>  	clk_put(i2c->clk);
>  eclk:
> -	kfree(i2c);
> -emalloc:
>  	release_mem_region(res->start, resource_size(res));
> +emalloc:
> +	kfree(i2c);
>  	return ret;
>  }
>  
> 

-- 
Regards,
Igor.
