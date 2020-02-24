From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v1 24/40] i2c: owl: Use generic definitions for bus
 frequencies
Date: Mon, 24 Feb 2020 20:57:57 +0530
Message-ID: <20200224152757.GC5656@Mani-XPS-13-9360>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
 <20200224151530.31713-24-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38656 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgBXP2G (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 24 Feb 2020 10:28:06 -0500
Received: by mail-pl1-f194.google.com with SMTP id t6so4192314plj.5
        for <linux-i2c@vger.kernel.org>; Mon, 24 Feb 2020 07:28:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200224151530.31713-24-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Mon, Feb 24, 2020 at 05:15:14PM +0200, Andy Shevchenko wrote:
> Since we have generic definitions for bus frequencies, let's use them.
> 
> Cc: "Andreas Färber" <afaerber@suse.de>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/i2c/busses/i2c-owl.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
> index b6b5a495118b..f9baeeb1a711 100644
> --- a/drivers/i2c/busses/i2c-owl.c
> +++ b/drivers/i2c/busses/i2c-owl.c
> @@ -87,9 +87,6 @@
>  
>  #define OWL_I2C_MAX_RETRIES	50
>  
> -#define OWL_I2C_DEF_SPEED_HZ	100000
> -#define OWL_I2C_MAX_SPEED_HZ	400000
> -
>  struct owl_i2c_dev {
>  	struct i2c_adapter	adap;
>  	struct i2c_msg		*msg;
> @@ -419,11 +416,11 @@ static int owl_i2c_probe(struct platform_device *pdev)
>  
>  	if (of_property_read_u32(dev->of_node, "clock-frequency",
>  				 &i2c_dev->bus_freq))
> -		i2c_dev->bus_freq = OWL_I2C_DEF_SPEED_HZ;
> +		i2c_dev->bus_freq = I2C_STANDARD_MODE_FREQ;
>  
>  	/* We support only frequencies of 100k and 400k for now */
> -	if (i2c_dev->bus_freq != OWL_I2C_DEF_SPEED_HZ &&
> -	    i2c_dev->bus_freq != OWL_I2C_MAX_SPEED_HZ) {
> +	if (i2c_dev->bus_freq != I2C_STANDARD_MODE_FREQ &&
> +	    i2c_dev->bus_freq != I2C_FAST_MODE_FREQ) {
>  		dev_err(dev, "invalid clock-frequency %d\n", i2c_dev->bus_freq);
>  		return -EINVAL;
>  	}
> -- 
> 2.25.0
> 
