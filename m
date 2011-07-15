From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c/imx: add device tree probe support
Date: Thu, 14 Jul 2011 20:54:10 -0600
Message-ID: <20110715025410.GH2927@ponder.secretlab.ca>
References: <1310659425-17499-1-git-send-email-shawn.guo@linaro.org>
 <1310659425-17499-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1310659425-17499-3-git-send-email-shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 15, 2011 at 12:03:45AM +0800, Shawn Guo wrote:
> It adds device tree probe support for i2c-imx driver.
> 
> Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Cc: Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> ---
>  .../devicetree/bindings/i2c/fsl-imx-i2c.txt        |   25 ++++++++++++++++++++
>  drivers/i2c/busses/i2c-imx.c                       |   25 +++++++++++++++----
>  2 files changed, 44 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/i2c/fsl-imx-i2c.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/fsl-imx-i2c.txt b/Documentation/devicetree/bindings/i2c/fsl-imx-i2c.txt
> new file mode 100644
> index 0000000..5066cd9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/fsl-imx-i2c.txt
> @@ -0,0 +1,25 @@
> +* Freescale Inter IC (I2C) and High Speed Inter IC (HS-I2C) for i.MX
> +
> +Required properties:
> +- compatible : Should be "fsl,<chip>-i2c"
> +- reg : Should contain I2C/HS-I2C registers location and length
> +- interrupts : Should contain I2C/HS-I2C interrupt
> +
> +Optional properties:
> +- clock-frequency : Constains desired I2C/HS-I2C bus clock frequency in Hz.
> +  The absence of the propoerty indicates the default frequency 100 kHz.
> +
> +Examples:
> +
> +i2c@83fc4000 { /* I2C2 on i.MX51 */
> +	compatible = "fsl,imx51-i2c", "fsl,imx1-i2c";
> +	reg = <0x83fc4000 0x4000>;
> +	interrupts = <63>;
> +};
> +
> +i2c@70038000 { /* HS-I2C on i.MX51 */
> +	compatible = "fsl,imx51-i2c", "fsl,imx1-i2c";
> +	reg = <0x70038000 0x4000>;
> +	interrupts = <63>;
> +	clock-frequency = <400000>
> +};
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 54d809e..58832e5 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -48,6 +48,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_i2c.h>
>  
>  #include <mach/irqs.h>
>  #include <mach/hardware.h>
> @@ -125,6 +128,11 @@ struct imx_i2c_struct {
>  	unsigned int		ifdr; /* IMX_I2C_IFDR */
>  };
>  
> +static const struct of_device_id i2c_imx_dt_ids[] = {
> +	{ .compatible = "fsl,imx1-i2c", },
> +	{ /* sentinel */ }
> +};
> +

This isn't dangerous, and I think the patch should be merged, but you
should send a followup patch to protect the of_device_id table with
#ifdef CONFIG_OF/#else/#endif to save a bit of data when CONFIG_OF is
not selected.  (Although maybe I'm quibbling over nothing).

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

Ben, can you merge this series?

g.

>  /** Functions for IMX I2C adapter driver ***************************************
>  *******************************************************************************/
>  
> @@ -469,7 +477,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  	struct imxi2c_platform_data *pdata = pdev->dev.platform_data;
>  	void __iomem *base;
>  	resource_size_t res_size;
> -	int irq;
> +	int irq, bitrate;
>  	int ret;
>  
>  	dev_dbg(&pdev->dev, "<%s>\n", __func__);
> @@ -512,6 +520,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  	i2c_imx->adapter.algo		= &i2c_imx_algo;
>  	i2c_imx->adapter.dev.parent	= &pdev->dev;
>  	i2c_imx->adapter.nr 		= pdev->id;
> +	i2c_imx->adapter.dev.of_node	= pdev->dev.of_node;
>  	i2c_imx->irq			= irq;
>  	i2c_imx->base			= base;
>  	i2c_imx->res			= res;
> @@ -538,10 +547,12 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
>  
>  	/* Set up clock divider */
> -	if (pdata && pdata->bitrate)
> -		i2c_imx_set_clk(i2c_imx, pdata->bitrate);
> -	else
> -		i2c_imx_set_clk(i2c_imx, IMX_I2C_BIT_RATE);
> +	bitrate = IMX_I2C_BIT_RATE;
> +	ret = of_property_read_u32(pdev->dev.of_node,
> +				   "clock-frequency", &bitrate);
> +	if (ret < 0 && pdata && pdata->bitrate)
> +		bitrate = pdata->bitrate;
> +	i2c_imx_set_clk(i2c_imx, bitrate);
>  
>  	/* Set up chip registers to defaults */
>  	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
> @@ -554,6 +565,8 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  		goto fail5;
>  	}
>  
> +	of_i2c_register_devices(&i2c_imx->adapter);
> +
>  	/* Set up platform driver data */
>  	platform_set_drvdata(pdev, i2c_imx);
>  
> @@ -584,7 +597,6 @@ fail1:
>  static int __exit i2c_imx_remove(struct platform_device *pdev)
>  {
>  	struct imx_i2c_struct *i2c_imx = platform_get_drvdata(pdev);
> -	struct imxi2c_platform_data *pdata = pdev->dev.platform_data;
>  
>  	/* remove adapter */
>  	dev_dbg(&i2c_imx->adapter.dev, "adapter removed\n");
> @@ -613,6 +625,7 @@ static struct platform_driver i2c_imx_driver = {
>  	.driver	= {
>  		.name	= DRIVER_NAME,
>  		.owner	= THIS_MODULE,
> +		.of_match_table = i2c_imx_dt_ids,
>  	}
>  };
>  
> -- 
> 1.7.4.1
> 
