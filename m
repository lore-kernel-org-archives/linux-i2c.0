From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH v1 21/40] i2c: mv64xxx: Use generic definitions for bus frequencies
Date: Fri, 13 Mar 2020 21:28:12 +0100
Message-ID: <878sk4yp7n.fsf@FE-laptop>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com> <20200224151530.31713-21-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:56313 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgCMU2U (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 13 Mar 2020 16:28:20 -0400
In-Reply-To: <20200224151530.31713-21-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> Since we have generic definitions for bus frequencies, let's use them.
>
> Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory


> ---
>  drivers/i2c/busses/i2c-mv64xxx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
> index febb7c7ea72b..e803c6b0a947 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -810,7 +810,7 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
>  	tclk = clk_get_rate(drv_data->clk);
>  
>  	if (of_property_read_u32(np, "clock-frequency", &bus_freq))
> -		bus_freq = 100000; /* 100kHz by default */
> +		bus_freq = I2C_STANDARD_MODE_FREQ; /* 100kHz by default */
>  
>  	if (of_device_is_compatible(np, "allwinner,sun4i-a10-i2c") ||
>  	    of_device_is_compatible(np, "allwinner,sun6i-a31-i2c"))
> @@ -846,14 +846,14 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
>  	if (of_device_is_compatible(np, "marvell,mv78230-i2c")) {
>  		drv_data->offload_enabled = true;
>  		/* The delay is only needed in standard mode (100kHz) */
> -		if (bus_freq <= 100000)
> +		if (bus_freq <= I2C_STANDARD_MODE_FREQ)
>  			drv_data->errata_delay = true;
>  	}
>  
>  	if (of_device_is_compatible(np, "marvell,mv78230-a0-i2c")) {
>  		drv_data->offload_enabled = false;
>  		/* The delay is only needed in standard mode (100kHz) */
> -		if (bus_freq <= 100000)
> +		if (bus_freq <= I2C_STANDARD_MODE_FREQ)
>  			drv_data->errata_delay = true;
>  	}
>  
> -- 
> 2.25.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
