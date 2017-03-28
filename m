From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Get selected speed mode sda-hold-time
 via ACPI
Date: Tue, 28 Mar 2017 12:13:46 +0300
Message-ID: <1490692426.708.26.camel@linux.intel.com>
References: <1490690882-11623-1-git-send-email-chin.yew.tan@intel.com>
         <1490690882-11623-2-git-send-email-chin.yew.tan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:43914 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754855AbdC1JQs (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 28 Mar 2017 05:16:48 -0400
In-Reply-To: <1490690882-11623-2-git-send-email-chin.yew.tan@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tan Chin Yew <chin.yew.tan@intel.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2017-03-28 at 16:48 +0800, Tan Chin Yew wrote:
> Sda-hold-time is an important parameter for tuning i2c to meet the
> electrical specification especially for high speed. I2C with incorrect
> sda-hold-time may cause lost arbitration error. Instead of loading all
> speed mode settings, only selected speed mode settings are loaded.
> 
> Signed-off-by: Tan Chin Yew <chin.yew.tan@intel.com>


Looks good to me:

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 31
> ++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> b/drivers/i2c/busses/i2c-designware-platdrv.c
> index a597ba32..5a4eb6b 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -85,8 +85,7 @@ static void dw_i2c_acpi_params(struct
> platform_device *pdev, char method[],
>  
>  		*hcnt = (u16)objs[0].integer.value;
>  		*lcnt = (u16)objs[1].integer.value;
> -		if (sda_hold)
> -			*sda_hold = (u32)objs[2].integer.value;
> +		*sda_hold = (u32)objs[2].integer.value;
>  	}
>  
>  	kfree(buf.pointer);
> @@ -105,14 +104,28 @@ static int dw_i2c_acpi_configure(struct
> platform_device *pdev)
>  	dev->rx_fifo_depth = 32;
>  
>  	/*
> -	 * Try to get SDA hold time and *CNT values from an ACPI
> method if
> -	 * it exists for both supported speed modes.
> +	 * Try to get SDA hold time and *CNT values from an ACPI
> method for
> +	 * selected speed modes.
>  	 */
> -	dw_i2c_acpi_params(pdev, "SSCN", &dev->ss_hcnt, &dev-
> >ss_lcnt, NULL);
> -	dw_i2c_acpi_params(pdev, "FMCN", &dev->fs_hcnt, &dev-
> >fs_lcnt,
> -			   &dev->sda_hold_time);
> -	dw_i2c_acpi_params(pdev, "FPCN", &dev->fp_hcnt, &dev-
> >fp_lcnt, NULL);
> -	dw_i2c_acpi_params(pdev, "HSCN", &dev->hs_hcnt, &dev-
> >hs_lcnt, NULL);
> +	switch (dev->clk_freq) {
> +	case 100000:
> +		dw_i2c_acpi_params(pdev, "SSCN", &dev->ss_hcnt, &dev-
> >ss_lcnt,
> +				   &dev->sda_hold_time);
> +		break;
> +	case 1000000:
> +		dw_i2c_acpi_params(pdev, "FPCN", &dev->fp_hcnt, &dev-
> >fp_lcnt,
> +				   &dev->sda_hold_time);
> +		break;
> +	case 3400000:
> +		dw_i2c_acpi_params(pdev, "HSCN", &dev->hs_hcnt, &dev-
> >hs_lcnt,
> +				   &dev->sda_hold_time);
> +		break;
> +	case 400000:
> +	default:
> +		dw_i2c_acpi_params(pdev, "FMCN", &dev->fs_hcnt, &dev-
> >fs_lcnt,
> +				   &dev->sda_hold_time);
> +		break;
> +	}
>  
>  	id = acpi_match_device(pdev->dev.driver->acpi_match_table,
> &pdev->dev);
>  	if (id && id->driver_data)

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
