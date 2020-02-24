From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH v1 19/40] i2c: lpc2k: Use generic definitions for bus
 frequencies
Date: Mon, 24 Feb 2020 17:35:54 +0200
Message-ID: <db95daf2-bccf-1073-91d5-5e827e011645@mleia.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
 <20200224151530.31713-19-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:46066 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbgBXPod (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:44:33 -0500
In-Reply-To: <20200224151530.31713-19-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

Hi Andy!

On 2/24/20 5:15 PM, Andy Shevchenko wrote:
> Since we have generic definitions for bus frequencies, let's use them.
> 
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-lpc2k.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-lpc2k.c b/drivers/i2c/busses/i2c-lpc2k.c
> index deea18b14add..159ebec5861c 100644
> --- a/drivers/i2c/busses/i2c-lpc2k.c
> +++ b/drivers/i2c/busses/i2c-lpc2k.c
> @@ -396,7 +396,7 @@ static int i2c_lpc2k_probe(struct platform_device *pdev)
>  	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
>  				   &bus_clk_rate);
>  	if (ret)
> -		bus_clk_rate = 100000; /* 100 kHz default clock rate */
> +		bus_clk_rate = I2C_STANDARD_MODE_FREQ; /* 100 kHz default clock rate */

The line above becomes longer than 80 symbols, please fix it by simply
removing the comment, note that it might be an issue through the series.

Could I2C_STD_MODE_FREQ be a shorter and still acceptable name?

>  
>  	clkrate = clk_get_rate(i2c->clk);
>  	if (clkrate == 0) {
> @@ -407,9 +407,9 @@ static int i2c_lpc2k_probe(struct platform_device *pdev)
>  
>  	/* Setup I2C dividers to generate clock with proper duty cycle */
>  	clkrate = clkrate / bus_clk_rate;
> -	if (bus_clk_rate <= 100000)
> +	if (bus_clk_rate <= I2C_STANDARD_MODE_FREQ)
>  		scl_high = (clkrate * I2C_STD_MODE_DUTY) / 100;
> -	else if (bus_clk_rate <= 400000)
> +	else if (bus_clk_rate <= I2C_FAST_MODE_FREQ)
>  		scl_high = (clkrate * I2C_FAST_MODE_DUTY) / 100;
>  	else
>  		scl_high = (clkrate * I2C_FAST_MODE_PLUS_DUTY) / 100;
> 

After the requested fix:

Acked-by: Vladimir Zapolskiy <vz@mleia.com>
