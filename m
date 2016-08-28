From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] i2c: designware: save the preset value of
 DW_IC_SDA_HOLD
Date: Sun, 28 Aug 2016 15:31:42 +0300
Message-ID: <1472387502.4887.321.camel@linux.intel.com>
References: <1472283570-31471-1-git-send-email-zhuo-hao.lee@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472283570-31471-1-git-send-email-zhuo-hao.lee@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhuo-hao Lee <zhuo-hao.lee@intel.com>, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 2016-08-27 at 15:39 +0800, Zhuo-hao Lee wrote:
> There are several ways to set the SDA hold time for i2c controller,
> including: Device Tree, built-in device properties and ACPI. However,
> if the SDA hold time is not specified by above method, we should
> read the value, where it is preset by firmware, and save it to
> sda_hold_time. This is needed because when i2c controller enters
> runtime suspend, the DW_IC_SDA_HOLD value will be reset to chipset
> default value. And during runtime resume, i2c_dw_init will be called
> to reconfigure i2c controller. If sda_hold_time is zero, the chipset
> default hold time will be used, that will be too short for some
> platforms. Therefore, to have a better tolerance, the DW_IC_SDA_HOLD
> value should be kept by sda_hold_time.

Looks good to me.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Zhuo-hao Lee <zhuo-hao.lee@intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-core.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-core.c
> b/drivers/i2c/busses/i2c-designware-core.c
> index c6922b8..fcd973d 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -367,13 +367,17 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
>  	dev_dbg(dev->dev, "Fast-mode HCNT:LCNT = %d:%d\n", hcnt,
> lcnt);
>  
>  	/* Configure SDA Hold Time if required */
> -	if (dev->sda_hold_time) {
> -		reg = dw_readl(dev, DW_IC_COMP_VERSION);
> -		if (reg >= DW_IC_SDA_HOLD_MIN_VERS)
> +	reg = dw_readl(dev, DW_IC_COMP_VERSION);
> +	if (reg >= DW_IC_SDA_HOLD_MIN_VERS) {
> +		if (dev->sda_hold_time) {
>  			dw_writel(dev, dev->sda_hold_time,
> DW_IC_SDA_HOLD);
> -		else
> -			dev_warn(dev->dev,
> -				"Hardware too old to adjust SDA hold
> time.");
> +		} else {
> +			/* Keep previous hold time setting if no one
> set it */
> +			dev->sda_hold_time = dw_readl(dev,
> DW_IC_SDA_HOLD);
> +		}
> +	} else {
> +		dev_warn(dev->dev,
> +			"Hardware too old to adjust SDA hold
> time.\n");
>  	}
>  
>  	/* Configure Tx/Rx FIFO threshold levels */

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
