From: Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Add missing request_mem_region in probe()
Date: Tue, 31 Mar 2009 14:57:12 +0300
Message-ID: <49D20518.5060702@gmail.com>
References: <20090331115253.16399.53728.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090331115253.16399.53728.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: public-ben-linux-elnMNo+KYs3YtjvyW6yDsg-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org
Cc: public-linux-i2c-u79uwXL29TY76Z2rM5mHXA-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



Ben,

please merge this one too, if possible.

Darius.


Darius Augulis wrote:
> Signed-off-by: Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
> ---
> 
>  drivers/i2c/busses/i2c-imx.c |   20 +++++++++++++-------
>  1 files changed, 13 insertions(+), 7 deletions(-)
> 
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 3296380..515bbed 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -483,6 +483,11 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  		goto fail1;
>  	}
>  
> +	if (!request_mem_region(res->start, res_size, DRIVER_NAME)) {
> +		ret = -EBUSY;
> +		goto fail2;
> +	}
> +
>  	/* Setup i2c_imx driver structure */
>  	strcpy(i2c_imx->adapter.name, pdev->name);
>  	i2c_imx->adapter.owner		= THIS_MODULE;
> @@ -498,7 +503,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  	if (IS_ERR(i2c_imx->clk)) {
>  		ret = PTR_ERR(i2c_imx->clk);
>  		dev_err(&pdev->dev, "can't get I2C clock\n");
> -		goto fail2;
> +		goto fail3;
>  	}
>  	clk_enable(i2c_imx->clk);
>  
> @@ -506,7 +511,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  	ret = request_irq(i2c_imx->irq, i2c_imx_isr, 0, pdev->name, i2c_imx);
>  	if (ret) {
>  		dev_err(&pdev->dev, "can't claim irq %d\n", i2c_imx->irq);
> -		goto fail3;
> +		goto fail4;
>  	}
>  
>  	/* Init queue */
> @@ -529,7 +534,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  	ret = i2c_add_numbered_adapter(&i2c_imx->adapter);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "registration failed\n");
> -		goto fail4;
> +		goto fail5;
>  	}
>  
>  	/* Set up platform driver data */
> @@ -546,11 +551,13 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  
>  	return 0;   /* Return OK */
>  
> -fail4:
> +fail5:
>  	free_irq(i2c_imx->irq, i2c_imx);
> -fail3:
> +fail4:
>  	clk_disable(i2c_imx->clk);
>  	clk_put(i2c_imx->clk);
> +fail3:
> +	release_mem_region(i2c_imx->res->start, resource_size(res));
>  fail2:
>  	kfree(i2c_imx);
>  fail1:
> @@ -589,8 +596,7 @@ static int __exit i2c_imx_remove(struct platform_device *pdev)
>  	clk_put(i2c_imx->clk);
>  
>  	/* Release memory */
> -	release_mem_region(i2c_imx->res->start,
> -		i2c_imx->res->end - i2c_imx->res->start + 1);
> +	release_mem_region(i2c_imx->res->start, resource_size(i2c_imx->res));
>  	iounmap(i2c_imx->base);
>  	kfree(i2c_imx);
>  	return 0;
> 
