From: Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH v1 09/40] i2c: bcm-kona: Use generic definitions for bus
 frequencies
Date: Mon, 24 Feb 2020 09:29:29 -0800
Message-ID: <1a617e20-c3c9-51a2-5c3a-81adf2358a84@broadcom.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
 <20200224151530.31713-9-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50890 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbgBXR3e (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 24 Feb 2020 12:29:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so155011wmb.0
        for <linux-i2c@vger.kernel.org>; Mon, 24 Feb 2020 09:29:33 -0800 (PST)
In-Reply-To: <20200224151530.31713-9-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>



On 2020-02-24 7:14 a.m., Andy Shevchenko wrote:
> Since we have generic definitions for bus frequencies, let's use them.
>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/i2c/busses/i2c-bcm-kona.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-bcm-kona.c b/drivers/i2c/busses/i2c-bcm-kona.c
> index 4e489a9d16fb..2858639767da 100644
> --- a/drivers/i2c/busses/i2c-bcm-kona.c
> +++ b/drivers/i2c/busses/i2c-bcm-kona.c
> @@ -722,16 +722,16 @@ static int bcm_kona_i2c_assign_bus_speed(struct bcm_kona_i2c_dev *dev)
>   	}
>   
>   	switch (bus_speed) {
> -	case 100000:
> +	case I2C_STANDARD_MODE_FREQ:
>   		dev->std_cfg = &std_cfg_table[BCM_SPD_100K];
>   		break;
> -	case 400000:
> +	case I2C_FAST_MODE_FREQ:
>   		dev->std_cfg = &std_cfg_table[BCM_SPD_400K];
>   		break;
> -	case 1000000:
> +	case I2C_FAST_MODE_PLUS_FREQ:
>   		dev->std_cfg = &std_cfg_table[BCM_SPD_1MHZ];
>   		break;
> -	case 3400000:
> +	case I2C_HIGH_SPEED_MODE_FREQ:
>   		/* Send mastercode at 100k */
>   		dev->std_cfg = &std_cfg_table[BCM_SPD_100K];
>   		dev->hs_cfg = &hs_cfg_table[BCM_SPD_3P4MHZ];
