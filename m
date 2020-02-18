From: Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] i2c: omap: use devm_platform_ioremap_resource()
Date: Tue, 18 Feb 2020 11:28:17 +0530
Message-ID: <5f045d3c-d106-9f2d-1b2c-b7b6b04bfaba@ti.com>
References: <1581755803-11242-1-git-send-email-qiwuchen55@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1581755803-11242-1-git-send-email-qiwuchen55@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: qiwuchen55@gmail.com, tony@atomide.com, aaro.koskinen@iki.fi
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
List-Id: linux-i2c@vger.kernel.org



On 15/02/20 2:06 pm, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Use a new API devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

>  drivers/i2c/busses/i2c-omap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 2dfea35..47d994a 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1355,7 +1355,6 @@ static void omap_i2c_unprepare_recovery(struct i2c_adapter *adap)
>  {
>  	struct omap_i2c_dev	*omap;
>  	struct i2c_adapter	*adap;
> -	struct resource		*mem;
>  	const struct omap_i2c_bus_platform_data *pdata =
>  		dev_get_platdata(&pdev->dev);
>  	struct device_node	*node = pdev->dev.of_node;
> @@ -1375,8 +1374,7 @@ static void omap_i2c_unprepare_recovery(struct i2c_adapter *adap)
>  	if (!omap)
>  		return -ENOMEM;
>  
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	omap->base = devm_ioremap_resource(&pdev->dev, mem);
> +	omap->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(omap->base))
>  		return PTR_ERR(omap->base);
>  
> 

-- 
Regards
Vignesh
