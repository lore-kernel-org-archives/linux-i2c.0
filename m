From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH V5] i2c: designware: fix wrong Tx/Rx FIFO for ACPI
Date: Thu, 15 Dec 2016 19:57:45 +0200
Message-ID: <1481824665.9552.41.camel@linux.intel.com>
References: <1481707438-32240-1-git-send-email-tnhuynh@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25551 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753384AbcLOSAM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 15 Dec 2016 13:00:12 -0500
In-Reply-To: <1481707438-32240-1-git-send-email-tnhuynh@apm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tin Huynh <tnhuynh@apm.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com

On Wed, 2016-12-14 at 16:23 +0700, Tin Huynh wrote:
> ACPI always sets Tx/Rx FIFO to 32. This configuration will
> cause problem if the IP core supports a FIFO size of less than 32.
> The driver should read the FIFO size from the IP and select the
> smaller
> one of the two.
> 
> Signed-off-by: Tin Huynh <tnhuynh@apm.com>
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c |   31
> ++++++++++++++++++++------
>  1 files changed, 24 insertions(+), 7 deletions(-)
> 
> Change from V4:
>  -Change else condition and add some comments to clarify new approach.
> 
> Change from V3:
>  -Use uppercase of FIFO instead of lowercase.
>  -Correct else condition when IP core return 0 of FIFO.
> 
> Change from V2:
>  -Add a helper function to set FIFO size.
> 
> Change from V1:
>  -Revert the default 32 for FIFO, read parameter from IP core
>  and pick the smaller one of the two.
>  -Correct the title to describe new approach.
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 0b42a12..682adc3 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -150,6 +150,29 @@ static int i2c_dw_plat_prepare_clk(struct
> dw_i2c_dev *i_dev, bool prepare)
>  	return 0;
>  }
>  
> +static void dw_i2c_set_fifo_size(struct dw_i2c_dev *dev, int id)
> +{
> +	u32 param, tx_fifo_depth, rx_fifo_depth;
> +
> +	/*
> +	 * Try to detect the FIFO depth if not set by interface
> driver,
> +	 * the depth could be from 2 to 256 from HW spec.
> +	 */
> +	param = i2c_dw_read_comp_param(dev);
> +	tx_fifo_depth = ((param >> 16) & 0xff) + 1;
> +	rx_fifo_depth = ((param >> 8)  & 0xff) + 1;
> +	if (!dev->tx_fifo_depth) {
> +		dev->tx_fifo_depth = tx_fifo_depth;
> +		dev->rx_fifo_depth = rx_fifo_depth;
> +		dev->adapter.nr = id;
> +	} else if (tx_fifo_depth >= 2) {
> +		dev->tx_fifo_depth = min_t(u32, dev->tx_fifo_depth,
> +				tx_fifo_depth);
> +		dev->rx_fifo_depth = min_t(u32, dev->rx_fifo_depth,
> +				rx_fifo_depth);
> +	}
> +}
> +
>  static int dw_i2c_plat_probe(struct platform_device *pdev)
>  {
>  	struct dw_i2c_platform_data *pdata = dev_get_platdata(&pdev-
> >dev);
> @@ -246,13 +269,7 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
>  				1000000);
>  	}
>  
> -	if (!dev->tx_fifo_depth) {
> -		u32 param1 = i2c_dw_read_comp_param(dev);
> -
> -		dev->tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;
> -		dev->rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
> -		dev->adapter.nr = pdev->id;
> -	}
> +	dw_i2c_set_fifo_size(dev, pdev->id);
>  
>  	adap = &dev->adapter;
>  	adap->owner = THIS_MODULE;

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
