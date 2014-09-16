From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3] i2c: designware: Add support for AMD i2c controller
Date: Tue, 16 Sep 2014 13:03:26 +0300
Message-ID: <20140916100309.GA10854@lahna.fi.intel.com>
References: <1410848458-1455-1-git-send-email-carlpeng008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410848458-1455-1-git-send-email-carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 16, 2014 at 02:20:58PM +0800, Carl Peng wrote:
> AMD i2c bus controller is ACPI device, its ACPI ID
> is "AMD0010". This patch is used to add support for
> AMD i2c bus controller in the Designware platform
> driver.

This is looking better now. I still have few comments, though.

> 
> Signed-off-by: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-designware-core.h    |  1 +
>  drivers/i2c/busses/i2c-designware-platdrv.c | 46 +++++++++++++++++++++++++----
>  2 files changed, 41 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
> index d66b6cb..c67d4ac 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -105,6 +105,7 @@ struct dw_i2c_dev {
>  	u16			ss_lcnt;
>  	u16			fs_hcnt;
>  	u16			fs_lcnt;
> +	struct	dw_i2c_pdata	*pdata;

You don't need this.

>  };
>  
>  #define ACCESS_SWAP		0x00000001
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index bc87733..8a96e69 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -43,15 +43,31 @@
>  #include <linux/acpi.h>
>  #include "i2c-designware-core.h"
>  
> +#define AMD_CLK_KHZ		(133 * 1000)

Do you really need define for this?

> +
> +struct dw_i2c_pdata {
> +	u32 clk_rate_khz;
> +};

Call it dw_i2c_config instead.

> +
>  static struct i2c_algorithm i2c_dw_algo = {
>  	.master_xfer	= i2c_dw_xfer,
>  	.functionality	= i2c_dw_func,
>  };
> +
> +static struct dw_i2c_pdata amd_i2c_config = {
> +	.clk_rate_khz = AMD_CLK_KHZ,
> +};
> +
>  static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
>  {
>  	return clk_get_rate(dev->clk)/1000;

How about doing this instead?

	const struct dw_i2c_config *conf = i2c_dw_get_config(dev);

	if (conf)
		return conf->clk_rate_khz;
	return clk_get_rate(dev->clk)/1000;

And then just implement i2c_dw_get_config() that understands to look
clk_rate from acpi_device_id.

>  }
>  
> +static u32 amd_i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)

Please don't call it amd_xxx because if now some other vendor decides
that their version of dw ip runs at 120MHz we would need to rename this.

> +{
> +	return dev->pdata->clk_rate_khz;
> +}
> +
