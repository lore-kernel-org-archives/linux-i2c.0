From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] i2c: uniphier{-f}: don't print error when adding adapter
 fails
Date: Tue, 9 Aug 2016 18:25:48 -0700
Message-ID: <20160810012548.GB26808@roeck-us.net>
References: <1470773500-13946-1-git-send-email-wsa-dev@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50323 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932595AbcHJB1L (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 9 Aug 2016 21:27:11 -0400
Content-Disposition: inline
In-Reply-To: <1470773500-13946-1-git-send-email-wsa-dev@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>

On Tue, Aug 09, 2016 at 10:11:40PM +0200, Wolfram Sang wrote:
> The core will do this for us now.
> 
> Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/i2c/busses/i2c-uniphier-f.c | 5 -----
>  drivers/i2c/busses/i2c-uniphier.c   | 5 -----
>  2 files changed, 10 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
> index aeead0d27d1007..35608531fe070d 100644
> --- a/drivers/i2c/busses/i2c-uniphier-f.c
> +++ b/drivers/i2c/busses/i2c-uniphier-f.c
> @@ -550,11 +550,6 @@ static int uniphier_fi2c_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = i2c_add_adapter(&priv->adap);
> -	if (ret) {
> -		dev_err(dev, "failed to add I2C adapter\n");
> -		goto err;
> -	}
> -
>  err:
>  	if (ret)
>  		clk_disable_unprepare(priv->clk);
> diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uniphier.c
> index 475a5eb514e215..d6e612a0e02a9d 100644
> --- a/drivers/i2c/busses/i2c-uniphier.c
> +++ b/drivers/i2c/busses/i2c-uniphier.c
> @@ -407,11 +407,6 @@ static int uniphier_i2c_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = i2c_add_adapter(&priv->adap);
> -	if (ret) {
> -		dev_err(dev, "failed to add I2C adapter\n");
> -		goto err;
> -	}
> -
>  err:
>  	if (ret)
>  		clk_disable_unprepare(priv->clk);
> -- 
> 2.8.1
> 
