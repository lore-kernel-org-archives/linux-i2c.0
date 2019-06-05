From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 7/8] usb: dwc3: qcom: Start USB in 'host mode' on the
 SDM845
Date: Wed, 5 Jun 2019 00:00:29 -0700
Message-ID: <20190605070029.GN22737@tuxbook-pro>
References: <20190604104455.8877-1-lee.jones@linaro.org>
 <20190604104455.8877-7-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190604104455.8877-7-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alokc@codeaurora.org, kramasub@codeaurora.org, andy.gross@linaro.org, david.brown@linaro.org, wsa+renesas@sang-engineering.com, linus.walleij@linaro.org, balbi@kernel.org, gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, jlhugo@gmail.com, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue 04 Jun 03:44 PDT 2019, Lee Jones wrote:

> When booting with Device Tree, the current default boot configuration
> table option, the request to boot via 'host mode' comes from the
> "dr_mode" property.

This has been the default on the MTP, but this is changing as this is
causing issues when connected downstream from a hub (the typical
development case for the primary USB port of a phone like device) and
more importantly we don't have support for the PMIC blocks that control
VBUS.

Once these issues are resolved the dr_mode would be "otg".

> A property of the same name can be used inside
> ACPI tables too.  However it is missing from the SDM845's ACPI tables
> so we have to supply this information using Platform Device Properites
> instead.
> 

Afaict this would install a fall-back property, so in the case that we
have specified dr_mode in DT (or ACPI) that would take precedence. So
the commit message should reflect that this redefines the default choice
to be "host", rather than "otg".

Which is in conflict with what's described for dr_mode in
Documentation/devicetree/bindings/usb/generic.txt


And this driver is used on a range of different Qualcomm platforms, so I
don't think this is SDM845 specific.

Regards,
Bjorn

> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 349bf549ee44..f21fdd6cdd1a 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -468,6 +468,11 @@ static const struct acpi_device_id dwc3_qcom_acpi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, dwc3_qcom_acpi_match);
>  
> +static const struct property_entry dwc3_qcom_acpi_properties[] = {
> +	PROPERTY_ENTRY_STRING("dr_mode", "host"),
> +	{}
> +};
> +
>  static int dwc3_qcom_probe(struct platform_device *pdev)
>  {
>  	struct device_node	*np = pdev->dev.of_node, *dwc3_np;
> @@ -603,6 +608,13 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  			goto platform_unalloc;
>  		}
>  
> +		ret = platform_device_add_properties(qcom->dwc3,
> +						     dwc3_qcom_acpi_properties);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "failed to add properties\n");
> +			goto platform_unalloc;
> +		}
> +
>  		ret = platform_device_add(qcom->dwc3);
>  		if (ret) {
>  			dev_err(&pdev->dev, "failed to add device\n");
> -- 
> 2.17.1
> 
