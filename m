From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] drivers/i2c: Correct use of
 request_region/request_mem_region
Date: Sat, 12 Sep 2009 18:04:25 +0200
Message-ID: <20090912180425.6dbf339d@hyperion.delvare>
References: <Pine.LNX.4.64.0908091506160.16252@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754222AbZILQE3@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0908091506160.16252@ask.diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: Julia Lawall <julia@diku.dk>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 9 Aug 2009 15:06:43 +0200 (CEST), Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> request_mem_region should be used when ioremap is used subsequently.
> release_region is then correspondingly replaced by release_mem_region.
> (...)
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> ---
>  drivers/i2c/busses/i2c-pnx.c        |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
> index ec15cff..6ff6c20 100644
> --- a/drivers/i2c/busses/i2c-pnx.c
> +++ b/drivers/i2c/busses/i2c-pnx.c
> @@ -586,7 +586,8 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
>  	alg_data->mif.timer.data = (unsigned long)i2c_pnx->adapter;
>  
>  	/* Register I/O resource */
> -	if (!request_region(alg_data->base, I2C_PNX_REGION_SIZE, pdev->name)) {
> +	if (!request_mem_region(alg_data->base, I2C_PNX_REGION_SIZE,
> +				pdev->name)) {
>  		dev_err(&pdev->dev,
>  		       "I/O region 0x%08x for I2C already in use.\n",
>  		       alg_data->base);
> @@ -650,7 +651,7 @@ out_clock:
>  out_unmap:
>  	iounmap((void *)alg_data->ioaddr);
>  out_release:
> -	release_region(alg_data->base, I2C_PNX_REGION_SIZE);
> +	release_mem_region(alg_data->base, I2C_PNX_REGION_SIZE);
>  out_drvdata:
>  	platform_set_drvdata(pdev, NULL);
>  out:
> @@ -667,7 +668,7 @@ static int __devexit i2c_pnx_remove(struct platform_device *pdev)
>  	i2c_del_adapter(adap);
>  	i2c_pnx->set_clock_stop(pdev);
>  	iounmap((void *)alg_data->ioaddr);
> -	release_region(alg_data->base, I2C_PNX_REGION_SIZE);
> +	release_mem_region(alg_data->base, I2C_PNX_REGION_SIZE);
>  	platform_set_drvdata(pdev, NULL);
>  
>  	return 0;

Vitaly, can you please ack this change?

-- 
Jean Delvare
