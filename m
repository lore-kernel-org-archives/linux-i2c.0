From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [Patch V2] i2c: imx-lpi2c: add VLLS mode support
Date: Tue, 17 Jan 2017 11:10:25 +0200
Message-ID: <848799b4-a364-3791-0727-414f82308e25@mleia.com>
References: <1484636967-23599-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:48592 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751137AbdAQJKg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 17 Jan 2017 04:10:36 -0500
In-Reply-To: <1484636967-23599-1-git-send-email-pandy.gao@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <pandy.gao@nxp.com>, wsa@the-dreams.de, wsa-dev@sang-engineering.com
Cc: linux-i2c@vger.kernel.org, frank.li@nxp.com

Hello Pandy,

On 01/17/2017 09:09 AM, Gao Pan wrote:
> When system enters VLLS mode, module power is turned off. As a result,
> all registers are reset to HW default value. After exiting VLLS mode,
> registers are still in default mode. As a result, the pinctrl settings
> are incorrect, which will affect the module function.
> 
> The patch recovers the pinctrl setting when exit VLLS mode.
> 
> Signed-off-by: Gao Pan <pandy.gao@nxp.com>
> ---
> V2:
>  -drop "#else branch" and IMX_LPI2C_PM completely
>  -pm = &imx_lpi2c_pm
> 
>  drivers/i2c/busses/i2c-imx-lpi2c.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
> index c62b7cd..dbde95d 100644
> --- a/drivers/i2c/busses/i2c-imx-lpi2c.c
> +++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
> @@ -636,12 +636,33 @@ static int lpi2c_imx_remove(struct platform_device *pdev)
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
> +#endif

in case if I didn't manage to explain what is desirable, please change
the order of two lines above, you may find that commonly SIMPLE_DEV_PM_OPS()
macro is used outside #ifdef CONFIG_PM_SLEEP, due to the feature that
CONFIG_PM_SLEEP token is incorporated into SIMPLE_DEV_PM_OPS() internals.

> +
>  static struct platform_driver lpi2c_imx_driver = {
>  	.probe = lpi2c_imx_probe,
>  	.remove = lpi2c_imx_remove,
>  	.driver = {
>  		.name = DRIVER_NAME,
>  		.of_match_table = lpi2c_imx_of_match,
> +#ifdef CONFIG_PM_SLEEP
> +		.pm = &imx_lpi2c_pm,
> +#endif

Then this #ifdef won't be needed here.

>  	},
>  };
>  
> 

--
With best wishes,
Vladimir
