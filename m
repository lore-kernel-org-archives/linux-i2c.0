From: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 07/13] i2c: pnx: Use devm_*() functions
Date: Tue, 17 Dec 2013 13:30:35 +0100
Message-ID: <52B043EB.2010106@antcom.de>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com> <002b01cefaf4$fa737d40$ef5a77c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <002b01cefaf4$fa737d40$ef5a77c0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Vitaly Wool' <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 12/17/2013 07:55 AM, Jingoo Han wrote:
> Use devm_*() functions to make cleanup paths simpler.
> 
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-pnx.c |   56 +++++++++++++-----------------------------
>  1 file changed, 17 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
> index c9a352f..f2d7add 100644
> --- a/drivers/i2c/busses/i2c-pnx.c
> +++ b/drivers/i2c/busses/i2c-pnx.c
> @@ -628,11 +628,9 @@ static int i2c_pnx_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	u32 speed = I2C_PNX_SPEED_KHZ_DEFAULT * 1000;
>  
> -	alg_data = kzalloc(sizeof(*alg_data), GFP_KERNEL);
> -	if (!alg_data) {
> -		ret = -ENOMEM;
> -		goto err_kzalloc;
> -	}
> +	alg_data = devm_kzalloc(&pdev->dev, sizeof(*alg_data), GFP_KERNEL);
> +	if (!alg_data)
> +		return -ENOMEM;
>  
>  	platform_set_drvdata(pdev, alg_data);
>  
> @@ -657,11 +655,9 @@ static int i2c_pnx_probe(struct platform_device *pdev)
>  		 */
>  	}
>  #endif
> -	alg_data->clk = clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(alg_data->clk)) {
> -		ret = PTR_ERR(alg_data->clk);
> -		goto out_drvdata;
> -	}
> +	alg_data->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(alg_data->clk))
> +		return PTR_ERR(alg_data->clk);
>  
>  	init_timer(&alg_data->mif.timer);
>  	alg_data->mif.timer.function = i2c_pnx_timeout;
> @@ -674,29 +670,27 @@ static int i2c_pnx_probe(struct platform_device *pdev)
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
>  		dev_err(&pdev->dev, "Unable to get mem resource.\n");
> -		ret = -EBUSY;
> -		goto out_clkget;
> +		return -EBUSY;
>  	}
> -	if (!request_mem_region(res->start, I2C_PNX_REGION_SIZE,
> -				pdev->name)) {
> +	if (!devm_request_mem_region(&pdev->dev, res->start,
> +				     I2C_PNX_REGION_SIZE, pdev->name)) {
>  		dev_err(&pdev->dev,
>  		       "I/O region 0x%08x for I2C already in use.\n",
>  		       res->start);
> -		ret = -ENOMEM;
> -		goto out_clkget;
> +		return -ENOMEM;
>  	}
>  
>  	alg_data->base = res->start;
> -	alg_data->ioaddr = ioremap(res->start, I2C_PNX_REGION_SIZE);
> +	alg_data->ioaddr = devm_ioremap(&pdev->dev, res->start,
> +					I2C_PNX_REGION_SIZE);
>  	if (!alg_data->ioaddr) {
>  		dev_err(&pdev->dev, "Couldn't ioremap I2C I/O region\n");
> -		ret = -ENOMEM;
> -		goto out_release;
> +		return -ENOMEM;
>  	}
>  
>  	ret = clk_enable(alg_data->clk);
>  	if (ret)
> -		goto out_unmap;
> +		return ret;
>  
>  	freq = clk_get_rate(alg_data->clk);
>  
> @@ -730,8 +724,8 @@ static int i2c_pnx_probe(struct platform_device *pdev)
>  		ret = alg_data->irq;
>  		goto out_clock;
>  	}
> -	ret = request_irq(alg_data->irq, i2c_pnx_interrupt,
> -			0, pdev->name, alg_data);
> +	ret = devm_request_irq(&pdev->dev, alg_data->irq, i2c_pnx_interrupt,
> +			       0, pdev->name, alg_data);
>  	if (ret)
>  		goto out_clock;
>  
> @@ -739,7 +733,7 @@ static int i2c_pnx_probe(struct platform_device *pdev)
>  	ret = i2c_add_numbered_adapter(&alg_data->adapter);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "I2C: Failed to add bus\n");
> -		goto out_irq;
> +		goto out_clock;
>  	}
>  
>  	dev_dbg(&pdev->dev, "%s: Master at %#8x, irq %d.\n",
> @@ -747,19 +741,8 @@ static int i2c_pnx_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> -out_irq:
> -	free_irq(alg_data->irq, alg_data);
>  out_clock:
>  	clk_disable(alg_data->clk);
> -out_unmap:
> -	iounmap(alg_data->ioaddr);
> -out_release:
> -	release_mem_region(res->start, I2C_PNX_REGION_SIZE);
> -out_clkget:
> -	clk_put(alg_data->clk);
> -out_drvdata:
> -	kfree(alg_data);
> -err_kzalloc:
>  	return ret;
>  }
>  
> @@ -767,13 +750,8 @@ static int i2c_pnx_remove(struct platform_device *pdev)
>  {
>  	struct i2c_pnx_algo_data *alg_data = platform_get_drvdata(pdev);
>  
> -	free_irq(alg_data->irq, alg_data);
>  	i2c_del_adapter(&alg_data->adapter);
>  	clk_disable(alg_data->clk);
> -	iounmap(alg_data->ioaddr);
> -	release_mem_region(alg_data->base, I2C_PNX_REGION_SIZE);
> -	clk_put(alg_data->clk);
> -	kfree(alg_data);
>  
>  	return 0;
>  }
> 

Thanks!

Acked-by: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Tested-by: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
