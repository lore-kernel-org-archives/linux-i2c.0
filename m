From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [Patch V1] i2c: imx-lpi2c: add VLLS mode support
Date: Fri, 6 Jan 2017 23:20:25 +0200
Message-ID: <fee8ed68-7280-175c-c33e-8aafe9f94e7c@mleia.com>
References: <1483521616-17914-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:49572 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750993AbdAFVU1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 6 Jan 2017 16:20:27 -0500
In-Reply-To: <1483521616-17914-1-git-send-email-pandy.gao@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <pandy.gao@nxp.com>, wsa@the-dreams.de, wsa-dev@sang-engineering.com
Cc: linux-i2c@vger.kernel.org, frank.li@nxp.com, fugang.duan@nxp.com

Hi,

On 01/04/2017 11:20 AM, Gao Pan wrote:
> When system enters VLLS mode, module power is turned off. As a result,
> all registers are reset to HW default value. After exiting VLLS mode,
> registers are still in default mode. As a result, the pinctrl settings
> are incorrect, which will affect the module function.
> 
> The patch recovers the pinctrl setting when exit VLLS mode.
> 
> Signed-off-by: Gao Pan <pandy.gao@nxp.com>
> ---
>  drivers/i2c/busses/i2c-imx-lpi2c.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
> index c62b7cd..e528c1d1 100644
> --- a/drivers/i2c/busses/i2c-imx-lpi2c.c
> +++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
> @@ -636,12 +636,34 @@ static int lpi2c_imx_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int lpi2c_imx_suspend(struct device *dev)
> +{
> +	pinctrl_pm_select_sleep_state(dev);
> +
> +	return 0;
> +}
> +
> +static int lpi2c_imx_resume(struct device *dev)
> +{
> +	pinctrl_pm_select_default_state(dev);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(imx_lpi2c_pm, lpi2c_imx_suspend, lpi2c_imx_resume);
> +#define IMX_LPI2C_PM	(&imx_lpi2c_pm)
> +#else
> +#define IMX_LPI2C_PM	NULL

Please drop #else branch and IMX_LPI2C_PM completely.

> +#endif
> +
>  static struct platform_driver lpi2c_imx_driver = {
>  	.probe = lpi2c_imx_probe,
>  	.remove = lpi2c_imx_remove,
>  	.driver = {
>  		.name = DRIVER_NAME,
>  		.of_match_table = lpi2c_imx_of_match,
> +		.pm = IMX_LPI2C_PM,

Here it should be:

		.pm = &imx_lpi2c_pm,

>  	},
>  };
>  

--
With best wishes,
Vladimir
