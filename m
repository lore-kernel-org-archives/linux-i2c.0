From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v4 3/6] soc: qcom: geni: Add support for ACPI
Date: Tue, 18 Jun 2019 22:43:14 -0700
Message-ID: <20190619054314.GJ4814@minitux>
References: <20190612142654.9639-1-lee.jones@linaro.org>
 <20190612142654.9639-4-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190612142654.9639-4-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alokc@codeaurora.org, agross@kernel.org, david.brown@linaro.org, wsa+renesas@sang-engineering.com, balbi@kernel.org, gregkh@linuxfoundation.org, ard.biesheuvel@linaro.org, jlhugo@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.or
List-Id: linux-i2c@vger.kernel.org

On Wed 12 Jun 07:26 PDT 2019, Lee Jones wrote:

> When booting with ACPI as the active set of configuration tables,
> all; clocks, regulators, pin functions ect are expected to be at
> their ideal values/levels/rates, thus the associated frameworks
> are unavailable.  Ensure calls to these APIs are shielded when
> ACPI is enabled.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/soc/qcom/qcom-geni-se.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 6b8ef01472e9..d5cf953b4337 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
>  
> +#include <linux/acpi.h>
>  #include <linux/clk.h>
>  #include <linux/slab.h>
>  #include <linux/dma-mapping.h>
> @@ -450,6 +451,9 @@ int geni_se_resources_off(struct geni_se *se)
>  {
>  	int ret;
>  
> +	if (has_acpi_companion(se->dev))
> +		return 0;
> +
>  	ret = pinctrl_pm_select_sleep_state(se->dev);
>  	if (ret)
>  		return ret;
> @@ -487,6 +491,9 @@ int geni_se_resources_on(struct geni_se *se)
>  {
>  	int ret;
>  
> +	if (has_acpi_companion(se->dev))
> +		return 0;
> +
>  	ret = geni_se_clks_on(se);
>  	if (ret)
>  		return ret;
> @@ -724,12 +731,14 @@ static int geni_se_probe(struct platform_device *pdev)
>  	if (IS_ERR(wrapper->base))
>  		return PTR_ERR(wrapper->base);
>  
> -	wrapper->ahb_clks[0].id = "m-ahb";
> -	wrapper->ahb_clks[1].id = "s-ahb";
> -	ret = devm_clk_bulk_get(dev, NUM_AHB_CLKS, wrapper->ahb_clks);
> -	if (ret) {
> -		dev_err(dev, "Err getting AHB clks %d\n", ret);
> -		return ret;
> +	if (!has_acpi_companion(&pdev->dev)) {
> +		wrapper->ahb_clks[0].id = "m-ahb";
> +		wrapper->ahb_clks[1].id = "s-ahb";
> +		ret = devm_clk_bulk_get(dev, NUM_AHB_CLKS, wrapper->ahb_clks);
> +		if (ret) {
> +			dev_err(dev, "Err getting AHB clks %d\n", ret);
> +			return ret;
> +		}
>  	}
>  
>  	dev_set_drvdata(dev, wrapper);
> -- 
> 2.17.1
> 
