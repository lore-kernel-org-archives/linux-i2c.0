From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] i2c: at91: Handle return value of clk_prepare_enable
Date: Wed, 31 May 2017 14:05:42 +0200
Message-ID: <20170531120542.iscumzwkhbkd2wuv@rfolt0960.corp.atmel.com>
References: <74b05c5180872e368970562535bc305728da4be8.1496211597.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:60411 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdEaMGB (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 31 May 2017 08:06:01 -0400
Content-Disposition: inline
In-Reply-To: <74b05c5180872e368970562535bc305728da4be8.1496211597.git.arvind.yadav.cs@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: ludovic.desroches@microchip.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 31, 2017 at 12:27:44PM +0530, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
I would split this patch in:
- add missing clk_disable_unprepare()
- check clk_prepare_enable() return value

Since there are trivial fixes, maybe having them squashed is ok.

Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks
> ---
>  drivers/i2c/busses/i2c-at91.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index fabbb9e..2525cd9 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -1083,12 +1083,16 @@ static int at91_twi_probe(struct platform_device *pdev)
>  		dev_err(dev->dev, "no clock defined\n");
>  		return -ENODEV;
>  	}
> -	clk_prepare_enable(dev->clk);
> +	rc = clk_prepare_enable(dev->clk);
> +	if (rc)
> +		return rc;
>  
>  	if (dev->dev->of_node) {
>  		rc = at91_twi_configure_dma(dev, phy_addr);
> -		if (rc == -EPROBE_DEFER)
> +		if (rc == -EPROBE_DEFER) {
> +			clk_disable_unprepare(dev->clk);
>  			return rc;
> +		}
>  	}
>  
>  	if (!of_property_read_u32(pdev->dev.of_node, "atmel,fifo-size",
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
