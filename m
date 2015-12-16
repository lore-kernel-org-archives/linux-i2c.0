From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Do not require clock when SSCN and FFCN
 are provided
Date: Wed, 16 Dec 2015 11:42:02 +0200
Message-ID: <20151216094202.GR1762@lahna.fi.intel.com>
References: <1450219138-5868-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450219138-5868-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: wsa@the-dreams.de, lho@apm.com, Ken.Xue@amd.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

+Jarkko and Andy

On Tue, Dec 15, 2015 at 04:38:58PM -0600, Suravee Suthikulpanit wrote:
> The current driver uses input clock source frequency to calculate
> values for [SS|FS]_[HC|LC] registers. However, when booting ACPI, we do not
> currently have a good way to provide the frequency information.
> Instead, we can leverage the SSCN and FFCN ACPI methods, which can be used
> to directly provide these values.
> 
> So, this patch removes the clock requirement when SSCN and FFCN
> are provided.

Actually I think the only thing you need to change is i2c_dw_init() so
that it does not call dev->get_clk_rate_khz(dev) if *CNT values are
already provided.

The clk framework should work fine if the returned clock is NULL (which
I think is your case).

The driver gates clocks when the device is suspended and on Intel LPSS
there actually is a clock that gets gated.

> 
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
> 
> Note: This has been tested on AMD Seattle RevB for both DT and ACPI.
> 
>  drivers/i2c/busses/i2c-designware-core.c    |  5 +++--
>  drivers/i2c/busses/i2c-designware-platdrv.c | 30 +++++++++++++++++++++++------
>  2 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index 8c48b27..ec458ec 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -281,7 +281,7 @@ static void __i2c_dw_enable(struct dw_i2c_dev *dev, bool enable)
>   */
>  int i2c_dw_init(struct dw_i2c_dev *dev)
>  {
> -	u32 input_clock_khz;
> +	u32 input_clock_khz = 0;
>  	u32 hcnt, lcnt;
>  	u32 reg;
>  	u32 sda_falling_time, scl_falling_time;
> @@ -295,7 +295,8 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
>  		}
>  	}
>  
> -	input_clock_khz = dev->get_clk_rate_khz(dev);
> +	if (dev->get_clk_rate_khz)
> +		input_clock_khz = dev->get_clk_rate_khz(dev);
>  
>  	reg = dw_readl(dev, DW_IC_COMP_TYPE);
>  	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 809579e..57f623b 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -127,6 +127,26 @@ static inline int dw_i2c_acpi_configure(struct platform_device *pdev)
>  }
>  #endif
>  
> +static int dw_i2c_configure_clk(struct platform_device *pdev,
> +				struct dw_i2c_dev *dev)
> +{
> +	/* For ACPI, if SSCN and FMCN is provided, we should not
> +	 * need the clock value.
> +	 */
> +	if (has_acpi_companion(&pdev->dev) &&
> +	    dev->ss_hcnt && dev->ss_lcnt &&
> +	    dev->fs_hcnt && dev->fs_lcnt)
> +		return 0;
> +
> +	dev->clk = devm_clk_get(&pdev->dev, NULL);
> +	dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
> +	if (IS_ERR(dev->clk))
> +		return PTR_ERR(dev->clk);
> +	clk_prepare_enable(dev->clk);
> +
> +	return 0;
> +}
> +
>  static int dw_i2c_plat_probe(struct platform_device *pdev)
>  {
>  	struct dw_i2c_dev *dev;
> @@ -203,13 +223,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>  		dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
>  			DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
>  
> -	dev->clk = devm_clk_get(&pdev->dev, NULL);
> -	dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
> -	if (IS_ERR(dev->clk))
> -		return PTR_ERR(dev->clk);
> -	clk_prepare_enable(dev->clk);
> +	r = dw_i2c_configure_clk(pdev, dev);
> +	if (r)
> +		return r;
>  
> -	if (!dev->sda_hold_time && ht) {
> +	if (!dev->sda_hold_time && ht && dev->get_clk_rate_khz) {
>  		u32 ic_clk = dev->get_clk_rate_khz(dev);
>  
>  		dev->sda_hold_time = div_u64((u64)ic_clk * ht + 500000,
> -- 
> 2.5.0
