From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCHv2 2/2] i2c: cadence: Implement save restore
Date: Wed, 2 Mar 2016 09:32:31 +0100
Message-ID: <56D6A51F.6000908@xilinx.com>
References: <1456824065-22080-1-git-send-email-shubhraj@xilinx.com>
 <1456824065-22080-2-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-cys01nam02on0046.outbound.protection.outlook.com ([104.47.37.46]:6896
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751240AbcCBIcr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 2 Mar 2016 03:32:47 -0500
In-Reply-To: <1456824065-22080-2-git-send-email-shubhraj@xilinx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-i2c@vger.kernel.org
Cc: soren.brinkmann@xilinx.com, michal.simek@xilinx.com, wsa@the-dreams.de, Shubhrajyoti Datta <shubhraj@xilinx.com>

On 1.3.2016 10:21, Shubhrajyoti Datta wrote:
> Implement save restore for i2c module.
> Since we have only a couple of registers
> an unconditional restore is done.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
> ---
> zynq-mp has the capability of going off.
> the current kernel does not hit off however some day it will.
> since the overhead of having the support is not much may be it is better to have it in the kernel.
> 
> v2 changes:
> add kernel doc for ctrl_reg and cdns_i2c_init
> 
>  drivers/i2c/busses/i2c-cadence.c |   41 +++++++++++++++++++++++++-------------
>  1 files changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
> index f9f485d..88d2c8b 100644
> --- a/drivers/i2c/busses/i2c-cadence.c
> +++ b/drivers/i2c/busses/i2c-cadence.c
> @@ -143,6 +143,7 @@
>   * @clk:		Pointer to struct clk
>   * @clk_rate_change_nb:	Notifier block for clock rate changes
>   * @quirks:		flag for broken hold bit usage in r1p10
> + * @ctrl_reg:		Cached value of the control register.
>   */
>  struct cdns_i2c {
>  	struct device		*dev;
> @@ -163,6 +164,7 @@ struct cdns_i2c {
>  	struct clk *clk;
>  	struct notifier_block clk_rate_change_nb;
>  	u32 quirks;
> +	u32 ctrl_reg;
>  };
>  
>  struct cdns_platform_data {
> @@ -745,12 +747,11 @@ static int cdns_i2c_setclk(unsigned long clk_in, struct cdns_i2c *id)
>  	if (ret)
>  		return ret;
>  
> -	ctrl_reg = cdns_i2c_readreg(CDNS_I2C_CR_OFFSET);
> +	ctrl_reg = id->ctrl_reg;
>  	ctrl_reg &= ~(CDNS_I2C_CR_DIVA_MASK | CDNS_I2C_CR_DIVB_MASK);
>  	ctrl_reg |= ((div_a << CDNS_I2C_CR_DIVA_SHIFT) |
>  			(div_b << CDNS_I2C_CR_DIVB_SHIFT));
> -	cdns_i2c_writereg(ctrl_reg, CDNS_I2C_CR_OFFSET);
> -
> +	id->ctrl_reg = ctrl_reg;
>  	return 0;
>  }
>  
> @@ -835,6 +836,26 @@ static int __maybe_unused cdns_i2c_runtime_suspend(struct device *dev)
>  }
>  
>  /**
> + * cdns_i2c_init -  Controller initialisation
> + * @id:		Device private data structure
> + *
> + * Initialise the i2c controller.
> + *
> + */
> +static void cdns_i2c_init(struct cdns_i2c *id)
> +{
> +	cdns_i2c_writereg(id->ctrl_reg, CDNS_I2C_CR_OFFSET);
> +	/*
> +	 * Cadence I2C controller has a bug wherein it generates
> +	 * invalid read transaction after HW timeout in master receiver mode.
> +	 * HW timeout is not used by this driver and the interrupt is disabled.
> +	 * But the feature itself cannot be disabled. Hence maximum value
> +	 * is written to this register to reduce the chances of error.
> +	 */
> +	cdns_i2c_writereg(CDNS_I2C_TIMEOUT_MAX, CDNS_I2C_TIME_OUT_OFFSET);
> +}
> +
> +/**
>   * cdns_i2c_runtime_resume - Runtime resume
>   * @dev:	Address of the platform_device structure
>   *
> @@ -853,6 +874,7 @@ static int __maybe_unused cdns_i2c_runtime_resume(struct device *dev)
>  		dev_err(dev, "Cannot enable clock.\n");
>  		return ret;
>  	}
> +	cdns_i2c_init(xi2c);
>  
>  	return 0;
>  }
> @@ -945,8 +967,7 @@ static int cdns_i2c_probe(struct platform_device *pdev)
>  	if (ret || (id->i2c_clk > CDNS_I2C_SPEED_MAX))
>  		id->i2c_clk = CDNS_I2C_SPEED_DEFAULT;
>  
> -	cdns_i2c_writereg(CDNS_I2C_CR_ACK_EN | CDNS_I2C_CR_NEA | CDNS_I2C_CR_MS,
> -			  CDNS_I2C_CR_OFFSET);
> +	id->ctrl_reg = CDNS_I2C_CR_ACK_EN | CDNS_I2C_CR_NEA | CDNS_I2C_CR_MS;
>  
>  	ret = cdns_i2c_setclk(id->input_clk, id);
>  	if (ret) {
> @@ -967,15 +988,7 @@ static int cdns_i2c_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "reg adap failed: %d\n", ret);
>  		goto err_clk_dis;
>  	}
> -
> -	/*
> -	 * Cadence I2C controller has a bug wherein it generates
> -	 * invalid read transaction after HW timeout in master receiver mode.
> -	 * HW timeout is not used by this driver and the interrupt is disabled.
> -	 * But the feature itself cannot be disabled. Hence maximum value
> -	 * is written to this register to reduce the chances of error.
> -	 */
> -	cdns_i2c_writereg(CDNS_I2C_TIMEOUT_MAX, CDNS_I2C_TIME_OUT_OFFSET);
> +	cdns_i2c_init(id);
>  
>  	dev_info(&pdev->dev, "%u kHz mmio %08lx irq %d\n",
>  		 id->i2c_clk / 1000, (unsigned long)r_mem->start, id->irq);
> 

Looks good to me.
Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
