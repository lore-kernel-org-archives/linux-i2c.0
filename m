From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for a bus clock
Date: Tue, 17 Jul 2018 14:07:37 +0200
Message-ID: <20180717120737.bipotpki3yhn6klf@verge.net.au>
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
 <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 16, 2018 at 09:59:13AM +0100, Phil Edworthy wrote:
> The Synopsys I2C Controller has a bus clock, but typically SoCs hide this away.
> However, on some SoCs you need to explicity enable the bus clock in order to
> access the registers.
> Therefore, enable an optional bus clock specified by DT.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>  drivers/i2c/busses/i2c-designware-common.c  | 14 +++++++++++++-
>  drivers/i2c/busses/i2c-designware-core.h    |  1 +
>  drivers/i2c/busses/i2c-designware-platdrv.c |  2 ++
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
> index 48914df..4fa67d6 100644
> --- a/drivers/i2c/busses/i2c-designware-common.c
> +++ b/drivers/i2c/busses/i2c-designware-common.c
> @@ -186,13 +186,25 @@ unsigned long i2c_dw_clk_rate(struct dw_i2c_dev *dev)
>  
>  int i2c_dw_prepare_clk(struct dw_i2c_dev *dev, bool prepare)
>  {
> +	int ret;
> +
>  	if (IS_ERR(dev->clk))
>  		return PTR_ERR(dev->clk);
>  
> -	if (prepare)
> +	if (prepare) {
> +		/* Optional bus clock */
> +		if (!IS_ERR(dev->busclk)) {

I suspect that error values stored in dev->busclk,  other than -ENOENT,
should be treated as errors.

> +			ret = clk_prepare_enable(dev->busclk);
> +			if (ret)
> +				return ret;
> +		}
> +
>  		return clk_prepare_enable(dev->clk);
> +	}
>  
>  	clk_disable_unprepare(dev->clk);
> +	clk_disable_unprepare(dev->busclk);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(i2c_dw_prepare_clk);
> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
> index d690e64..10f905d 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -239,6 +239,7 @@ struct dw_i2c_dev {
>  	void __iomem		*base;
>  	struct completion	cmd_complete;
>  	struct clk		*clk;
> +	struct clk		*busclk;
>  	struct reset_control	*rst;
>  	struct i2c_client		*slave;
>  	u32			(*get_clk_rate_khz) (struct dw_i2c_dev *dev);
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 5660daf..64389fe 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -332,6 +332,8 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>  	else
>  		i2c_dw_configure_master(dev);
>  
> +	/* Optional bus clock */
> +	dev->busclk = devm_clk_get(&pdev->dev, "bus");
>  	dev->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (!i2c_dw_prepare_clk(dev, true)) {
>  		dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
> -- 
> 2.7.4
> 
